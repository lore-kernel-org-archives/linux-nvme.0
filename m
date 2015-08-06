From: keith.busch@intel.com (Keith Busch)
Date: Thu, 6 Aug 2015 16:33:38 +0000 (UTC)
Subject: [PATCH] NVMe:Remove unreachable code in nvme_abort_req
In-Reply-To: <1438349218-8907-1-git-send-email-sunad.s@samsung.com>
References: <1438349218-8907-1-git-send-email-sunad.s@samsung.com>
Message-ID: <alpine.LNX.2.00.1508061632370.15930@localhost.lm.intel.com>

On Fri, 31 Jul 2015, Sunad Bhandary wrote:
> Removing unreachable code from nvme_abort_req as nvme_submit_cmd has no
> failure status to return

Thanks.

Acked-by: Keith Busch <keith.busch at intel.com>

> Signed-off-by: Sunad Bhandary <sunad.s at samsung.com>
