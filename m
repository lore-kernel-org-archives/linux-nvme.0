From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 May 2017 13:12:37 +0200
Subject: [PATCH 04/11] nvme-rdma: Don't rearm the CQ when polling directly
In-Reply-To: <1493893995-27063-5-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-5-git-send-email-sagi@grimberg.me>
Message-ID: <20170504111237.GE9301@lst.de>

On Thu, May 04, 2017@01:33:08PM +0300, Sagi Grimberg wrote:
> We don't need it as the core polling context will take
> are of rearming the completion queue.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine (and I remember we had this discussion and am a bit
surprised we didn't merge something like this yet).

Reviewed-by: Christoph Hellwig <hch at lst.de>
