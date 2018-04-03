require 'spec_helper'

describe 'StrongPassword::Generator' do
  describe 'default generator' do
    it 'should generate a password containing at least 8 characters,' \
      'at least 1 upper case letter, 1 number, and 1 special character' do
      @password = StrongPassword::Generator.new.call
      expect(@password.size).to eq StrongPassword::Generator::DEFAULT_LENGTH
      chars_count(@password).each do |_k, count|
        expect(count).to be >= 1
      end
    end
  end

  describe '2 upper cases input request' do
    it 'should generate a 8 characters password with at least 2 upper case characters' do
      @password = StrongPassword::Generator.new(mixed_case: 2).call
      expect(@password.size).to eq StrongPassword::Generator::DEFAULT_LENGTH
      expect(chars_count(@password)[:mixed_case]).to be >= 2
    end
  end

  describe '2 numbers input request' do
    it 'should generate a 8 characters password with at least 2 numbers' do
      @password = StrongPassword::Generator.new(numeric: 2).call
      expect(@password.size).to eq StrongPassword::Generator::DEFAULT_LENGTH
      expect(chars_count(@password)[:numeric]).to be >= 2
    end
  end

  describe '4 special character request' do
    it 'should generate a 8 characters password with at least 4 special characters' do
      @password = StrongPassword::Generator.new(special_char: 4).call
      expect(@password.size).to eq StrongPassword::Generator::DEFAULT_LENGTH
      expect(chars_count(@password)[:special_char]).to be >= 4
    end
  end

  describe '16 characters password' do
    it 'should generate a 16 characters length password' do
      @password = StrongPassword::Generator.new(total_chars: 16).call
      expect(@password.size).to eq 16
    end
  end

  describe 'mixed inputs' do
    context 'invalid request' do
      let(:service) { StrongPassword::Generator.new(mixed_case: 4, numeric: 4) }
      it 'should throw an exception' do
        expect{ service.call }.to raise_error 'Invalid password combination: insufficient password length'
      end
    end

    context '1 upper case, 3 numbers, and 2 special chars at least' do
      let(:inputs) { { mixed_case: 1, numeric: 3, special_char: 2 } }

      it 'should returns correct password combinations' do
        @password = StrongPassword::Generator.new(inputs).call
        expect(@password.size).to eq StrongPassword::Generator::DEFAULT_LENGTH
        @chars_count = chars_count(@password)

        puts @password
        puts @chars_count.inspect

        inputs.each do |key, value|
          expect(@chars_count[key.to_sym]).to be >= value
        end
      end
    end
  end

  def chars_count(password)
    chars_map = { mixed_case: 0, numeric: 0, special_char: 0 }
    password.split('').each do |char|
      chars_map[:mixed_case] += 1 if StrongPassword::Generator::UPPER_CASE_CHARS.include? char
      chars_map[:numeric] += 1 if StrongPassword::Generator::NUMERIC.include? char
      chars_map[:special_char] += 1 if StrongPassword::Generator::SPECIAL_CHARS.include? char
    end
    chars_map
  end
end
