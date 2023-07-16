class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:destroy]

  def index
    @categories = current_user.categories.includes(:expenses)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @category.expenses.destroy_all
    @category.destroy
    redirect_to categories_path, notice: 'Category was successfully destroyed.'
  end

  def expenses
    @category = current_user.categories.find(params[:category_id])
    @expenses = @category.expenses.order(date: :desc)
    @total_amount = @expenses.sum(:amount)

    render :index, locals: { expenses: @expenses, total_amount: @total_amount }
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
