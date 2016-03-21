From: keith.busch@intel.com (Keith Busch)
Date: Mon, 21 Mar 2016 15:51:39 +0000
Subject: [PATCH RFC] nvme: rewrite discard support
In-Reply-To: <20160321144759.GA12934@lst.de>
References: <1458170132-16031-1-git-send-email-mlin@kernel.org>
 <20160317153335.GB6217@localhost.lm.intel.com>
 <20160321144759.GA12934@lst.de>
Message-ID: <20160321155138.GA19307@localhost.localdomain>

On Mon, Mar 21, 2016@03:47:59PM +0100, Christoph Hellwig wrote:
> I think we should just do a 16 byte (or rather cache line size) kmalloc,
> as there is no need for a mempool for discards.  Would a version of
> that be fine with you?  Because discard is currently the only thing
> preventing us from having a split between transport and commanset specific
> setup for NVMe.  And as things like Fabrics and LighNVM show I think
> a clean split there would be rather benefitical in the long run.

We only used the mempool for the driver to leverage normal IO clean up
so that discard isn't special.

It looks like SCSI's special handling lead to what the code comments
describe as a "horrible hack", so that's not convincing this is a good
example to follow.
