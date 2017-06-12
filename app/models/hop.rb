class Hop
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name, type: String
  field :status, type: Integer, default: 0
  field :recursive, type: Mongoid::Boolean
  field :next_stage, type: String
  field :approved, type: Mongoid::Boolean, default: false
  field :approved_user, type: String
  field :has_image, type: Mongoid::Boolean, default: false
  field :picture_file_name, type: String
  field :picture_file_size, type: Integer
  field :picture_content_type, type: String
  field :priority, type: Integer, default: 0
  field :estimated_time, type: String
  field :versao, type: String
  
  belongs_to :stage
  has_many :comments

  has_mongoid_attached_file :picture, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'PainelMobile',
    :bucket    => 'PainelMobile',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  after_update :update_stage_status

  def update_stage_status
    
    if self.stage.hops.count > 0
      total = 0
      self.stage.hops.each do |h|
        total += h.status
      end
      percentil = total / self.stage.hops.count
    else
      percentil = 0
    end

    self.stage.update(:status => percentil)

    if self.status == 100 && self.approved == false
      self.send_approve_notification
    end
    
  end

  def send_approve_notification
    self.stage.core.customer.users.each do |u|
      u.notifications.create(:description => 'Há um novo item aguardando sua aprovação', :icon => 'fa-check-square-o text-red', :link => '/client_projects/'+self.stage.core.id)
    end
  end

end