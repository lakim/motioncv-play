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

  # Looks like RubyMotion only adds constants
  # at compile time. If you don't use these
  # directly in your code, they don't get added
  # to Kernel and const_get will crash
  def constantsHack
    CV_RGB2GRAY
    CV_RGB2XYZ
    CV_RGB2YCrCb
    CV_RGB2HSV
    CV_RGB2HLS
    CV_RGB2Lab
    CV_RGB2Luv

    CV_THRESH_BINARY
    CV_THRESH_BINARY_INV
    CV_ADAPTIVE_THRESH_MEAN_C
    CV_ADAPTIVE_THRESH_GAUSSIAN_C

    MCV_BORDER_REPLICATE
    MCV_BORDER_REFLECT
    MCV_BORDER_WRAP
    MCV_BORDER_REFLECT_101
    MCV_BORDER_DEFAULT
    MCV_BORDER_TRANSPARENT
    MCV_BORDER_ISOLATED

    CV_RETR_EXTERNAL
    CV_RETR_LIST
    CV_RETR_CCOMP
    CV_RETR_TREE

    CV_CHAIN_APPROX_NONE
    CV_CHAIN_APPROX_SIMPLE
    CV_CHAIN_APPROX_TC89_L1
    CV_CHAIN_APPROX_TC89_KCOS
  end

end