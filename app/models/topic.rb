class Topic < ActiveRecord::Base
  belongs_to :topic_group, inverse_of: :topics
  has_many :categories, -> { order(:order) }, inverse_of: :topic, dependent: :destroy
  has_many :facts, as: :context
  before_destroy :have_active_categories?

  private
  def have_active_categories?
    errors.add(:base, 'Cannot delete Category with active Values') unless categories.where(active: true).count == 0
    errors.blank?
  end

end
