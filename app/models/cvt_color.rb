class CvtColor

  def self.apply(srcMat)
    dstMat = MotionMat.new
    Cv::cvtColor(srcMat, dstMat, CV_RGB2GRAY)
    MotionCV.UIImageFromMotionMat(dstMat)
  end

end