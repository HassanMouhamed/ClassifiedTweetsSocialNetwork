class Request < ActiveRecord::Base

	def self.delete (sender_id , user_id)
		Request.connection.execute("DELETE FROM requests WHERE user_id = #{user_id} AND sender_id = #{sender_id}")		
	end

	def self.retrieve user_id
		Request.find_by_sql("SELECT * FROM requests WHERE user_id = #{user_id}")
	end

	def self.find sender_id,user_id
		Request.find_by_sql("SELECT * FROM requests WHERE sender_id = #{sender_id} AND 
							user_id = #{user_id}")
	end

	def self.insert sender , user
		Request.connection.execute("INSERT INTO requests VALUES(#{user},#{sender},false)")
	end
end
