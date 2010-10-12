class UsersController < ApplicationController

  def new
		@user = User.new
		@title = "Регистрация"
  end

	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Регистрация прошла успешно."
			redirect_to @user
		else
			@title = "Регистрация"
			render 'new'
		end
	end
end
