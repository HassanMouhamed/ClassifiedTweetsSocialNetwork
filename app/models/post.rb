class Post < ActiveRecord::Base
	has_attached_file :image
	validates_presence_of :caption
	validates_attachment_size :image , :less_than => 3.megabytes
    validates_attachment_content_type :image , :content_type => ['image/jpeg','image/png']
end
