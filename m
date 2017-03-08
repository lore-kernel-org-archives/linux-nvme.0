From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Mar 2017 22:35:19 +0100
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170308213519.GA32009@lst.de>

Wrong kind of interface - this needs to use vfs_iter_read/write
of type ITER_BVEC.

And before merging anything I'd really like to see how this is
an improvement over simply using the loop device.
