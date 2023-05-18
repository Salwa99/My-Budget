require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create!(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }
  let(:category) { Category.create!(user:, name: 'Food', icon: '🍔') }
  let(:expense) { Expense.create!(author: user, name: 'Lunch', amount: 6, category:) }

  describe 'validations' do
    it 'should not be valid if name is not present' do
      expense.name = nil
      expect(expense).to_not be_valid
    end

    it 'should not be valid if amount is not present' do
      expense.amount = nil
      expect(expense).to_not be_valid
    end

    it 'should not be valid if amount is negative' do
      expense.amount = -100
      expect(expense).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to a category' do
      expect(expense.category).to eq(category)
    end

    it 'should belong to an author (user)' do
      expect(expense.author).to eq(user)
    end
  end
end
