class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :artist_name, presence: true
  validate :release_year_if_released
  validate :release_year_time
  validate :already_released

  def release_year_if_released
    if self.released && !release_year.present?
      errors.add(:release_year, "must have a release year if released")
    end
  end

  def release_year_time
    if release_year.present? && release_year > 2017
      errors.add(:relase_year, "cannot be in the future")
    end
  end

  def already_released
    if id == nil && Song.where("release_year = ? and title = ?", release_year, title).count > 0
      errors.add(:title, "cannot add same song twice in a year")
    end
  end

end
