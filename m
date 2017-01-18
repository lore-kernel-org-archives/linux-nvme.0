From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 17 Jan 2017 17:54:20 -0800
Subject: [PATCH 3/3] nvme: Add a quirk to disable APST on a buggy Samsung
 device
In-Reply-To: <cover.1484703713.git.luto@kernel.org>
References: <cover.1484703713.git.luto@kernel.org>
Message-ID: <c03cc754700d18667ffe88d9e46b2e458f8848ee.1484703713.git.luto@kernel.org>

This can't use the existing NVMe-over-PCI quirk mechanism because,
as far as I can tell, all the Samsung devices use the same PCI
device id.  Instead, this adds a "core" quirk table that matches on
the vendor id and one or more of (model name, firmware revision),
and quirks found in that table will be added to the quirk mask.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 12 +++++++++++-
 drivers/nvme/host/nvme.h |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index be887dc2ffc9..9395e016f602 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1328,6 +1328,16 @@ struct nvme_core_quirk_entry {
 };
 
 static const struct nvme_core_quirk_entry core_quirks[] = {
+	/*
+	 * Seen on a Samsung "SM951 NVMe SAMSUNG 256GB": using APST causes
+	 * the controller to go out to lunch.  It dies when the watchdog
+	 * timer reads CSTS and gets 0xffffffff.
+	 */
+	{
+		.vid = 0x144d,
+		.fr = "BXW75D0Q",
+		.quirks = NVME_QUIRK_NO_APST,
+	},
 };
 
 /* match is null-terminated but idstr is space-padded. */
@@ -1424,7 +1434,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->npss = id->npss;
 	prev_apsta = ctrl->apsta;
-	ctrl->apsta = id->apsta;
+	ctrl->apsta = (ctrl->quirks & NVME_QUIRK_NO_APST) ? 0 : id->apsta;
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
 	if (ctrl->ops->is_fabrics) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1e9aa7482b75..629129133be0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -77,6 +77,11 @@ enum nvme_quirks {
 	 * readiness, which is done by reading the NVME_CSTS_RDY bit.
 	 */
 	NVME_QUIRK_DELAY_BEFORE_CHK_RDY		= (1 << 3),
+
+	/*
+	 * APST should not be used.
+	 */
+	NVME_QUIRK_NO_APST			= (1 << 4),
 };
 
 /*
-- 
2.9.3
