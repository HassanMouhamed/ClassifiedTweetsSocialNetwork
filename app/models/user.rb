class User < ActiveRecord::Base
	has_secure_password
	has_attached_file :profile_picture
	validates_confirmation_of :password
 	validates_attachment_size :profile_picture , :less_than => 3.megabytes
    validates_attachment_content_type :profile_picture , :content_type => ['image/jpeg','image/png']


	before_save { self.email = email.downcase }
	validates :first_name,  presence: true, length: { maximum: 50 }
	validates :last_name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	                    format: { with: VALID_EMAIL_REGEX },
	                    uniqueness: { case_sensitive: false }
	  
	VALID_BIRTH_DATE_REGEX = ~ /\A(?:0?[1-9]|1[0-2])\/(?:0?[1-9]|[1-2]\d|3[01])\/\d{4}\z/i
	validates :birth_date, presence: true, length: { maximum: 50 }, 
	                    format: { with: VALID_BIRTH_DATE_REGEX }
	validates :phone_number,  presence: true, length: { maximum: 12 , minimum: 8 }
	validates :password, presence: true, length: { minimum: 6 }
	validates :hometown , presence: true , length: { maximum: 20 }
	validates :about_me , presence: true , length: { maximum: 50 }
	validates :marital_status , presence: true
	validates :gender , presence: true

	scope :retrieve ,lambda {|id| find_by_sql("SELECT * FROM users WHERE id = #{id}")}


end