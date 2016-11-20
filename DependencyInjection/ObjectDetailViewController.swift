//
//  Created by Tomaz Kragelj on 16.10.16.
//  Copyright © 2016 Tomaz Kragelj. All rights reserved.
//

import UIKit

class ObjectDetailViewController: UIViewController, DatabaseConsumer, ObjectConsumer {
	
	@IBOutlet private weak var label: UILabel!
	
	var database: Database!
	var object: Object!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		label.text = object.name
    }
}
