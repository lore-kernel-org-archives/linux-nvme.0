Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F54ECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=miz5dyzjNMitdloMFsUfrk2aHvWlfa9L/nhJJbYEKm8=; b=4FKRv1UEAZQa69uygEfGCXMOxy
	wlEcfNGON4yQ83VylZxZ5jCz7DNe8V8XHC6l5HBGmbVIJhpoXCWQdbr722OfgM8UCDAi4cGy1Z6Ps
	VVQSMc3s126SUd9QJ9TI79LKSPFngIYZIFomKif6oNNhqr70cuuNelzq1NOjZ2ieHpEiExEBu1i/+
	qMj0+Y3PZ87ruHsuUZuILfZy3ETyl08zEpGaD/1v7n/9L2OHLJUi/Crny5ix+GeiO7cDrRX4GJtbF
	dOv+k44RO9XmtMQXVUqHiZjb2XNQy+bbEkecTXEp8sC4U849WoBnqpu9STgUcp63An5ZbM5H7+sWT
	hfwm+dAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0gU-00Gx2r-Qb; Tue, 30 Aug 2022 12:49:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0gO-00Gwvw-61
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 12:49:33 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3CE13221FB;
	Tue, 30 Aug 2022 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661863767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miz5dyzjNMitdloMFsUfrk2aHvWlfa9L/nhJJbYEKm8=;
	b=dvbI9dwZIn/wEVpqE5F6/4P1Tg/3LktFrffytQ4YtmbwLJX8J5H4hMdiMBomQ2Lv+si9Wi
	6Y6q90DoOrOEW+HVRsIuF3UwNnd/ixmtx6ARgOlctH5P5r5mBKsdoewUUf/ESzA65cs79h
	aaaPki5BRvKeEfnKn3TdXBJ48I9RlkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661863767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miz5dyzjNMitdloMFsUfrk2aHvWlfa9L/nhJJbYEKm8=;
	b=sgRwOfJGzSyPxN0lMybreSFRvaizeHsUUNrVJSbV2u50VyoOSYbmQDN+LYPyiARyKYxo1g
	Io3tbRVqrYUzqkCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0AA2E2C141;
	Tue, 30 Aug 2022 12:49:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id F11D151AA5BA; Tue, 30 Aug 2022 14:49:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: [PATCH 1/2] nvme-auth: retry command if DNR bit is not set
Date: Tue, 30 Aug 2022 14:49:24 +0200
Message-Id: <20220830124925.40711-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220830124925.40711-1-hare@suse.de>
References: <20220830124925.40711-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_054932_411649_89B59E8F 
X-CRM114-Status: GOOD (  15.64  )
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

If the cqe returns a status with the DNR bit not set we should
retry the command; otherwise we might incur spurious failures.

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c |  2 +-
 drivers/nvme/host/core.c | 20 ++++++++++++++++++--
 include/linux/blk-mq.h   |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..4ca3f7d042f1 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -69,7 +69,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
 				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+				     0, BLK_MQ_REQ_RETRY | flags);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66ae23e9cb0e..a77f406512eb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -355,7 +355,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
+	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED &&
+	    !(nvme_req(req)->status & NVME_SC_DNR))
 		return AUTHENTICATE;
 
 	if (blk_noretry_request(req) ||
@@ -1037,15 +1038,30 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	nvme_init_request(req, cmd);
+	if (flags & BLK_MQ_REQ_RETRY)
+		nvme_req(req)->retries = nvme_max_retries;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
 		if (ret)
 			goto out;
 	}
-
+retry:
 	req->rq_flags |= RQF_QUIET;
 	ret = nvme_execute_rq(req, at_head);
+	if (ret > 0) {
+		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
+		if (ctrl->kas)
+			ctrl->comp_seen = true;
+
+		switch (nvme_decide_disposition(req)) {
+		case COMPLETE:
+			break;
+		default:
+			goto retry;
+		}
+	}
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
  out:
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index effee1dc715a..acd833f37cd4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -713,6 +713,8 @@ enum {
 	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
 	/* set RQF_PM */
 	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 2),
+	/* Retry reserved commands */
+	BLK_MQ_REQ_RETRY	= (__force blk_mq_req_flags_t)(1 << 3),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
-- 
2.35.3


