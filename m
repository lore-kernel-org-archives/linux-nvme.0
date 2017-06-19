From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 12:19:53 +0200
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
 <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>
Message-ID: <20170619101953.GA18746@lst.de>

On Mon, Jun 19, 2017@01:12:54PM +0300, Sagi Grimberg wrote:
> General question, Would it make sense to invoke this search from the
> block layer as part of adding a new disk (a new block_device operation)?
> And should the sibling association maybe move up to struct block_device?
> (we could cache nvme_id_ns in nvme_ns for that to happen)?

For the block/nvme multipath code I need to expose the relationship
to the block layer.  But the locking is already complicated enough as
is, so I want to keep the NVMe list as well with that.
