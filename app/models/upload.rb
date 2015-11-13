class Upload < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :user
  validates_format_of :name, with: /(\.|\/)(txt)\z/i
end
