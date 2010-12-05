class ArticlesController < ApplicationController

	def new
		@article = Article.new
		@title = "Новая статья"
	end
end
