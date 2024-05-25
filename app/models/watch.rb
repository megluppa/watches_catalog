class Watch < ApplicationRecord
  CATEGORIES = ['standard','premium','premium+']

  validates_inclusion_of :category, :in => CATEGORIES

  scope :by_category, -> (category) { where(category: category) }
  scope :by_name, -> (name) { where("name LIKE ?", "%#{Watch.sanitize_sql_like(name)}%") }
  scope :by_price, -> (from, to) { where("price >= ? AND price <= ?", from, to) }
  scope :by_description, -> (description) { where("description LIKE ?", "%#{Watch.sanitize_sql_like(description)}%") }
  scope :by_url, -> (url) { where("url LIKE ?", "%#{Watch.sanitize_sql_like(url)}%") }
end
