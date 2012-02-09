require './app'

use Rack::Reloader, 1
use Rack::Coffee, {
    :urls => '/assets/js',
    :join => 'index'
}
use Rack::Static, :urls => ["/assets"]

run App
