Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98489C7115A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=328LExAF+6nFdIdnG9tz3BXdT64phz6aSkvhdTetWHY=; b=2YTtzcfVECF/cwic5rWlmpYdtp
	Jvrig+59ZATS0mL/DKmgIC/pCmaST0JW3MaIaszZ68Vom7b6slZ541sDD1mTnZNYRDfsDgXDmZnh+
	SbUxvtioL6ZMK7iBqh2v3v1ajFYwxSMsgirv3wSEu5uCTfXcA0h/K8oHSYch8J83NHQlBEIDvmErN
	GraSmHFa25p+zTOuRW3Wu7RpV72ekK/JwYvVkj8h3c5CRHi8hnTJcRLWjx9xo6Vhj4r31CYT04WdO
	PjkWJmLZjsweLAZrRfYmgsgYTWsA2W8PR56HneY9IC11rHK2OzrVh6tpI4DT/9UXcA3Y/DtpR0Bpr
	W/RHp1Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHSP-0000000DSxO-0wyr;
	Thu, 19 Jun 2025 15:45:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDX0-0000000Ctrm-2vCd
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Jun 2025 11:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=328LExAF+6nFdIdnG9tz3BXdT64phz6aSkvhdTetWHY=; b=RYPILI/DxkCgR4VjsR9tHlz4az
	c1/f89tLXXs1tw504iug3Mq+hBANZN2mJp2uZoBjLwZ00C/+0EQvlj+GqoN9DJoP1GmSmI5Y1ztg6
	15ShHr7BdYdtGH6SDqS6qaMLZqxhlVqrrq/pys14q2bMvW/LoaHYr/BDamOTv6rtXrnnodkrFAA3N
	IFLaHIEUDTJhmtblPXC9hYtC3fCGZW6IWEO9LQ/psztWqyg3tyjur7/H8ZsPummfQxuNpXe55RSKD
	kEEUdK1ZWy/sBP8DUVTodO34CW02bBTnaGzDHRBsPK3Lowu9Zjk5KAfA5y2s2dSLiN1660zKQtUF9
	0gMcMeZw==;
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDWx-00000004QoU-0wnO
	for linux-nvme@lists.infradead.org;
	Thu, 19 Jun 2025 11:34:09 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNV0qnLzKHNCw
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7861E1A0E88
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 19:31:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S12;
	Thu, 19 Jun 2025 19:31:52 +0800 (CST)
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
Subject: [PATCH v2 8/9] block: add FALLOC_FL_WRITE_ZEROES support
Date: Thu, 19 Jun 2025 19:18:05 +0800
Message-ID: <20250619111806.3546162-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH618Y9VNoihn_Pw--.51230S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry7Xw4xJr4xAry7Gr1fCrg_yoW8AryUpF
	4UX3WYgFWFgas3GF1rCa1DWrn5Za1kGrWfCayI9w1F9w47Jrn7Krn0gF98tF98JFWUAan5
	XayavryUuF17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250619_123408_181563_B0D422E7 
X-CRM114-Status: GOOD (  13.75  )
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

Add support for FALLOC_FL_WRITE_ZEROES, if the block device enables the
unmap write zeroes operation, it will issue a write zeroes command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/fops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index e1c921549d28..474656a0de70 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -841,7 +841,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_WRITE_ZEROES)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -856,6 +856,13 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	/* Fail if we don't recognize the flags. */
 	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
 		return -EOPNOTSUPP;
+	/*
+	 * Don't allow writing zeroes if the device does not enable the
+	 * unmap write zeroes operation.
+	 */
+	if ((mode & FALLOC_FL_WRITE_ZEROES) &&
+	    !bdev_write_zeroes_unmap_sectors(bdev))
+		return -EOPNOTSUPP;
 
 	/* Don't go off the end of the device. */
 	isize = bdev_nr_bytes(bdev);
@@ -886,6 +893,9 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
 		flags = BLKDEV_ZERO_NOFALLBACK;
 		break;
+	case FALLOC_FL_WRITE_ZEROES:
+		flags = 0;
+		break;
 	default:
 		error = -EOPNOTSUPP;
 		goto fail;
-- 
2.46.1


