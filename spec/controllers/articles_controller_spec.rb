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

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :title => "", :rubric => "", :autor => "", :release => "", :date => "2010/12/03", :content => ""}
        @article = Factory.build(:article, @attr)
        Article.stub!(:new).and_return(@article)
        @article.should_receive(:save).and_return(false)
      end

      it "should have the right title" do
        post :create, :article => @attr
        response.should have_tag("title", /Новая статья/)
      end

      it "should render the 'new' page" do
        post :create, :article => @attr
        response.should render_template('new')
      end
    end
  end


end
