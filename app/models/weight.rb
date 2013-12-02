class Weight < ActiveRecord::Base
belongs_to :user
validates :user_id, presence: true 
validates :weight, presence: true
end
