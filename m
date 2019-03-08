From: hch@lst.de (Christoph Hellwig)
Date: Fri, 8 Mar 2019 14:41:50 +0100
Subject: [PATCH] multipath: set discard and norot queue flags on the
 multipath stacking device
In-Reply-To: <20190226225550.30378-1-sagi@grimberg.me>
References: <20190226225550.30378-1-sagi@grimberg.me>
Message-ID: <20190308134150.GA18554@lst.de>

On Tue, Feb 26, 2019@02:55:50PM -0800, Sagi Grimberg wrote:
> If the underlying device supports discard we set it and clear it otherwise.
> Without this blkdiscard doesn't work on a multipath device node.
> 
> Also while we're at it, unconditionally set non rotational queue flag to
> make schedulers do the right thing.

QUEUE_FLAG_NONROT is already set by nvme_mpath_alloc_disk.

For discard don't we also need to the limits?  Also what about
Write Zeroes?
