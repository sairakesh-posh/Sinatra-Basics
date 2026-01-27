require_relative '../models/user'
require_relative '../services/book_service'
require_relative '../services/book_search'
require_relative '../platform/json_parser_helper'

class Controller < Sinatra::Base
  before do
    content_type :json

    # if request.request_method == 'PUT' || request.request_method == 'POST'
    #   begin
    #     request.body.rewind
    #     @data = JSON.parse(request.body.read)
    #   rescue => e
    #     halt(400, {
    #       response: 'JSON format is expected',
    #       error: e
    #     }.to_json
    #     )
    #   end
    # end
  end

  set :service, nil
  set :book_search_helper, nil

  get '/' do
    status 200
    {
      res: 'Welcome to MyProject!'
    }.to_json
  end

  get '/book' do

    settings.service.print_all.to_json
    # settings.service.print_all.map do |book|
    #   "ID : #{book.id}, Name : #{book.name}, Ph_No: #{book.ph_no}, Email : #{book.email}, Age: #{book.age}"
    # end.join("\n")
  end

  get '/book/:id' do
    book = settings.service.find_by_id(params[:id])
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

  post '/book' do
    @data = json_parser
    puts @data
    # obj = Model.new(
    #   settings.service.get_id,
    #   @data['name'],
    #   @data['ph_no'],
    #   @data['email'],
    #   @data['age'].to_i
    # )
    begin
      book_new = settings.service.add(@data)
      settings.book_search_helper.index(book_new)
      @data.to_json
    rescue => error
      status 500
      {err: error }.to_json
    end
  end

  delete '/book/:id' do
    if settings.service.delete(params['id']) == true
      settings.book_search_helper.delete(params['id'].to_s)
      status 200
      {
        response: 'ok'
      }.to_json
    else
      status 404
      {
        response: 'not found'
      }.to_json
    end
  end



  put '/book' do
    @data = json_parser
    puts @data['id']
    if settings.service.update_by_id(@data['id'], @data)
      settings.book_search_helper.update(@data['id'])
      settings.service.find_by_id(@data['id']).as_json.to_json
    else
      status 400
      {
        err: 'No Valid Book with given ID is found!'
      }.to_json
    end
  end

  get '/test' do
    settings.service.test.to_json
  end

  get '/search' do
    begin
      settings.book_search_helper.search(params[:query])
    rescue => error
      puts error
      {
        response: 'search error'
      }.to_json
    end

  end
end
