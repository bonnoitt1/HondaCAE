class Goal < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :description, presence: false, length: { maximum: 500 }
  validates :date_created, presence: true, length: { maximum: 500 }
  validates :target_date, presence: true, length: { maximum: 500 }
end
