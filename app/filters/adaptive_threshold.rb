class AdaptiveThreshold < Filter

  ADAPTIVE_METHODS = %w{ CV_ADAPTIVE_THRESH_MEAN_C CV_ADAPTIVE_THRESH_GAUSSIAN_C }
  THRESHOLD_TYPES = %w{ CV_THRESH_BINARY CV_THRESH_BINARY_INV }
  BLOCK_SIZES = (3..1000).to_a.select{ |i| i % 2 == 1 }.map{ |i| i.to_s }

  form_title name
  form_property :maxValue, :slider, range: (1..255)
  form_property :adaptiveMethod, :picker, items: ADAPTIVE_METHODS
  form_property :thresholdType, :picker, items: THRESHOLD_TYPES
  form_property :blockSize, :picker, items: BLOCK_SIZES
  form_property :constant, :number

  form_properties.each do |prop|
    attr_writer prop[:property]
  end
  def maxValue; @maxValue ||= 255; end
  def adaptiveMethod; @adaptiveMethod ||= ADAPTIVE_METHODS.first; end
  def thresholdType; @thresholdType ||= THRESHOLD_TYPES.first; end
  def blockSize; @blockSize ||= BLOCK_SIZES[4]; end
  def constant; @constant ||= 10; end

  def apply
    dstMat = MotionMat.new
    Cv::cvtColor(Image.instance.srcMat, dstMat, CV_RGB2GRAY)
    Cv::adaptiveThreshold(dstMat, dstMat, maxValue, Kernel.const_get(adaptiveMethod), Kernel.const_get(thresholdType), blockSize.to_i, constant.to_i)
    updateImage(dstMat)
  end

end