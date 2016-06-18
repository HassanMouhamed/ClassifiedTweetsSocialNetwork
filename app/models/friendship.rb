class Friendship < ActiveRecord::Base

	def self.unfriend user1 , user2
		Friendship.connection.execute("DELETE FROM friendships WHERE first_user_id = #{user1} 
			                          AND second_user_id = #{user2} OR 
			                          first_user_id = #{user2} 
			                          AND second_user_id = #{user1}")
	end

	def self.create_friendship user1 , user2
		Friendship.connection.execute("INSERT INTO friendships VALUES(#{user1},#{user2})")

	end

end
