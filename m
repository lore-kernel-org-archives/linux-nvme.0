Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A19CD1297
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xpB64Po3VVVSIjN5C7GxnRL2r9TC0wHxotunMxcxyI=; b=TzRhwa0jfyoQg9bGR2092ZXYoy
	njHcZnvXTtmnrEL8QqO+flpQ/merDPznWMMoAB458LZRVg6j9nnFlWUvtb2jhKYeQVQlRSqBnXHTX
	kseStLW5TSNg1z5WG30t5xz+utRtNkfM34VyTF3C34q3980DlmSSZvOnPwLxZuQD5z/1xVj8YIwWj
	RBvwZrC6Kdj4379NR9jp7Kc7WhY/8YFsJIWncER4Qx8rOOQe7zkcZyti0kxWVoFfUTa/ou0fhJoFi
	QCqMLdHL1p2cBaQ1jqrKm2hcKVB6s010FaAisWa/oOG4jKS2wcQJkPRD0RPL8aZZUxS9o+xanSt0U
	93pFkNeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSR-00000005LOT-1hUS;
	Fri, 05 Apr 2024 05:49:47 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPN-00000005BMd-3fAJ
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 159E0CE35F7;
	Fri,  5 Apr 2024 04:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C02C433A6;
	Fri,  5 Apr 2024 04:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292151;
	bh=YARcYpByiC8z1QdFM74x6voKyEeLX1LQj+WGr00zNUQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NmRujvtvzT8w/hIhtPuhOrktgTI6B41KnkW4YWzYTgUPkZ4W6wzFlta2UwnZQ5x5K
	 Amk4u9JM+0pLs4NjEas5eAbAK5+7dRHb1+cY/sluYPDL6rnVvdWzyQNbVyKuzv3n7S
	 kORA0l4krB4VUpjukhShj58wWCx8fdeJB3xFXQS8d72iqlaTQ9fZNQpmoy9TVaWdQN
	 qYYzkDei9aNB0jxRQFAzikE0hr9UMbtO1WUt+pgJu5w5bCsYSfEYSiSbuym1vSKqgF
	 uR1P5BerNxym+RNqrzt6KkurIQ8DCU3oS5rbxur1MDQMYbDSlCbOm13RebVseF12fo
	 sudsfYmEwcFHg==
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
Subject: [PATCH v6 15/28] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Fri,  5 Apr 2024 13:41:54 +0900
Message-ID: <20240405044207.1123462-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214234_551476_B54AF9FD 
X-CRM114-Status: GOOD (  11.09  )
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

With zone write plugging enabled at the block layer level, a zoned
device can only ever see at most a single write operation per zone.
There is thus no need to request a block scheduler with strick per-zone
sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
feature. Removing this allows using a zoned null_blk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 drivers/block/null_blk/zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 1689e2584104..8e217f8fadcd 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -165,7 +165,6 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
 	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
-- 
2.44.0


