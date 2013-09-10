class ImageController < UIViewController

  include BW::KVO

  stylesheet :imageStyle
  layout do
    @scrollView = subview(UIScrollView, :scrollView, delegate: self) do
      @imageView = subview(UIImageView, :imageView)
    end
  end

  # View lifecycle

  def viewDidLoad
    super
    setImage
    tapGesture
    observe(Image.instance, :dst) do |oldValue, newValue|
      @imageView.image = newValue
    end
  end

  def setImage
    image = Image.instance.src
    @imageView.image = image
    @imageView.sizeToFit
    @scrollView.contentSize = image.size
    @scrollView.zoomScale = @scrollView.minimumZoomScale = [
      App.delegate.detailSize.width / image.size.width,
      App.delegate.detailSize.height / image.size.height
    ].min
  end

  def tapGesture
    recognizer = @scrollView.when_tapped do |gesture|
      if @scrollView.zoomScale == @scrollView.minimumZoomScale
        point = gesture.locationInView(@imageView)
        rect = CGRectMake(point.x, point.y, 1, 1)
        scale = @scrollView.maximumZoomScale
        @scrollView.zoomToRect(rect, animated: true)
        @scrollView.setZoomScale(scale, animated: true)
      else
        @scrollView.setZoomScale(@scrollView.minimumZoomScale, animated: true)
      end
    end
    recognizer.numberOfTapsRequired = 2
  end

  # UIScrollViewDelegate

  def viewForZoomingInScrollView(scrollView)
    @imageView
  end

end