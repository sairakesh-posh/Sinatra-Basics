require_relative '../models/book'
require_relative '../services/book_service'

class Controller < Sinatra::Base
  # def initialize(app = nil, **_kwargs)
  #   @service = Service.get_instance
  #   super
  # end


  get '/' do
    'Welcome to BookList!'
  end

  post '/add' do
    @service.add(Model.new(
      @service.get_id,
      params['name'],
      params['ph_no'],
      params['email'],
      params['age'].to_i
    ))
    "Successfully Added"
  end

  delete '/delete' do
    @service.delete(params['id'].to_i).to_s
  end

  get '/display' do
    @service.print_all.map do |book|
      "ID : #{book.id}, Name : #{book.name}, Ph_No: #{book.ph_no}, Email : #{book.email}, Age: #{book.age}"
    end.join("\n")
  end

  get '/find' do
    book = @service.find_by_id(params[:id].to_i)
    if book == nil
      "No Valid Book with given ID is found!"
    else
      "ID : #{book.id}, Name : #{book.name}, Ph_No: #{book.ph_no}, Email : #{book.email}, Age: #{book.age}"
    end
  end

  put '/update' do
    @service.update_by_id(params['id'].to_i ,Model.new(
      params['id'].to_i,
      params['name'],
      params['ph_no'],
      params['email'],
      params['age'].to_i)
    )
  end
end
