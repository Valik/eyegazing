# == Schema Information
#
# Table name: recalls
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  text         :text
#  published    :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  published_at :datetime
#

class Recall < ActiveRecord::Base
  validates :name, :email, :text, presence: true

  scope :published, -> { where published: true }

  self.per_page = 10

  before_save :set_published_at, if: Proc.new { |recall| recall.published == true }

  protected

    def set_published_at
      self.published_at = Time.current
    end
end
