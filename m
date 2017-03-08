From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Mar 2017 17:15:28 -0500
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170308213519.GA32009@lst.de>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de>
Message-ID: <20170308221527.GA1885@localhost.localdomain>

On Wed, Mar 08, 2017@10:35:19PM +0100, Christoph Hellwig wrote:
> Wrong kind of interface - this needs to use vfs_iter_read/write
> of type ITER_BVEC.

Gotchya, that's what I was locking for. Thanks for the pointer.

> And before merging anything I'd really like to see how this is
> an improvement over simply using the loop device.

This is a step toward getting namespace management. It's easy to create
namespaces if they're files.
