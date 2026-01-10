require 'sinatra/base'

class TestController < Sinatra::Base
  get '/test/.*' do
    # matches /download/path/to/file.xml
    params['splat'] # => ["path/to/file", "xml"]
  end


end