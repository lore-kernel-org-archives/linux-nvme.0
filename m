Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291F3C369C2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N0nnALdUIrDn9r525BJBO8eZ4ofFxHc+z0oqIGU8rQM=; b=lMpKouRoJnFi6yhet1qI8fk90J
	JJElw2XsgEFoBcR44Si10tH0i43zfdYfXLNLq1xQpxCSxfX8UE9NnWPVkjyI2urXAqdCkQ/+Bnpdf
	mbIt0oZIpNnVz1CG4VWSPJ9YVVxxjwK7p5NTXr58Ora3xNyytkSy0kg5YK9Siw4lIjyNlXGbXla/O
	Li2BfuXCm3Cr0rLISurNEmvw1aE/mXTkaqpe4jvrtuB0ZzQx91fQ9Bd9q49Rm2eGgRKEjxOjUGc+S
	HmbCB7Az3GkODwTnf8pVIrL26oZ9oXMkk3tpVNPRGYIv0110hh0aPM05ov45ugryCKgIxbcOlC/n6
	Z41G66zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6gr3-00000003Pnb-2RuA;
	Mon, 21 Apr 2025 02:25:53 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6gqr-00000003PZZ-4BdM
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 02:25:46 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zgq2t52qfz4f3jXb
	for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 10:25:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C7F91A195F
	for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 10:25:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+MrAVoFxZkKA--.3102S13;
	Mon, 21 Apr 2025 10:25:34 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v4 09/11] block: factor out common part in blkdev_fallocate()
Date: Mon, 21 Apr 2025 10:15:07 +0800
Message-ID: <20250421021509.2366003-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3m1+MrAVoFxZkKA--.3102S13
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4fAr45Cw48CFWUWFyDJrb_yoW8tF15pr
	W3W3Z8GFs5W34qqF1fWF4xu345ta1Dtr4ruFW2qwn3u3yIyr97Kr4qkr1rWrWxKFy8Aw45
	GFWa9ry29r17C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_192542_380860_3B19954B 
X-CRM114-Status: GOOD (  12.07  )
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

Only the flags passed to blkdev_issue_zeroout() differ among the two
zeroing branches in blkdev_fallocate(). Therefore, do cleanup by
factoring them out.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index be9f1dbea9ce..77a5465309e7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -812,6 +812,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	struct block_device *bdev = I_BDEV(inode);
 	loff_t end = start + len - 1;
 	loff_t isize;
+	unsigned int flags;
 	int error;
 
 	/* Fail if we don't recognize the flags. */
@@ -838,34 +839,29 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
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
2.46.1


