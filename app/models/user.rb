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
  field :picture_file_size, type: Integer
  field :picture_content_type, type: String
  field :login, type: String
  field :user_type, type: String

  has_secure_password
  
  belongs_to :client
  has_many :backlogs
  
  has_mongoid_attached_file :picture, :styles => { :medium => "320x320>", :thumb => "160x160#" },
                      :path => ':rails_root/public/images/:id-:basename-:style.:extension',
                      :url => '/images/:id-:basename-:style.:extension'
   validates_attachment_size :picture, :less_than => 5.megabytes
   validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']
end
