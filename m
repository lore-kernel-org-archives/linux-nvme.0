From: sathya.prakash@broadcom.com (Sathya Prakash Veerichetty)
Date: Mon, 24 Jul 2017 15:52:16 -0600
Subject: Test Unit Ready translation seems wrong in latest driver
Message-ID: <706a68b8482154bdf77efe7fb195fe24@mail.gmail.com>

The TUR translation returns LUN not ready when the controller is ready in
the latest code whereas in the old code it returns LUN not ready only when
the controller is not ready (proper behavior).

The patch  [PATCH 11/47] nvme: split a new struct nvme_ctrl out of struct
nvme_dev seeded the issue by missing the !.

@@ -2295,9 +2288,7 @@ static int nvme_trans_test_unit_ready(struct nvme_ns
*ns,
 					struct sg_io_hdr *hdr,
 					u8 *cmd)
 {
-	struct nvme_dev *dev = ns->dev;
-
-	if (!(readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_RDY))
+	if (nvme_ctrl_ready(ns->ctrl))
 		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
 					    NOT_READY,
SCSI_ASC_LUN_NOT_READY,

SCSI_ASCQ_CAUSE_NOT_REPORTABLE);

Thanks
Sathya
