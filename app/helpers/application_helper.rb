# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	# Return a title on a per-page basis.
	def title
		base_title = "Автошка online"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{h(@title)}"
		end
	end

	def logo
		image_tag("logo.png", :alt => "Автошка online")
	end
end
