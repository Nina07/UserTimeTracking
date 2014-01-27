 class User < ActiveRecord::Base
 include Common
	has_many :user_times , dependent: :destroy
	validates :name , :uniqueness=> true , 
					  :presence=> true ,
    				  length: { in: 6..15 }
    validates_format_of :name,  :with => /\A[a-zA-Z0-9]+[^\W]\z/
    
end