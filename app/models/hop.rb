class Hop
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name, type: String
  field :status, type: Integer, default: 0
  field :recursive, type: Mongoid::Boolean, default: false
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
  field :cleared, type: Mongoid::Boolean, default: false
  
  belongs_to :stage
  has_many :comments
  belongs_to :user, optional: :true

  has_mongoid_attached_file :picture, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'PainelMobile',
    :bucket    => 'PainelMobile',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf']
  
  after_update :update_stage_status
  after_create :send_notification
  
  def send_notification
    if self.cleared != true
      User.where(:user_type => 'superUser').each do |u|
        u.notifications.create(:description => 'Há uma nova solicitação de '+self.stage.core.customer.fantasy_name, :icon => 'fa-bell text-red', :link => '/stages/'+self.stage.id)
      end
    end
  end

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