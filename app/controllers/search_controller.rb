class SearchController < ApplicationController

	def show
		@users = search_users(search_params)
	end

	def posts
		
		@posts = Array.new

		if params[:search_query].length >0
			@likes = Hash.new
			@users = Hash.new

			@posts = Post.find_by_sql("SELECT * FROM posts WHERE caption LIKE '%#{params[:search_query]}%' AND
					(is_public = true OR user_id = #{current_user_id} OR user_id in (SELECT first_user_id from friendships WHERE second_user_id = #{current_user_id} UNION 
				                       SELECT second_user_id from friendships WHERE first_user_id = #{current_user_id}))")
		

			@posts.each do |post|
				unless @users[post.user_id]
					@users[post.user_id] = User.retrieve(post.user_id)[0]
				end
				@likes[post.id] = !(Like.retrieve(current_user_id,post.id).empty?)	
			end
		end
	end

	private

	def search_users parameters
		
		users = Array.new

		if parameters[:email].length>0 || parameters[:first_name].length>0 || parameters[:last_name].length>0 || parameters[:phone_number].length>0 || parameters[:hometown].length>0
			users = User.all
			users = users.where("email LIKE ?", "%#{parameters[:email]}%") if parameters[:email].length>0 
			users = users.where("first_name LIKE ?", "%#{parameters[:first_name]}%") if parameters[:first_name].length>0
			users = users.where("last_name LIKE ?", "%#{parameters[:last_name]}%") if parameters[:last_name].length>0
			users = users.where("phone_number LIKE ?", "%#{parameters[:phone_number]}%") if parameters[:phone_number].length>0
			users = users.where("hometown LIKE ?", "%#{parameters[:hometown]}%") if parameters[:hometown].length>0
		
		end

		return users
	end

	def search_params
		params.permit(:email, :first_name, :last_name, :phone_number, :hometown)
	end
end