From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:51:52 +0100
Subject: [PATCH 3/3] block: Polling completion performance optimization
In-Reply-To: <20171221204636.2924-4-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
Message-ID: <20171229095152.GE24043@lst.de>

This looks fine, but we also need the same in blkdev_bio_end_io and
iomap_dio_bio_end_io.  Probably best to add a little helper.
