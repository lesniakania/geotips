require './app'

use Rack::Reloader, 1
use Rack::Static, :urls => ["/assets"]
run App
