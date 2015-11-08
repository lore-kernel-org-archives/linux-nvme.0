From: hch@lst.de (Christoph Hellwig)
Date: Sun, 8 Nov 2015 14:56:31 +0100
Subject: [PATCH 8/8] nvme-loop: add a NVMe loopback device
In-Reply-To: <563F4C83.5030709@dev.mellanox.co.il>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-9-git-send-email-hch@lst.de>
 <563F29D4.5030801@dev.mellanox.co.il> <563F4C83.5030709@dev.mellanox.co.il>
Message-ID: <20151108135631.GA5244@lst.de>

On Sun, Nov 08, 2015@03:22:11PM +0200, Sagi Grimberg wrote:
> Actually this is wrong. Whats wrong here is that ctrl->list
> is being removed twice (once in nvme_loop_cleanup_module and
> then here).

Yes, this looks fine.
