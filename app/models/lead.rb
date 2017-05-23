class Lead < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true

  enum occupation: {"Sou estudante": 0, "Sou estagiário": 1}

  def self.options_for_select
    occupations
  end
end
