require 'rspec/autorun'

require 'rack'
require 'rack/test'
require 'raptor'

require_relative '../app'

def env(method, path, body="")
  {'REQUEST_METHOD' => method,
   'PATH_INFO' => path,
   'rack.input' => body}
end

def request(method, path, body="")
  Rack::Request.new(env(method, path, body))
end

def params(hash)
  hash.to_json
end

def app
  App
end

def json_body
  JSON.parse(last_response.body)
end
