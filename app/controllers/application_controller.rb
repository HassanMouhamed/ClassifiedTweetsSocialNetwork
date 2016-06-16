class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include UserHelper
  before_action :authenticate , :except => [:login , :signup , :logout]

  	def authenticate

		unless session[:id]
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

end
