Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DCFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bf+YaoUfZPJSEZ1OMBrtNJPiLarJYszURc65ZV0Wasw=; b=mkw4Nns2fXh+CAeld4g464a49k
	TdKI/T0jCxpxyJa8KqEtuPEX3nWFMXbG1B7otbhd33tgTnjd9rCjEmgkUMbKgVe4JClkETXfLUuYq
	bgUpDbwvxgLJzaFMyBQi3rEgLZyppAucZUC+OL63+RehHJEbSQPMNcA3U1EfdU0ayaJkXs6x+GwTl
	AT5pU1oXEZMPHpvVNzj5iKZIiO2WUTgsiPEsOAvIPJA1LzHEbN+EJHm5HmpqtTnBjVp7j0iZYchJh
	HuwvBymL0zDVQi215+MEWCrBLjq83FMcM+csSjXFlx4nHYbXyFiXvMj/nmR6WrVFEMYLvdIMPJnZl
	vOtCc9Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc3F-00APKV-Qm; Wed, 09 Nov 2022 03:46:57 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc12-00AOPW-4g
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:41 +0000
Received: by mail-pf1-f182.google.com with SMTP id b185so15553568pfb.9
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf+YaoUfZPJSEZ1OMBrtNJPiLarJYszURc65ZV0Wasw=;
        b=Oogypx3uFJhV5m7PuMfmEKNY2yuQBkHpaOX1Kgq8WIPJLlESNHSZTbyzyKXbz7pTNN
         fr7dHkIFPSd/KeHcu/DR98FGXxfsBJxD3ioyEyhVglZet5hZetq+a/rMYBMHnBlUQU/Z
         88uutkuZtloOXqkgacas4NS8673KT8A6C3B6l0bmuIrLZOfIHol/ZgphWidFttMg8FAH
         nprN3hMs6ScxtsLUgCVZRn7+0dvgMWrfLEaxuOrmsIOy9su/+OkHfh61pNYF5Y/UT/kd
         6/G5s42JeFVjVYD0QXoesPtyxqYty7r88VpThHX8AjcA66ChF0o6UcgDAkp9fsA2K2AB
         LvNw==
X-Gm-Message-State: ACrzQf1tS6aAe/xXpFfkxUt5j67v0xiF0SMyZYY+qEqfDJx6u7M1t/xS
	thBPgnm+qHj+lFC1L8PBu4p6g2u6FrQEVnJ5
X-Google-Smtp-Source: AMsMyM7ClnD+lcNAVs5iDb30lBcPEscU3L1QiekpK7s5hK7u2CDB7WbAbOxem3QfVl2WlOvnMI7VKQ==
X-Received: by 2002:a05:6a00:2187:b0:56c:7e85:c8f9 with SMTP id h7-20020a056a00218700b0056c7e85c8f9mr59283796pfi.75.1667965479144;
        Tue, 08 Nov 2022 19:44:39 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:38 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 12/16] nvme-auth: convert dhchap_auth_list to an array
Date: Wed,  9 Nov 2022 05:44:15 +0200
Message-Id: <20221109034420.1000086-13-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194440_202884_82FC5357 
X-CRM114-Status: GOOD (  22.68  )
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

We know exactly how many dhchap contexts we will need, there is no need
to hold a list that we need to protect with a mutex. Convert to
a dynamically allocated array. And dhchap_context access state is
maintained by the chap itself.

Make dhchap_auth_mutex protect only the ctrl host_key and ctrl_key
in a fine-graned lock such that there is no long lasting acuisition
of the lock.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 113 +++++++++++++++++++++------------------
 drivers/nvme/host/core.c |   4 ++
 drivers/nvme/host/nvme.h |   2 +-
 3 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 23d486284da9..b78e0df54f6c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -46,6 +46,14 @@ struct nvme_dhchap_queue_context {
 	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
 #define nvme_auth_queue_from_qid(ctrl, qid) \
 	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
+#define nvme_auth_chap_from_qid(ctrl, qid) \
+	&((struct nvme_dhchap_queue_context*)(ctrl)->dhchap_ctxs)[qid]
+#define ctrl_max_dhchaps(ctrl) \
+	(ctrl)->opts->nr_io_queues + (ctrl)->opts->nr_write_queues + \
+			(ctrl)->opts->nr_poll_queues + 1
+#define nvme_foreach_dhchap(i, chap, ctrl) \
+	for (i = 0, chap = (ctrl)->dhchap_ctxs; \
+	     i < ctrl_max_dhchaps(ctrl) && chap != NULL; i++, chap++)
 
 static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			    void *data, size_t data_len, bool auth_send)
@@ -330,7 +338,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
 	size_t size = sizeof(*data);
 
-	if (ctrl->ctrl_key)
+	if (chap->ctrl_key)
 		size += chap->hash_len;
 
 	if (chap->buf_size < size) {
@@ -418,8 +426,10 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		__func__, chap->qid, chap->s1, chap->transaction);
 
 	if (!chap->host_response) {
+		mutex_lock(&ctrl->dhchap_auth_mutex);
 		chap->host_response = nvme_auth_transform_key(ctrl->host_key,
 						ctrl->opts->host->nqn);
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		if (IS_ERR(chap->host_response)) {
 			ret = PTR_ERR(chap->host_response);
 			chap->host_response = NULL;
@@ -430,8 +440,10 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 			__func__, chap->qid);
 	}
 
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	ret = crypto_shash_setkey(chap->shash_tfm,
 			chap->host_response, ctrl->host_key->len);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -507,6 +519,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		ret = PTR_ERR(ctrl_response);
 		return ret;
 	}
