class Upload < ActiveRecord::Base
  attr_reader :get_path, :file_path
  belongs_to :user

  validates_presence_of :name, :user
  validates_format_of :name, with: /(\.|\/)(txt)\z/i

  after_create :create_folder
  before_destroy :del_folder

  def get_path
    "#{self.user.get_path}#{id}/"
  end

  def file_path
    get_path + name
  end
  
private

  def del_folder
    FileUtils.rm_rf(get_path) if File.directory?(get_path)
  end

  def create_folder
    FileUtils.mkdir_p(get_path) unless File.directory?(get_path)
  end

end
