class FiltersController < UITableViewController

  CELL_IDENTIFIER = "filterCell"

  attr_accessor :delegate

  # View lifecycle

  def viewDidLoad
    super
    tableView.registerClass(UITableViewCell, forCellReuseIdentifier:CELL_IDENTIFIER)
  end

  # Accessors

  def delegate=(delegate)
    @delegate = WeakRef.new(delegate)
  end

  # UITableViewDataSource

  def tableView(tableView, numberOfRowsInSection:section)
    Filter.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER)
    cell.textLabel.text = Filter.filterAtIndex(indexPath.row).name
    cell
  end

  # UITableViewDelegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    delegate.applyFilterAtIndex(indexPath.row)
  end

end