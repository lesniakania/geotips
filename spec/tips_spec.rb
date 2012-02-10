require 'spec_helper'

describe Tips do
  include Rack::Test::Methods

  describe :create do
    let(:content) { 'Nie przyjezdzaj tu' }
    let(:created) { Tips.all.first }

    before do
      post '/tips', params(content: content)
    end

    it 'responds with 201' do
      last_response.status.should == 201
    end

    it 'returns a JSON hash with given content' do
      json_body['content'].should == content
    end
  end

  describe :index do
    it 'returns all of the records as json' do
      tips = [Tips::Record.new('content' => 'foo')]
      Tips::Record.stub(:all).and_return(tips)

      get '/tips'

      json_body.should == [{'content' => 'foo'}]
    end
  end
end

describe Tips::Record do
  describe '.create' do
    before do
      Tips::RecordsDb.should_receive(:insert).with({content: 'Jola'}).and_return(123)
    end

    let!(:created) { Tips::Record.create('content' => 'Jola') }

    it 'assigns the id to the record' do
      created.id.should == 123
    end

    it 'returns a record' do
      created.should be_an_instance_of(Tips::Record)
    end

    it 'sets the content of the newly created record' do
      created.content.should == "Jola"
    end

    it 'adds the record to the record collection' do
      Tips::Record.all.should include(created)
    end
  end
end

describe Tips::RecordsDb do
  before do
    Tips::RecordsDb.delete_all
  end

  def insert(hash)
    Tips::RecordsDb.insert(hash)
  end

  describe '.insert' do
    it 'inserts new records to database' do
      insert({content: 'hello'}).should_not be_nil
    end

    it 'returns an id' do
      insert({content: 'foo'}).should be_an_instance_of(String)
    end
  end

  it 'lists records in the database' do
    %w{foo bar baz}.each{|c| insert(content: c)}

    Tips::RecordsDb.all.map{|hash| hash['content']}.should == %w{foo bar baz}
  end
end
