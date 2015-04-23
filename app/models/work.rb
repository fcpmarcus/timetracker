class Work < ActiveRecord::Base
	belongs_to :project
	belongs_to :user

	validates :project, presence: true
	validates :user, presence: true
	validates :datetimeperformed, presence: true
	validate :date_is_in_past
	validates :hours, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 8 }

	scope :fullday, -> { where("hours >= 8") }
	# scope :recent, -> { where("datetimeperformed > '#{Time.now - 7.days}'")}

	def self.recentdays(numdaysago)
		since_date = Time.now - numdaysago.to_i.days
		where("datetimeperformed > '#{since_date}'")
	end

	def date_is_in_past
		if datetimeperformed.present? && datetimeperformed > Time.new
			errors.add(:datetimeperformed, "can't be in the future")
		end
	end	

	def to_s
		"#{datetimeperformed.strftime('%m/%d/%Y %H:%M')}"
	end
end
