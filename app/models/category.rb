class Category < ApplicationRecord
  has_many :expenses
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
  validates :icon, presence: true

  def total_expense
    expenses.sum(:amount)
  end
end
