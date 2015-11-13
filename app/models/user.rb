class User < ActiveRecord::Base

	attr_reader :get_path

	has_many :uploads, dependent: :destroy
	validates :name, presence: true, length: { minimum: 3, maximum: 50 }
	validates :email, presence: true, length: {	minimum: 6, maximum: 255 }

	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	after_create :create_folder
	before_save :downcase_email

	has_secure_password # this will validate password & confirmation


  def to_s
    name
  end
  
	def get_path
		"#{UPLOAD_PATH}#{id}/"
	end

private


	def downcase_email
		self.email.downcase!
	end

	def create_folder
		FileUtils.mkdir_p(get_path) unless File.directory?(get_path)
	end
end
