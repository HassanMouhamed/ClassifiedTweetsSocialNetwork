class PostController < ApplicationController

	include UserHelper

	before_action  :check_privacy, :except =>[:create]

	def create
		post = Post.new(get_post_params)
		if post.save
			init
			@posts = [post]
			@likes[post.id] = false
			@users[post.user_id] = User.retrieve(current_user_id)[0]
			respond_to do |f|
       			 f.js {render 'post/add_post'}
      		end
		end
	end


	def show

		post_id = params[:post_id] 
		init
		@posts = Post.retrieve(post_id)
		@comments = Comment.find_by_sql("SELECT * FROM comments WHERE post_id = #{post_id}")
		@users[@posts[0].user_id] = User.retrieve(@posts[0].user_id)[0]
		@likes[@posts[0].id] = !(Like.retrieve(current_user_id,@posts[0].id).empty?)
		@commenters = Comment.commenters(@comments)
		
	end

	def comment

		comment = Comment.new(get_comment_params)

		if comment.save 
			@commenters = Hash.new
			@comments = [comment]
			@commenters[comment.user_id] = User.retrieve(current_user_id)[0]
			respond_to do |f|
       			 f.js {render 'post/add_comment'}
      		end
		end
	end


	def like
		
		@post_id = params[:post_id] 		

		if Post.like_by(@post_id,current_user_id)
			@likes = Post.likes(@post_id)
			respond_to do |f|
       			 f.js {render 'post/like_post'}
      		end
		end
	end

	def unlike
		
		@post_id = params[:post_id] 
		liked = Like.retrieve(current_user_id,@post_id)
		
		unless liked.empty? 

			Post.unlike_by(@post_id,current_user_id)
			@likes = Post.likes(@post_id)

			respond_to do |f|
       			 f.js {render 'post/unlike_post'}
      		end
		end
	end


	protected

	def check_privacy

		post = Post.find_by_sql("SELECT user_id,is_public FROM posts WHERE id = #{params[:post_id]}")[0]

		if !post.is_public && !(post.user_id == current_user_id) && !(is_friend post.user_id , current_user_id)
			redirect_to '/'
		end


	end

	private

	def get_post_params
	 	par = params.permit(:caption,:image , :is_public)
	 	par[:user_id] = current_user_id
	 	par[:image_updated_at] = DateTime.now  
	 	return par 
	end

	def get_comment_params
		para = Hash.new
		para[:user_id] = current_user_id
		para[:post_id] = params[:post_id]
		para[:body] = params[:body]
		return para
	end

	def init
		@users = Hash.new
		@likes = Hash.new
	end
	
end
