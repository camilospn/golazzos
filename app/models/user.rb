class User < ActiveRecord::Base

	has_many :bets, :dependent => :destroy
  has_many :partidos, :through => :bets, :uniq => true

  has_one :profile

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key =>"friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  #attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, 
                  :uid, :pezzos, :administrator, :invitation_token, :visits_number, 
                  :invitation_number, :invitation_id, :post_on_fb, :bets_number, :age,
                   :pezzos_que_apuesta, :local_apostado, :visitante_apostado, :referidos


  validates :pezzos, :numericality => {:greater_than_or_equal_to => 0, :message => "no puedes tener menos de 0 pezzos"}
  #INVITATION before_create :set_invitation_limit
  #----este si se necesita validates_presence_of :invitation_id, :message => 'is required'
  #validates_uniqueness_of :invitation_id

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  #belongs_to :invitation


def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.profile = Profile.new
    #CHAMBONADAAAA!!!! ------
    if auth.info.email == nil
      
    else
      user.email = auth.info.email
    end
    
    #------
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!    
  end
end


#invitaciones

def facebook
  @facebook ||= Koala::Facebook::API.new(oauth_token)
end

def friends_count
  facebook.get_connection("me","friends").size
end

  def descontar_pezzos(monto)
    pezzos_total = self.pezzos - monto
    self.update_attributes(pezzos: pezzos_total)
  end
  def consignar_pezzos(monto)
    pezzos_total = self.pezzos + monto
    self.update_attributes(pezzos: pezzos_total)
  end
  def aumentar_visitas
    visitas_total = self.visits_number + 1
    self.update_attributes(visits_number: visitas_total)
  end
  def aumentar_invitaciones
    invitaciones_total = self.invitation_number + 1
    self.update_attributes(invitation_number: invitaciones_total)
  end
  def aumentar_referidos
    referidos_total = self.referidos + 1
    self.update_attributes(referidos: referidos_total)
  end
  def aumentar_apuestas
    apuestas_total = self.bets_number + 1
    self.update_attributes(bets_number: apuestas_total)
  end
  def aumentar_posts
    posts_total = self.post_on_fb + 1
    self.update_attributes(post_on_fb: posts_total)
  end
  
    def position(column = 'pezzos', order = 'DESC')
    order_by = "#{column} #{order}"
    arrow = order.capitalize == "ASC" ? "<=" : ">="
    User.where("#{column} #{arrow} ?", self.send(column)).order(order_by).count
  end  
end
