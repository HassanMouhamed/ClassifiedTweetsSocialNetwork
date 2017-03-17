class Post < ActiveRecord::Base
	has_attached_file :image
	validates_presence_of :caption
	validates_attachment_size :image , :less_than => 3.megabytes
    validates_attachment_content_type :image , :content_type => ['image/jpeg','image/png']


    def self.retrieve post_id
			find_by_sql("SELECT * FROM posts WHERE id = #{post_id}")
    end

    def self.likes post_id
    	find_by_sql("SELECT likes FROM posts WHERE id = #{post_id}")[0].likes
    end

    def self.like_by post_id,user_id 
    	begin
    		transaction do
		    	Post.connection.execute("INSERT into likes values(#{post_id},#{user_id})")
				Post.connection.execute("UPDATE posts set likes = likes+1 WHERE id = #{post_id}")
    		end
    	rescue 
    		return false
    	end
  
    	return true
    end

    def self.unlike_by post_id,user_id 
    	begin
    		transaction do
		    	Post.connection.execute("DELETE from likes WHERE post_id = #{post_id} AND 
			                       user_id = #{user_id} ")
				Post.connection.execute("UPDATE posts set likes = likes-1 WHERE id = #{post_id}")
    		end
    	rescue 
    		return false
    	end
  
    	return true
    end
end
