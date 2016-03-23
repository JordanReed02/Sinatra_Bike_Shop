class Project < AvtiveRecord::Base
  belongs_to :user
  has_many :parts
end
