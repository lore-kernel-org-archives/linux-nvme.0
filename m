From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 09:03:57 +0200
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180604083658.55a9bc10@pentland.suse.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de> <20180604083658.55a9bc10@pentland.suse.de>
Message-ID: <20180604070357.GA21329@lst.de>

On Mon, Jun 04, 2018@08:36:58AM +0200, Hannes Reinecke wrote:
> This suffers from the 'nvme connect' stall if the first detected
> namespace is inaccessible.

Yes.  This isn't really different from any other NVMe target that
constantly returns errors when you connect.

If we want to do this properly we need some block level (e.g. gendisk)
state that a given device is ready for I/O.  And then don't scan
partition tables if it isn't, and instead do the scan once it becomes
life.  In other words: this is something that should be handled
mostly at the block level.
