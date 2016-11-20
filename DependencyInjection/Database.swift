//
//  Created by Tomaz Kragelj on 16.10.16.
//  Copyright © 2016 Tomaz Kragelj. All rights reserved.
//

import Foundation

class Database {
	
	func fetch() -> [Object] {
		return ["One", "Two", "Three", "Four"].map { Object(name: $0) }
	}
}
