class HomeController < ApplicationController
  def index
    if user_signed_in?
      @categories = current_user.categories
    else
      redirect_to new_user_session_path
    end
  end
end
