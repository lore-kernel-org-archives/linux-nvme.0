From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Mar 2019 09:43:28 -0600
Subject: [PATCH] nvme: disable Write Zeroes for qemu controllers
In-Reply-To: <20190312151256.22986-1-hch@lst.de>
References: <20190312151256.22986-1-hch@lst.de>
Message-ID: <20190312154328.GB12657@localhost.localdomain>

On Tue, Mar 12, 2019@04:12:56PM +0100, Christoph Hellwig wrote:
> Qemu started out with a broken implementation of Write Zeroes written
> by yours truly.  Disable Write Zeroes on qemu for now, eventually
> we need to go back and make all the qemu quirks version specific,
> but that is left for another time.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>


Reviewed-by: Keith Busch <keith.busch at intel.com>
