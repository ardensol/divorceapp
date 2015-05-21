class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
  	@comments = @commentable.comments
  end

  def new
  	@comment = @commentable.comments.new
  end

  def create
  	@comment = @commentable.comments.new(comment_params)
  	@comment.user = current_user
    if @comment.save
      ##this won't work if you add another klass to the commentable other than bid MVP'ing this BITCH!
  		redirect_to quote_bid_path(@commentable.quote_id, @commentable), notice: "Comment Created."
  	else
  		render :new
  	end
  end


private

	def load_commentable
		klass = [Bid].detect { |c| params["#{c.name.underscore}_id"] }
     	@commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def comment_params
      params.require(:comment).permit(:user_id, :content)
    end

end
