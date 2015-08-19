From: sunad.s@samsung.com (Sunad Bhandary)
Date: Wed, 19 Aug 2015 20:22:05 +0530
Subject: [PATCH] NVMe:Remove unreachable code in nvme_abort_req
In-Reply-To: <alpine.LNX.2.00.1508061632370.15930@localhost.lm.intel.com>
References: <1438349218-8907-1-git-send-email-sunad.s@samsung.com>
 <alpine.LNX.2.00.1508061632370.15930@localhost.lm.intel.com>
Message-ID: <01b801d0da8e$9f779590$de66c0b0$@samsung.com>

Can this be picked up?

Thanks,
Sunad

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: Thursday, August 06, 2015 10:04 PM
To: Sunad Bhandary
Cc: keith.busch at intel.com; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe:Remove unreachable code in nvme_abort_req

On Fri, 31 Jul 2015, Sunad Bhandary wrote:
> Removing unreachable code from nvme_abort_req as nvme_submit_cmd has 
> no failure status to return

Thanks.

Acked-by: Keith Busch <keith.busch at intel.com>

> Signed-off-by: Sunad Bhandary <sunad.s at samsung.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
