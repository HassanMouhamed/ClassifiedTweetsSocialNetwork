class FriendshipController < ApplicationController


	def show
		requests = Request.retrieve(current_user_id)
		@users = Array.new

		requests.each do |request|
			@users << User.retrieve(request.sender_id)[0]
		end
	end

	def send_request
		Request.insert(current_user_id,params[:user_id])
		url = '/users/'+params[:user_id]
		redirect_to user_url
	end

	def cancel
		Request.delete(current_user_id,params[:user_id])
		url = '/users/'+params[:user_id]
		redirect_to user_url
	end

	def unfriend
		Friendship.unfriend(current_user_id , params[:user_id])
		redirect_to user_url
	end

	def accept

		unless Request.find(params[:user_id],current_user_id).empty?
			Friendship.create_friendship(current_user_id,params[:user_id])
			Request.delete(params[:user_id],current_user_id)
		end
		redirect_to '/friendship/show'
	end

	def reject
		Request.delete(params[:user_id],current_user_id)
		redirect_to '/friendship/show'
	end

	private

	def get_params
		params.permit(:user_id)
	end

	def user_url
		'/users/'+params[:user_id]
	end
end