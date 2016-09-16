class Instrument < ActiveRecord::Base
  has_many :instruments_users
  has_many :users, through: :instruments_users

  validates :name, uniqueness: true
end
