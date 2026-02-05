require_relative '../platform/books'
require_relative '../platform/json_parser_helper'
require_relative '../services/user_service'

class Controller < Sinatra::Base
  include JWT_Helper
  def initialize(app = nil, **_kwargs)
    super
    @books = Books_Flow.new
    @user_service = UserService.new
  end

  before do
    content_type :json
  end

  get '/' do
    status 200
    {
      res: 'Welcome to MyProject!'
    }.to_json
  end

  get '/book' do
    pg = params[:pg]
    if pg.nil?
      list = @books.get_books(1)
    else
      list = @books.get_books(pg.to_i)
    end
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
    username = authenticated?
    book = @books.get_book_by_id(username, params[:id])
    if book.nil?
      status 400
      {
        error: 'No Valid Book with given ID is found!'
      }.to_json
    else
      status 200
      book.as_json.to_json
    end
  end

  post '/book' do
    authenticated_admin?
    @data = json_parser
    book_new = @books.add_book(@data)
    if book_new[:err].nil?
      book_new.as_json.to_json
    else
      status 500
      book_new.as_json.to_json
    end
  end

  delete '/book/:id' do
    authenticated_admin?
    if @books.delete_book(params[:id]) == true
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

  patch '/book' do
    authenticated_admin?
    @data = json_parser
    updated_book = @books.update_book(@data)
    if updated_book != false
      status 200
      updated_book.as_json.to_json
    else
      status 400
      {
        err: 'Invalid ID!'
      }.to_json
    end
  end

  put '/book' do
    authenticated_admin?
    @data = json_parser
    if @data['id'].nil?
      status 400
      {
        error: 'Book ID is missing!'
      }.as_json.to_json
    else
      book_new = @books.replace_book(@data)
      if book_new[:err].nil?
        book_new.as_json.to_json
      else
        status 500
        book_new.as_json.to_json
      end
    end
  end


  get '/search' do
    username = authenticated?

    begin
      @books.search(params, username).as_json.to_json
    rescue => error
      puts error
      {
        response: error
      }.to_json
    end
  end


  #User endpoints
  post '/user/register' do
    @data = json_parser
    @data['role'] = 'user'
    begin
      res = @user_service.add_new_user(@data)
      token = create_token(res)
      status 200
      {
        res: token
      }.to_json
    rescue => error
      status 400
      {err: error}.to_json
    end
  end

  post '/login' do
    @data = json_parser
    begin
      res = @user_service.authenticate(@data)
      token = create_token(res)
      status 200
      {
        res: token
      }.to_json
    rescue => error
      status 400
      {err: error}.to_json
    end
  end

  post '/admin/register' do
    @data = json_parser
    @data['role'] = 'admin'
    begin
      res = @user_service.add_new_user(@data)
      token = create_token(res)
      status 200
      {
        res: token
      }.to_json
    rescue => error
      status 400
      {err: error}.to_json
    end
  end


end
