Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C0AC41513
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ru6e7QlCJJG/gBR+o3ggbDTJvKsMm+SRm2m/B6Mvy6c=; b=jkgR4iOP7eAAJufPeGgyBy8d9H
	vVjZOYPCp/NLTdXyjZN7VU645wlpgBINXvGxGjFknkPX1TOd4MdlB5Eb9notArJEr9Xnc25ibaHEk
	GYX25NR3v9wiJE27Az7FbgQ8CLbeMvhXO1hzUzAIQQZNAg8mRTWaOzgy77FW7HHsnrWj+7TKnvy2v
	x/hEl7hL7kA9lLxc9n3h2CQE5lorR/Sa8Tu2kqXoevik2ng1dWZcMJuLRZVRM0RGWuSK9h+pajYk6
	dtbnjU6OfD6P6y+lZvHzU4MIFjOVZa98JE5lQr5Iyt+avXWmUKxf5vNN7rS/l65cmbuc4WPy/pLjP
	8V6im0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8V-0000000Fn26-1GF0;
	Thu, 13 Jun 2024 08:48:47 +0000
Received: from 2a02-8389-2341-5b80-034b-6bc2-b258-c831.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:34b:6bc2:b258:c831] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8S-0000000Fmzb-4BDW;
	Thu, 13 Jun 2024 08:48:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 01/12] block: initialize integrity buffer to zero before writing it to media
Date: Thu, 13 Jun 2024 10:48:11 +0200
Message-ID: <20240613084839.1044015-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
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

Metadata added by bio_integrity_prep is using plain kmalloc, which leads
to random kernel memory being written media.  For PI metadata this is
limited to the app tag that isn't used by kernel generated metadata,
but for non-PI metadata the entire buffer leaks kernel memory.

Fix this by adding the __GFP_ZERO flag to allocations for writes.

Fixes: 7ba1ba12eeef ("block: Block layer data integrity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961eae..af7f71d16114de 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -432,6 +432,7 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned long start, end;
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
+	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
 		return true;
@@ -454,11 +455,19 @@ bool bio_integrity_prep(struct bio *bio)
 		if (!bi->profile->generate_fn ||
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk.  For PI this only affects the app tag, but
+		 * for non-integrity metadata it affects the entire metadata
+		 * buffer.
+		 */
+		gfp |= __GFP_ZERO;
 	}
 
 	/* Allocate kernel buffer for protection data */
 	len = bio_integrity_bytes(bi, bio_sectors(bio));
-	buf = kmalloc(len, GFP_NOIO);
+	buf = kmalloc(len, gfp);
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
-- 
2.43.0


