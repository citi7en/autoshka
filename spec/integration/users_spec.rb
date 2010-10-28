require 'spec_helper'

describe "Users" do

	describe "signup" do

		describe "failure" do

			it "should not make a new user" do
				lambda do
					visit signup_path
					click_button
					response.should render_template('users/new')
					response.should have_tag("div#errorExplanation")
				end.should_not change(User, :count)
			end
		end

		describe "success" do

			it "should make a new user" do
				lambda do
					visit signup_path
					fill_in "Имя пользователя",						:with => "Example User"
					fill_in "Адрес электронной почты",					:with => "user@example.com"
					fill_in "Пароль",				:with => "foobar"
					fill_in "Подтверждение пароля",		:with => "foobar"
					click_button
					response.should render_template('users/show')
				end.should change(User, :count).by(1)
			end
		end
	end

	describe "sign in/out" do

		describe "failure" do
			it "should not sign a user in" do
				visit signin_path
				fill_in :"Адрес электронной почты", :with => ""
				fill_in :"Пароль", :with => ""
				click_button
				response.should render_template('sessions/new')
				response.should have_tag("div.flash.error", ~/неправильно/i)
			end
		end

		describe "success" do
			it "should sign a user in and out" do
				user = Factory(:user)
				visit signin_path
				fill_in :"Адрес электронной почты", :with => user.email
				fill_in	:"Пароль", :with => user.password
				click_button
				controller.should be_signed_in
				click_link "Выйти"
				controller.should_not be_signed_in
			end
		end
	end
end
