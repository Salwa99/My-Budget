require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }

  describe 'validations' do
    it 'is valid with all valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid if name is not present' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid if email is not present' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid if name is not unique' do
      User.create(name: 'Elma', email: 'elma@gmail.com', password: 'password')
      user.name = 'Elma'
      expect(user).to_not be_valid
    end
  end

  describe 'authentication' do
    it 'has email and password columns' do
      columns = User.column_names
      expect(columns).to include('email', 'encrypted_password')
    end

    it 'validates the password' do
      expect(user.valid_password?('password')).to be true
      expect(user.valid_password?('wrong_password')).to be false
    end
  end
end
