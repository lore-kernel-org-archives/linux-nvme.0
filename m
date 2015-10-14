From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 14 Oct 2015 21:23:38 +0000
Subject: [PATCH 2/8] nvme: use the block layer for userspace passthrough
 metadata
In-Reply-To: <alpine.LNX.2.00.1510142038370.27742@localhost.lm.intel.com>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-3-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510142038370.27742@localhost.lm.intel.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CD21957@fmsmsx104.amr.corp.intel.com>

> Similarly, we need to set bio->bi_bdev to 'bdev_get(ns->disk, 0)' to
> fix a NULL pointer in bio_integrity_advance in the completion path.


err ... I mean "bdget_disk". What I wrote above doesn't even exist.
