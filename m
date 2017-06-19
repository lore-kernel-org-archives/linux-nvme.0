From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:38:28 +0200
Subject: [PATCH rfc 05/30] nvme-rdma: introduce nvme_rdma_start_queue
In-Reply-To: <1497799324-19598-6-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-6-git-send-email-sagi@grimberg.me>
Message-ID: <20170619123828.GE29061@lst.de>

On Sun, Jun 18, 2017@06:21:39PM +0300, Sagi Grimberg wrote:
> This should pair with nvme_rdma_stop_queue. While this
> is not a complete 1x1 reverse, it still pairs up pretty
> well because in fabrics we don't have a disconnect capsule
> but we simply teardown the transport association.

Looks like we are going to get one sooner or later.  Not that I'd
like to send them if we can avoid it.

But the patch itself looks fine to me.
