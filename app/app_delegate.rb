class AppDelegate

  def masterWidth
    500
  end

  def detailSize
    CGSizeMake(UIScreen.mainScreen.bounds.size.height - masterWidth,
      UIScreen.mainScreen.bounds.size.width)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UISplitViewController.new.tap do |splitController|
      splitController.masterColumnWidth = masterWidth # Private API
      filtersController = FiltersController.new
      navigationController = UINavigationController.alloc.initWithRootViewController(filtersController)
      imageController = ImageController.new
      splitController.viewControllers = [ navigationController, imageController ]
    end
    @window.makeKeyAndVisible
    true
  end

end
