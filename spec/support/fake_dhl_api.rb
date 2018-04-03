require 'sinatra/base'

class FakeDhlApi < Sinatra::Base
  post '/authenticate/api-key' do
    json_response 200, 'access_token.json'
  end

  post '/labels' do
    json_response 200, 'pdf_label.json'
  end

  get '/track-trace' do
    json_response 200, 'track_trace.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end