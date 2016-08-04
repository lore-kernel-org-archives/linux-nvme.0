From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Aug 2016 13:49:38 +0200
Subject: [PATCH] nvmet-rdma: Don't use the inline buffer in order to
 avoid allocation for small reads
In-Reply-To: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
References: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160804114938.GA32487@lst.de>

On Mon, Aug 01, 2016@11:36:39AM +0300, Sagi Grimberg wrote:
> Under extreme conditions this might cause data corruptions. By doing that
> we we repost the buffer and then post this buffer for the device to send.
> If we happen to use shared receive queues the device might write to the
> buffer before it sends it (there is no ordering between send and recv
> queues). Without SRQs we probably won't get that if the host doesn't
> mis-behave and send more than we allowed it, but relying on that is not
> really a good idea.

Allright, after the discussion:

Reviewed-by: Christoph Hellwig <hch at lst.de>
