require_relative '../models/book'
require_relative '../services/book_service'

class Controller < Sinatra::Base
  before do
    content_type :json

    if request.request_method == 'PUT' || request.request_method == 'POST'
      begin
        request.body.rewind
        @data = JSON.parse(request.body.read)
      rescue => e
        halt(400, {
          response: 'JSON format is expected',
             error: e
        }.to_json
        )
      end
    end
  end

  set :service, nil

  get '/' do
    status 200
    {
      res: 'Welcome to MyProject!'
    }.to_json
  end

  post '/book' do
    obj = Model.new(
      settings.service.get_id,
      @data['name'],
      @data['ph_no'],
      @data['email'],
      @data['age'].to_i
    )
    settings.service.add(obj)
    obj.as_json.to_json
  end

  delete '/book/:id' do
    {
      res: settings.service.delete(params['id'].to_i)
    }.to_json
  end

  get '/book' do
    settings.service.print_all.map{|item| item.as_json}.to_json
    # settings.service.print_all.map do |book|
    #   "ID : #{book.id}, Name : #{book.name}, Ph_No: #{book.ph_no}, Email : #{book.email}, Age: #{book.age}"
    # end.join("\n")
  end

  get '/book/:id' do
    book = settings.service.find_by_id(params[:id].to_i)
    if book.nil?
      status 400
      {
        error: 'No Valid Book with given ID is found!'
      }.to_json
    else
      status 200
      book.as_json.to_json
      # "ID : #{book.id}, Name : #{book.name}, Ph_No: #{book.ph_no}, Email : #{book.email}, Age: #{book.age}"
    end
  end

  put '/book' do
    if settings.service.update_by_id(@data['id'].to_i, Model.new(
      @data['id'].to_i,
      @data['name'],
      @data['ph_no'],
      @data['email'],
      @data['age'].to_i
    ))
      settings.service.find_by_id(@data['id'].to_i).as_json.to_json
    else
      status 400
      {
        err: 'No Valid Book with given ID is found!'
      }.to_json
    end
  end
end
