Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0999CC001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MErqQWuHXQkx29lgJh13/RK/2BLip0mqLHZMg6wELcA=; b=A8w148pXy1yCkyRavn9C2qp2sa
	ChlWyuZJI7nnvnRnWGgEPlkl/vYdwB48gk896XrJHH45d7nFF8NYhYO5r14M4d+1bhwpQOZh2Y3KB
	GMtRj+asIp429cuBde/rjBRm3B565kK6IZOQoDfMxaaUGTGXJEXzVMDYCF4qtdqWLatNE0867+82o
	I9MeB+qXkwWt5DzM1GrWINGuHmqtgXdvMp8s2QuNLZG1MHro9UjQy6Xq1xgC0XyzFyuIUWAbD8ivj
	rUF1BC791k9osaE8CHElY1A7Lvg2BYRAvE6fGvEhPVxxOH+tqbn/ljkzZdaqLzfqG/J9WBiqX7e+N
	IxshmL2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6e-0005xX-1I;
	Thu, 29 Jun 2023 06:26:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6X-0005u8-31
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:26:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 795CB614AC;
	Thu, 29 Jun 2023 06:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23616C433C9;
	Thu, 29 Jun 2023 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688019968;
	bh=xHJViNRochmFfkpGu4V5kEET8WKXpezvRtP00JVSRG8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kOyEskx6rtk6VOMI0reImUMVyeAtzfP+X35hcsD8M9YpjZmdRj841av8fiN/rUo1U
	 a7pQKXsrHuLjl1iPVU7bhmVwXn++Sfo2jLvFKnatroHxzbYvwOj4svYUc12rmA9l3a
	 PISadmrykYPTUCA7/4Nu/TQojKPYgulCQ/oi3ZE/BB+uBil+03K4z0TgLuGUOScfBz
	 YcmX/MFTOK0jXGeeKfaCxNGkNRo6kPoKCiKctEfwpuw21E6c6C3KR/rmIOq6igQbFK
	 tvLTE1sMo62GxcNME05q9n6kLGmyoM01MG292oqjIWHAlCxFQtgCIoFb64DFL0ZgC2
	 qcMb3uTXaCMGg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4/5] block: virtio_blk: Set zone limits before revalidating zones
Date: Thu, 29 Jun 2023 15:26:01 +0900
Message-ID: <20230629062602.234913-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629062602.234913-1-dlemoal@kernel.org>
References: <20230629062602.234913-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_232610_056702_54031592 
X-CRM114-Status: GOOD (  12.49  )
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

In virtblk_probe_zoned_device(), call blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set a device zone
size and maximum zone append sector limit before executing
blk_revalidate_disk_zones() to allow this function to check zone limits.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/virtio_blk.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b47358da92a2..7d9c9f9d2ae9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -751,7 +751,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	u32 v, wg;
 	u8 model;
-	int ret;
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.model, &model);
@@ -806,6 +805,7 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			vblk->zone_sectors);
 		return -ENODEV;
 	}
+	blk_queue_chunk_sectors(q, vblk->zone_sectors);
 	dev_dbg(&vdev->dev, "zone sectors = %u\n", vblk->zone_sectors);
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
@@ -814,26 +814,23 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 		blk_queue_max_discard_sectors(q, 0);
 	}
 
-	ret = blk_revalidate_disk_zones(vblk->disk, NULL);
-	if (!ret) {
-		virtio_cread(vdev, struct virtio_blk_config,
-			     zoned.max_append_sectors, &v);
-		if (!v) {
-			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
-			return -ENODEV;
-		}
-		if ((v << SECTOR_SHIFT) < wg) {
-			dev_err(&vdev->dev,
-				"write granularity %u exceeds max_append_sectors %u limit\n",
-				wg, v);
-			return -ENODEV;
-		}
-
-		blk_queue_max_zone_append_sectors(q, v);
-		dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
+	virtio_cread(vdev, struct virtio_blk_config,
+		     zoned.max_append_sectors, &v);
+	if (!v) {
+		dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
+		return -ENODEV;
+	}
+	if ((v << SECTOR_SHIFT) < wg) {
+		dev_err(&vdev->dev,
+			"write granularity %u exceeds max_append_sectors %u limit\n",
+			wg, v);
+		return -ENODEV;
 	}
 
-	return ret;
+	blk_queue_max_zone_append_sectors(q, v);
+	dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
+
+	return blk_revalidate_disk_zones(vblk->disk, NULL);
 }
 
 #else
-- 
2.41.0


