Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EADAC46CD3
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Dec 2023 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=enCDnmquPxgkKwyC2qR+XvLDdfSg3i0fs7qLsP5yxNo=; b=B0F6d0lhyGffkwkZ6G8XZPv/bi
	ZeqtIh+LasbwGSxZNIWbQLSTY5ZTMJRT4FWbfm6BMwBVyhAkPqTH/0EhFHdZu1GFKnOIEQPOBa+Jm
	jFRk8Y+rXjczNMEKElGWTBwm7uupwe7zalOZBn4rw3VpiQUsooE6TcsEFBG9bK3gUNnoNx9bB7EVH
	b0HRDNSFzmwNcWTTwlC/fhT6ycWo2S+SDcB6UGeXPhUuCfQ4CBfN/k9NFsfzS/lAtSIHXnOBajkB9
	mk0WHKITE7ea9tLPle6FVLK0VafvE3YHge2gBb45hJQdxt4uKULnQelipNOEL7wWGMFN2veRoM2mz
	0pHT1s9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuP2-0088Lz-08;
	Sun, 17 Dec 2023 16:54:08 +0000
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuOz-0088LO-2C;
	Sun, 17 Dec 2023 16:54:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 1/5] virtio_blk: cleanup zoned device probing
Date: Sun, 17 Dec 2023 17:53:55 +0100
Message-Id: <20231217165359.604246-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
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

Move reading and checking the zoned model from virtblk_probe_zoned_device
into the caller, leaving only the code to perform the actual setup for
host managed zoned devices in virtblk_probe_zoned_device.

This allows to share the model reading and sharing between builds with
and without CONFIG_BLK_DEV_ZONED, and improve it for the
!CONFIG_BLK_DEV_ZONED case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 50 +++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69a4..aeead732a24dc9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -748,22 +748,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 				       struct request_queue *q)
 {
 	u32 v, wg;
-	u8 model;
-
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.model, &model);
-
-	switch (model) {
-	case VIRTIO_BLK_Z_NONE:
-	case VIRTIO_BLK_Z_HA:
-		/* Present the host-aware device as non-zoned */
-		return 0;
-	case VIRTIO_BLK_Z_HM:
-		break;
-	default:
-		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
-		return -EINVAL;
-	}
 
 	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
 
@@ -846,16 +830,9 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
-	u8 model;
-
-	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
-	if (model == VIRTIO_BLK_Z_HM) {
-		dev_err(&vdev->dev,
-			"virtio_blk: zoned devices are not supported");
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	dev_err(&vdev->dev,
+		"virtio_blk: zoned devices are not supported");
+	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -1570,9 +1547,26 @@ static int virtblk_probe(struct virtio_device *vdev)
 	 * placed after the virtio_device_ready() call above.
 	 */
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
-		err = virtblk_probe_zoned_device(vdev, vblk, q);
-		if (err)
+		u8 model;
+
+		virtio_cread(vdev, struct virtio_blk_config, zoned.model,
+				&model);
+		switch (model) {
+		case VIRTIO_BLK_Z_NONE:
+		case VIRTIO_BLK_Z_HA:
+			/* Present the host-aware device as non-zoned */
+			break;
+		case VIRTIO_BLK_Z_HM:
+			err = virtblk_probe_zoned_device(vdev, vblk, q);
+			if (err)
+				goto out_cleanup_disk;
+			break;
+		default:
+			dev_err(&vdev->dev, "unsupported zone model %d\n",
+				model);
+			err = -EINVAL;
 			goto out_cleanup_disk;
+		}
 	}
 
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
-- 
2.39.2


