

RSpec.describe Visibilize do

  before(:all) do 
    User.destroy_all
    Car.destroy_all
    Animal.destroy_all
    Building.destroy_all
    Computer.destroy_all
    Keyboard.destroy_all
    Book.destroy_all
    Furniture.destroy_all
  end

  it "should work without provided options" do
    instance=User.create(name: "Furkan Enes")
    expect(instance.visible_id.length).to be 8
  end

  it "should work with different column arguments" do
    instance=Car.create(name: "Mustang 70")
    expect(instance.serial_number.length).to be 8
  end

  it "should work with different length arguments" do
    instance=Animal.create(name: "Dog")
    expect(instance.visible_id.length).to be 16
  end

  it "should work with lambdas" do
    instance=Building.create(name: "Empire State")
    expect(instance.visible_id.to_i).to be 12
  end

  it "should work with different type arguments" do
    computer=Computer.create(name: "Apple Macbook Pro")
    expect(computer.serial_number).not_to match /^[0-9]$/

    keyboard=Keyboard.create(name: "Logitech Keyboard")
    expect(keyboard.serial_number).to match UUID_REGEX
  end


  it "should provide uniqueness" do
    books=[]
    books.push Book.create(name: "Lord of The Rings")
    books.push Book.create(name: "Mistborn: Secret History")
    books.push Book.create(name: "How to Program With Ruby")
    books.push Book.create(name: "How to Test Your Code")
    books.push Book.create(name: "Usage of Rspec")
    books.push Book.create(name: "Life of Tiber Septim")
    books.push Book.create(name: "How to Become an Influencer")
    books.push Book.create(name: "Mistborn: The Last Empire")
    books.push Book.create(name: "Why My Life Sucks")

    sum=0
    books.each{|b| sum+=b.page_number}

    expect(sum).to be 45
  end


  it "should work with different callbacks" do
    instance=Furniture.create(name: "Sofa 11")
    expect(instance.visible_id).to be nil

    instance.update(name: "Sofa 12")
    vid=instance.visible_id
    expect(instance.visible_id).not_to be nil

    instance.update(name: "Sofa 13")
    expect(instance.visible_id).not_to be vid
  end


end
