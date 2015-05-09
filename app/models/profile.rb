class Profile < ActiveRecord::Base
	has_attached_file :avatar, :styles => {:medium => "225x225#", :thumb => "90x90>", :mini => "40x40#"}, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
