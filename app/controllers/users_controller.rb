class UsersController < ApplicationController

  def new
		@title = "Регистрация"
  end

	def show
		@user = User.find(params[:id])
	end
end
