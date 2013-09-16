class FindContours < Filter

  MODES = %w{ CV_RETR_EXTERNAL CV_RETR_LIST CV_RETR_CCOMP CV_RETR_TREE }
  METHODS = %w{ CV_CHAIN_APPROX_NONE CV_CHAIN_APPROX_SIMPLE CV_CHAIN_APPROX_TC89_L1 CV_CHAIN_APPROX_TC89_KCOS }

  form_title name
  form_property :mode, :picker, items: MODES
  form_property :method, :picker, items: METHODS
  form_property :offsetX, :number
  form_property :offsetY, :number
  form_properties.each do |prop|
    attr_writer prop[:property]
  end
  def mode; @mode ||= MODES.first; end
  def method; @method ||= METHODS[1]; end
  def offsetX; @offsetX ||= 0; end
  def offsetY; @offsetY ||= 0; end

  def apply
    dstMat = MotionMat.new
    contours = NSMutableArray.new
    Cv::cvtColor(Image.instance.srcMat, dstMat, CV_RGB2GRAY)
    Cv::Canny(dstMat, dstMat, 100, 200, 3, true)
    Cv::findContours(dstMat, contours, Kernel.const_get(mode), Kernel.const_get(method))
    UIGraphicsBeginImageContext(Image.instance.src.size)
    contours.each do |path|
      path.lineWidth = 2
      UIColor.randomColor.setStroke
      path.stroke
    end
    Image.instance.dst = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
  end

end