class User < ApplicationRecord
  validates :access_token, presence: true, uniqueness: true
  has_many :entries
end
