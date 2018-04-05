From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Thu,  5 Apr 2018 12:19:41 -0700
Subject: [PATCH] nvmet: fix space padding in serial number
Message-ID: <20180405191941.318707-1-daniel.verkamp@intel.com>

Commit 42de82a8b544 previously attempted to fix this, and it did
correctly pad the MN and FR fields with spaces, but the SN field still
contains 0 bytes.  The current code fills out the first 16 bytes with
hex2bin, leaving the last 4 bytes zeroed.  Rather than adding a lot of
error-prone math to avoid overwriting SN twice, just set the whole thing
to spaces up front (it's only 20 bytes).

Fixes: 42de82a8b544 ("nvmet: don't report 0-bytes in serial number")
Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 90dcdc40ac71..5e0e9fcc0d4d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -178,6 +178,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
+	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
 	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
-- 
2.14.3
