Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6CDC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD4A21548
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpUeBttt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nG9w6UVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD4A21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TexjHF87fo+GNla41LjBhy4ASoQsxmsFj81x1NQgnaQ=; b=MpUeBtttVsVE/k5uXTsw7lhhV
	RsmvEC+ExPOUIQETB98mH+9ekBJ66mk08lhGqV0h9AqR0bVWjHWsGfvYXnc9Coc0L8TpbzF+TDeaT
	kGl+XbT+KalU8D/D4M6NlJomVlNU6UDAJVPOscLktha16+i3d7Bu3L4RZLj5xiLvU8NEwLP5KL3y+
	3OTDzt4ySoI8dilupjApcZoyn1JG874/WKfJ0m/g1fSLBfz8bS7/c3L9Ez8ASPJ46DGz50SwMAgEn
	z+PvsoOGv8nRBDM9RHwzQO5A1xNz0RaXutpRPMFxVJLR09LDG5VsMwEX9OzA0fN3uE1K1rKf+ebAg
	nBCeQkYYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsN7-0002LK-AY; Mon, 28 Sep 2020 12:35:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN3-0002KM-Qe
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=j8ops9cA9b12V83tKSwp5zaGHQ7WpJ5p33aXh0B1Yxw=; b=nG9w6UVcEwRK7FdHJKPnko4c1P
 /jbvrnGQy8nPpzT5MCXflG1uXp7DTBCzUBqqw01I6gLHDhVhPUf3Q3lUff9Kj0O5YVxcGxqeXKgCe
 Q4x9OI8sczFdh2+Cl0GcpXXWf7CR6VnlWuh3UJeVgEZlQ0xmkK997qJ5MWoOXs4f+2pdONKiYnABc
 CteZ018ra9fTYoWBWV3goCu4YAdoZsa1LQ3dBTVoqxKZHAlwYBlANEyhR05WFpR8SKf6HBP6N+fEe
 rp5lSNyP4zeUlu4w2XMDa4oxWBvGy8uKsMpKC+0a7xTsRr88F0I59mzJ396jRGy0GxpIZAHXsONuL
 7SopmY1A==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN2-0004hy-Mc; Mon, 28 Sep 2020 12:35:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 03/20] nvme: remove the disk argument to nvme_update_zone_info
Date: Mon, 28 Sep 2020 14:34:45 +0200
Message-Id: <20200928123502.435373-4-hch@lst.de>
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

The queue can trivially be derived from the nvme_ns structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 8 ++------
 drivers/nvme/host/zns.c  | 5 ++---
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 400d995f95fe2d..d4b5032084972a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,7 +2095,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	case NVME_CSI_NVM:
 		break;
 	case NVME_CSI_ZNS:
-		ret = nvme_update_zone_info(disk, ns, lbaf);
+		ret = nvme_update_zone_info(ns, lbaf);
 		if (ret) {
 			dev_warn(ctrl->device,
 				"failed to add zoned namespace:%u ret:%d\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6cbbd1597ae6d7..5667761001267d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -760,9 +760,7 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 
 int nvme_revalidate_zones(struct nvme_ns *ns);
 #ifdef CONFIG_BLK_DEV_ZONED
-int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
-			  unsigned lbaf);
-
+int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
 int nvme_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
 
@@ -779,9 +777,7 @@ static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
 	return BLK_STS_NOTSUPP;
 }
 
-static inline int nvme_update_zone_info(struct gendisk *disk,
-					struct nvme_ns *ns,
-					unsigned lbaf)
+static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 {
 	dev_warn(ns->ctrl->device,
 		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 672a18fcf3bfe2..cdabc3eb192bad 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -46,11 +46,10 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
-int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
-			  unsigned lbaf)
+int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 {
 	struct nvme_effects_log *log = ns->head->effects;
-	struct request_queue *q = disk->queue;
+	struct request_queue *q = ns->queue;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
 	int status;
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
