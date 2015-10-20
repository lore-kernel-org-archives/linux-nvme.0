From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Oct 2015 13:30:41 +0200
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <56261AF1.2040408@dev.mellanox.co.il>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
 <56261541.9030702@dev.mellanox.co.il> <20151020102617.GA29824@lst.de>
 <56261AF1.2040408@dev.mellanox.co.il>
Message-ID: <20151020113041.GA31462@lst.de>

On Tue, Oct 20, 2015@01:44:01PM +0300, Sagi Grimberg wrote:
> I wasn't suggesting moving it to nvme_ctrl, I was suggesting to keep it
> in nvme_dev and maybe add a helper have nvme_ctrl_to_dev(ctrl)->dev used
> in slow paths. It would allow to remove the copy pointer in nvme_ctrl.

But it would require adding a function pointer to get the location from
the different transport drivers.  A pointer seems much simpler than that.
