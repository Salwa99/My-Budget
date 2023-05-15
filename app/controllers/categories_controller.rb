class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      if params[:category][:icon].present?
        @category.icon.attach(
          io: File.open(params[:category][:icon]),
          filename: params[:category][:icon].original_filename,
          content_type: params[:category][:icon].content_type
        )
      end
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def expenses
    @category = current_user.categories.find(params[:category_id])
    @expenses = @category.expenses.order(date: :desc)
    @total_amount = @expenses.sum(:amount)
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
