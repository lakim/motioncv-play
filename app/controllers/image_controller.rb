class ImageController < UIViewController

  # View lifecycle

  def viewDidLoad
    super
    @imageView = UIImageView.alloc.initWithImage(UIImage.imageNamed("receipt.jpg"))
    @imageView.frame = view.bounds
    @imageView.contentMode = UIViewContentModeScaleAspectFit
    @imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin
    view.addSubview(@imageView)
  end

  # Delegate

  def applyFilterAtIndex(index)
    filter = Filter.filterAtIndex(index)
    image = filter.apply(MotionCV.MotionMatFromUIImage(@imageView.image))
    @imageView.image = image
  end

end