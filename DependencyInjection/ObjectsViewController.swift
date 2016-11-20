//
//  Created by Tomaz Kragelj on 16.10.16.
//  Copyright © 2016 Tomaz Kragelj. All rights reserved.
//

import UIKit

class ObjectsViewController: UITableViewController, DatabaseConsumer, DatabaseProvider, ObjectProvider {
	
	var database: Database!
	var object: Object {
		return objects[tableView.indexPathForSelectedRow!.row]
	}
	
	private lazy var objects: [Object] = {
		return self.database.fetch()
	}()

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath) as! ObjectTableViewCell
		cell.configure(with: objects[indexPath.row])
        return cell
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		inject(toController: segue.destination)
    }
}

class ObjectTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var label: UILabel!
	
	func configure(with object: Object) {
		label.text = object.name
	}
}
