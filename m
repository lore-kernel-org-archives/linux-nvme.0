Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB848C47423
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F97121548
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZfoRO4zf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XTjtTnnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F97121548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JtQssey+PjLNaXkCKEpepl5/7+XZZTkZlRp6BqKdcc8=; b=ZfoRO4zfZTLgTXrErowRpyBs8
	/8yKjmS4IrNXT+v5aXV6iEg5fcP+XKdgRtzsmvodX1X6cfBvPIW3NpN7B9OsNZd0OiaErMoHVAAN1
	hftlzZEZS2OKH1AtJ7nbfaMNGAw6GNGnOCffdrf+J+HdUiNgnsBOKanknGmomWsxarjmPcfiEwj9a
	k1RSLm2SKndyzpYn8H3w9Fj39xI+JbGYF1KnwGoyRDaPl5+7XXMDIp+z44rdeMqe/2eR7NhH3MIfg
	eJezUGt2jw63vhfRrDFE2Bd+NRj7n45KlB4m7h6SkUsjH0O/JOjOgn/m/Fg0HJTuivS4opcJ4Zj2M
	du2N6uGxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsN6-0002Kw-0k; Mon, 28 Sep 2020 12:35:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN2-0002K8-H4
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=67Lh/Pd9rv1HQ+miIK5ShPqfT/9IvcoJtijmwspS6x8=; b=XTjtTnnXZsaim1wxdrFGZkOvZ/
 oCm/6qJ5rWk+YUh2eHpumduaXuG2SSwUCH0Gg0VBHsNSNh05QwCDnfi1+thOb4u37TmwaBwn2BXQn
 AE/0plv178HyK22jaliqtVgcwJ9I++c1v1nRK92sbrmDI5yec5/8dChPe/1kaOZvM4FO3Crab3hGb
 /9dtbB8L8bK12RRkBd0HOHDe6XjAD3XLB8TlWhzPeNIYt7m0AWPNQYDgeMyBeRclZnYqiZQ+Tq32M
 9qZEZBqAWBFMpfz9NMfJH6/7Gs3vgE9zbrWt6FQye/yKAi2fuSbd2NqNoZz44acHQZtRBUr7RiB9i
 ucIZbV/g==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN1-0004hr-Az; Mon, 28 Sep 2020 12:35:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Date: Mon, 28 Sep 2020 14:34:44 +0200
Message-Id: <20200928123502.435373-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The removal of the ->revalidate_disk method broke the initialization of
the zone bitmaps, as nvme_revalidate_disk now never gets called during
initialization.

Move the zone related code from nvme_revalidate_disk into a new helper in
zns.c, and call it from nvme_alloc_ns in addition to nvme_validate_ns to
ensure the zone bitmaps are initialized during probe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 28 +++++-----------------------
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/zns.c  | 11 +++++++++++
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a985c601c62c3..400d995f95fe2d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2202,28 +2202,6 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
 	return ret;
 }
 
-static int nvme_revalidate_disk(struct gendisk *disk)
-{
-	int ret;
-
-	ret = _nvme_revalidate_disk(disk);
-	if (ret)
-		return ret;
-
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (blk_queue_is_zoned(disk->queue)) {
-		struct nvme_ns *ns = disk->private_data;
-		struct nvme_ctrl *ctrl = ns->ctrl;
-
-		ret = blk_revalidate_disk_zones(disk, NULL);
-		if (!ret)
-			blk_queue_max_zone_append_sectors(disk->queue,
-							  ctrl->max_zone_append);
-	}
-#endif
-	return ret;
-}
-
 static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -3958,6 +3936,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (__nvme_revalidate_disk(disk, id))
 		goto out_put_disk;
+	if (blk_queue_is_zoned(ns->queue) && nvme_revalidate_zones(ns))
+		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -4052,7 +4032,9 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		return;
 	}
 
-	ret = nvme_revalidate_disk(ns->disk);
+	ret = _nvme_revalidate_disk(ns->disk);
+	if (!ret && blk_queue_is_zoned(ns->queue))
+		ret = nvme_revalidate_zones(ns);
 	revalidate_disk_size(ns->disk, ret == 0);
 	if (ret)
 		nvme_ns_remove(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1096ef1f6aa2b0..6cbbd1597ae6d7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -758,6 +758,7 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+int nvme_revalidate_zones(struct nvme_ns *ns);
 #ifdef CONFIG_BLK_DEV_ZONED
 int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 			  unsigned lbaf);
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 53efecb6789838..672a18fcf3bfe2 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -7,6 +7,17 @@
 #include <linux/vmalloc.h>
 #include "nvme.h"
 
+int nvme_revalidate_zones(struct nvme_ns *ns)
+{
+	struct request_queue *q = ns->disk->queue;
+	int ret;
+
+	ret = blk_revalidate_disk_zones(ns->disk, NULL);
+	if (!ret)
+		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+	return ret;
+}
+
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 {
 	struct nvme_command c = { };
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
