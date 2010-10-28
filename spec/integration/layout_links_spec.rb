require 'spec_helper'

describe "LayoutLinks" do
	it "should have a Home page at '/'" do
		get '/'
		response.should render_template('pages/home')
	end

	it "should have a Contact page at '/contact'" do
		get '/contact'
		response.should render_template('pages/contact')
	end

	it "should have an About page at '/about'" do
		get '/about'
		response.should render_template('pages/about')
	end

	it "should have a signup page at '/signup'" do
		get '/signup'
		response.should render_template('users/new')
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "О сайте"
		response.should render_template('pages/about.html.erb')
		click_link "Свежий номер"
		response.should render_template('pages/home.html.erb')
	end

	describe "when not signed in" do
		it "should have a signin link" do
			visit root_path
			response.should have_tag("a[href=?]", signin_path, "Войти")
		end
	end

	describe "when signed in" do

		before(:each) do
			@user = Factory(:user)
			visit signin_path
			fill_in :"Адрес электронной почты",	:with => @user.email
			fill_in :"Пароль", :with => @user.password
			click_button
		end

		it "should have a signout link" do
			visit root_path
			response.should have_tag("a[href=?]", signout_path, "Выйти")
		end

		it "should have a profile link" do
			visit root_path
			response.should have_tag("a[href=?]", user_path(@user), "Профиль")
		end
	end
end
