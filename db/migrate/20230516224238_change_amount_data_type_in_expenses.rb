class ChangeAmountDataTypeInExpenses < ActiveRecord::Migration[7.0]
  def change
    change_column :expenses, :amount, :decimal, using: 'amount::numeric'
  end
end
