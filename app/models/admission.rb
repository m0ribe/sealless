class Admission < ApplicationRecord
  belongs_to :request, optional: true
end
