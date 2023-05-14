class Categories::ExpensesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = current_user.categories.find(params[:category_id])
    @expense = @category.expenses.build
  end

  def create
    @category = current_user.categories.find(params[:category_id])
    @expense = @category.expenses.build(expense_params)

    if @expenses.save
      redirect_to category_expenses_path(@category), notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:date, :description, :amount)
  end
end
