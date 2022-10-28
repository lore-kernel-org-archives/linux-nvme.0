Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9751CC38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b9h+qK/joU9LAyiji/3z4vgl1Pq2diNawwEERbVLmOk=; b=OEAL5moSBe9ExZJxtotJR2AD4I
	3EXS5q4b354YRne6vmSIGOUXpUNtAJZPvEYf+BKTWMSLfLzQ3+KkDpyaCOFHGt33mz1nBde+wz16k
	qIaS8xG4A3c0XMUvWtNq/yZPYQxVJqzMIHqnGtod0kydzT9IBHzpDy1tcSNq+HTgR4r+UGTBBrOXJ
	KrCmyhDQpx8E/TkRN4V9Z9jKjMiIfUlw6MKxNcuasnnbhIxB8VG/tggY7XgnZKJLuVEc09UHWlS04
	n1WCFJ4a8Mm2b33AqBjimNd614fyJbFTvgTndJ2c8R136Y8clFMMYJT5o5xqLNZCAy31WISqaGf9s
	YeA02g2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooPky-00HS9U-9H; Fri, 28 Oct 2022 13:50:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooPko-00HS3L-9c
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 13:50:37 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0E0621F986;
	Fri, 28 Oct 2022 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666965029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9h+qK/joU9LAyiji/3z4vgl1Pq2diNawwEERbVLmOk=;
	b=OmOpwYsvvc/N+7ZtonsdwDh/YFwQ2YsUpFNC4TLNJi+rzZOcKcHjxL7EM29qLFiEklj1o9
	82x9yBB8ip/rp/Ib0Ivr0SlgJNBUjt/A6AmlGywgNAfBjDT7ovaGJlydWbxS9CwrhdbB6C
	u2hWb2axPfz0jM6AO5TmsvSrafs2JwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666965029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9h+qK/joU9LAyiji/3z4vgl1Pq2diNawwEERbVLmOk=;
	b=voPW1IU4uv5F+UGAmeeUy7rN9r7RCh3bZFwDyOVmEqaNdao+s6pGv+kQwAOQKEYuZbQzD0
	0GE9KCdUQ6613pCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 038B72C141;
	Fri, 28 Oct 2022 13:50:28 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8956551AD2C9; Fri, 28 Oct 2022 15:50:28 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme-auth: use xarray instead of linked list
Date: Fri, 28 Oct 2022 15:50:27 +0200
Message-Id: <20221028135027.116044-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221028135027.116044-1-hare@suse.de>
References: <20221028135027.116044-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_065034_536960_996E21FF 
X-CRM114-Status: GOOD (  18.31  )
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
away with the lock and access the context directly via the queue number.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 116 ++++++++++++++++++++++-----------------
 drivers/nvme/host/nvme.h |   3 +-
 2 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b68fb2c764f6..7b974bd0fa64 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -72,10 +72,12 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 				     0, flags, nvme_max_retries);
 	if (ret > 0)
 		dev_warn(ctrl->device,
-			"qid %d auth_send failed with status %d\n", qid, ret);
+			"qid %d auth_%s failed with status %d\n",
+			 qid, auth_send ? "send" : "recv", ret);
 	else if (ret < 0)
 		dev_err(ctrl->device,
-			"qid %d auth_send failed with error %d\n", qid, ret);
+			"qid %d auth_%s failed with error %d\n",
+			qid, auth_send ? "send" : "recv", ret);
 	return ret;
 }
 
@@ -870,29 +872,42 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		return -ENOKEY;
 	}
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	/* Check if the context is already queued */
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		if (chap->qid == qid) {
-			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
-			mutex_unlock(&ctrl->dhchap_auth_mutex);
-			flush_work(&chap->auth_work);
-			__nvme_auth_reset(chap);
-			queue_work(nvme_wq, &chap->auth_work);
-			return 0;
-		}
-	}
-	chap = kzalloc(sizeof(*chap), GFP_KERNEL);
+	if (qid == NVME_QID_ANY)
+		qid = 0;
+	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
 	if (!chap) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		return -ENOMEM;
-	}
-	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
-	chap->ctrl = ctrl;
+		int ret;
+
+		chap = kzalloc(sizeof(*chap), GFP_KERNEL);
+		if (!chap) {
+			dev_warn(ctrl->device,
+				 "qid %d: error allocation authentication", qid);
+			return -ENOMEM;
+		}
+		chap->qid = qid;
+		chap->ctrl = ctrl;
 
-	INIT_WORK(&chap->auth_work, __nvme_auth_work);
-	list_add(&chap->entry, &ctrl->dhchap_auth_list);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+		INIT_WORK(&chap->auth_work, __nvme_auth_work);
+		ret = xa_insert(&ctrl->dhchap_auth_xa, qid, chap, GFP_KERNEL);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %d: error %d inserting authentication",
+				 qid, ret);
+			kfree(chap);
+			return ret;
+		}
+	} else {
+		if (chap->qid != qid) {
+			dev_warn(ctrl->device,
+				 "qid %d: authentication qid mismatch (%d)!",
+				 chap->qid, qid);
+			chap = xa_erase(&ctrl->dhchap_auth_xa, qid);
+			__nvme_auth_free(chap);
+			return -ENOENT;
+		}
+		flush_work(&chap->auth_work);
+		__nvme_auth_reset(chap);
+	}
 	queue_work(nvme_wq, &chap->auth_work);
 	return 0;
 }
@@ -901,33 +916,35 @@ EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
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
+	if (qid == NVME_QID_ANY)
+		qid = 0;
+	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
+	if (!chap) {
+		dev_warn(ctrl->device,
+			 "qid %d: authentication not initialized!",
+			 qid);
+		return -ENOENT;
+	} else if (chap->qid != qid) {
+		dev_warn(ctrl->device,
+			 "qid %d: authentication qid mismatch (%d)!",
+			 chap->qid, qid);
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
 
@@ -947,7 +964,7 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 	ret = nvme_auth_wait(ctrl, 0);
 	if (ret) {
 		dev_warn(ctrl->device,
-			 "qid 0: authentication failed\n");
+			 "qid 0: authentication failed with %d\n", ret);
 		return;
 	}
 
@@ -969,9 +986,8 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 
 void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
-	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
+	xa_init_flags(&ctrl->dhchap_auth_xa, XA_FLAGS_ALLOC);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
-	mutex_init(&ctrl->dhchap_auth_mutex);
 	if (!ctrl->opts)
 		return;
 	nvme_auth_generate_key(ctrl->opts->dhchap_secret, &ctrl->host_key);
@@ -981,27 +997,25 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
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
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
-		list_del_init(&chap->entry);
-		flush_work(&chap->auth_work);
+	xa_for_each(&ctrl->dhchap_auth_xa, qid, chap) {
+		chap = xa_erase(&ctrl->dhchap_auth_xa, qid);
 		__nvme_auth_free(chap);
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	xa_destroy(&ctrl->dhchap_auth_xa);
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key = NULL;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 32d9dc2d957e..d0b2d3e4b63f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -338,8 +338,7 @@ struct nvme_ctrl {
 
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
-	struct list_head dhchap_auth_list;
-	struct mutex dhchap_auth_mutex;
+	struct xarray dhchap_auth_xa;
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
-- 
2.35.3


