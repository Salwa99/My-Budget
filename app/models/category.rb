class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses, dependent: :destroy
  has_one_attached :icon


  validates :name, presence: true, length: { maximum: 30 }
  validates :icon, presence: true

  def total_expense
    expenses.sum(:amount)
  end
end
