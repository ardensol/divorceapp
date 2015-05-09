class QuotesController < ApplicationController
	before_action :set_quote, only: [:show, :edit, :update, :destroy]
	def new
		@quote = Quote.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @mainoption }
	    end
	end

	def create
		@quote = Quote.new(quote_params)

	    respond_to do |format|
	      if @quote.save
	        format.html { redirect_to root_path, notice: 'Your Quote Has Been Processed.' }
	        format.json { render action: 'show', status: :created, location: @quote }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @quote.errors, status: :unprocessable_entity }
	      end
	    end

	end

	private

	def set_quote
		@quote = Quote.find(params[:id])
	end

	def quote_params
      params.require(:quote).permit(:email, :name, :field, :description, :location)
    end
end