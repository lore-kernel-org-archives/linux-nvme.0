From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 20 Sep 2016 14:01:51 -0500
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
Message-ID: <011101d21371$722909d0$567b1d70$@opengridcomputing.com>

> When we reconnect we can't really clear the
> queue flags (DELETING flag in specific) because
> we might end up trigerring a use-after-free condition
> if we fail to establish the rdma connection.
> 
> Fixes: e89ca58f9c90 ("nvme-rdma: add DELETING queue flag")
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Tests good.  

Thanks Sagi!

Tested-by: Steve Wise <swise at opengridcomputing.com>
