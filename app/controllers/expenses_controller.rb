class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category

  def index
    @expenses = @category.expenses
    @total_amount = @expenses.sum(:amount)
  end

  def new
    @category = Category.find(params[:category_id])
    @categories = current_user.categories
    @expense = Expense.new
  end

  def create
    @expense = @category.expenses.build(expense_params)
    @expense.author = current_user
    @expense.date = Date.parse(params[:expense][:date]) unless params[:expense][:date].nil?

    if @expense.save
      flash[:success] = "You've just added a new expense."
      redirect_to category_expenses_path(@category)
    else
      flash.now[:error] = @expense.errors.full_messages.first
      render :new
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:success] = 'Expense item has been removed.'
    redirect_to category_expenses_path
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :category_id)
  end
end
