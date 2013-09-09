class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UISplitViewController.new.tap do |splitController|
      filtersController = FiltersController.new
      imageController = ImageController.new
      filtersController.delegate = imageController
      splitController.viewControllers = [ filtersController,  imageController ]
    end
    @window.makeKeyAndVisible
    true
  end
end
