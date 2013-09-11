class Blur < Filter

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
  form_property :ksizeWidth, :number
  form_property :ksizeHeight, :number
  form_property :anchorX, :number
  form_property :anchorY, :number
  form_property :borderType, :picker, items: BORDER_TYPES

  form_properties.each do |prop|
    attr_writer prop[:property]
  end
  def ksizeWidth; @ksizeWidth ||= 50; end
  def ksizeHeight; @ksizeHeight ||= 50; end
  def anchorX; @anchorX ||= -1; end
  def anchorY; @anchorY ||= -1; end
  def borderType; @borderType ||= BORDER_TYPES[4]; end

  def valid?
    0 <= anchorX.to_i && anchorX.to_i < ksizeWidth.to_i && 0 <= anchorY.to_i && anchorY.to_i < ksizeHeight.to_i
  end

  def apply
    dstMat = MotionMat.new
    Cv::blur(Image.instance.srcMat, dstMat, [ksizeWidth.to_i, ksizeHeight.to_i], [anchorX.to_i, anchorY.to_i], Kernel.const_get(borderType))
    updateImage(dstMat)
  end

  def constantsHack
    MCV_BORDER_REPLICATE
    MCV_BORDER_REFLECT
    MCV_BORDER_WRAP
    MCV_BORDER_REFLECT_101
    MCV_BORDER_DEFAULT
    MCV_BORDER_TRANSPARENT
    MCV_BORDER_ISOLATED
  end

end