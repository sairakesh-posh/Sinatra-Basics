require_relative '../platform/books'
require_relative '../platform/json_parser_helper'

class Controller < Sinatra::Base
  def initialize(app = nil, **_kwargs)
    super
    @platform = Books_Helper.new
  end

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

  # set :service, nil
  # set :book_search_helper, nil
  set :books_helper, nil

  get '/' do
    status 200
    {
      res: 'Welcome to MyProject!'
    }.to_json
  end

  get '/book' do
    list = @platform.get_books
    if list.nil?
      {
        res: "No books available"
      }.to_json
    else
      list.to_json
    end

    # settings.service.print_all.map do |book|
    #   "ID : #{book.id}, Name : #{book.name}, Ph_No: #{book.ph_no}, Email : #{book.email}, Age: #{book.age}"
    # end.join("\n")
  end

  get '/book/:id' do
    puts @platform
    book = @platform.get_book_by_id(params[:id])
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
    # obj = Model.new(
    #   settings.service.get_id,
    #   @data['name'],
    #   @data['ph_no'],
    #   @data['email'],
    #   @data['age'].to_i
    # )
    book_new = @platform.add_book(@data)
    if book_new[:err].nil?
      book_new.as_json.to_json
    else
      status 500
      book_new.as_json.to_json
    end
  end

  delete '/book/:id' do
    if @platform.delete_book(params[:id]) == true
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
    updated_book = @platform.update_book(@data['id'], @data)
    if updated_book != false
      updated_book.as_json.to_json
      # settings.book_search_helper.update(@data['id'])
      # settings.service.find_by_id(@data['id']).as_json.to_json
    else
      status 400
      {
        err: 'No Valid Book with given ID is found!'
      }.to_json
    end
  end

  # get '/test' do
  #   @platform.test.to_json
  # end

  get '/search' do
    begin
      @platform.search(params[:query]).as_json.to_json
    rescue => error
      puts error
      {
        response: error
      }.to_json
    end

  end
end
