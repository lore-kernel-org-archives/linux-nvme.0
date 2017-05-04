From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 May 2017 13:20:35 +0200
Subject: [PATCH 09/11] nvme: Move transports to use nvme-core workqueue
In-Reply-To: <1493893995-27063-10-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-10-git-send-email-sagi@grimberg.me>
Message-ID: <20170504112035.GE9686@lst.de>

On Thu, May 04, 2017@01:33:13PM +0300, Sagi Grimberg wrote:
> Instead of each transport using it's own workqueue, export
> a single nvme-core workqueue and use that instead.
> 
> In the future, this will help us moving towards some unification
> if controller setup/teardown flows.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
