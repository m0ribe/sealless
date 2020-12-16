class Pass < ApplicationRecord
  has_many :users
  belongs_to :request

  validates :final_user_id, presence: true
end
