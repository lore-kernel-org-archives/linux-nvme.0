From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed, 28 Feb 2018 16:49:30 +0100
Subject: [PATCH 10/15] lightnvm: pblk: check for supported version
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519832975-25432-11-git-send-email-javier@cnexlabs.com>

At this point, only 1.2 spec is supported, thus check for it. Also,
since device-side L2P is only supported in the 1.2 spec, make sure to
only check its value under 1.2.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 11424beb214c..b67b5b11ae16 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -991,9 +991,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	struct pblk *pblk;
 	int ret;
 
-	if (dev->geo.dom & NVM_RSP_L2P) {
+	if (geo->version != NVM_OCSSD_SPEC_12) {
+		pr_err("pblk: OCSSD version not supported (%u)\n",
+							geo->version);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
 		pr_err("pblk: host-side L2P table not supported. (%x)\n",
-							dev->geo.dom);
+							geo->dom);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.7.4
