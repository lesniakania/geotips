module Tips

  def self.routes
    Raptor.routes(self) do
      root :render => "new", :present => :one
      create :redirect => nil, :present => :one, :render => 'tip', :to => 'Tips::JSONParser.create'
      show
      index :render => 'tips'
    end
  end

  class PresentsMany
    def all
      Record.all.map{ |r| PresentsOne.new(r).attributes }
    end
  end

  class PresentsOne
    takes :record

    def attributes
      {content: @record.content}
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

  class Record
    attr_reader :content

    def initialize(params = {})
      @content = params.fetch('content')
    end

    def id
      1
    end

    def self.create(params = {})
      record = Record.new(params)
      all << record
      record
    end

    def self.all
      @all ||= []
    end
  end
end
