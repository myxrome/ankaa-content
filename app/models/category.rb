class Category < ActiveRecord::Base
  belongs_to :topic, inverse_of: :categories
  has_many :values, -> { order(:name) }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context
  before_destroy :have_active_values?, prepend: true

  private
  def have_active_values?
    unless values.where(active: true).count == 0
      errors[:base] << 'Cannot delete Category with active Values'
      false
    end
  end

end
