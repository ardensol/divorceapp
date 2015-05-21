class BidsController < ApplicationController
	before_action :set_bid, only: [:show, :edit, :update, :destroy]
	before_action :set_quote, only: [:show, :new]
	before_filter :verify_vendor, only: [:new, :index]

	def new
		@bid = Bid.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @bid }
	    end
	end
	
	def create
		@bid = current_user.bids.new(bid_params)
		@bid.user_id = current_user.id
		@bid.quote_id = params[:quote_id]
			
	    respond_to do |format|
	      if @bid.save
	        format.html { redirect_to quote_bid_path(@bid.quote_id, @bid), notice: 'Your Bid Has Been Processed.' }
	        format.json { render action: 'show', status: :created, location: @bid }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @bid.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def show
		if signed_in?	
			if current_user.id == @bid.user_id || current_user.id == @quote.user_id	
				@commentable = @bid
				@comments = @commentable.comments
				@comment = Comment.new
			else
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end

	def index
		@bids = current_user.bids.order("id DESC")
	end
	private

	def set_bid
		@bid = Bid.find(params[:id])
	end

	def set_quote
		@quote = Quote.find_by_id(params[:quote_id])
	end


	def bid_params
      params.require(:bid).permit(:user_id, :quote_id, :description, :amount, :name)
    end

end