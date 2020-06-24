class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :request
  belongs_to :pass

end
