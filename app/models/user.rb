class User < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: {	maximum: 255 }
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :password, presence: true, length: { minimum: 6 }

	after_create :create_folder
	before_save :downcase_email

	has_secure_password


  def to_s
    name
  end

private

	def downcase_email
		self.email.downcase!
	end
	
	def create_folder
		dir = UPLOAD_PATH + self.id
		FileUtils.mkdir_p(dir) unless File.directory?(dir)
	end
end
