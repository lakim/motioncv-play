class ImageController < UIViewController

  include BW::KVO

  stylesheet :imageStyle
  layout do
    @imageView = subview(UIImageView, :imageView, image: Image.instance.src, contentMode: UIViewContentModeScaleAspectFit)
  end

  # View lifecycle

  def viewDidLoad
    super
    observe(Image.instance, :dst) do |oldValue, newValue|
      @imageView.image = newValue
    end
  end

end