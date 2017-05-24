class Lead < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true

  enum occupation: { "Sou estudante" => 0, "Sou estagiário" => 1, "Sou funcionário" => 2, "Sou gerente/supervisor" => 3, "Sou diretor/sócio" => 4, "Outros" => 5 }

  def self.options_for_select
    occupations
  end

end
