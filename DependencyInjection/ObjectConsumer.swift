//
//  Created by Tomaz Kragelj on 16.10.16.
//  Copyright © 2016 Tomaz Kragelj. All rights reserved.
//

import Foundation

protocol ObjectConsumer {
	var object: Object! { get set }
}

protocol ObjectProvider {
	var object: Object { get }
}
