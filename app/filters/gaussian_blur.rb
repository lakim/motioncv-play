class GaussianBlur < Filter

  SIZES = (1..1000).to_a.select{ |i| i % 2 == 1 }.map(&:to_s)
  BORDER_TYPES = %w{
    MCV_BORDER_REPLICATE
    MCV_BORDER_REFLECT
    MCV_BORDER_WRAP
    MCV_BORDER_REFLECT_101
    MCV_BORDER_DEFAULT
    MCV_BORDER_TRANSPARENT
    MCV_BORDER_ISOLATED
  }

  form_title name
  form_property :ksizeWidth, :picker, items: SIZES
  form_property :ksizeHeight, :picker, items: SIZES
  form_property :sigmaX, :number
  form_property :sigmaY, :number
  form_property :borderType, :picker, items: BORDER_TYPES

  form_properties.each do |prop|
    attr_writer prop[:property]
  end
  def ksizeWidth; @ksizeWidth ||= SIZES[20]; end
  def ksizeHeight; @ksizeHeight ||= SIZES[20]; end
  def sigmaX; @sigmaX ||= 0; end
  def sigmaY; @sigmaY ||= 0; end
  def borderType; @borderType ||= BORDER_TYPES[4]; end

  def apply
    dstMat = MotionMat.new
    Cv::GaussianBlur(Image.instance.srcMat, dstMat, [ksizeWidth.to_i, ksizeHeight.to_i], sigmaX, sigmaY, Kernel.const_get(borderType))
    updateImage(dstMat)
  end

end