From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 09:01:00 +0200
Subject: [PATCH v2 1/4] nvme-pci: Introduce nvme_ring_cq_doorbell
In-Reply-To: <1497796090-14808-2-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
 <1497796090-14808-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170619070100.GC12938@lst.de>

On Sun, Jun 18, 2017@05:28:07PM +0300, Sagi Grimberg wrote:
> Nice abstraction of the actual mechanics of how to do it.
> Note the change that we call it after we assign nvmeq->cq_head
> to avoid passing it.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
