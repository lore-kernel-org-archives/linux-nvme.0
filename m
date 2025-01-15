Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBFC02185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNFWrOyb6MU5vxCAp0taov7L88Eyn2JokJCp7SE/Zt4=; b=aN5kSaQFZWLMB0Z1YkU9qcAIXL
	+qii9hQ31cva4G4YRaPxgLAv00TDY281ln16cQFo7Al9EmswZWbFpM5fZEvN+5fKeLG4Mlr5EszsC
	77g1k8NViZ0B5woZatcxsDionQGzpQwarli7gPx+k5HsH1zMtfKbePlOfB2/UzkQLQZt/ab01Loi5
	21eSoThr89oZHVuDCh2pJ5p5ibkBJQR/U81Q7DhXbUhqu2AdzrnzK0dGdvziJb7EslqDz0An/pybn
	/iOp18jp4QkMhW0Yd8AMY+duwzm7j7GOUJN7cfNGwQ6CeKM6DA5QCuB9DUcQR1Lnu7HgIhKAx4Fns
	r87aqGCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY32X-0000000Buty-3B3S;
	Wed, 15 Jan 2025 13:02:33 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1wW-0000000BkRC-1ZS1
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 11:52:18 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY4975mdsz4f3jks
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:51:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 085871A10E0
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:52:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S10;
	Wed, 15 Jan 2025 19:52:10 +0800 (CST)
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
Subject: [RFC PATCH v2 6/8] block: add FALLOC_FL_WRITE_ZEROES support
Date: Wed, 15 Jan 2025 19:46:35 +0800
Message-Id: <20250115114637.2705887-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Gl9aoYdnvK0ZBA--.21959S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry7Wr4xCr18Cw13ury3Arb_yoW8WFykpF
	WDXF1rJFZ0gas7WF1fCF4q9ryFya1kJrWrGayI9wn5uws3XF97Krn0gF45KryUWFy5Aw4D
	ZF909ryY93W7ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250115_035216_758086_7DBFC49E 
X-CRM114-Status: GOOD (  11.37  )
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

Add support for FALLOC_FL_WRITE_ZEROES. It directly calls
blkdev_issue_zeroout() with flags set to 0. The underlying process will
attempt to use the fastest method for issuing zeroes. First, the block
layer will try to issue a write zeroes command if the storage device
supports it; if not, it will fall back to issuing zeroed data. Then, the
storage device driver may attempt to submit an unmap write zero command
if the device supports it; if not, the driver may fall back to
submitting a no-unmap write zeroes command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 block/fops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 13a67940d040..56486de0960b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -777,7 +777,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_WRITE_ZEROES)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -836,6 +836,15 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
+	case FALLOC_FL_WRITE_ZEROES:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
+		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					     len >> SECTOR_SHIFT, GFP_KERNEL,
+					     0);
+		break;
 	default:
 		error = -EOPNOTSUPP;
 	}
-- 
2.39.2


