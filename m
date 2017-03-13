From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 20:56:50 +0100
Subject: [PATCH v2] nvmet-rdma: Fix a possible uninitialized variable
 dereference
In-Reply-To: <1489412381-28947-1-git-send-email-sagi@grimberg.me>
References: <1489412381-28947-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170313195650.GA9648@lst.de>

On Mon, Mar 13, 2017@03:39:41PM +0200, Sagi Grimberg wrote:
> When handling a new recv command, we grab a new rsp resource and
> check for the queue state being live. In case the queue is not in
> live state, we simply restore the rsp back to the free list. However
> in this flow we didn't set rsp->queue yet, so we cannot dereference it.
> 
> Instead, make sure to initialize rsp->queue (and other rsp members)
> as soon as possible so we won't reference uninitialized variables.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
