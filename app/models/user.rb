class User < ActiveRecord::Base
  has_many :instruments_users
  has_many :genres_users
  has_many :genres, through: :genres_users
  has_many :instruments, through: :instruments_users

  validates :email, uniqueness: true
  validate :email_format

  private
  def email_format
    unless email.match /\w+@\w+.\w+/
      errors.add(:email, "must be a valid email address")
    end
  end
end
