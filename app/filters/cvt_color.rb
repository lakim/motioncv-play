class CvtColor < Filter

  CODES = %w{ CV_RGB2GRAY CV_RGB2XYZ CV_RGB2YCrCb CV_RGB2HSV CV_RGB2HLS CV_RGB2Lab CV_RGB2Luv }

  form_title name
  form_property :code, :picker, items: CODES

  form_properties.each do |prop|
    attr_writer prop[:property]
  end
  def code; @code ||= CODES.first; end

  def apply
    dstMat = MotionMat.new
    Cv::cvtColor(Image.instance.srcMat, dstMat, Kernel.const_get(code))
    updateImage(dstMat)
  end

end