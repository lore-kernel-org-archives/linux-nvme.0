From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Jun 2017 16:51:53 +0200
Subject: [PATCH 1/7] nvme: move queue_count to the nvme_ctrl
In-Reply-To: <1498734552-14845-2-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
 <1498734552-14845-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170629145153.GA18028@lst.de>

On Thu, Jun 29, 2017@02:09:06PM +0300, Sagi Grimberg wrote:
> all drivers use it exactly the same, move it
> to nvme_ctrl. Looking further ahead, nvme core
> will really maintain it.

All all transports use the queue_count in exactly the same, so move it to
the generic struct nvme_ctrl. In the future it will also be maintained by
the core.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
