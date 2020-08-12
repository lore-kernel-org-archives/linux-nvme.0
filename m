Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41BCC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 08:19:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8809220774
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 08:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zJm9vtmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8809220774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xvEhVxDnoIDLTxGg/5cQ3zXvXi1Oh0UKErTq2dJjf/Y=; b=zJm9vtmS+v8tr+wCAUb38mgeVb
	6FZ7Sa34fnIFatlMNCgdCq/+qVCuRu3cVXc7vGaxhRkk0HcK5oMSFxGRROUw771CkZLvaNlxWZluH
	64Js+ArLNGWzmA3UwbBGQa1O7O3tcvPGF1zCWNViPJvRRCevykKmWTUn33OBJZ2xQqeAsCPZjv6nv
	Qj6kGARA03PND7EqKj17Jl8z9MVjQjfNzpauGNv8+7KkU5j06UeCIsVuSpjuZY8n8M2OG6behveWU
	6jecrGA1CDtHWVn4hDA/9XhzGBJ2B3Lbim6h7enowR+exGK0I36Ogtp47UfXJevTvpLZ9pfqqHfOU
	xch5qD9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5lyL-0001Gk-FY; Wed, 12 Aug 2020 08:18:57 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5lyI-0001FU-86
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 08:18:55 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 14F469375A531B2A7560;
 Wed, 12 Aug 2020 16:18:44 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:37 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH 1/3] nvme-core: fix io interrupt caused by non path error
Date: Wed, 12 Aug 2020 16:18:37 +0800
Message-ID: <20200812081837.22144-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_041854_542560_F52D2339 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For nvme multipath configured, just fail over to retry IO for path error,
but maybe blk_queue_dying return true, IO can not be retry at current
path, thus IO will interrupted.

For nvme multipath configured, blk_queue_dying and path error both need
fail over to retry. We need check whether path-related errors first, and
then retry local or fail over to retry.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c      | 18 ++++++++++++++----
 drivers/nvme/host/multipath.c | 11 +++--------
 drivers/nvme/host/nvme.h      |  5 ++---
 include/linux/nvme.h          |  9 +++++++++
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4ee2330c603e..52d19a4d3bc8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -252,6 +252,14 @@ static inline bool nvme_req_needs_retry(struct request *req)
 	return true;
 }
 
+static inline bool nvme_req_path_error(struct request *req)
+{
+	if ((nvme_req(req)->status & NVME_SCT_MASK) == NVME_SCT_PATH ||
+		blk_queue_dying(req->q))
+		return true;
+	return false;
+}
+
 static void nvme_retry_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -280,10 +288,12 @@ void nvme_complete_rq(struct request *req)
 		nvme_req(req)->ctrl->comp_seen = true;
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-			return;
-
-		if (!blk_queue_dying(req->q)) {
+		if (nvme_req_path_error(req)) {
+			if (req->cmd_flags & REQ_NVME_MPATH) {
+				nvme_failover_req(req);
+				return;
+			}
+		} else {
 			nvme_retry_req(req);
 			return;
 		}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 66509472fe06..e182fb3bcd0c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,7 +65,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-bool nvme_failover_req(struct request *req)
+void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status;
@@ -90,17 +90,13 @@ bool nvme_failover_req(struct request *req)
 			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		}
 		break;
-	case NVME_SC_HOST_PATH_ERROR:
-	case NVME_SC_HOST_ABORTED_CMD:
+	default:
 		/*
-		 * Temporary transport disruption in talking to the controller.
+		 * Normal error path.
 		 * Try to send on a new path.
 		 */
 		nvme_mpath_clear_current_path(ns);
 		break;
-	default:
-		/* This was a non-ANA error so follow the normal error path. */
-		return false;
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
@@ -109,7 +105,6 @@ bool nvme_failover_req(struct request *req)
 	blk_mq_end_request(req, 0);
 
 	kblockd_schedule_work(&ns->head->requeue_work);
-	return true;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 09ffc3246f60..cbb5d4ba6241 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -582,7 +582,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-bool nvme_failover_req(struct request *req);
+void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -640,9 +640,8 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline bool nvme_failover_req(struct request *req)
+static inline void nvme_failover_req(struct request *req)
 {
-	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab4c50e..8c4a5b4d5b4d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1441,6 +1441,15 @@ enum {
 	NVME_SC_DNR			= 0x4000,
 };
 
+#define NVME_SCT_MASK 0x700
+enum {
+	NVME_SCT_GENERIC = 0,
+	NVME_SCT_COMMAND_SPECIFIC = 0x100,
+	NVME_SCT_MEDIA = 0x200,
+	NVME_SCT_PATH = 0x300,
+	NVME_SCT_VENDOR = 0x700
+};
+
 struct nvme_completion {
 	/*
 	 * Used by Admin and Fabrics commands to return data:
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
