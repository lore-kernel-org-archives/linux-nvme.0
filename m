From: james.smart@broadcom.com (James Smart)
Date: Thu, 28 Jul 2016 17:00:26 -0700
Subject: [PATCH 2/3] nvme-fabrics: revise host transport option
 descriptions
Message-ID: <579a9c9a.hlvHI7SZaXIxRR5X%james.smart@broadcom.com>


Revise some of the comments so not so ethernet-network centric

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fabrics.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 89df52c..2755efd 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -64,9 +64,10 @@ enum {
  *		being added.
  * @subsysnqn:	Hold the fully qualified NQN subystem name (format defined
  *		in the NVMe specification, "NVMe Qualified Names").
- * @traddr:	network address that will be used by the host to communicate
- *		to the added NVMe controller.
- * @trsvcid:	network port used for host-controller communication.
+ * @traddr:	The transport-specific TRADDR field for a port on the
+ *              subsystem which is adding a controller.
+ * @trsvcid:	The transport-specific TRSVCID field for a port on the
+ *              subsystem which is adding a controller.
  * @queue_size: Number of IO queue elements.
  * @nr_io_queues: Number of controller IO queues that will be established.
  * @reconnect_delay: Time between two consecutive reconnect attempts.
-- 
2.5.0
