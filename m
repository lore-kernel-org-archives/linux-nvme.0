From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Oct 2015 12:26:17 +0200
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <56261541.9030702@dev.mellanox.co.il>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
 <56261541.9030702@dev.mellanox.co.il>
Message-ID: <20151020102617.GA29824@lst.de>

On Tue, Oct 20, 2015@01:19:45PM +0300, Sagi Grimberg wrote:
> Can you explain why nvme_ctrl needs an additional struct device pointer?
> (I understand it will go away from your statement "at the moment"
> haven't read the rest of the patch set yet).

No, it won't go away for the foreseeable future.  I don't want to move
any members used in the hot path to sturct nvme_ctrl so that drivers can
be optimized in this path without impacting the generic code.  Both for
PCIe and Fabrics we need to squeeze the last bit of performance out and
I don't want to have to cacheline optimize nvme_ctrl or even worse
interactions between it and the containing structures.
