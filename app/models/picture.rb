class Picture
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :picture_file_name, type: String
  field :picture_file_size, type: String
  field :picture_content_type, type: String

  belongs_to :message

  has_mongoid_attached_file :picture, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'PainelMobile',
    :bucket    => 'PainelMobile',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :picture, :less_than => 10.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf']


end
