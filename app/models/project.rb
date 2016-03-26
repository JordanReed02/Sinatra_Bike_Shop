class Project < ActiveRecord::Base
  validates_presence_of :title, :budget
  belongs_to :user
  has_many :parts
end
