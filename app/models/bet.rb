class Bet < ActiveRecord::Base
  belongs_to :partido
  belongs_to :user

  validates :golesLocal, presence: true 
  validates :golesVisitante, presence: true 
  validates :monto, presence: true 
  validates :user_id, presence: true 
  
  attr_accessible :golesLocal, :golesVisitante, :monto, :user_id, :pezzos_ganados, :posteo_fb
end
