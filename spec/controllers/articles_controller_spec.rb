require 'spec_helper'

describe ArticlesController do
	integrate_views

	describe "GET 'new'" do
		it "should be successful" do
			get 'new'
			response.should be_success
		end

		it "should have the right title" do
			get 'new'
			response.should have_tag("title", /Новая статья/)
		end
	end


end
