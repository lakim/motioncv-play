class Image

  attr_accessor :dst

  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def src
    @src ||= UIImage.imageNamed("sato.jpg")
  end

  def srcMat
    @srcMat ||= Cv::MotionMatFromUIImage(src)
  end

  def reset
    self.dst = src
  end

end
