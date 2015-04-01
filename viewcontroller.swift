import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var expandedSections: NSMutableIndexSet! = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.expandedSections == nil{
        expandedSections = NSMutableIndexSet() as NSMutableIndexSet;
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView,canCollapseSection section:NSInteger) -> Bool{
    if section >= 0{
    return true;
    }
    else{
    return false;
    }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    return 3;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.tableView(tableView, canCollapseSection: section)) {
            if(self.expandedSections.containsIndex(section)){
            return 5;
            }
        return 1;
        }
    return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        if (self.tableView(tableView, canCollapseSection: indexPath.section)){
             if (indexPath.row >= 0){
                cell.textLabel?.text = "Expandable";
                if expandedSections.containsIndex(indexPath.section){
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
                }
                else{
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
                }
            }
            else{
            cell.textLabel?.text = "SomeDetail";
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
            }
        }
        else{
        cell.accessoryView = nil;
        cell.textLabel?.text = "Normal Cell";
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
    if (self.tableView(tableView, canCollapseSection: indexPath.section)){
        if(indexPath.row >= 0){
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
            var section = indexPath.section;
            var currentlyExpanded = expandedSections.containsIndex(section);
            var rows:NSInteger;
            var tempArray = NSMutableArray();
            if(currentlyExpanded){
                rows = self.tableView(tableView, numberOfRowsInSection: section);
                expandedSections.removeIndex(section);
            }
            else{
            expandedSections.addIndex(section);
            rows = self.tableView(tableView, numberOfRowsInSection: section);
            }
            for(var i=1; i<rows; i++){
                var tempIndexPath = NSIndexPath(forRow: i, inSection: section);
                tempArray.addObject(tempIndexPath);
            }
            var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath);
            if currentlyExpanded{
            tableView.deleteRowsAtIndexPaths(tempArray, withRowAnimation: UITableViewRowAnimation.Top);
            }
            else{
            tableView.insertRowsAtIndexPaths(tempArray, withRowAnimation: UITableViewRowAnimation.Top);
            }
        }
    }
  }
}
