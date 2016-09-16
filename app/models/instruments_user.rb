class InstrumentsUser < ActiveRecord::Base
  belongs_to :instrument
  belongs_to :user
end
