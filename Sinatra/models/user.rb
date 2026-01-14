class Model
  attr_accessor :id, :name, :ph_no, :email, :age
  def initialize(id, name, ph_no, email, age)
    @id = id
    @name = name
    @ph_no = ph_no
    @email = email
    @age = age
  end

  def as_json
    {
      id: @id,
      name: @name,
      ph_no: @ph_no,
      email: @email,
      age: @age
    }
  end
end