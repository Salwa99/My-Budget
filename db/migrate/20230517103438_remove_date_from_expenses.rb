class RemoveDateFromExpenses < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses, :date, :date
  end
end
