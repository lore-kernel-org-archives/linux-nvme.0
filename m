Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B388CC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPwsDgSQdQyzTYmPn/9vrcU1Tyv8AsqirwnkXySCbkk=; b=HxTLPvDELs0FDuCzwFbrYToZK6
	9MOBA4pWK2qtDLGzvcfhhMAptOxI5ZREJn3UYpC95KwAbOp29H4FzJGwccix8mBaf8URIApuceKzw
	60m2pyER5SdUmxDddA52PV14dXSMTMqynMB/Igv2ZyHhpSxS2VOkfp/z/LcUNu6G8hX9ALHMlNydp
	44Ui//6VAFBfPovVFH1BTNDVdn3J5mMgGzVEBzi09RJHVCSMxDGElWf7Eqw+hDi60uvcUzylAWTuq
	oPc9xDDlvC7wOldfjqSbnwKqH+4kokZ3+esvLoIreU1QNxRsaPD2I+UGoAVFDUc1yXiJ+cntUej4U
	b7TCPFuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouBAA-00B82b-P9; Sun, 13 Nov 2022 11:28:34 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6V-00B6Te-Ai
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:49 +0000
Received: by mail-wr1-f41.google.com with SMTP id h9so12459778wrt.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPwsDgSQdQyzTYmPn/9vrcU1Tyv8AsqirwnkXySCbkk=;
        b=mR/3Zkk2PdCv98V+I4SplC5H33qqsqNrzGWsuPCa+1xZh8rQSkmrTgEwS2t5eDksk4
         XEcJxdrUVpqbgLkqPrWzUR51/TtIleU7yW2h1oUTo2lT1gp7XogxxUdo363JfLgbzqRp
         vzKrPXRuCSddV4rOpe3eu01/G0xqESlusEXPdUzqDgIDIUlg6L7k5EITZTbIRExlZhrM
         ATDr7Sk4Z/rEnRtzS0ENMdkw+SfB0tsDC1JK/Qxr8JCsoYuAIAoyYXYBNyIevYFf0Y5d
         aPuTTQS4e6MEBkqnBZ+c7CetEAQLBb3X+5DH7gEQLGSDSPu3fRVQMzZPj9YOAE+SHvx6
         ZfuQ==
X-Gm-Message-State: ANoB5pkZV1kG+1+T08ZZaxok0wCN1NfgDHg64LgdnbaDfjKazQ3Kn8uW
	LRPHylNECUFYi4qLxa1a9bln0TK+nTk=
X-Google-Smtp-Source: AA0mqf6NRKPuLNXSIDC3XSZV+uQLKcRqQHelKW8jpj4u3Scd9EqPGiF0Gy02lxEwb9oun21phFJJww==
X-Received: by 2002:a05:6000:1817:b0:236:53d2:a2dd with SMTP id m23-20020a056000181700b0023653d2a2ddmr5248198wrh.382.1668338685826;
        Sun, 13 Nov 2022 03:24:45 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:45 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 16/20] nvme-auth: convert dhchap_auth_list to an array
Date: Sun, 13 Nov 2022 13:24:20 +0200
Message-Id: <20221113112424.1049834-17-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032447_411476_941A7274 
X-CRM114-Status: GOOD (  22.67  )
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
in a fine-grained lock such that there is no long lasting acquisition
of the lock and no need to take/release this lock when flushing
authentication works.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 118 +++++++++++++++++++++------------------
 drivers/nvme/host/core.c |   4 ++
 drivers/nvme/host/nvme.h |   2 +-
 3 files changed, 69 insertions(+), 55 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 5fad1b6f8439..eaa294376247 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -22,6 +22,12 @@ mempool_t *nvme_chap_buf_pool;
 #define nvme_auth_queue_from_qid(ctrl, qid) \
 	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
 
+static inline int ctrl_max_dhchaps(struct nvme_ctrl *ctrl)
+{
+	return ctrl->opts->nr_io_queues + ctrl->opts->nr_write_queues +
+			ctrl->opts->nr_poll_queues + 1;
+}
+
 static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			    void *data, size_t data_len, bool auth_send)
 {
@@ -482,6 +488,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		ret = PTR_ERR(ctrl_response);
 		return ret;
 	}
+
 	ret = crypto_shash_setkey(chap->shash_tfm,
 			ctrl_response, ctrl->ctrl_key->len);
 	if (ret) {
@@ -640,7 +647,6 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
 		crypto_free_kpp(chap->dh_tfm);
-	kfree(chap);
 }
 
 static void nvme_queue_auth_work(struct work_struct *work)
@@ -719,11 +725,14 @@ static void nvme_queue_auth_work(struct work_struct *work)
 
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
 	if (ret) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		chap->error = ret;
 		goto fail2;
 	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 
 	/* DH-HMAC-CHAP Step 3: send reply */
 	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
@@ -763,16 +772,19 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		return;
 	}
 
+	mutex_lock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->ctrl_key) {
 		dev_dbg(ctrl->device,
 			"%s: qid %d controller response\n",
 			__func__, chap->qid);
 		ret = nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
 		if (ret) {
+			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			chap->error = ret;
 			goto fail2;
 		}
 	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 
 	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
@@ -822,29 +834,8 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
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
-	INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
-	list_add(&chap->entry, &ctrl->dhchap_auth_list);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	chap = &ctrl->dhchap_ctxs[qid];
+	cancel_work_sync(&chap->auth_work);
 	queue_work(nvme_wq, &chap->auth_work);
 	return 0;
 }
@@ -855,19 +846,12 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
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
+	chap = &ctrl->dhchap_ctxs[qid];
+	flush_work(&chap->auth_work);
+	ret = chap->error;
+	/* clear sensitive info */
+	nvme_auth_reset_dhchap(chap);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);
 
@@ -916,11 +900,11 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
-	int ret;
+	struct nvme_dhchap_queue_context *chap;
+	int i, ret;
 
-	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
-	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	mutex_init(&ctrl->dhchap_auth_mutex);
+	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
 	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
@@ -929,37 +913,63 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
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
+	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
+		chap = &ctrl->dhchap_ctxs[i];
+		chap->qid = i;
+		chap->ctrl = ctrl;
+		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
+	}
+
+	return 0;
+err_free_dhchap_ctrl_secret:
+	nvme_auth_free_key(ctrl->ctrl_key);
+	ctrl->ctrl_key = NULL;
+err_free_dhchap_secret:
+	nvme_auth_free_key(ctrl->host_key);
+	ctrl->host_key = NULL;
 	return ret;
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
+	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
+		chap = &ctrl->dhchap_ctxs[i];
 		cancel_work_sync(&chap->auth_work);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	}
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
-		flush_work(&chap->auth_work);
-		nvme_auth_free_dhchap(chap);
+	if (ctrl->dhchap_ctxs) {
+		for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
+			chap = &ctrl->dhchap_ctxs[i];
+			flush_work(&chap->auth_work);
+			nvme_auth_free_dhchap(chap);
+		}
+		kfree(ctrl->dhchap_ctxs);
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key = NULL;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 140e8ca0858a..1973686c062b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3754,7 +3754,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
+		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->host_key = key;
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
 	}
 	/* Start re-authentication */
@@ -3806,7 +3808,9 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
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
index 8bd7554b68a8..357fa7330bd9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -367,8 +367,8 @@ struct nvme_ctrl {
 
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
-	struct list_head dhchap_auth_list;
 	struct mutex dhchap_auth_mutex;
+	struct nvme_dhchap_queue_context *dhchap_ctxs;
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
-- 
2.34.1


