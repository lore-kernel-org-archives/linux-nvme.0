From: daniel.mcleran@intel.com (Dan McLeran)
Date: Fri,  6 Jun 2014 08:27:27 -0600
Subject: [PATCH] NVMe: Fix START_STOP_UNIT Scsi->NVMe translation.
Message-ID: <1402064847-8412-1-git-send-email-daniel.mcleran@intel.com>

This patch contains several fixes for Scsi START_STOP_UNIT. The previous code did not account for
signed vs. unsigned arithmetic which resulted in an invalid lowest power state caculation when
the device only supports 1 power state.

The code for Power Condition == 2 (Idle) was not following the spec. The spec calls out
setting the device to specific power states, depending upon Power Condition Modifier, without
accounting for the number of power states supported by the device.

The code for Power Condition == 3 (Standby) was using a hard-coded '0' which I replaced with the
macro POWER_STATE_0.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-scsi.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 4fc25b9..61215ca 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1477,7 +1477,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out_dma;
 	}
 	id_ctrl = mem;
-	lowest_pow_st = id_ctrl->npss - 1;
+	lowest_pow_st = max(POWER_STATE_0, (int)(id_ctrl->npss - 1));
 
 	switch (pc) {
 	case NVME_POWER_STATE_START_VALID:
@@ -1496,18 +1496,18 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		/* Action unspecified if POWER CONDITION MODIFIER != [0,1,2] */
 		/* min of desired state and (lps-1) because lps is STOP */
 		if (pcmod == 0x0)
-			ps_desired = min(POWER_STATE_1, (lowest_pow_st - 1));
+			ps_desired = POWER_STATE_1;
 		else if (pcmod == 0x1)
-			ps_desired = min(POWER_STATE_2, (lowest_pow_st - 1));
+			ps_desired = POWER_STATE_2;
 		else if (pcmod == 0x2)
-			ps_desired = min(POWER_STATE_3, (lowest_pow_st - 1));
+			ps_desired = POWER_STATE_3;
 		break;
 	case NVME_POWER_STATE_STANDBY:
 		/* Action unspecified if POWER CONDITION MODIFIER != [0,1] */
 		if (pcmod == 0x0)
-			ps_desired = max(0, (lowest_pow_st - 2));
+			ps_desired = max(POWER_STATE_0, (lowest_pow_st - 2));
 		else if (pcmod == 0x1)
-			ps_desired = max(0, (lowest_pow_st - 1));
+			ps_desired = max(POWER_STATE_0, (lowest_pow_st - 1));
 		break;
 	case NVME_POWER_STATE_LU_CONTROL:
 	default:
-- 
1.7.10.4
