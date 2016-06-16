class UserController < ApplicationController

	include UserHelper

	def login
		users = User.find_by_sql("SELECT * from users WHERE email = '#{params[:email]}'")

		if !users.empty? && users[0].authenticate(params[:password])
			session[:id] = users[0].id;
		end
		redirect_to '/'	
	end


	def logout
		session[:id] = nil
		redirect_to '/'
	end

	def signup
		user = User.new(get_params);
		if user.save
			session[:id] = user.id
		end
		redirect_to "/"
	end


	def home
		@posts = Post.find_by_sql("SELECT * FROM posts WHERE user_id in 
			                      (SELECT first_user_id from friendships WHERE second_user_id = #{current_user_id} UNION 
			                       SELECT second_user_id from friendships WHERE first_user_id = #{current_user_id}) ")

		@posts = @posts.concat(Post.find_by_sql("SELECT * FROM posts WHERE is_public = 1 OR user_id = #{current_user_id}  order by image_updated_at DESC  LIMIT 10")).uniq

		@users = Hash.new
		@likes = Hash.new

		@posts.each do |post|
			unless @users[post.user_id]
				@users[post.user_id] = User.retrieve(post.user_id)[0]
			end
			@likes[post.id] = !(Like.retrieve(current_user_id,post.id).empty?)	
		end

	end

	def profile
		@likes = Hash.new
		@users = Hash.new

		@friends = params[:user_id].to_i == current_user_id || (is_friend params[:user_id] , current_user_id)

		if @friends  
			@posts = Post.find_by_sql("SELECT * FROM posts WHERE user_id = #{params[:user_id]} ORDER by image_updated_at DESC")
		else
			@posts = Post.find_by_sql("SELECT * FROM posts WHERE user_id = #{params[:user_id]} AND is_public = true ORDER by image_updated_at DESC")			
		end

		@users[params[:user_id].to_i] = User.retrieve(params[:user_id])[0] 
		@user =  @users[params[:user_id].to_i]

		@posts.each do |post|
			@likes[post.id] = !(Like.retrieve(current_user_id,post.id).empty?)	
		end
	end

	def friends

		@users = User.find_by_sql("SELECT * FROM users WHERE id in (SELECT first_user_id from friendships WHERE second_user_id = #{current_user_id} UNION 
			                       SELECT second_user_id from friendships WHERE first_user_id = #{current_user_id})") 

	end

	private 

	def get_params
		params.permit(:first_name,:last_name,:password , :password_confirmation,:email,:phone_number,:birth_date,:hometown,:about_me,:marital_status,:gender,:profile_picture)
	end
end
