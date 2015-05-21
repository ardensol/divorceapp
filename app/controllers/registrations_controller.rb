class RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params, if: :devise_controller?

	def create
		super
		check_existing_quotes
	end

	def check_existing_quotes
		email = current_user.email
		@quote = Quote.find_by_email(email)
		if @quote != nil
			@quote.user_id = current_user.id
			@quote.save
		end
	end

	def update_sanitized_params
       devise_parameter_sanitizer.for(:sign_up) << :vendor
    end

end