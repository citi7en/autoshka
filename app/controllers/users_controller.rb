class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]

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
			sign_in @user
			flash[:success] = "Регистрация прошла успешно."
			redirect_to @user
		else
			@title = "Регистрация"
			render 'new'
		end
	end

	def edit
		@title = "Редактирование профиля"
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Профиль успешно обновлён."
			redirect_to @user
		else
			@title = "Редактирование профиля"
			render 'edit'
		end
	end

	def index
		@title = "Все пользователи"
    @users = User.paginate(:page => params[:page])
	end

	private
		
		def authenticate
			deny_access unless signed_in?
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
end
