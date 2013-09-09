class ParamsController < Formotion::FormableController

  def initWithFilter(filter)
    @filter = filter
    initWithModel(filter)
  end

end