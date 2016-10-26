From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 26 Oct 2016 13:20:57 -0700
Subject: [PATCH] nvme-loop: kfree(ctrl) on _create() error exit
Message-ID: <1477513257-30474-1-git-send-email-james_p_freyensee@linux.intel.com>

ctrl is kzalloc'ed but looks like it's never kfree'ed
on the goto exit cases on nvme_loop_create_ctrl().

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d5df77d..b0f9931 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -673,6 +673,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	nvme_uninit_ctrl(&ctrl->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
+	kfree(ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
-- 
2.7.4
