class AdaptiveThreshold < Filter

  ADAPTIVE_METHODS = %w{ CV_ADAPTIVE_THRESH_MEAN_C CV_ADAPTIVE_THRESH_GAUSSIAN_C }
  THRESHOLD_TYPES = %w{ CV_THRESH_BINARY CV_THRESH_BINARY_INV }
  BLOCK_SIZES = (3..1000).to_a.select{ |i| i % 2 == 1 }.map{ |i| i.to_s }

  form_title name
  form_property :maxValue, :slider, range: (1..255), value: 255
  form_property :adaptiveMethod, :picker, items: ADAPTIVE_METHODS, value: ADAPTIVE_METHODS.first
  form_property :thresholdType, :picker, items: THRESHOLD_TYPES, value: THRESHOLD_TYPES.first
  form_property :blockSize, :picker, items: BLOCK_SIZES, value: BLOCK_SIZES[4]
  form_property :constant, :number, value: 10

  def attributes
    @attributes ||= [ :maxValue, :adaptiveMethod, :thresholdType, :blockSize, :constant ]
  end

  def apply
    self.maxValue ||= 255 # Hack, because maxValue is not set at first
    return if attributes.any? { |name| send(name).nil? }
    dstMat = MotionMat.new
    Cv::cvtColor(Image.instance.srcMat, dstMat, CV_RGB2GRAY)
    Cv::adaptiveThreshold(dstMat, dstMat, maxValue, Kernel.const_get(adaptiveMethod), Kernel.const_get(thresholdType), blockSize.to_i, constant.to_i)
    updateImage(dstMat)
  end

  private

  # Looks like RubyMotiononly  adds constants
  # at compile time. If you don't use these
  # directly in your code, they don't get added
  # to Kernel and const_get will crash
  def constantsHack
    CV_THRESH_BINARY
    CV_THRESH_BINARY_INV
    CV_ADAPTIVE_THRESH_MEAN_C
    CV_ADAPTIVE_THRESH_GAUSSIAN_C
  end

end