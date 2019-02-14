From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 14 Feb 2019 14:50:53 -0800
Subject: [PATCH 2/6] nvme-fabrics: Document the poll function argument
In-Reply-To: <20190214225057.195397-1-bvanassche@acm.org>
References: <20190214225057.195397-1-bvanassche@acm.org>
Message-ID: <20190214225057.195397-3-bvanassche@acm.org>

This patch avoids that the kernel-doc tool reports a warning when
building with W=1.

Fixes: 26c682274e0a ("nvme-fabrics: allow nvmf_connect_io_queue to poll") # v5.0-rc1
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3eb908c50e1a..70c09abcfcbf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -430,6 +430,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  * @qid:	NVMe I/O queue number for the new I/O connection between
  *		host and target (note qid == 0 is illegal as this is
  *		the Admin queue, per NVMe standard).
+ * @poll:	Whether or not to poll for the completion of the connect cmd.
  *
  * This function issues a fabrics-protocol connection
  * of a NVMe I/O queue (via NVMe Fabrics "Connect" command)
-- 
2.21.0.rc0.258.g878e2cd30e-goog
