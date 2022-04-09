Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E61DC433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Apr 2022 04:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7OacHYZtXHcRJcUjaO4g7N75FFwuFvyGKpz8CHLs7c=; b=SI/mZYHxng7vPzzKpqSTrssyNy
	b9TFoYxYfKhI2Is42cyOaU6gf3Mt8xF5l1fBI5NUSxIJlwWSRZlElWHXmgw+JDN0bIMAdu9JkFg4R
	W3B8iI32VbJSstodih/ANeDwktr3FcB52SK6n37zkG0qgag3yrVJi0E/z1GErBbYlZ3vpmTJrQBz1
	2iMB4NscIFRRCAgxdge1Wq2xV+RePkiviKpzcNfx5TX41qNt9ul+P3fekik+BBQhOv84DFfVYbqXZ
	F71s92AbKDBreF8Gt0WoLsmSFLDpQPdqFbVgZ0mdhNN3fmvGe5hDNAziBgpnLsdk3lol43xtOI0wU
	VUXgpITw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nd36h-0022v6-Rp; Sat, 09 Apr 2022 04:53:55 +0000
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd33s-0020WM-ET; Sat, 09 Apr 2022 04:51:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: [PATCH 04/27] drbd: remove assign_p_sizes_qlim
Date: Sat,  9 Apr 2022 06:50:20 +0200
Message-Id: <20220409045043.23593-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
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

Fold each branch into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c | 47 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9676a1d214bc5..1262fe1c33618 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -903,31 +903,6 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 	}
 }
 
-/* communicated if (agreed_features & DRBD_FF_WSAME) */
-static void
-assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
-					struct request_queue *q)
-{
-	if (q) {
-		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
-		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
-		p->qlim->alignment_offset = cpu_to_be32(queue_alignment_offset(q));
-		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
-		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
-		p->qlim->discard_enabled = blk_queue_discard(q);
-		p->qlim->write_same_capable = 0;
-	} else {
-		q = device->rq_queue;
-		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
-		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
-		p->qlim->alignment_offset = 0;
-		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
-		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
-		p->qlim->discard_enabled = 0;
-		p->qlim->write_same_capable = 0;
-	}
-}
-
 int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags)
 {
 	struct drbd_device *device = peer_device->device;
@@ -957,14 +932,32 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
 		q_order_type = drbd_queue_order_type(device);
 		max_bio_size = queue_max_hw_sectors(q) << 9;
 		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
-		assign_p_sizes_qlim(device, p, q);
+		p->qlim->physical_block_size =
+			cpu_to_be32(queue_physical_block_size(q));
+		p->qlim->logical_block_size =
+			cpu_to_be32(queue_logical_block_size(q));
+		p->qlim->alignment_offset =
+			cpu_to_be32(queue_alignment_offset(q));
+		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
+		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
+		p->qlim->discard_enabled = blk_queue_discard(q);
 		put_ldev(device);
 	} else {
+		struct request_queue *q = device->rq_queue;
+
+		p->qlim->physical_block_size =
+			cpu_to_be32(queue_physical_block_size(q));
+		p->qlim->logical_block_size =
+			cpu_to_be32(queue_logical_block_size(q));
+		p->qlim->alignment_offset = 0;
+		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
+		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
+		p->qlim->discard_enabled = 0;
+
 		d_size = 0;
 		u_size = 0;
 		q_order_type = QUEUE_ORDERED_NONE;
 		max_bio_size = DRBD_MAX_BIO_SIZE; /* ... multiple BIOs per peer_request */
-		assign_p_sizes_qlim(device, p, NULL);
 	}
 
 	if (peer_device->connection->agreed_pro_version <= 94)
-- 
2.30.2


