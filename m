Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21B6C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnAMrxZ/OkU0rxqaLHrUeHmqI0XLs740XV8yFbPIJko=; b=VLSn0NT86BElQOkYcuqG39GAug
	ITDosrYueVbxgaExz1PIKOA8iyrcaH5R9Xc2RZvmxeSLKTtNLL+jmwkVhF/VfztaplezvJx7grnGi
	mLBgWSYEd6SFjo91ylMnOj4+pwizM9Cc4XcBM1Z7M8YYC9OQOnpm21cOjVs8MBGa+E6z+ATehLSyh
	FQRGdLWYUwj409h6BNDauNAh1T0dmAK9QTfyajqKBLxMpFCAhgRR3fILwhkPI7ENisc+EWj5ez9iC
	wnzS8tVFmvfkBkUm55YrYKdq/9tmotJET1IDQA4YNgPqMdBZBl8xYPXoVgs/iAs2BKO0GWRNH08B0
	vj9XfS+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsc-0000000BnO9-3PVg;
	Thu, 28 Mar 2024 00:44:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsU-0000000BnGl-3eAe
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3364061713;
	Thu, 28 Mar 2024 00:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248E1C433C7;
	Thu, 28 Mar 2024 00:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586662;
	bh=JWcFjyy+OD/TNvYIfUUGiuk5k3y51VJlLmQxqzZP42Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gidhj3PJSs25ona2MLVYHS5ZdvH7WofywoqHZFBVdNZbQWzs15PwSDgdQ6WRcX6qn
	 4gonsGJOg0wBOv5JOGD89CV8nb1DnROHR4s26LSpsyjdiYnodNNiG1+fJJ4zX85FqO
	 NsYKOsaIRdjpYZiOyfXnveli68miC9yIO3fJLBnLN0Z9md3Fh5KuUEwoVmVxWQCzc7
	 9o2dEpgK0mudY2GkxxCsJIaqwCzxx4HqdrT3o77nI7o/G3koc6eBM6DF1fylJx/9SL
	 BNBhRD703+z1p2onaJ0b+02+QpTIAgjJiX374uMw0VQigHX9MkpFZQxXH5O4v6DrVF
	 ntuxTkFe8/Jqg==
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
Subject: [PATCH v3 05/30] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
Date: Thu, 28 Mar 2024 09:43:44 +0900
Message-ID: <20240328004409.594888-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174423_092535_1EDA7A93 
X-CRM114-Status: GOOD (  10.33  )
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

Implement the inline helper functions bio_straddles_zones() and
bio_offset_from_zone_start() to respectively test if a BIO crosses a
zone boundary (the start sector and last sector belong to different
zones) and to obtain the offset of a BIO from the start sector of its
target zone.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..ec7bd7091467 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -853,6 +853,13 @@ static inline unsigned int bio_zone_no(struct bio *bio)
 	return disk_zone_no(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector);
 }
 
+static inline bool bio_straddles_zones(struct bio *bio)
+{
+	return bio_sectors(bio) &&
+		bio_zone_no(bio) !=
+		disk_zone_no(bio->bi_bdev->bd_disk, bio_end_sector(bio) - 1);
+}
+
 static inline unsigned int bio_zone_is_seq(struct bio *bio)
 {
 	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector);
@@ -1328,6 +1335,12 @@ static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
 	return sector & (bdev_zone_sectors(bdev) - 1);
 }
 
+static inline sector_t bio_offset_from_zone_start(struct bio *bio)
+{
+	return bdev_offset_from_zone_start(bio->bi_bdev,
+					   bio->bi_iter.bi_sector);
+}
+
 static inline bool bdev_is_zone_start(struct block_device *bdev,
 				      sector_t sector)
 {
-- 
2.44.0


