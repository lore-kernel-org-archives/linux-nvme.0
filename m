From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Aug 2016 11:49:41 +0200
Subject: [PATCH] nvmet-rdma: Don't use the inline buffer in order to
 avoid allocation for small reads
In-Reply-To: <20160802161526.GA14964@obsidianresearch.com>
References: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
 <20160802125042.GB13235@lst.de>
 <157675f0-0576-1cc9-1f99-c0944185e3c5@grimberg.me>
 <20160802161526.GA14964@obsidianresearch.com>
Message-ID: <20160803094941.GA11821@lst.de>

On Tue, Aug 02, 2016@10:15:26AM -0600, Jason Gunthorpe wrote:
> On Tue, Aug 02, 2016@04:38:58PM +0300, Sagi Grimberg wrote:
> > that is currently being sent (its a rare race condition, but
> > theoretically possible). The reason is that we repost the inline data
> > buffer for receive before we post the send request. We used to have
> 
> ?? The same buffer is posted at the same time for send and recv? That
> is never OK, SRQ or not.

We will never POST it for a SEND, but it would be used as the target
of RDMA READ / WRITE operations.
