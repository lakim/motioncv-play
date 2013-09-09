class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UISplitViewController.new.tap do |splitController|
      filtersController = FiltersController.new
      navigationController = UINavigationController.alloc.initWithRootViewController(filtersController)
      imageController = ImageController.new
      splitController.viewControllers = [ navigationController, imageController ]
    end
    @window.makeKeyAndVisible
    true
  end

end
