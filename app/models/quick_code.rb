class QuickCode < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true, length: { in: 3..20 }
  validates :content, :presence => true, length: { in: 1..50 }
  validates :size, :presence => true, length: { in: 100..1000 }, numericality: { only_integer: true }
  validates :offset, :presence => true, length: { in: 1..100 }, numericality: { only_integer: true }
  validates :unit, :presence => true, length: { in: 1..100 }, numericality: { only_integer: true }
  validates :fill, :css_hex_color => true, :presence => true
  validates :color, :css_hex_color => true, :presence => true
  validate :qr_count_within_limit, :on => :create

  def qr_count_within_limit
    if self.user.quick_codes(:reload).count >= 10
      errors.add(:base, "Exceeded QR Code limit. Delete old QR Codes for more room.")
    end
  end
end
