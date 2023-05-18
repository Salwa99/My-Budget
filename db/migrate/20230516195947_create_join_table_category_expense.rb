class CreateJoinTableCategoryExpense < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :expenses do |t|
      # t.index [:category_id, :expense_id]
      # t.index [:expense_id, :category_id]
    end
  end
end