+
 	ret = crypto_shash_setkey(chap->shash_tfm,
 			ctrl_response, ctrl->ctrl_key->len);
 	if (ret) {
@@ -665,7 +678,6 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
 		crypto_free_kpp(chap->dh_tfm);
-	kfree(chap);
 }
 
 static void __nvme_auth_work(struct work_struct *work)
@@ -789,6 +801,7 @@ static void __nvme_auth_work(struct work_struct *work)
 		return;
 	}
 
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->ctrl_key) {
 		dev_dbg(ctrl->device,
 			"%s: qid %d controller response\n",
@@ -816,6 +829,7 @@ static void __nvme_auth_work(struct work_struct *work)
 		if (ret)
 			chap->error = ret;
 	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (!ret) {
 		chap->error = 0;
 		return;
@@ -848,29 +862,8 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		return -ENOKEY;
 	}
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	/* Check if the context is already queued */
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		WARN_ON(!chap->buf);
-		if (chap->qid == qid) {
-			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
-			mutex_unlock(&ctrl->dhchap_auth_mutex);
-			flush_work(&chap->auth_work);
-			nvme_auth_reset_dhchap(chap);
-			queue_work(nvme_wq, &chap->auth_work);
-			return 0;
-		}
-	}
-	chap = kzalloc(sizeof(*chap), GFP_KERNEL);
-	if (!chap) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		return -ENOMEM;
-	}
-	chap->qid = qid;
-	chap->ctrl = ctrl;
-	INIT_WORK(&chap->auth_work, __nvme_auth_work);
-	list_add(&chap->entry, &ctrl->dhchap_auth_list);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	chap = nvme_auth_chap_from_qid(ctrl, qid);
+	cancel_work_sync(&chap->auth_work);
 	queue_work(nvme_wq, &chap->auth_work);
 	return 0;
 }
@@ -881,19 +874,12 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 	struct nvme_dhchap_queue_context *chap;
 	int ret;
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		if (chap->qid != qid)
-			continue;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		flush_work(&chap->auth_work);
-		ret = chap->error;
-		/* clear sensitive info */
-		nvme_auth_reset_dhchap(chap);
-		return ret;
-	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
-	return -ENXIO;
+	chap = nvme_auth_chap_from_qid(ctrl, qid);
+	flush_work(&chap->auth_work);
+	ret = chap->error;
+	/* clear sensitive info */
+	nvme_auth_reset_dhchap(chap);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);
 
@@ -942,11 +928,11 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
-	int ret;
+	struct nvme_dhchap_queue_context *chap;
+	int i, ret;
 
-	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
-	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
 	mutex_init(&ctrl->dhchap_auth_mutex);
+	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
 	if (!ctrl->opts)
 		return 0;
 	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
@@ -955,37 +941,57 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		return ret;
 	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
 			&ctrl->ctrl_key);
-	if (ret) {
-		nvme_auth_free_key(ctrl->host_key);
-		ctrl->host_key = NULL;
+	if (ret)
+		goto err_free_dhchap_secret;
+
+	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
+		return ret;
+
+	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
+				sizeof(*chap), GFP_KERNEL);
+	if (!ctrl->dhchap_ctxs) {
+		ret = -ENOMEM;
+		goto err_free_dhchap_ctrl_secret;
 	}
+
+	nvme_foreach_dhchap(i, chap, ctrl) {
+		chap->qid = i;
+		chap->ctrl = ctrl;
+		INIT_WORK(&chap->auth_work, __nvme_auth_work);
+	}
+
+out:
 	return ret;
+err_free_dhchap_ctrl_secret:
+	nvme_auth_free_key(ctrl->ctrl_key);
+	ctrl->ctrl_key = NULL;
+err_free_dhchap_secret:
+	nvme_auth_free_key(ctrl->host_key);
+	ctrl->host_key = NULL;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
 void nvme_auth_stop(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap = NULL, *tmp;
+	struct nvme_dhchap_queue_context *chap;
+	int i;
 
 	cancel_work_sync(&ctrl->dhchap_auth_work);
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry)
+	nvme_foreach_dhchap(i, chap, ctrl)
 		cancel_work_sync(&chap->auth_work);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
 void nvme_auth_free(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap = NULL, *tmp;
+	struct nvme_dhchap_queue_context *chap;
+	int i;
 
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
-		list_del_init(&chap->entry);
+	nvme_foreach_dhchap(i, chap, ctrl) {
 		flush_work(&chap->auth_work);
 		nvme_auth_free_dhchap(chap);
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key = NULL;
@@ -994,5 +1000,6 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 		nvme_auth_free_key(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
+	kfree(ctrl->dhchap_ctxs);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c15dbbe509f5..d8e6ff4257e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3755,7 +3755,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
+		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->host_key = key;
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
 	}
 	/* Start re-authentication */
@@ -3807,7 +3809,9 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
+		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->ctrl_key = key;
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
 	}
 	/* Start re-authentication */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f9708825aa24..7d12759857d7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -336,8 +336,8 @@ struct nvme_ctrl {
 
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
-	struct list_head dhchap_auth_list;
 	struct mutex dhchap_auth_mutex;
+	void *dhchap_ctxs;
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
-- 
2.34.1


