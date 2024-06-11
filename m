Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E3EC27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XX8OKzSF4I8HqKWv9CPGPzdF42TlXrJn92mCb7zGUpU=; b=WiD+mzGT4zhFh7Nh9wDZDzNYno
	G1J/wNlQFZWkLvu9vVZBjKl9P9GuQxwxw4Hkv1f+zyVVIC1Yu4lrK0sWaI++TV7smJLacvrZZXFRR
	QLpa6Mpd20F0C8nf4cdcJoG7sCAQUzokkS4PQpQX9KZPnCF1TPZdNVaDP3IANWYWc5QIO4TZnDkCX
	47jFC4DVtAwNKXA7Yszap2LwYPJzx0a6EFneWkc4NsiJ8uhHKzPnNMP22Mqm0TMmDjHT4Yk+M9Nq5
	yxKoyJPu7j7s/OReLRmrS3tSxCET7tYcYWqQwYdTE0bxfFel59hvKdSUdfQlyip8TsnZoIa55hxoO
	76Uh44nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtzR-00000007UGM-2en5;
	Tue, 11 Jun 2024 05:24:13 +0000
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtvO-00000007R2v-03k6;
	Tue, 11 Jun 2024 05:20:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com,
	nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/26] xen-blkfront: don't disable cache flushes when they fail
Date: Tue, 11 Jun 2024 07:19:10 +0200
Message-ID: <20240611051929.513387-11-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 22:22:01 -0700
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

blkfront always had a robust negotiation protocol for detecting a write
cache.  Stop simply disabling cache flushes when they fail as that is
a grave error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 9b4ec3e4908cce..9794ac2d3299d1 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -982,18 +982,6 @@ static const char *flush_info(struct blkfront_info *info)
 		return "barrier or flush: disabled;";
 }
 
-static void xlvbd_flush(struct blkfront_info *info)
-{
-	blk_queue_write_cache(info->rq, info->feature_flush ? true : false,
-			      info->feature_fua ? true : false);
-	pr_info("blkfront: %s: %s %s %s %s %s %s %s\n",
-		info->gd->disk_name, flush_info(info),
-		"persistent grants:", info->feature_persistent ?
-		"enabled;" : "disabled;", "indirect descriptors:",
-		info->max_indirect_segments ? "enabled;" : "disabled;",
-		"bounce buffer:", info->bounce ? "enabled" : "disabled;");
-}
-
 static int xen_translate_vdev(int vdevice, int *minor, unsigned int *offset)
 {
 	int major;
@@ -1162,7 +1150,15 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	info->sector_size = sector_size;
 	info->physical_sector_size = physical_sector_size;
 
-	xlvbd_flush(info);
+	blk_queue_write_cache(info->rq, info->feature_flush ? true : false,
+			      info->feature_fua ? true : false);
+
+	pr_info("blkfront: %s: %s %s %s %s %s %s %s\n",
+		info->gd->disk_name, flush_info(info),
+		"persistent grants:", info->feature_persistent ?
+		"enabled;" : "disabled;", "indirect descriptors:",
+		info->max_indirect_segments ? "enabled;" : "disabled;",
+		"bounce buffer:", info->bounce ? "enabled" : "disabled;");
 
 	if (info->vdisk_info & VDISK_READONLY)
 		set_disk_ro(gd, 1);
@@ -1622,13 +1618,6 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
-			if (unlikely(blkif_req(req)->error)) {
-				if (blkif_req(req)->error == BLK_STS_NOTSUPP)
-					blkif_req(req)->error = BLK_STS_OK;
-				info->feature_fua = 0;
-				info->feature_flush = 0;
-				xlvbd_flush(info);
-			}
 			fallthrough;
 		case BLKIF_OP_READ:
 		case BLKIF_OP_WRITE:
-- 
2.43.0


