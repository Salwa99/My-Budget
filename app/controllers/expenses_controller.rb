module Categories
  class ExpensesController < ApplicationController
    before_action :authenticate_user!

    def index
      @category = current_user.categories.find(params[:category_id])
      @expenses = @category.expenses.order(date: :desc)
      @total_amount = @expenses.sum(:amount)
    end

    def new
      @category = current_user.categories.find(params[:category_id])
      @expense = @category.expenses.build
    end

    def create
      @category = current_user.categories.find(params[:category_id])
      @expense = @category.expenses.build(expense_params)

      if @expense.save
        redirect_to category_expenses_path(@category), notice: 'Expense was successfully created.'
      else
        render :new
      end
    end

    private

    def expense_params
      params.require(:expense).permit(:date, :amount)
    end
  end
end
