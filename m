From: hch@lst.de (Christoph Hellwig)
Date: Tue, 2 Aug 2016 14:50:42 +0200
Subject: [PATCH] nvmet-rdma: Don't use the inline buffer in order to
 avoid allocation for small reads
In-Reply-To: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
References: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160802125042.GB13235@lst.de>

On Mon, Aug 01, 2016@11:36:39AM +0300, Sagi Grimberg wrote:
> Under extreme conditions this might cause data corruptions. By doing that
> we we repost the buffer and then post this buffer for the device to send.
> If we happen to use shared receive queues the device might write to the
> buffer before it sends it (there is no ordering between send and recv
> queues). Without SRQs we probably won't get that if the host doesn't
> mis-behave and send more than we allowed it, but relying on that is not
> really a good idea.

Pitty - it seems so wasteful not being able to use these buffers for
anything that isn't an inline write.  I fully agree on the SRQ case,
but I think we should offer it for the non-SRP case.
