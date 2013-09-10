class ParamsController < Formotion::FormableController

  def initWithFilter(filter)
    @filter = filter
    initWithModel(filter)
  end

  def viewDidAppear(animated)
    super
    @filter.observeAttributes
    @filter.apply
  end

end