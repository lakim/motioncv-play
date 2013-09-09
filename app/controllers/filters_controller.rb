class FiltersController < UITableViewController

  CELL_IDENTIFIER = "filterCell"

  # View lifecycle

  def viewDidLoad
    super
    self.title = "Filters"
    tableView.registerClass(UITableViewCell, forCellReuseIdentifier:CELL_IDENTIFIER)
  end

  def viewDidAppear(animated)
    super
    Image.instance.reset
  end

  # UITableViewDataSource

  def tableView(tableView, numberOfRowsInSection:section)
    Filter.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER)
    cell.textLabel.text = Filter.titleAtIndex(indexPath.row)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  # UITableViewDelegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    viewController = ParamsController.alloc.initWithFilter(Filter.filterWithIndex(indexPath.row))
    self.navigationController.pushViewController(viewController, animated: true)
  end

end