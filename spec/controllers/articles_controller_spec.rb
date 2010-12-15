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

  describe "GET 'show'" do

    before(:each) do
      @article = Factory(:article)
      Article.stub!(:find, @article.id).and_return(@article)
    end

    it "should be successfull" do
      get :show, :id => @article
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => @article
      response.should have_tag("title", /#{@article.title}/)
    end

    it "should include the article's title" do
      get :show, :id => @article
      response.should have_tag("h1", /#{@article.title}/)
    end

    it "should include the article's rubric" do
      get :show, :id => @article
      response.should have_tag("h2", /#{@article.rubric}/)
    end

    it "should include the article's autor" do
      get :show, :id => @article
      response.should have_tag("h2", /#{@article.autor}/)
    end
    
    it "should include the article's release number" do
      get :show, :id => @article
      response.should have_tag("h2", /#{@article.release}/)
    end

    it "should include the article's date" do
      get :show, :id => @article
      response.should have_tag("h2", /#{@article.date}/)
    end

    it "should include tha article's date" do
      get :show, :id => @article
      response.should have_tag("div.article_content", /#{@article.content}/)
    end
  end

  describe "GET 'archive'" do

    before(:each) do
      @article = Factory(:article, :date => "2010-12-01")
      @articles = [@article]
      10.times do
        @articles << Factory(:article, :date => Factory.next(:date))
      end
    end

    it "should be successful" do
       get :archive, :year => 2010, :month => 12
       response.should be_success
    end

    it "should have the right title" do
      get :archive, :year => 2010, :month => 12
      response.should have_tag("title", /2010 12/)
    end

    it "should have an element for each article" do
      get :archive, :year => 2010, :month => 12
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

    describe "success" do

      before(:each) do
        @attr = { :title => "Новый Год", 
                  :rubric => "Записки",
                  :content => "С Новым Годом!",
                  :autor => "Никита Литвинков",
                  :release => 2,
                  :date => "2010-12-08" }
        @article = Factory(:article, @attr)
        Article.stub!(:new).and_return(@article)
        @article.should_receive(:save).and_return(true)
      end

      it "should redirect to the articke show page" do
        post :create, :article => @article
        response.should redirect_to(article_path(@article))
      end

      it "should have a success  message" do
        post :create, :article => @attr
        flash[:success].should =~ /Статья успешно добавлена/
      end
    end
  end

	describe "GET 'edit'" do
		
		before(:each) do
			@article = Factory(:article)
		end

		it "should be successful" do
			get :edit, :id => @article
			response.should be_success
		end

		it "should have the right title" do
			get :edit, :id => @article
			response.should have_tag("title", /Редактирование статьи/i)
		end
	end

  describe "PUT 'update'" do

    before(:each) do
      @article = Factory(:article)
      Article.should_receive(:find).with(@article).and_return(@article)
    end

		describe "failure" do

			before(:each) do
				@invalid_attr = { :title => "", :rubric => "", :autor => "", :date => "", :release => "", :content => "" }
				@article.should_receive(:update_attributes).and_return(false)
			end

			it "should render the 'edit' page" do
				put :update, :id => @article, :article => @invalid_attr
				response.should render_template('edit')
			end

			it "should have the right title" do
				put :update, :id => @article, :article => @invalid_attr
				response.should have_tag("title", /Редактирование статьи/i)
			end
		end

    describe "success" do
      before(:each) do
        @attr = { :title => "Снусмумрик покидает Муми-Дол!", :rubric => "Новости Муми-Дола", :autor => "Воробей", :date => "2010/12/13", :release => "3", :content => "<p>ПРОПАЛА  СУМКА  МУМИ-МАМЫ!</p>  <p>Никаких  путеводных  нитей!  Розыски продолжаются. Неслыханное пиршество в вознаграждение за находку!</p>"}
        @article.should_receive(:update_attributes).and_return(true)
      end

			it "should redirect to the article show page" do
				put :update, :id => @article, :article => @attr
				response.should redirect_to(article_path(@article))
			end

			it "should have a flash message" do
				put :update, :id => @article, :article => @attr
				flash[:success].should =~ /Статья успешно обновлена/
			end
    end
  end
end
