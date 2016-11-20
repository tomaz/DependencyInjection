//
//  Created by Tomaz Kragelj on 16.10.16.
//  Copyright © 2016 Tomaz Kragelj. All rights reserved.
//

import Foundation

protocol DatabaseConsumer {
	var database: Database! { get set }
}

protocol DatabaseProvider {
	var database: Database! { get }
}
