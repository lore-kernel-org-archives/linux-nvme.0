From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 May 2017 13:12:02 +0200
Subject: [PATCH 03/11] nvme-rdma: Make queue flags bit numbers and not
 shifts
In-Reply-To: <1493893995-27063-4-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-4-git-send-email-sagi@grimberg.me>
Message-ID: <20170504111202.GD9301@lst.de>

On Thu, May 04, 2017@01:33:07PM +0300, Sagi Grimberg wrote:
> bitops accept bit numbers.
> 
> Reported-by: Vijay Immanuel <vijayi at attalasystems.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
