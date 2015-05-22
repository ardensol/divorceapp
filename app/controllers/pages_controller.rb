class PagesController < ApplicationController

	def home
		if signed_in?
			if current_user.vendor == true
				redirect_to quotes_path
			else
				redirect_to '/quote'
			end
		end
		
		@states = State.all

	end

end