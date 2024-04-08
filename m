Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC718CD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8jYj29l+b2/vmDd4xO2ALhQl+bPEeT6wF5egWxT8wE=; b=xewnlEKnqvkkNf06zWm1wnL058
	Qehu1367wdKkDn62sGCEWc/MwC+rczF2oMlVaMGH1iY6LiMPHNfcj4YznYLcCcNdyYIC3805BaIUm
	ToDwxU5Mi0Yx3Qp+IftCjFTu0dxFc7taTfegKu1j0ZmUDe61QqubX9N4V9iZONDn8lK9cMbpFqENE
	Zwuk8MMjE5dATJvRovaJKcMA3J7a4vEqtZFl1ahSxG5UQr6L5mBJpID9QcOlBsungX9U7ULn+UBqZ
	+fuwwKuJFld59f/CD78VWd+lQw6bc/ywKvTzCNcqpxUJzqyqxlj1bZk9535OVtcDExTHjZczG5jfs
	RYe2iYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf0v-0000000E5MY-1GdC;
	Mon, 08 Apr 2024 02:45:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1I-0000000DvXM-18og
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 86A9060DDC;
	Mon,  8 Apr 2024 01:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB811C43390;
	Mon,  8 Apr 2024 01:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540519;
	bh=21I6cZVbmo9GbZmqqYAGOoR45iESDFfQMFchEsaf+Cw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eUdQMmFp+gFTPJqt4JSk9aHqShK8t6OW3cNIcVW7oiqjp/sZjtmAQFxYcXuDXKunO
	 MfGlWoVLsPMqceinaIjZv7iyIFI20dtIFOzexkfdngbeJxbGDJK1UYPtgtSxNPxM3I
	 BQikjN32iVGI1pcPAvVXaLKWdeCIqbLHQfrAWFJJXniK7h/gRzJLIxKnRk8rTrIZN7
	 k+x0XtaE3JXu44uC8XhIxjOzsO2Ys5I1f4BecDqQz+inEPRMjX6N1zLxDGvUX8NHc8
	 j33Upmz0AQun+D0lVHJB5SwEStW4heAS5IkaMsua7aORBOZyXB3aZaj3uHjDPpNrJX
	 ZKlb4gg9hIPWg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 15/28] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Mon,  8 Apr 2024 10:41:15 +0900
Message-ID: <20240408014128.205141-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184201_056825_2211384E 
X-CRM114-Status: GOOD (  11.22  )
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

With zone write plugging enabled at the block layer level, a zoned
device can only ever see at most a single write operation per zone.
There is thus no need to request a block scheduler with strick per-zone
sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
feature. Removing this allows using a zoned null_blk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/null_blk/zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 1689e2584104..8e217f8fadcd 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -165,7 +165,6 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
 	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
-- 
2.44.0


