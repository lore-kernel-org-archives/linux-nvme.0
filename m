Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B2EC27C52
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CbneON9b6Br3YJjkeUqlFpDr77Xqf/2UZTtp8OANsA=; b=P4nGVgxWfR1vFIEj+DaxJ0BHEU
	85SZxwArq+2+LrK69vsOtKRPgnq5oYCGhLz9dQxvRAtyQdl/yPoe994cVd7fJvO4Rvo2AiYYGYHLE
	IEerY61F/cBfh1Ubcqcd8x1Yx31HGcRUKBQNUiwZtTq24JJR+yY4e+eCU4lie5MA4/vwD7SBOQ9jI
	0Y1wnLEGuGAvUHVFvClzS76fS6Nc+gB+0zeQlybsFBLmKL8AUN5hhowkzqpsPYvRNlOVDMOQ7SOHk
	yjVlN3huZEA2H/DWoYBD6PMFOMJiVclZTn+oGqJ0+4vPOua3nQgjrB4wesLuC+tp8DTOuYACWjsLa
	5IOaA0OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAr-00000004mpx-1AvH;
	Wed, 05 Jun 2024 06:31:05 +0000
Received: from 2a02-8389-2341-5b80-5bcb-678a-c0a8-08fe.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5bcb:678a:c0a8:8fe] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAn-00000004mm4-3mML;
	Wed, 05 Jun 2024 06:31:02 +0000
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
Subject: [PATCH 08/12] block: don't pretend to generate/verify for non-PI metadata
Date: Wed,  5 Jun 2024 08:28:37 +0200
Message-ID: <20240605063031.3286655-9-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605063031.3286655-1-hch@lst.de>
References: <20240605063031.3286655-1-hch@lst.de>
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

The kernel won't ever generate or verify non-PI metadata, so don't
set the flags and don't allow the user to modify them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index bb3cd1e0eeb58e..c2fcb8e659ed56 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -248,6 +248,9 @@ static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	int err;
 
+	if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE)
+		return -EINVAL;
+
 	err = kstrtoul(page, 10, &val);
 	if (err)
 		return err;
@@ -369,8 +372,9 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	struct blk_integrity *bi = &disk->queue->integrity;
 
 	bi->csum_type = template->csum_type;
-	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
-		template->flags;
+	bi->flags = template->flags;
+	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
+		bi->flags |= BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE;
 	bi->interval_exp = template->interval_exp ? :
 		ilog2(queue_logical_block_size(disk->queue));
 	bi->tuple_size = template->tuple_size;
-- 
2.43.0


