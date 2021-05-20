Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:46:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9E0610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9E0610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ffdzDqOZxzpQl49KNG2wqQzw6Bhs901CWF+5KLVSXHk=; b=rK/NZaAp3EL41Kg8ZrlHCyrIR
	BjDWubRF0eefYb+Hws3JkzEF0a/tevbaOeAWH6iUbcbzYbKiu/Kz+XrgTzgI+HXut9fPTgo8lQz61
	vvxwtk/ezvpS7RRTl6uKatlyIiWdbY/1c5zcjmabCIe4okTLI+2PtVIiW60w21OpLPAKEKHSQPS4T
	+kDmc6OzRcfiU2Oa5tsi5ytXjw8rQBxHcfGNzbiB1bN9i/OvbjoAGAl0iGWAeG1u69G2qB/Sj3xOv
	amddkS3qdTAmvi3mQeqzJfKfKrH1ddOJ3xdvp42BCEuqlz6+R46rAcyG9hFdAf4+mWFjUdGQaMaZx
	9A2gKJAig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbVO-005yr9-EG; Thu, 20 May 2021 05:45:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbUE-005yfS-8b
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=JoSJkBaJXcaVfj+E189RxrmtRUy7VbYxWGCjKY9TSqc=; b=z7IFZFgb9wUvKchSnHYDLa8N/Q
 PkEcns6nUvAuswOxwtKlyMemzlh0fcaMg+T4tyQj6KYG7tEbBO7N5mVHXCZoBNjngRE+cNva1JX6V
 e9FPPLwRcnHq9PsarvloWnXWiv7onrJrUak8FAxK1daPNA5Pj2ii/29EtAyYUnQMjRSYRoKT+QzcI
 a5Lv40U5WZArXBtOJqigM2Im2mP8cnj1/79Yex7PiYxac//RZDpkRO6oA0khRfm61nxzqr49YehB6
 VW3ogdn720MMejTt0SHZSKowT5p8emxUzz/nf01uzoALvUq7/JqU0NMDfGi5lAZYB4BulOLIO6ZGU
 diMrofjQ==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbUC-00FxMk-J1; Thu, 20 May 2021 05:44:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6/7] nvme: split nvme_report_zones
Date: Thu, 20 May 2021 07:44:25 +0200
Message-Id: <20210520054426.567241-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
References: <20210520054426.567241-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Split multipath support out of nvme_report_zones into a separate helper
and simplify the non-multipath version as a result.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 11 +++++++++++
 drivers/nvme/host/multipath.c | 21 ++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  7 ++-----
 drivers/nvme/host/zns.c       | 20 ++------------------
 4 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e7441ccaa8db..309b7b3635f0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2073,6 +2073,17 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static int nvme_report_zones(struct gendisk *disk, sector_t sector,
+		unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
+			data);
+}
+#else
+#define nvme_report_zones	NULL
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 static const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f81871c7128a..127a17b4c13d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -349,6 +349,25 @@ static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
 	nvme_put_ns_head(disk->private_data);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
+		unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx, ret = -EWOULDBLOCK;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (ns)
+		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+#else
+#define nvme_ns_head_report_zones	NULL
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 const struct block_device_operations nvme_ns_head_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= nvme_ns_head_submit_bio,
@@ -356,7 +375,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ns_head_ioctl,
 	.getgeo		= nvme_getgeo,
-	.report_zones	= nvme_report_zones,
+	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0015860ec12b..01f41b2bf915 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -810,17 +810,14 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_revalidate_zones(struct nvme_ns *ns);
+int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
+		unsigned int nr_zones, report_zones_cb cb, void *data);
 #ifdef CONFIG_BLK_DEV_ZONED
 int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
-int nvme_report_zones(struct gendisk *disk, sector_t sector,
-		      unsigned int nr_zones, report_zones_cb cb, void *data);
-
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 				       struct nvme_command *cmnd,
 				       enum nvme_zone_mgmt_action action);
 #else
-#define nvme_report_zones NULL
-
 static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_zone_mgmt_action action)
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 31e789ecd940..d95010481fce 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -171,8 +171,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	return cb(&zone, idx, data);
 }
 
-static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
-			unsigned int nr_zones, report_zones_cb cb, void *data)
+int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
+		unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct nvme_zone_report *report;
 	struct nvme_command c = { };
@@ -230,22 +230,6 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	return ret;
 }
 
-int nvme_report_zones(struct gendisk *disk, sector_t sector,
-		      unsigned int nr_zones, report_zones_cb cb, void *data)
-{
-	struct nvme_ns_head *head = NULL;
-	struct nvme_ns *ns;
-	int srcu_idx, ret;
-
-	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
-	if (unlikely(!ns))
-		return -EWOULDBLOCK;
-	ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
-	nvme_put_ns_from_disk(head, srcu_idx);
-
-	return ret;
-}
-
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *c, enum nvme_zone_mgmt_action action)
 {
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
