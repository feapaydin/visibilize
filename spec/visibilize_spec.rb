# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Visibilize do # rubocop:disable Metrics/BlockLength
  it 'should work without provided options' do
    instance = User.create(name: 'Furkan Enes')
    expect(instance.visible_id.length).to be 8
  end

  it 'should work with different column arguments' do
    instance = Car.create(name: 'Mustang 70')
    expect(instance.serial_number.length).to be 8
  end

  it 'should work with different length arguments' do
    instance = Animal.create(name: 'Dog')
    expect(instance.visible_id.length).to be 16
  end

  it 'should work with lambdas' do
    instance = Building.create(name: 'Empire State')
    expect(instance.visible_id.to_i).to be 12
  end

  it 'should work with different type arguments' do
    computer = Computer.create(name: 'Apple Macbook Pro')
    expect(computer.serial_number).not_to match(/^[0-9]$/)

    keyboard = Keyboard.create(name: 'Logitech Keyboard')
    expect(keyboard.serial_number).to match UUID_REGEX
  end

  it 'should provide uniqueness' do
    books = []
    9.times { books.push Book.create(name: 'Book') }

    expect(books.map(&:page_number).sort).to contain_exactly(1, 2, 3, 4, 5, 6, 7, 8, 9)
  end

  it 'should work with different callbacks' do
    instance = Furniture.create(name: 'Sofa 11')
    expect(instance.visible_id).to be nil

    instance.update(name: 'Sofa 12')
    vid = instance.visible_id
    expect(instance.visible_id).not_to be nil

    instance.update(name: 'Sofa 13')
    expect(instance.visible_id).not_to be vid
  end
end
