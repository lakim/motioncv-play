class Filter

  def self.all
    @all ||= [
      CvtColor
    ]
  end

  def self.count
    all.count
  end

  def self.filterAtIndex(index)
    all[index]
  end

end