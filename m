From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 13 Jul 2016 16:58:29 -0500
Subject: [PATCH 0/2] nvme-rdma: device removal crash fixes
In-Reply-To: <1468445196-6915-1-git-send-email-mlin@kernel.org>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
Message-ID: <013a01d1dd51$b08cec10$11a6c430$@opengridcomputing.com>

> From: Ming Lin <ming.l at samsung.com>
> 
> Here are 2 fixes for the device removal crash.
> 
> Steve,
> 
> Could you review and add tag if you feel OK?
> Thanks again for your great debug.

Thanks for the quick fixes.

The series tests good.  I verified no crashing on module unload/shutdown using
both cxgb4 and mlx4.

Tested-by: Steve Wise <swise at opengridcomputing.com>
