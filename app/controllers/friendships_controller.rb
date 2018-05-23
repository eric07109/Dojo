class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		@friendship = current_user.sent_friendships.build(friendship_params)
		
		if @friendship.save
			redirect_back fallback_location: posts_path
		else
			logger.debug "#{@friendship.errors.full_messages.to_sentence}"
		end
	end

	def destroy
	end

	private
	def friendship_params
		params.permit(:receiver_id)
	end
end
