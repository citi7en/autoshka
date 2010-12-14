class ArticlesController < ApplicationController

def new
	@article = Article.new
	@title = "Новая статья"
end

  def show
    specs = params[:specs]
    @article = Article.find_by_year_month(specs[0], specs[1])
    @title = "OK"
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:success] = "Статья успешно добавлена"
      redirect_to @article
    else
      @title = "Новая статья"
	    render 'new'
    end
  end

	def edit
		@title = "Редактирование статьи"
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(params[:article])
			flash[:success] = "Статья успешно обновлена"
			redirect_to @article
		else
			@title = "Редактирование статьи"
			render 'edit'
		end
	end
end
