class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :comment, type: String
  field :has_image, type: Mongoid::Boolean, default: false
  field :picture_file_name, type: String
  field :picture_file_size, type: Integer
  field :picture_content_type, type: String

  has_mongoid_attached_file :picture, :styles => { :medium => "320x320>", :thumb => "160x160#" },
                      :path => ':rails_root/public/images/:id-:basename-:style.:extension',
                      :url => '/images/:id-:basename-:style.:extension'
  validates_attachment_size :picture, :less_than => 10.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  belongs_to :hop
  belongs_to :user

  after_create :send_notification

  def send_notification
    if self.user.user_type == 'User'
      User.where(:user_type => 'superUser').each do |u|
        u.notifications.create(:description => self.user.name+' comentou o item '+self.hop.name, :icon => 'fa fa-comment-o text-green', :link => '/stages/'+self.hop.stage.id)
      end
    else
      self.user.client.users.each do |u|
        u.notifications.create(:description => self.user.name+' comentou o item '+self.hop.name, :icon => 'fa fa-comment-o text-green', :link => '/client_projects/'+self.hop.stage.core.id)
      end
    end
  end

end
