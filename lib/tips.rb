module Tips

  def self.routes
    Raptor.routes(self) do
      root :render => "root", :present => :many
      create :redirect => nil, :present => :one, :render => 'show', :to => 'Tips::JSONParser.create'
      show
      index
    end
  end

  class PresentsMany
    def all
      Record.all.map{ |r| r.attributes }
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
