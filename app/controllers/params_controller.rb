class ParamsController < Formotion::FormableController

  def initWithFilter(filter)
    @filter = filter
    initWithModel(filter)
  end

  def viewWillAppear(animated)
    super
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Update", style: UIBarButtonItemStylePlain, target: self, action: "submit")
  end

  def viewDidAppear(animated)
    super
    @filter.apply
  end

  def submit
    view.endEditing(true)
    if !@filter.valid?
      App.alert("Invalid parameters")
      return
    end
    @filter.apply
  end

end