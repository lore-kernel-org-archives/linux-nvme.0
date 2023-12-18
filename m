Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98810C46CD7
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uzOG7Isu/wema4L5LjfuhPRrA66wsN0lpXzQZZvpto=; b=LsjvlHHdo6uznwGoONQvU8Nnrr
	eZJS/rYWYjvzTZMf/vl5mGaGxLiUrl3qJ24g3h29CmKw204ZxrR/uCqypRoCW2F94w49w421CezyZ
	cCpZNQaWpA3Ru2V8RtBwoyDoMiurTTcRsCUr4K+sjIJX3hwj/Y47OHGMuvB/5U0Fk0iIBGHBWimfY
	Ojji/Zcmj5WzC8pmhMh50kHFk1DrpkrpT+vY7b9zKmNQmRXTRieKmJ5zG+XLuBi2UbcyylyAmGC+g
	4/ms+lDRVhB80w7iuRDcsgkCxp/Su7GlyjpOkLPBSBCEhVCAlVMURGxLgcQP/Ylm0yLWKN36vdekV
	Bwm5y6/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRi-009yOI-1h;
	Mon, 18 Dec 2023 11:06:02 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRc-009yI5-2b
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:05:59 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VykaJPI_1702897547;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VykaJPI_1702897547)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 19:05:51 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 3/3] nvme: rdma: use ib_device's max_qp_wr to limit sqsize
Date: Mon, 18 Dec 2023 19:05:33 +0800
Message-Id: <1702897533-49685-4-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_030557_020391_2CB857C6 
X-CRM114-Status: GOOD (  11.54  )
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

Currently, the host is limited to creating queues with a depth of
128. To enable larger queue sizes, constrain the sqsize based on
the ib_device's max_qp_wr capability.

And also remove unused NVME_RDMA_MAX_QUEUE_SIZE macro.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/rdma.c  | 14 ++++++++------
 include/linux/nvme-rdma.h |  2 --
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 81e2621..982f3e4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -489,8 +489,7 @@ static int nvme_rdma_create_cq(struct ib_device *ibdev,
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct ib_device *ibdev;
-	const int send_wr_factor = 3;			/* MR, SEND, INV */
-	const int cq_factor = send_wr_factor + 1;	/* + RECV */
+	const int cq_factor = NVME_RDMA_SEND_WR_FACTOR + 1;	/* + RECV */
 	int ret, pages_per_mr;
 
 	queue->device = nvme_rdma_find_get_device(queue->cm_id);
@@ -508,7 +507,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	if (ret)
 		goto out_put_dev;
 
-	ret = nvme_rdma_create_qp(queue, send_wr_factor);
+	ret = nvme_rdma_create_qp(queue, NVME_RDMA_SEND_WR_FACTOR);
 	if (ret)
 		goto out_destroy_ib_cq;
 
@@ -1006,6 +1005,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
 	bool changed;
+	int ib_max_qsize;
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, new);
 	if (ret)
@@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
+	ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
+			(NVME_RDMA_SEND_WR_FACTOR + 1);
+	if (ctrl->ctrl.sqsize + 1 > ib_max_qsize) {
 		dev_warn(ctrl->ctrl.device,
 			"ctrl sqsize %u > max queue size %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
-		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
+			ctrl->ctrl.sqsize + 1, ib_max_qsize);
+		ctrl->ctrl.sqsize = ib_max_qsize - 1;
 	}
 
 	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index c19858b..67ee770 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -6,8 +6,6 @@
 #ifndef _LINUX_NVME_RDMA_H
 #define _LINUX_NVME_RDMA_H
 
-#define NVME_RDMA_MAX_QUEUE_SIZE	128
-
 #define NVME_RDMA_SEND_WR_FACTOR 3  /* MR, SEND, INV */
 
 enum nvme_rdma_cm_fmt {
-- 
1.8.3.1


