Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C7EC41535
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 04:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUS6y6SVPRCfJmQVPGCeD5o714qtaTT6EGogPxQdIy8=; b=SruDTBo9jMdg211R9fSY61oXrG
	3Xtomw6o9cfJQGlhOzhoaGfeH+JBx8V1SU5OCcZ1RYfMw4tWZipvUWPDRdlHAEOElA2z0Y+EVk0kH
	5L559KP68FCEFRLgNrspw1S0dhrBg9rqIrRfZ1MNZ1vV8w8U2qmrf/YnSGaBTsX2nNTy80/VnYwJb
	Nll/Z/2CXSxW5hHlZetJoImJXFsB7BrDznx2y35Z4cZDyREUwHZyUG06+hkAFPoskn0Txe7dH5L9H
	gYvQQcgq9zQI2tkQg5ITuGJJvYJe1kBFuL4APc2WacCXTpuaYIYi0UI9cQamT6HpDXIBbX561oBGo
	jvIs0nHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfDxV-008Ori-Mi; Fri, 15 Apr 2022 04:53:25 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfDxL-008Omo-Q5; Fri, 15 Apr 2022 04:53:16 +0000
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
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 01/27] target: remove an incorrect unmap zeroes data deduction
Date: Fri, 15 Apr 2022 06:52:32 +0200
Message-Id: <20220415045258.199825-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
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

For block devices, the SCSI target drivers implements UNMAP as calls to
blkdev_issue_discard, which does not guarantee zeroing just because
Write Zeroes is supported.

Note that this does not affect the file backed path which uses
fallocate to punch holes.

Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/target/target_core_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 44bb380e7390c..fa866acef5bb2 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -850,7 +850,6 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
 	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
 	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
 								block_size;
-	attrib->unmap_zeroes_data = !!(q->limits.max_write_zeroes_sectors);
 	return true;
 }
 EXPORT_SYMBOL(target_configure_unmap_from_queue);
-- 
2.30.2


