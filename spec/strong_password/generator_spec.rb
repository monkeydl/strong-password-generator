require 'spec_helper'

describe 'StrongPassword::Generator' do
  describe 'default generator' do
    it 'should generate a password containing at least 8 characters,' \
      'at least 1 upper case letter, 1 number, and 1 special character' do
      service = StrongPassword::Generator.new
      @password = service.call
      puts @password.inspect
    end
  end

  describe '2 upper cases input request' do

  end

  describe '2 numbers input request' do

  end

  describe '4 special character request' do

  end

  describe '16 characters password' do

  end

  describe 'mixed inputs' do

  end
end
