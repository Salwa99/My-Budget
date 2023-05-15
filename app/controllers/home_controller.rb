class HomeController < ApplicationController
  def index
    @categories = current_user.categories if user_signed_in?
  end
end
