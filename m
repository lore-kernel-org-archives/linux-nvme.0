Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD3FC02185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhdZyQziTQ3/d6l/IkPmjJ3mCMO/SXAmjnjNL07fMr8=; b=1pnAOQ/YghEdmM0y0tDDSVnWIu
	XUpU5lNJNh3MAZFfMD1tnFT2PjjUKmtMiGVh3Ysfnim/9KxN0kyoVHqHVxfIoMbBsfq+mhnL3bei6
	3MrOePmgINt3voEUl0YvIQIENZFpP68cIzkIJyXVEvXb4QDY9LRjzYSC9z5u5AFD3XbZhsPc6y3iF
	QmzgIUFkdkodY1bvVGVOzhVOMUjp5kVnCe+gPRA5dkh2UpubMpMj2FOgdMxSjgkE253aqFwpYaprT
	/F6r1DmSB1E8XEWbxd3HQgynb1x3jpsnkd+E40V3ZN73DCrMIXDiQuLgssg0i2+vlyR5F6Q7G+1zR
	zos1XJ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1xh-0000000Bktd-3fl8;
	Wed, 15 Jan 2025 11:53:29 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1wZ-0000000BkQj-0lQ8
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 11:52:21 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY49173Xbz4f3jM8
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:51:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D7D61A10CC
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:52:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S11;
	Wed, 15 Jan 2025 19:52:11 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v2 7/8] block: factor out common part in blkdev_fallocate()
Date: Wed, 15 Jan 2025 19:46:36 +0800
Message-Id: <20250115114637.2705887-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Gl9aoYdnvK0ZBA--.21959S11
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fXry3WFyfCr13uF45Jrb_yoW5JryDpr
	WagFnxGFs5Wa42qF1fCF4xu34Yya1Utr45uayaqwn3u3yIvr97Kr4qkr1FgrW8KFy8Aw15
	GFWY9ry29r17C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUljgxUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_035219_552030_DFE63AD2 
X-CRM114-Status: GOOD (  11.96  )
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

From: Zhang Yi <yi.zhang@huawei.com>

Only the flags passed to blkdev_issue_zeroout() differ among the three
zeroing branches in blkdev_fallocate(). Therefore, do cleanup by
factoring them out.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 block/fops.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 56486de0960b..22eda3a43908 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -786,6 +786,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	struct block_device *bdev = I_BDEV(inode);
 	loff_t end = start + len - 1;
 	loff_t isize;
+	unsigned int flags;
 	int error;
 
 	/* Fail if we don't recognize the flags. */
@@ -812,43 +813,32 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/*
-	 * Invalidate the page cache, including dirty pages, for valid
-	 * de-allocate mode calls to fallocate().
-	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
-		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-		if (error)
-			goto fail;
-
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     BLKDEV_ZERO_NOUNMAP);
+		flags = BLKDEV_ZERO_NOUNMAP;
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-		if (error)
-			goto fail;
-
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     BLKDEV_ZERO_NOFALLBACK);
+		flags = BLKDEV_ZERO_NOFALLBACK;
 		break;
 	case FALLOC_FL_WRITE_ZEROES:
-		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-		if (error)
-			goto fail;
-
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     0);
+		flags = 0;
 		break;
 	default:
 		error = -EOPNOTSUPP;
+		goto fail;
 	}
 
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
+	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+	if (error)
+		goto fail;
+
+	error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+				     len >> SECTOR_SHIFT, GFP_KERNEL, flags);
  fail:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return error;
-- 
2.39.2


