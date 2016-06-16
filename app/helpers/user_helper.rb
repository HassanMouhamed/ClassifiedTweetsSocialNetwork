module UserHelper


	def current_user
		User.find_by_sql("SELECT * FROM users WHERE id= #{session[:id]} ")[0]
	end

	def current_user_id
		session[:id]
	end
end
