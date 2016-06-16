class User < ActiveRecord::Base
	has_secure_password
	has_attached_file :profile_picture
	validates_confirmation_of :password
 	validates_attachment_size :profile_picture , :less_than => 3.megabytes
    validates_attachment_content_type :profile_picture , :content_type => ['image/jpeg','image/png']

    scope :retrieve ,lambda {|id| find_by_sql("SELECT * FROM users WHERE id = #{id}")}

end
