From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 22 Sep 2016 19:12:05 -0500
Subject: [PATCH] nvme-rdma: only clear queue flags after successful connect
In-Reply-To: <1474488144-7158-1-git-send-email-sagi@grimberg.me>
References: <1474488144-7158-1-git-send-email-sagi@grimberg.me>
Message-ID: <000801d2152f$1f0fa190$5d2ee4b0$@opengridcomputing.com>

> Otherwise, nvme_rdma_stop_and_clear_queue() will incorrectly
> try to stop/free rdma qps/cm_ids that are already freed.
> 
> Fixes: e89ca58f9c90 ("nvme-rdma: add DELETING queue flag")
> Reported-by: Steve Wise <swise at opengridcomputing.com>
> Tested-by: Steve Wise <swise at opengridcomputing.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Jens, care to pick this last minute fix for rc8?

It would be great to get this rc8 to avoid the crash on reconnect
timeouts...

Steve.
