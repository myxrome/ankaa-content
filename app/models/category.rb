class Category < ActiveRecord::Base
  belongs_to :topic, inverse_of: :categories
  has_many :values, -> { order(:name) }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

  def destroy
    raise 'Cannot delete Category with active Values' unless values.where(active: true).count == 0
    super
  end

end
