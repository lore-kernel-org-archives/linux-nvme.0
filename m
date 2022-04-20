Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833FEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4iywM2NxZtj81lS0JMiWG3oPa1GX0IJLJcAv71fJKM=; b=aPfaEB6C2dT8Gf+xjI8AHyUJmi
	z67cmlfSqnByTrm0VK8kUlkctPmGmP16sgXm4BTL0xtKT8ruDBFW9WLHeeXuMjQj/W5s8wUQcyBD4
	5QR4XZjDeuTD8QlqvWXv6CbHQ4dJ3pOQ19q699EkywkOOZmVH8jwHZTAmhwDtDuZIiX8+rdodciXz
	jlEmQH55THBrQYvWs0iOQ8iZoZvnU5mZyg1Soi5PxssKIVF3hWX0PyqchKwbRH1mjDf2rBan3YD3b
	FFxly/JRUcpDDOoM4GKAHq6ck4lnT5d8kzSq19A2XUHJhX2emJJjEujPzcMnvJd974QWtpaWK3GVf
	lguM8/0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wT-007FOB-9s; Wed, 20 Apr 2022 04:27:49 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wK-007FGp-Ja; Wed, 20 Apr 2022 04:27:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 04/15] blk-cgroup: move blkcg_{get,set}_fc_appid out of line
Date: Wed, 20 Apr 2022 06:27:12 +0200
Message-Id: <20220420042723.1010598-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

No need to have these helpers inline.  Also remove the stubs and just use
an IS_ENABLED for the get side (the set side already is only built
conditionlly).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile                |  1 +
 block/blk-cgroup-fc-appid.c   | 57 ++++++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_scsi.c |  4 ++-
 include/linux/blk-cgroup.h    | 58 ++---------------------------------
 4 files changed, 63 insertions(+), 57 deletions(-)
 create mode 100644 block/blk-cgroup-fc-appid.c

diff --git a/block/Makefile b/block/Makefile
index 3950ecbc5c263..4e01bb71ad6e0 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
+obj-$(CONFIG_BLK_CGROUP_FC_APPID) += blk-cgroup-fc-appid.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
diff --git a/block/blk-cgroup-fc-appid.c b/block/blk-cgroup-fc-appid.c
new file mode 100644
index 0000000000000..760a2e1878dde
--- /dev/null
+++ b/block/blk-cgroup-fc-appid.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "blk-cgroup.h"
+
+/**
+ * blkcg_set_fc_appid - set the fc_app_id field associted to blkcg
+ * @app_id: application identifier
+ * @cgrp_id: cgroup id
+ * @app_id_len: size of application identifier
+ */
+int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
+{
+	struct cgroup *cgrp;
+	struct cgroup_subsys_state *css;
+	struct blkcg *blkcg;
+	int ret  = 0;
+
+	if (app_id_len > FC_APPID_LEN)
+		return -EINVAL;
+
+	cgrp = cgroup_get_from_id(cgrp_id);
+	if (!cgrp)
+		return -ENOENT;
+	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
+	if (!css) {
+		ret = -ENOENT;
+		goto out_cgrp_put;
+	}
+	blkcg = css_to_blkcg(css);
+	/*
+	 * There is a slight race condition on setting the appid.
+	 * Worst case an I/O may not find the right id.
+	 * This is no different from the I/O we let pass while obtaining
+	 * the vmid from the fabric.
+	 * Adding the overhead of a lock is not necessary.
+	 */
+	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
+	css_put(css);
+out_cgrp_put:
+	cgroup_put(cgrp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkcg_set_fc_appid);
+
+/**
+ * blkcg_get_fc_appid - get the fc app identifier associated with a bio
+ * @bio: target bio
+ *
+ * On success return the fc_app_id, on failure return NULL
+ */
+char *blkcg_get_fc_appid(struct bio *bio)
+{
+	if (!bio->bi_blkg || bio->bi_blkg->blkcg->fc_app_id[0] == '\0')
+		return NULL;
+	return bio->bi_blkg->blkcg->fc_app_id;
+}
+EXPORT_SYMBOL_GPL(blkcg_get_fc_appid);
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ba9dbb51b75f0..f6b83853f7eea 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5528,7 +5528,9 @@ static char *lpfc_is_command_vm_io(struct scsi_cmnd *cmd)
 {
 	struct bio *bio = scsi_cmd_to_rq(cmd)->bio;
 
-	return bio ? blkcg_get_fc_appid(bio) : NULL;
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !bio)
+		return NULL;
+	return blkcg_get_fc_appid(bio);
 }
 
 /**
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 652cd05b0924c..7a2f7de30173c 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -218,61 +218,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
 
 #endif	/* CONFIG_BLK_CGROUP */
 
-#ifdef CONFIG_BLK_CGROUP_FC_APPID
-/*
- * Sets the fc_app_id field associted to blkcg
- * @app_id: application identifier
- * @cgrp_id: cgroup id
- * @app_id_len: size of application identifier
- */
-static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
-{
-	struct cgroup *cgrp;
-	struct cgroup_subsys_state *css;
-	struct blkcg *blkcg;
-	int ret  = 0;
-
-	if (app_id_len > FC_APPID_LEN)
-		return -EINVAL;
-
-	cgrp = cgroup_get_from_id(cgrp_id);
-	if (!cgrp)
-		return -ENOENT;
-	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
-	if (!css) {
-		ret = -ENOENT;
-		goto out_cgrp_put;
-	}
-	blkcg = css_to_blkcg(css);
-	/*
-	 * There is a slight race condition on setting the appid.
-	 * Worst case an I/O may not find the right id.
-	 * This is no different from the I/O we let pass while obtaining
-	 * the vmid from the fabric.
-	 * Adding the overhead of a lock is not necessary.
-	 */
-	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
-	css_put(css);
-out_cgrp_put:
-	cgroup_put(cgrp);
-	return ret;
-}
+int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
+char *blkcg_get_fc_appid(struct bio *bio);
 
-/**
- * blkcg_get_fc_appid - get the fc app identifier associated with a bio
- * @bio: target bio
- *
- * On success return the fc_app_id, on failure return NULL
- */
-static inline char *blkcg_get_fc_appid(struct bio *bio)
-{
-	if (bio && bio->bi_blkg &&
-		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
-		return bio->bi_blkg->blkcg->fc_app_id;
-	return NULL;
-}
-#else
-static inline int blkcg_set_fc_appid(char *buf, u64 id, size_t len) { return -EINVAL; }
-static inline char *blkcg_get_fc_appid(struct bio *bio) { return NULL; }
-#endif /*CONFIG_BLK_CGROUP_FC_APPID*/
 #endif	/* _BLK_CGROUP_H */
-- 
2.30.2


