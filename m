From: hch@lst.de (Christoph Hellwig)
Date: Sun, 6 Nov 2016 17:41:40 +0100
Subject: [PATCH v1] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <1478423778-29829-1-git-send-email-sagi@grimberg.me>
References: <1478423778-29829-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161106164140.GG15675@lst.de>

On Sun, Nov 06, 2016@11:16:18AM +0200, Sagi Grimberg wrote:
> In the transport, in case of an interal queue error like
> error completion in rdma we trigger a fatal error. However,
> multiple queues in the same controller can serr error completions
> and we don't want to trigger fatal error work more than once.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine, although I'd avoid the goto and just use a if blocks
for the rest of the action..

Reviewed-by: Christoph Hellwig <hch at lst.de>
