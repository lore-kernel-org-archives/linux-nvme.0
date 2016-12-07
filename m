From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Dec 2016 18:44:27 +0100
Subject: [PATCH] nvme: support bi-directional commands
In-Reply-To: <20161207175049.GD29574@localhost.localdomain>
References: <1481132364-20583-1-git-send-email-keith.busch@intel.com>
 <20161207173323.GA24967@lst.de>
 <20161207175049.GD29574@localhost.localdomain>
Message-ID: <20161207174427.GA25211@lst.de>

On Wed, Dec 07, 2016@12:50:50PM -0500, Keith Busch wrote:
> NVMe defines this capability, so why would we want to make it unreachable
> in Linux?

NVMe defines no user of it, so that defintion is entirely theoretical
and it's a giant mess, and your implementation does not actually work
for the general case.

> SG_DXFER_TO_FROM_DEV does bidi commands in one request for
> SCSI using the same rq_map_data method this patch proposes to use.

SG_DXFER_TO_FROM_DEV does not actually work, for SCSI bidi support
you need bsg with the crazy next_rq linked block layer bidi support.
