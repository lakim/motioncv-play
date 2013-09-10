class Canny < Filter

  APERTURE_SIZES = (3..7).to_a.select{ |i| !((i & 1) == 0 || (i != -1 && (i < 3 || i > 7))) }.map{ |i| i.to_s }

  form_title name
  form_property :threshold1, :number
  form_property :threshold2, :number
  form_property :apertureSize, :picker, items: APERTURE_SIZES
  form_property :L2gradient, :switch

  form_properties.each do |prop|
    attr_writer prop[:property]
  end
  def threshold1; @threshold1 ||= 20; end
  def threshold2; @threshold2 ||= 120; end
  def apertureSize; @apertureSize ||= APERTURE_SIZES.first; end
  def L2gradient; @L2gradient.nil? ? (@L2gradient = false) : @L2gradient; end

  def apply
    dstMat = MotionMat.new
    Cv::Canny(Image.instance.srcMat, dstMat, threshold1.to_f, threshold2.to_f, apertureSize.to_i, self.L2gradient)
    updateImage(dstMat)
  end

end