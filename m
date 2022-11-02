Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DCBC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlJKyTafmA6En4ZCma0ReTEqRQC+WLH9K7pYo7nJ8X0=; b=x70f7B9skXZOPmavajFuIDQDBq
	rufs9vVz6m30GoWcyCwfeizdHhwbGDQ1gFnHkijHkYnLwFqU4NiQTcDWWN0f7RdJnF3vvMneAVpwg
	zpXUmOQKFaOUOBAld3R0ctF5QERG/2tkizvNlsi5kbpDoBQAUSJYVQn7cMBEJAIY+tS7EmgaqYAJX
	mcrxRfukyfa57vLNeedvMnIC3x03fUyAwif59KgkH2KQg63f3lxx2AXwrrFWq1wv7HDH8c0sPQekL
	+dRnMSJfHIPmUnVDFilazawGkx77wteoxWulAwPMv+CHJCMqaJhkkcjOHPjMV7C7bGy+j7Mrae299
	wsrIQWJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8YO-008gfM-4W; Wed, 02 Nov 2022 07:52:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y5-008gVR-GV
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:35 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9F5641F8CC;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlJKyTafmA6En4ZCma0ReTEqRQC+WLH9K7pYo7nJ8X0=;
	b=jZt/KlMbVhlniUY82JrkNqDpHP6Zn7rbvRkRYTHTO/a191Z6BlQRCmhuw/UFKs6eDCJS/H
	QZv6SR1hrppSQmxD2BARSrPpR6Oiuw6MmIatTVN/WHcDbLlKH9XyqSBIaUMABz2On+1ykH
	JCEpqOYq6QSZT008lVgxsdO9d7UteNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlJKyTafmA6En4ZCma0ReTEqRQC+WLH9K7pYo7nJ8X0=;
	b=Ufmh7V8CmEvXwLOBZwyCbYpiFnAxwTvvb0r5L5XTBq/xyFiDg79imoGch29IhMbRGSXjH5
	ytAEhmXejFvpxTBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 9AEF92C145;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 96A0051AD6C7; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] nvme-auth: use xarray instead of linked list
Date: Wed,  2 Nov 2022 08:52:21 +0100
Message-Id: <20221102075224.70869-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102075224.70869-1-hare@suse.de>
References: <20221102075224.70869-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005233_721132_E8B62727 
X-CRM114-Status: GOOD (  17.57  )
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

The current design of holding the chap context is slightly awkward,
as the context is allocated on demand, and we have to lock the list
when looking up contexts as we wouldn't know if the context is
allocated.

This patch moves the allocation out of the chap context before starting
authentication and stores it into an xarray. With that we can do
away with the list traversal and access the context directly
via the queue number.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 85 +++++++++++++++++++++-------------------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 719c514363ee..cece4f33e3a8 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -878,27 +878,35 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	/* Check if the context is already queued */
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		if (chap->qid == qid) {
-			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
+	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
+	if (!chap) {
+		int ret;
+
+		chap = kzalloc(sizeof(*chap), GFP_NOIO);
+		if (!chap) {
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
-			flush_work(&chap->auth_work);
-			__nvme_auth_reset(chap);
-			queue_work(nvme_wq, &chap->auth_work);
-			return 0;
+			dev_warn(ctrl->device,
+				 "qid %d: error allocation authentication", qid);
+			return -ENOMEM;
 		}
-	}
-	chap = kzalloc(sizeof(*chap), GFP_KERNEL);
-	if (!chap) {
+		chap->qid = qid;
+		chap->ctrl = ctrl;
+
+		INIT_WORK(&chap->auth_work, __nvme_auth_work);
+		ret = xa_insert(&ctrl->dhchap_auth_xa, qid, chap, GFP_NOIO);
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		return -ENOMEM;
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %d: error %d inserting authentication",
+				 qid, ret);
+			kfree(chap);
+			return ret;
+		}
+	} else {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		flush_work(&chap->auth_work);
+		__nvme_auth_reset(chap);
 	}
-	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
-	chap->ctrl = ctrl;
-
-	INIT_WORK(&chap->auth_work, __nvme_auth_work);
-	list_add(&chap->entry, &ctrl->dhchap_auth_list);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	queue_work(nvme_wq, &chap->auth_work);
 	return 0;
 }
@@ -907,33 +915,28 @@ EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
-	int ret;
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		if (chap->qid != qid)
-			continue;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		flush_work(&chap->auth_work);
-		ret = chap->error;
-		return ret;
+	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
+	if (!chap) {
+		dev_warn(ctrl->device,
+			 "qid %d: authentication not initialized!",
+			 qid);
+		return -ENOENT;
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
-	return -ENXIO;
+	flush_work(&chap->auth_work);
+	return chap->error;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);
 
 void nvme_auth_reset(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
+	unsigned long qid;
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
+	xa_for_each(&ctrl->dhchap_auth_xa, qid, chap) {
 		flush_work(&chap->auth_work);
 		__nvme_auth_reset(chap);
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_reset);
 
@@ -979,7 +982,7 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 
 void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
-	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
+	xa_init_flags(&ctrl->dhchap_auth_xa, XA_FLAGS_ALLOC);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
 	mutex_init(&ctrl->dhchap_auth_mutex);
 	if (!ctrl->opts)
@@ -991,27 +994,27 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
 void nvme_auth_stop(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap = NULL, *tmp;
+	struct nvme_dhchap_queue_context *chap;
+	unsigned long qid;
 
 	cancel_work_sync(&ctrl->dhchap_auth_work);
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry)
+	xa_for_each(&ctrl->dhchap_auth_xa, qid, chap)
 		cancel_work_sync(&chap->auth_work);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
 void nvme_auth_free(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap = NULL, *tmp;
+	struct nvme_dhchap_queue_context *chap;
+	unsigned long qid;
 
 	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
-		list_del_init(&chap->entry);
-		flush_work(&chap->auth_work);
+	xa_for_each(&ctrl->dhchap_auth_xa, qid, chap) {
+		chap = xa_erase(&ctrl->dhchap_auth_xa, qid);
 		__nvme_auth_free(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	xa_destroy(&ctrl->dhchap_auth_xa);
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key = NULL;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 32d9dc2d957e..9b31fb8c1b27 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -338,7 +338,7 @@ struct nvme_ctrl {
 
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
-	struct list_head dhchap_auth_list;
+	struct xarray dhchap_auth_xa;
 	struct mutex dhchap_auth_mutex;
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
-- 
2.35.3


