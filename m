Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C13EC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3weWIJUViJXKdzvof2vUgZ3p4PEoMrnAf9MFgx9mzWs=; b=2vTZaF4pQ0yCpKNDB44zkjyu0I
	hf2OIEUfayUgxk46MFaKzuojRXY22AubgInq/E1BJnp9K8Vz+foYEmPLedGS+zz4Rv9X4E68oB69c
	flpSTm23CfGAUwFmcuitLGhszTxIaXxC0B4xwwGPd9W6XzAQUoxsi7PlRQ9yN+W2a/FfA3PkRwwt9
	HuTPJXFn535AoLHFrewcqQG5IcnzS+WXw5/ORDeDJKrPj1r7pmofdLx9UfdwR83iJQNYm0HthqGpr
	E0ieqYuXXyCp2V9lq4E8V2JgK8kJeU2LXe723xw/KXN0dxQfBOgCYePZyj5W0IX+fR7BCtAKYZbJK
	X1YpD7RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fP-003Coj-1f;
	Fri, 30 Jun 2023 08:39:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fK-003Ckr-1H
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 08:39:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E903261689;
	Fri, 30 Jun 2023 08:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6D2C433C0;
	Fri, 30 Jun 2023 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114381;
	bh=CLkjUwaBY5FTvL02K2/nJwMOM3vPLIrW0Ksmnah+OcM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oCMZIzanjtlyQlIY/vh8hI/DvRMYDUBke1c3WlYevpIBRvwG/lKwHuNEVY79RZubJ
	 Ddn7B8gOh6ukNRQ3riAp6j7WeLBnaNuwk3+X0XTQv3o+ketGY+CR+dFZw+3j5qPGDj
	 0tvMJqPn+qcz3WARY556WRBcP2K1jsbNcSjAifn784fvANkorRtU0iNABZujiiH0Zi
	 KRBMQUFAIAtw8vfdu/3xmTHaoa4wbezoqY43yRSEsBwyftqF2vPXjkdF16mAmZtUPU
	 ngOjsalZFQyCTR/YTIXLRv8XOfexkzhnKgBIbmmoP38Lvq71WVZ25yeaATogsWm3HS
	 6xGAqDBKtQW2Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 4/5] block: virtio_blk: Set zone limits before revalidating zones
Date: Fri, 30 Jun 2023 17:39:34 +0900
Message-ID: <20230630083935.433334-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083935.433334-1-dlemoal@kernel.org>
References: <20230630083935.433334-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_013942_519105_B2FF8C11 
X-CRM114-Status: GOOD (  12.76  )
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

In virtblk_probe_zoned_device(), execute blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set the zoned device
zone size and maximum zone append sector limit before executing
blk_revalidate_disk_zones(). This is to allow the block layer zone
reavlidation to check these device characteristics prior to checking all
zones of the device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/virtio_blk.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b47358da92a2..1fe011676d07 100644
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
@@ -814,26 +814,22 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
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
+	blk_queue_max_zone_append_sectors(q, v);
+	dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
 
-	return ret;
+	return blk_revalidate_disk_zones(vblk->disk, NULL);
 }
 
 #else
-- 
2.41.0


