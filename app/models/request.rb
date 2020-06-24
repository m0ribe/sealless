class Request < ApplicationRecord
  belongs_to :user
  belongs_to :pass
  belongs_to :admission
end
