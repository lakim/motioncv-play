class Image

  attr_accessor :dst

  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def src
    @src ||= UIImage.imageNamed("receipt.jpg")
  end

  def srcMat
    @srcMat ||= MotionCV.MotionMatFromUIImage(src)
  end

  def reset
    self.dst = src
  end

end