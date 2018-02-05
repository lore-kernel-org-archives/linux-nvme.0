From: jeff.lien@wdc.com (Jeff Lien)
Date: Mon,  5 Feb 2018 10:35:59 -0600
Subject: [PATCH v2] NVMe-CLI Fix fw_log Command json output
Message-ID: <20180205163559.25925-1-jeff.lien@wdc.com>

Currently, the json output for the fw_log command slot number
is zero based while the normal output is one based.  This patch
will change the json output to one based.  It will also only
print the revisions for the valid slots.

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 nvme-print.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 1ca4b71..b8c6df6 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1928,10 +1928,12 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
 	json_object_add_value_int(fwsi, "Active Firmware Slot (afi)", fw_log->afi);
 
 	for (i = 0; i < 7; i++) {
-		snprintf(fmt, sizeof(fmt), "Firmware Rev Slot %d", i);
-		snprintf(str, sizeof(str), "%"PRIu64" (%s)", (uint64_t)fw_log->frs[i],
-			 fw_to_string(fw_log->frs[i]));
-		json_object_add_value_string(fwsi, fmt, str);
+		if (fw_log->frs[i]) {
+		 	snprintf(fmt, sizeof(fmt), "Firmware Rev Slot %d", i+1);
+		 	snprintf(str, sizeof(str), "%"PRIu64" (%s)", (uint64_t)fw_log->frs[i],
+			fw_to_string(fw_log->frs[i]));
+		 	json_object_add_value_string(fwsi, fmt, str);
+		}
 	}
 	json_object_add_value_object(root, devname, fwsi);
 
-- 
2.14.2.746.g8fb8a94
