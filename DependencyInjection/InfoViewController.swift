//
//  Created by Tomaz Kragelj on 16.10.16.
//  Copyright © 2016 Tomaz Kragelj. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, DatabaseConsumer {

	@IBOutlet private weak var label: UILabel!
	
	var database: Database!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let objectsCount = database.fetch().count
		label.text = "\(objectsCount) objects"
    }
}
