class CvtColor < Filter

  CODES = %w{ CV_RGB2GRAY CV_RGB2XYZ CV_RGB2YCrCb CV_RGB2HSV CV_RGB2HLS CV_RGB2Lab CV_RGB2Luv }

  form_title name
  form_property :code, :picker, items: CODES, value: CODES.first

  def attributes
    @attributes ||= [ :code ]
  end

  def apply
    dstMat = MotionMat.new
    Cv::cvtColor(Image.instance.srcMat, dstMat, Kernel.const_get(code))
    Image.instance.dst = MotionCV.UIImageFromMotionMat(dstMat)
  end

  private

  # Looks like RubyMotiononly  adds constants
  # at compile time. If you don't use these
  # directly in your code, they don't get added
  # to Kernel and const_get will crash
  def constantsHack
    [ CV_RGB2GRAY, CV_RGB2XYZ, CV_RGB2YCrCb, CV_RGB2HSV, CV_RGB2HLS, CV_RGB2Lab, CV_RGB2Luv ]
  end

end