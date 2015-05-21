class Bid < ActiveRecord::Base
	belongs_to :quote
	belongs_to :user
	has_many :comments, as: :commentable
end
