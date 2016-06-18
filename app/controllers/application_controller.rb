class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include UserHelper
  before_action :authenticate , :except => [:login , :signup , :logout]
  before_action :requests_cout , :except => [:login , :signup , :logout]
  	def authenticate

		unless session[:id]
			@user = User.new
			render  template: "user/authentication" , layout: "authentication" 
			return false 
		end
		return true 
	end

	def is_friend first_id , second_id
		!(Friendship.find_by_sql("SELECT * FROM friendships WHERE 
											(first_user_id = #{first_id } AND second_user_id = #{second_id})
											OR (first_user_id = #{second_id} AND second_user_id = #{first_id})").empty?)
	end

	def has_request sender , user

		!(Request.find_by_sql("SELECT * FROM requests WHERE user_id = #{user} AND sender_id = #{sender}").empty?)
	
	end

	def requests_cout
		r =  ActiveRecord::Base.connection.execute("SELECT COUNT(sender_id) from requests 
												WHERE user_id = #{current_user_id}")
		r.each do |row|
			@requests_cout = row
		end	
	end

end
