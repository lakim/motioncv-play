class Filter

  include BW::KVO
  include Formotion::Formable

  def self.inherited(subclass)
    all << subclass
  end

  def self.all
    @all ||= []
  end

  def self.count
    all.count
  end

  def self.filterWithIndex(index)
    all[index].new
  end

  def self.titleAtIndex(index)
    all[index].form_title
  end

  def valid?
    true
  end

  def updateImage(dstMat)
    Image.instance.dst = MotionCV.UIImageFromMotionMat(dstMat)
  end

end