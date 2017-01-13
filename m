From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Jan 2017 08:44:20 +0100
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <1484261109-3316-1-git-send-email-parav@mellanox.com>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
Message-ID: <20170113074420.GA25814@lst.de>

On Thu, Jan 12, 2017@04:45:09PM -0600, Parav Pandit wrote:
> This patch performs dma sync operations on nvme_commmand,
> inline page(s) and nvme_completion.
> 
> nvme_command and write cmd inline data is synced
> (a) on receiving of the recv queue completion for cpu access.
> (b) before posting recv wqe back to rdma adapter for device access.
> 
> nvme_completion is synced
> (a) on receiving send completion for nvme_completion for cpu access.
> (b) before posting send wqe to rdma adapter for device access.
> 
> Pushing this patch through linux-rdma tree as its more relavant with
> Bart's changes for dma_map_ops of[1].
> 
> [1] https://patchwork.kernel.org/patch/9514085/

This seems like a fix for 4.10-rc as the old code is buggy on
not DMA coherent architectures, so I suspect it should go in without
being based on Barts cleanup.

Btw, what architecture did you test this with?  One of the not coherent
ARM SOCs?
