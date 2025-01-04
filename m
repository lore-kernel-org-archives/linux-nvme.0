Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C88E77197
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UxO1WFtwL1Y5Kx0k/P6NR58uOefi1S4gvMj1VPPmBh4=; b=Xs3ozUuqhz25FFf6plYMn7A4Uc
	SCViW0jc/TlWf+bvQZJKPBsqajKTmeSk/f5xmM5m4BDjtqS0eLX9W5r0Pxe0giFP1oOvN44Ay1CHQ
	ljreUN/2YZomH0nLu2rp9pSgc9uzyrWkG4BB0bL4+XVuARAV50gCUH7nhqo3dLYj1/9LWrTOm8S/E
	Sf1dV76bmOJF7gHtVeDLtE29qAcNr/F7t6RSDFe9aSEfptGtIBW8DP4YEG50f6wftFSfcvKCHbQ6D
	ntjTgEpeWpevL+Sf7aayFasl8VgZXc/6+79FR6Volg9Yp2rG8SgAQt17FOvgFO0M8k9j2mPDwXH/C
	I7gcO9QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AL-0000000F2kJ-0Abg;
	Sat, 04 Jan 2025 13:26:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AF-0000000F2i7-3Gi2
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 13:26:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 167975C548E;
	Sat,  4 Jan 2025 13:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DBC4CED1;
	Sat,  4 Jan 2025 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997163;
	bh=COVE0bvwII+G60ByWk+rzuxwByQi7P/2T3NJasfjEeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7YAIA0yjkNnWkkNU5CJThD0r/hOGucsvMxakh/NbL2tf7+2fhE6wXGm9bt4ISPJR
	 nwwH+7AoFGdLr//bXhUkf7Bz7Xqshzh3oEmFu78I6dCFxtO/TqzJ/gBrJA/1YiN0Xf
	 qChanWG2U73ONHEKYEbFhxhu2VFQBFnlSvQU69dTdnFmJC6jQqqDI4FKB11fRXOzC2
	 RcewRngEPM7BoRliPwgIWnbj5R1Kq/MtivgFWZ3tekVKFZoCmjLAmVEHhoDrD/UpBh
	 6S+kWywgZ62duvbsNYe73TpFp7DfftjcKhgVXEqDv+YAmQuy2BxeVgMsAWJYPq0w/n
	 uw+O88tgm2gew==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/3] nvme: Fix queue freeze and limits lock order
Date: Sat,  4 Jan 2025 22:25:22 +0900
Message-ID: <20250104132522.247376-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104132522.247376-1-dlemoal@kernel.org>
References: <20250104132522.247376-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_052603_909463_86213A91 
X-CRM114-Status: GOOD (  12.66  )
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

Modify the functions nvme_update_ns_info_generic(),
nvme_update_ns_info_block() and nvme_update_ns_info() to freeze a
namespace queue using blk_mq_freeze_queue() after starting the queue
limits update with queue_limits_start_update() so that the queue
freezing is always done after obtaining the device queue limits lock (as
per the block layer convention for sysfs attributes).

Fixes: e6c9b130d681 ("nvme: use the atomic queue limits update API")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a970168a3014..8d4ae36c35fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2128,8 +2128,8 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	struct queue_limits lim;
 	int ret;
 
-	blk_mq_freeze_queue(ns->disk->queue);
 	lim = queue_limits_start_update(ns->disk->queue);
+	blk_mq_freeze_queue(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
@@ -2177,12 +2177,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
+	lim = queue_limits_start_update(ns->disk->queue);
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 
-	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
@@ -2285,6 +2286,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
 
+		lim = queue_limits_start_update(ns->head->disk->queue);
+
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		/*
 		 * queue_limits mixes values that are the hardware limitations
@@ -2301,7 +2304,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		 * the splitting limits in to make sure we still obey possibly
 		 * lower limitations of other controllers.
 		 */
-		lim = queue_limits_start_update(ns->head->disk->queue);
 		lim.logical_block_size = ns_lim->logical_block_size;
 		lim.physical_block_size = ns_lim->physical_block_size;
 		lim.io_min = ns_lim->io_min;
-- 
2.47.1


