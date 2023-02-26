module SearchHelper
	def invert_search_direction(direction)
		if 'asc' == direction.to_s
			'desc'
		else
			'asc'
		end
	end

	def second_relevant_params(old_params, key)
		inverted_direction = invert_search_direction(old_params[:second_relevant][key])
		{ key => inverted_direction }
	end
end
