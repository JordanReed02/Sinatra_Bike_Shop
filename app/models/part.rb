class Part < ActiveRecord::Base
  validates_presence_of :name, :price
  belongs_to :project
end
