class Pass < ApplicationRecord
  has_many :users
  belongs_to :request
end
