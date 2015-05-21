class QuotesController < ApplicationController
	before_action :set_quote, only: [:show, :edit, :update, :destroy]
	before_filter :verify_vendor, only: [:index]
	def new
		@quote = Quote.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: quote }
	    end
	end

	def create
		if current_user
			@quote = current_user.quotes.new(quote_params)
			@quote.user_id = current_user.id
			@quote.email = current_user.email
		else
			@quote = Quote.new(quote_params)
		end

	    respond_to do |format|
	      if @quote.save
	        format.html { redirect_to @quote, notice: 'Your Quote Has Been Processed.' }
	        format.json { render action: 'show', status: :created, location: @quote }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @quote.errors, status: :unprocessable_entity }
	      end
	    end

	end

	def index
		@quotes = Quote.order("id DESC").all
	end

	def quote
		if signed_in?
			if current_user.quotes.last.present?
				@quote = current_user.quotes.last
				redirect_to quote_path(@quote)
			else
				redirect_to new_quote_path
			end
		else
			redirect_to new_quote_path
		end
	end

	def show
		if signed_in?
			if current_user.id == @quote.user_id
				@bids = @quote.bids
			else
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end

	private

	def set_quote
		@quote = Quote.find(params[:id])
	end

	def quote_params
      params.require(:quote).permit(:email, :name, :field, :description, :location, :user_id)
    end


end