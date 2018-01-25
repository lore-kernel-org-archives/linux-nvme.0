From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 25 Jan 2018 16:10:23 +0800
Subject: [PATCH] nvme: don't retry request marked as NVME_REQ_CANCELLED
Message-ID: <20180125081023.13303-1-ming.lei@redhat.com>

If request is marked as NVME_REQ_CANCELLED, we don't need to retry for
requeuing it, and it should be completed immediately. Even simply from
the flag name, it needn't to be requeued.

Otherwise, it is easy to cause IO hang when IO is timed out in case of
PCI NVMe:

1) IO timeout is triggered, and nvme_timeout() tries to disable
device(nvme_dev_disable) and reset controller(nvme_reset_ctrl)

2) inside nvme_dev_disable(), queue is frozen and quiesced, and
try to cancel every request, but the timeout request can't be canceled
since it is completed by __blk_mq_complete_request() in blk_mq_rq_timed_out().

3) this timeout req is requeued via nvme_complete_rq(), but can't be
dispatched at all because queue is quiesced and hardware isn't ready,
finally nvme_wait_freeze() waits for ever in nvme_reset_work().

Cc: "jianchao.wang" <jianchao.w.wang at oracle.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Keith Busch <keith.busch at intel.com>
Cc: stable at vger.kernel.org
Reported-by: Xiao Liang <xiliang at redhat.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ff03cf95f7f..5cd713a164cb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -210,6 +210,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
 		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+		return false;
 	return true;
 }
 
-- 
2.9.5
