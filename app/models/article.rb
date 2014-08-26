class Article < ActiveRecord::Base

	# Includes
	extend FriendlyId
	acts_as_taggable

	# Pretty URLs
	friendly_id :title, use: :slugged

	# Relationships
	belongs_to :user

	# Validations
	validates :title, :content, :user_id, :description,
		presence: true

	validates :title,
		uniqueness: true

	validates :published,
		inclusion: { in: [true, false] }

	validates :tag_list, :published_at,
		presence: false,
		allow_blank: true

	validates :preview_image_url,
		format: { with: /https?:\/\/[\S]+/, message: "is not a valid URL" },
		allow_blank: true

	validates :description,
		length: { maximum: 425 },
		allow_blank: true

	# Search
	searchable do
	  text :title, boost: 5
	  text :content, boost: 3
   	text :tag_list, boost: 1
	  boolean :published
	  time :updated_at
	  time :published_at
	end

	# Scopes
	scope :unpublished, -> { where(published: false) }
	scope :published, -> { where(published: true) }

	# Methods
	def should_generate_new_friendly_id?
	  title_changed?
	end

end
