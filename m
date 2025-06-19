Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC355C7115B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wHJhoBfRSj8ESc6y85rx84mJowvHTvRkUykXhxl2wo=; b=sRmgspTHmYfCKeAYEIF6SQgteH
	6br08OSz7LSEqQpW5LYJ0yKGQXF69Ujc6/LEG2DYSl8HPx/4p06XPKNKDIgULJL79+PicHCm2NoOF
	nHWfRp2n9cVflZQt6bFsQ+M04jSCZQ3k3UqoC+UWz8E0bX9Ke9Eh6LIGrmhdNeZDFACo8E7GOYP2c
	8GC5BeY/dL3Qfd60cdZzOiDmnFUyR77Ba3RLInaM7jzML+J9N4jAG6/aXUkLCksUzBQKsSyA8pIG2
	SphzfiP6bBGEUs2UlLK3PPiljngvD0ihVL3T2SglbTPSwbADBk+Bshj4e5gyWE32fNya1JY2jRCkz
	6R3UkSsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHSI-0000000DSlV-1NfX;
	Thu, 19 Jun 2025 15:45:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDV2-0000000Ct7t-3VBP
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Jun 2025 11:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2wHJhoBfRSj8ESc6y85rx84mJowvHTvRkUykXhxl2wo=; b=Y6xUM2FoOuO2nD4GXHg+8PnqfA
	B0DMGKRagr7qcEMrp5BIT3DNXymwcB9wdWP0CO8vx9XJ/DMNt5Fon4JURcdAJ/OZtm/8tNA996uC4
	h0+KYJZcYFK182gqOUXsf963NYFQB/fTZbBzeV71hSWtcpUl/JJMaZgX+V0m66l63ZFr8Lzi1L4c6
	OKWqw4jY81kXAyBvRI6aSWet1jUtupc3sa4xousX2f69UmOQCcoy+n2e3BP5BFpPu+xKGJqhmk6z2
	BNrPn42ElcSFY8vERWX0CtZHyMADAk+0Cv6RpU4wuAJ/1m12wnP2XkYbpEmVeZpTBO/eYSOW0sfML
	KaTf+OAg==;
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDUz-00000004QoR-1Vns
	for linux-nvme@lists.infradead.org;
	Thu, 19 Jun 2025 11:32:08 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNT2RPMzKHMnF
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B210C1A1A14
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S11;
	Thu, 19 Jun 2025 19:31:51 +0800 (CST)
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
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 7/9] block: factor out common part in blkdev_fallocate()
Date: Thu, 19 Jun 2025 19:18:04 +0800
Message-ID: <20250619111806.3546162-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH618Y9VNoihn_Pw--.51230S11
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4xurW7Cw1rAFWxur1kAFb_yoW8Kry7pr
	W3W3Z8GFZ5Wa4UXF1rWF4xu345ta1DJw45uFW2qwn3u3yIy3s7KrnFkr1rWrWUKFW8Aw45
	WFW293429r17C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_123206_371224_221AC110 
X-CRM114-Status: GOOD (  12.08  )
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/fops.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..e1c921549d28 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -850,6 +850,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	struct block_device *bdev = I_BDEV(inode);
 	loff_t end = start + len - 1;
 	loff_t isize;
+	unsigned int flags;
 	int error;
 
 	/* Fail if we don't recognize the flags. */
@@ -877,34 +878,29 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	inode_lock(inode);
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
 	inode_unlock(inode);
-- 
2.46.1


