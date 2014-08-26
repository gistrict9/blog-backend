class Image < ActiveRecord::Base

	# Includes
	has_attached_file :photo,
		:styles => { :regular => "600x600>" }

	# Validations
	validates_attachment :photo, :presence => true,
	  :content_type => { :content_type => ["image/jpeg", "image/png"], :message => "must be a jpeg or png" },
	  :size => { :in => 0..1.megabytes, :message => "must be less than 1 MB" }
	validates :photo, presence: true

end
