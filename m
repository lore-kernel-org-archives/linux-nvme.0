Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09748CD129B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hV4KuEKNW7ZcJ4NByBKEhY3Zp3n2MSZhBevhoHroCCs=; b=dWS8I5w8D1laAzQgHMK/Tjl+A1
	01EM50jOQr9rkQrAAWfWbZmPQ54VtZ6hF4jC16rVTBZjA2CSqYapm7tYl4RiqScRNmksChh+L5Wkw
	jlj9F3zoxa3jdBYNrGLJkvSS75lNdIX9pytYo974ihore973K1gVcrvVysik+45kBL0X0ST6C7vgr
	hXsDxYP7Gzt2/o43LJaG3U0HrjzLO5v5vjyg8c8OUeNf8z1qyIXhHlmdiiOTyOKAWkKiOIGmVqT4S
	7ZtNLkB4HZCYp/SuAGDxqWyj1Oms5cgDM0qGFTFVZVzdG1jg9sAs8yOxZaocCik0+ymuP0GmQ9By3
	QffbruKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxF1-0000000FIQy-3Bfg;
	Wed, 03 Apr 2024 09:49:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDC-0000000Eyrp-2lnM
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00FC061363;
	Wed,  3 Apr 2024 08:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDF1C43390;
	Wed,  3 Apr 2024 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133793;
	bh=AlRpJddvRHquUbj18752X4Iel9EVoPRdVoTyldN+Rzo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YdN6z3xrKxBsFKivfIPigTGQXKhBynrMqMVs3Ir8GJImZIlEibyXJtDTDow8eGIop
	 13bDexpOPAQl5k+tNVslmZjixYnepHavVfPss7iKPEJtgMCFl9pKo3x1rJ4+ZTv3cq
	 Q2Ah6TYLYBuPURlY5xKPIr/LTPbXA25CXLDtgjtFhK1uGVLzh1LpAYg04a+UMUjqov
	 y9jk7Zu0QIwYudYRZQ8/vPBDTVwtDI0jK+z8VztbOpep5JOp5Ywwjb6XG+eLu49Gsv
	 LiTmciXqTz5CIjjUxVd66oHEBTl6SzulPZppaIhx7HYGakzsleZWZuS3MRDawAY/ZE
	 p5XEFyWeg3jSg==
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
Subject: [PATCH v5 15/28] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Wed,  3 Apr 2024 17:42:34 +0900
Message-ID: <20240403084247.856481-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_014314_936104_1426B1D1 
X-CRM114-Status: GOOD (  11.26  )
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


