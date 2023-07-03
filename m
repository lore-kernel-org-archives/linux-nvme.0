Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6E8C04A6A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6k3JB8Yi2dgF3/B6aoP7SrVOrWhUSxEiaodiZmqNEmE=; b=Y6a7RRJ35Tm3hsPO5ZIlGZ9Dhg
	dnsDUg0AfHjIPNmtkB2h8anZbwFq/0eVFhLOiif80mU/iP9K7Bwtp9ZwOXcajV8X3ZOa02rA/odWs
	yhNeV/GV2vxVOccGt8+fZA0AbrOIgUA9XFbXMydOBzRMtxNEJquP96SgWmxCGFaW2li9kmpjdEL9n
	xT6UcFZK4twRNtcjL55E+vwnfkg6iP31BlxB/3WUxSw2G95PeVejD2j6FfFVXI03EOM7f3LOM/Reh
	kfW2WOTwB8Q3DoNbkwcZILWHwG3BYDVbbpXQEvGTVbN7N+nKI5pPK+88izNoIRaEVTrlPHaq8vTwc
	GvtRvl6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9by-00962z-0J;
	Mon, 03 Jul 2023 02:48:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bv-0095zk-1p
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 02:48:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6C43660C7A;
	Mon,  3 Jul 2023 02:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F6C433C7;
	Mon,  3 Jul 2023 02:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688352498;
	bh=dBbFmN/6e1g7/clXdxXG0GneFGbYmbapZVRFT4a/gV8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JgzzMDF1k9nSJ+vF0pGaPf6W5YfDpHWKV99LnLkwBrYffh3eC7/sE9cuS9yoa/kd+
	 ic1Lf+bJaWMNM5EY+t9ta4xsEjDeREDxfhRk2jCygZKgU4mCrg1z4S/s95b+MKGBRA
	 phtTFg+yCnPGRkkBKCwSV+eccONQ1gXBmTUYiBqF2MLvLixbpebd6KD7+pmb8cG4HB
	 wqf/mXJKEUMYTQspKE9kK82TpASz1AfG+BsNrFc0Yn5R3KFsn/4GaK+xguOqzTKjkk
	 WF1iN6JA4rGlKqlmQCvJnqan7mhX5InzlBjMKR7BTfdPLwcmvWNdGp5IUD50TSYxok
	 crOh52ekvIeYQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 4/5] block: virtio_blk: Set zone limits before revalidating zones
Date: Mon,  3 Jul 2023 11:48:11 +0900
Message-ID: <20230703024812.76778-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703024812.76778-1-dlemoal@kernel.org>
References: <20230703024812.76778-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_194819_686032_77121B49 
X-CRM114-Status: GOOD (  13.17  )
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
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


