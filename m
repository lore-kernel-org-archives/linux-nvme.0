Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D30C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 06:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S8SjXhZLDr/pH8RKp+nLJLU/M7LgpF4OFUEbQtiC2qo=; b=Bf+tlKYhX4JM/0qvji8nNN2HVn
	mBjPJki7ZQqEJnJSPzE8lcAT6gUDIZWxKX6ryvXzFbDRkCeqRsKFaUFcR4TEu1UcKN08h0/1bOMtN
	AiGHP6RGwwvr44eh+BkgznSScX472YIrzEHe1cbRPLTVFtRiLdKwwo/0eKtDKQ2CWw4YkZGE2/GMx
	cJxseAo857neJdi8AI8uKE0wblOsbA9bt03SKMIny3PBIHkAAa5o6ZXmHmkx23sFJ3mB+uzuDcUH4
	CMe9cAhGa/bw1UGzatnRpOlVDCv7eJ31ylI4tsUt2MIt7Qejlt+wlTmyN3HWmvw74V7uEjO5Bd0M5
	S+vtdSkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSee-0000000Cah6-2dZs;
	Fri, 07 Jun 2024 06:00:48 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdd-0000000Ca79-1UUO;
	Fri, 07 Jun 2024 05:59:46 +0000
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
Subject: [PATCH 08/11] block: don't require stable pages for non-PI metadata
Date: Fri,  7 Jun 2024 07:59:02 +0200
Message-ID: <20240607055912.3586772-9-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607055912.3586772-1-hch@lst.de>
References: <20240607055912.3586772-1-hch@lst.de>
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

Non-PI metadata doesn't contain checksums and thus doesn't require
stable pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 58760a6d6b2209..1d2d371cd632d3 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -379,7 +379,8 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tag_size = template->tag_size;
 	bi->pi_offset = template->pi_offset;
 
-	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
+	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	if (disk->queue->crypto_profile) {
@@ -404,7 +405,8 @@ void blk_integrity_unregister(struct gendisk *disk)
 	if (!bi->tuple_size)
 		return;
 
-	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
+	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
+		blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
-- 
2.43.0


