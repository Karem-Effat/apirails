class User < ApplicationRecord
  validates :email , uniqueness: true
  validates :phone , uniqueness: true

end
