module Tips
  def self.routes
    Raptor.routes(self) do
      root :render => "root", :present => :many
      create :responder => JSONResponder, :present => :one, :to => 'Tips::JSONParser.create'
      show
      index :responder => JSONResponder
    end
  end

  class JSONResponder
    def initialize(resource, action, params)
      @resource = resource
      @action = action
      @presenter_name = params[:present]
    end

    def respond(record, injector)
      injector = injector.add_record(record)
      presenter_class = @resource.send("#{@presenter_name}_presenter")
      presenter = injector.call(presenter_class.method(:new))

      status = @action == :create ? 201 : 200
      Rack::Response.new(presenter.to_json, status, {"Content-Type" => "application/json"})
    end
  end

  class PresentsMany
    def all
      Record.all.map{ |r| r.attributes }
    end

    def to_json
      all.to_json
    end
  end

  class PresentsOne
    takes :record

    def attributes
      @record.attributes
    end
  end

  class JSONParser
    def self.create(request)
      Record.new(request_to_params(request))
    end

    def self.request_to_params(request)
      JSON.parse(request.body.read)
    end
  end

  module RecordsDb
    def insert(hash)
      connection.insert(hash).to_s
    end

    def all
      connection.find
    end

    def delete_all
      connection.remove
    end

    private

    def connection
      @connection ||= Mongo::Connection.new['geotips']['tips']
    end

    extend self
  end

  class Record
    attr_reader :content
    attr_accessor :id

    def initialize(params = {})
      @content = params.fetch('content')
    end

    def attributes
      {content: content}
    end

    def self.create(params = {})
      record = Record.new(params)
      record.id = RecordsDb.insert(record.attributes)
      all << record
      record
    end

    def self.all
      @all ||= []
    end
  end
end
