From: hch@lst.de (Christoph Hellwig)
Date: Tue, 1 Nov 2016 15:37:06 +0100
Subject: [PATCH, resend2] nvme-rdma: reject non-connect commands before
 the queue is live
In-Reply-To: <deb127eb-c468-79bf-e602-ba56932066b9@grimberg.me>
References: <1478007890-18934-1-git-send-email-hch@lst.de>
 <deb127eb-c468-79bf-e602-ba56932066b9@grimberg.me>
Message-ID: <20161101143706.GA17771@lst.de>

On Tue, Nov 01, 2016@04:32:57PM +0200, Sagi Grimberg wrote:
> Can we hide this mess in a static inline nvme_rdma_chk_ready()?

Sure, although I'd spell out check :)
