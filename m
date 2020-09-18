Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922A9C43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:26:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4325E23730
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8/QZed1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYGrkOxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4325E23730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T8+CnZxWvMVgbT7sSabZfPObsThcd4HUUHcpGEkS3YM=; b=A8/QZed1almY1Zva52QSNeRNJ
	qjiGwUc5la4HQ1GYcmjxc7CzBNJeI5yeALEIfkwtbeWJqgEQH22pwq3FgkZcFp7sRATjIvDkiHkMo
	jGjBGLwwc06h91G/xYlhFRnZO/cRX6c4UsyITYMYakafUPq6L7eKponza0sEh6O0NxE38nSAlcGh3
	EUbVRQj6wPIBcBooLzXwqWx+9Y6wKaKDiAlF4+kyAOaLbX/Plo9qDevBy/Avz1EgChkbedXsfkg6f
	pFm3fouUJIOKReRBTT2HeDwmNPg8NbAuwouFslJ4k+LNVmt21SgVHrRNOTALiKHaT91kIQilVB9Er
	ZcYbcU8Qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ665-0005hJ-DR; Fri, 18 Sep 2020 02:26:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ5rB-0006Ty-94
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 02:10:42 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5844D208DB;
 Fri, 18 Sep 2020 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600395035;
 bh=sMtUXiLrD2CTS5yhYpl994m8qcR94OVzzB4WmWh4BGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KYGrkOxaI08H7Wh6oct+PKPKBQfWJz4c/tfCnfXCDwpLbwT1KgkBSNnNYdIxBJXve
 d6eAnuVGEZBi27/ldY/rniwsyAAyykghD75jcorKDsAyq6jLRBox364LNK8IOJtkdS
 m9zVISpu5biWAnH/LpInRqJ+xqcpP7xGQl1AoA4E=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 126/206] nvme-multipath: do not reset on unknown
 status
Date: Thu, 17 Sep 2020 22:06:42 -0400
Message-Id: <20200918020802.2065198-126-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_221037_672503_988A6CA0 
X-CRM114-Status: GOOD (  15.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, John Meneghini <johnm@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: John Meneghini <johnm@netapp.com>

[ Upstream commit 764e9332098c0e60251386a507fe46ac91276120 ]

The nvme multipath error handling defaults to controller reset if the
error is unknown. There are, however, no existing nvme status codes that
indicate a reset should be used, and resetting causes unnecessary
disruption to the rest of IO.

Change nvme's error handling to first check if failover should happen.
If not, let the normal error handling take over rather than reset the
controller.

Based-on-a-patch-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Meneghini <johnm@netapp.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      |  5 +----
 drivers/nvme/host/multipath.c | 21 +++++++++------------
 drivers/nvme/host/nvme.h      |  5 +++--
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0d60f2f8f3eec..4b182ac15687e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -255,11 +255,8 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) &&
-		    blk_path_error(status)) {
-			nvme_failover_req(req);
+		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
 			return;
-		}
 
 		if (!blk_queue_dying(req->q)) {
 			nvme_req(req)->retries++;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2e63c1106030b..e71075338ff5c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -73,17 +73,12 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+bool nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-	blk_mq_end_request(req, 0);
-
 	switch (status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
@@ -111,15 +106,17 @@ void nvme_failover_req(struct request *req)
 		nvme_mpath_clear_current_path(ns);
 		break;
 	default:
-		/*
-		 * Reset the controller for any non-ANA error as we don't know
-		 * what caused the error.
-		 */
-		nvme_reset_ctrl(ns->ctrl);
-		break;
+		/* This was a non-ANA error so follow the normal error path. */
+		return false;
 	}
 
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	blk_steal_bios(&ns->head->requeue_list, req);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	blk_mq_end_request(req, 0);
+
 	kblockd_schedule_work(&ns->head->requeue_work);
+	return true;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc4273f119894..31c1496f938fb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -477,7 +477,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-void nvme_failover_req(struct request *req);
+bool nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -521,8 +521,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline void nvme_failover_req(struct request *req)
+static inline bool nvme_failover_req(struct request *req)
 {
+	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
