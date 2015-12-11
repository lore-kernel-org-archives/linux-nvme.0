From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 11 Dec 2015 12:36:34 -0700
Subject: [PATCH] nvme: Allow controllers to specify a min queue depth for CMB
Message-ID: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>

This patch introduces a quirk to allow a controller to specify a
preferred minimum queue depth for queues mapped within the CMB.

Queues located in the CMB currently inherit a restriction that queues
must be aligned with respect to the device page size. This restriction
often doesn't make sense with respect to the CMB, so we should allow
devices to let queues be mapped unaligned within the CMB.

Additionally, CMB sizes may be too small for the normal number and depth
of queues in system memory, but the controller may be fast enough to
handle a reduced queue depth.

Specifying this feature implies that the controller can handle
unaligned queues mapped within the CMB, otherwise the controller may as
well have the aligned, larger queue depth queues. Specifying a preferred
minimum queue depth of 1 (shift value of 0) is not supported as it
is assumed some amount of queueing is required.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
Applies against jens/for-4.5/nvme
 drivers/nvme/host/nvme.h | 12 ++++++++++++
 drivers/nvme/host/pci.c  | 10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b75d41e..6ff12d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -43,6 +43,18 @@ enum nvme_quirks {
 	 * specific Identify field.
 	 */
 	NVME_QUIRK_STRIPE_SIZE			= (1 << 0),
+	/*
+	 * The controller specifies a preferred minimum queue depth
+	 * for queues in the CMB. Specifying a preferred minimum queue
+	 * depth implies that the device's CMB supports queues being
+	 * mapped unaligned with respect to the device page size.
+	 *
+	 * Bits 3:1 is the preferred minimum queue depth as a power-of-2,
+	 * with '0' being the default of (device page size / entry size)
+	 */
+	#define NVME_QUIRK_MIN_QD_SHIFT(quirks)	(((quirks) & 0x7) << 1)
+	#define QUIRKS_TO_MIN_QD_SHIFT(quirks)	(((quirks) >> 1) & 0x7)
+
 };
 
 struct nvme_ctrl {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a64d0ba..98785ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1255,13 +1255,17 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 				int entry_size)
 {
+	struct nvme_ctrl *ctrl = &dev->ctrl;
 	int q_depth = dev->q_depth;
 	unsigned q_size_aligned = roundup(q_depth * entry_size,
 					  dev->ctrl.page_size);
+	int min_qd = 64;
 
 	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
 		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
-		mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
+		int ctrl_mqd_shift = QUIRKS_TO_MIN_QD_SHIFT(ctrl->quirks);
+		if (!ctrl_mqd_shift)
+			mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
 		q_depth = div_u64(mem_per_q, entry_size);
 
 		/*
@@ -1269,7 +1273,9 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 		 * would be better to map queues in system memory with the
 		 * original depth
 		 */
-		if (q_depth < 64)
+		if (ctrl_mqd_shift)
+			min_qd = 1 << ctrl_mqd_shift;
+		if (q_depth < min_qd)
 			return -ENOMEM;
 	}
 
-- 
2.5.0
