Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C17C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u8wA7FK8EmfGrjJyWTwfKO4vyxLsYi/nyfhA2ff0EeA=; b=RZmjJUsNeQ41LVPjnyBkxNySfF
	l2Y0xbc3SBlcDZdL1jbRSu4TPf/UlkHjNaHBKQTgMC7KUQavVV8cOzMlubCF73CLED/UPZELwOOiq
	LgVlF71ClZ6Wfs5uk7mmQNek7Igd2EL0Q/V4tzYJMr4zqCVPxu8zM9Ac8WU1je+pxKEj1EilfuKbb
	5zkmVVmU34OqLZ9dJ7c+KTJcziI8We25AGdnDkAjBs/r2dJCMr+9MTThSBZ7lGsdR53gerjbVgl3p
	nbPdcRwgPV+A5eNHsCjw7kwUsxaQh/WeZLMaGPJtv6IBetWmvjuLKEtI79VG2t9vMZFY1gAV7hS8w
	2Dy5qHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3nO-002VlM-0C;
	Fri, 15 Dec 2023 08:43:46 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3nM-002VjR-0B
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 08:43:45 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VyX9V2._1702629808;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyX9V2._1702629808)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 16:43:33 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: validate maxcmd before use it
Date: Fri, 15 Dec 2023 16:43:28 +0800
Message-Id: <1702629808-96718-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_004344_328652_32E0E123 
X-CRM114-Status: GOOD (  10.66  )
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

According to the NVMe specification, if the 'maximum outstanding
commands' (maxcmd) field is not utilized, it must be set to 0h.
When a host connects to a target that does not employ the maxcmd
field, the queue size (sqsize) gets set to an excessively large
value due to the calculation (u16)(0 - 1) = 65535.
As a result, such a misconfiguration leads to the failure of the
connection establishment.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/fc.c   | 3 ++-
 drivers/nvme/host/rdma.c | 3 ++-
 drivers/nvme/host/tcp.c  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fb22976..8ddbeef 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3156,7 +3156,8 @@ static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
 		goto out_stop_keep_alive;
 	}
 
-	if (opts->queue_size > ctrl->ctrl.maxcmd) {
+	if (ctrl->ctrl.maxcmd &&
+	    opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl maxcmd %u, reducing "
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 81e2621..597df7c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1037,7 +1037,8 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
+	if (ctrl->ctrl.maxcmd &&
+	    ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
 		dev_warn(ctrl->ctrl.device,
 			"sqsize %u > ctrl maxcmd %u, clamping down\n",
 			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08805f0..12b00ad 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2197,7 +2197,8 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
 			opts->queue_size, ctrl->sqsize + 1);
 
-	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
+	if (ctrl->maxcmd &&
+	    ctrl->sqsize + 1 > ctrl->maxcmd) {
 		dev_warn(ctrl->device,
 			"sqsize %u > ctrl maxcmd %u, clamping down\n",
 			ctrl->sqsize + 1, ctrl->maxcmd);
-- 
1.8.3.1


