class PagesController < ApplicationController
  def home
		@title = "Свежий номер"
  end

  def contact
		@title = "Контактная информация"
  end

	def about
		@title = "О сайте"
	end

end
