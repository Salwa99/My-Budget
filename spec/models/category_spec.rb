require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create!(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }
  let(:category) { Category.create!(user:, name: 'School', icon: '📚') }
  let(:expense) { Expense.create!(author: user, name: 'T-shirt', amount: 5, category:) }

  describe 'validations' do
    it 'should be valid with all valid attributes' do
      expect(category).to be_valid
    end

    it 'should not be valid if name is not present' do
      category.name = nil
      expect(category).to_not be_valid
    end

    it 'should not be valid if icon is not present' do
      category.icon = nil
      expect(category).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to the correct user' do
      expect(category.user).to eql(user)
    end

    it 'should include the correct expense' do
      expect(category.expenses).to include(expense)
    end
  end
end
