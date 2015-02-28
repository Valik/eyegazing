# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  link       :string(255)
#  name       :string(255)
#  video_main :boolean
#  created_at :datetime
#  updated_at :datetime
#  landing    :boolean          default(FALSE)
#

class Video < ActiveRecord::Base
  belongs_to :album, -> { where kind: 'video' }
  has_one :photo, as: :photoable

  validates :link, presence: true

  after_save :replace_main, if: "video_main?"
  after_save :replace_landing, if: "landing?"
  after_commit :destroy_photo, on: :destroy

  self.per_page = 24

  scope :all_but_main_and_landing, -> { where("video_main = FALSE and landing = FALSE").includes(:photo) }

  def photo_type
    'Video'
  end

  protected

    def replace_main
      video = Video.where("id != ? AND video_main = TRUE", self.id).take
      video.destroy if video
    end

    def replace_landing
      video = Video.where("id != ? AND landing = TRUE", self.id).take
      video.destroy if video
    end

    def destroy_photo
      self.photo.destroy
    end
end
