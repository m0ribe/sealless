class Request < ApplicationRecord
  belongs_to :user
  has_one :admission, dependent: :destroy
  has_one :pass, dependent: :destroy
  accepts_nested_attributes_for :admission, allow_destroy: true
  accepts_nested_attributes_for :pass, allow_destroy: true

  mount_uploader :pdf, ImageUploader
end
