class Comment < ActiveRecord::Base
	validates :body , length: {minimum: 1}

	def self.commenters comments

		commenters = Hash.new

		comments.each do |comment|
			unless commenters[comment.user_id]
				commenters[comment.user_id] = User.retrieve(comment.user_id)[0]
			end	
		end

		return commenters
	end
end
