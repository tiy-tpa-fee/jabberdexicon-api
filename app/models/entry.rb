require 'commonmarker'

class Entry < ApplicationRecord
  belongs_to :user
  validates :term, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :definition, presence: true
  before_save :format_definition
  after_commit :generate_slug

  def self.searchable_columns
    [:term, :definition]
  end

  def format_definition
    self.formatted_definition = CommonMarker.render_html(definition)
  end

  def generate_slug
    update_columns slug: [self.id, self.term.parameterize].join('-')
  end
end
