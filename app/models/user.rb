class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include ActiveModel::SecurePassword

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :rg, type: String
  field :cpf, type: String
  field :password_digest, type: String
  field :picture_file_name, type: String
  field :picture_file_size, type: String
  field :picture_content_type, type: String
  field :login, type: String
  field :user_type, type: String
  
  has_secure_password
  
  belongs_to :customer, optional: true
  has_many :backlogs, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  after_create :welcome_notification

  def welcome_notification
    self.notifications.create(:description => 'Seja bem vindo '+self.name+', entre em seu perfil para completar seu cadastro', :icon => 'fa-handshake-o text-green', :link => '/profile')
  end
  
  has_mongoid_attached_file :picture, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'PainelMobile',
    :bucket    => 'PainelMobile',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']
end
