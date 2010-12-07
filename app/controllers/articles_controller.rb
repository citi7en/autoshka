class ArticlesController < ApplicationController

	def new
		@article = Article.new
		@title = "Новая статья"
	end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:success] = "OK"
    else
      @title = "Новая статья"
      render 'new'
    end
  end
end
