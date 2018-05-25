From: hare@suse.de (Hannes Reinecke)
Date: Fri, 25 May 2018 11:06:27 +0200
Subject: [PATCH] nvme: fixup memory leak in nvme_init_identify()
Message-ID: <20180525090627.58927-1-hare@suse.de>

If nvme_get_effects_log() failed the 'id' buffer from the previous
nvme_identify_ctrl() call will never be freed.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62262fac7a5d..79d49f16d991 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2314,7 +2314,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
 		ret = nvme_get_effects_log(ctrl);
 		if (ret < 0)
-			return ret;
+			goto out_free;
 	}
 
 	if (!ctrl->identified) {
-- 
2.12.3
