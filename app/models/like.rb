class Like < ActiveRecord::Base

	 scope :retrieve ,lambda {|user_id , post_id | find_by_sql("SELECT * FROM likes WHERE post_id = #{post_id} AND 
			                       user_id = #{user_id}")}
end
