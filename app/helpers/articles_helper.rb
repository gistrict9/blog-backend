module ArticlesHelper

	# true if published date has passed
	def is_live(publish_date)
		if publish_date > Time.now
			"not-live"
		end
	end

end