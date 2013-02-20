class User < ActiveRecord::Base
  #attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

	has_many :bets, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable


  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :pezzos, :administrator, :pezzos_que_apuesta

  validates :pezzos, :numericality => {:greater_than_or_equal_to => 0, :message => "no puedes tener menos de 0 pezzos"}
  

def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    #CHAMBONADAAAA!!!! ------
    user.email = auth.uid
    #------
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!    
  end
end


  def descontar_pezzos(monto)
    pezzos_total = self.pezzos - monto
    self.update_attributes(pezzos: pezzos_total)
  end
  def consignar_pezzos(monto)
    pezzos_total = self.pezzos + monto
    self.update_attributes(pezzos: pezzos_total)
  end


end
