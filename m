Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D34C3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgXUv1lR9ug3nwTG29tn/0PWCaayMAxIyJ7luzNojE4=; b=ayMPyJa1+oXO7+WizmQlXyZD5k
	xnQ4Kk18Jm6OAVdGkBtYFv0DeonHTAm1Li/+6W0oJ/+P89MvWfLxLqd+1IJ8yuhSiNy8cH2U4b2up
	fIMDGsT30mWcsal5YpwGNGLgiFzui69rgJhQSzzS6KFXSLhkF1jO9oaERiqVv98YmaR2JXK5NJ/sr
	Rd7LRJl2ByARq5Od2Bv6GFjhNcIyQhtFJd3vH2RlHhYEyeHrQ4wsMOgsbQIsbN9LKg2Nng6K2L/4o
	Xh5O3YYHFdfZf8tJ4ciJRvswTusEUMU9RsYJxsvU///fVbDhhdHB3cZTBCeqgMmbqLKwz3PhHXx/T
	fqXpYEPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkW-00000009SYB-1bpV;
	Mon, 22 Jul 2024 12:02:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkQ-00000009SUx-3DqK
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EFB6A60AFE;
	Mon, 22 Jul 2024 12:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F3C116B1;
	Mon, 22 Jul 2024 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649753;
	bh=/gK72AmB89lTNuffVALvYbtHmxyZWa7mBQIO8iCZVXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPaSGLRT+TWjGFLMoJtn3SB6pyhcGXjEf72/wiLVy2omCS1lqduV1Nd+XweuPjNPs
	 Sp5Ulx7O/w6dQt18BjqRAORomOlY/WHG753kHPZKlvkgmqM11Ybjtf+5/+gwn2V3ab
	 zbYjcd0FSISkIw6303Xh0uFnYV5sysAmDdM5jK0E2k7Ef0M3gn138UZryOfgCKaW5k
	 cYeUWDhwuim89a1zwWZr6oqTNyRc6b/eh0NK0v2iJW3ZAAczWlcteM28yNm9uMg/5w
	 dPz8xqBAqoC3omCxYUP3Lo3nyHoJa2bI1dn3yrWjy9r01/uzoHgDtDRO8yTETs1qBu
	 cnC3tVLXDrGaw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/9] nvme-tcp: sanitize TLS key handling
Date: Mon, 22 Jul 2024 14:02:19 +0200
Message-Id: <20240722120226.88737-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050234_968795_35DAEBA7 
X-CRM114-Status: GOOD (  22.89  )
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

There is a difference between TLS configured (ie the user has
provisioned/requested a key) and TLS enabled (ie the connection
is encrypted with TLS). This becomes important for secure concatenation,
where the initial authentication is run on an unencrypted connection
(ie with TLS configured, but not enabled), and then the queue is reset to
run over TLS (ie TLS configured _and_ enabled).
So to differentiate between those two states store the generated
key in opts->tls_key (as we're using the same TLS key for all queues),
the key serial of the resulting TLS handshake in ctrl->tls_pskid
(to signal that TLS on the admin queue is enabled), and a simple
flag for the queues to indicated that TLS has been enabled.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c  |  1 -
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/sysfs.c |  4 +--
 drivers/nvme/host/tcp.c   | 53 +++++++++++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e78ef31eeef0..663fa14162ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4675,7 +4675,6 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	cleanup_srcu_struct(&ctrl->srcu);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ac587e64166..185fb986a5cc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -373,7 +373,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
-	struct key *tls_key;
+	key_serial_t tls_pskid;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ba05faaac562..72675b59a7a7 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -670,9 +670,9 @@ static ssize_t tls_key_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (!ctrl->tls_key)
+	if (!ctrl->tls_pskid)
 		return 0;
-	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
+	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f..b305873e588e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -165,6 +165,7 @@ struct nvme_tcp_queue {
 
 	bool			hdr_digest;
 	bool			data_digest;
+	bool			tls_enabled;
 	struct ahash_request	*rcv_hash;
 	struct ahash_request	*snd_hash;
 	__le32			exp_ddgst;
@@ -213,7 +214,21 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
-static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
+/*
+ * Check if the queue is TLS encrypted
+ */
+static inline bool nvme_tcp_queue_tls(struct nvme_tcp_queue *queue)
+{
+	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		return 0;
+
+	return queue->tls_enabled;
+}
+
+/*
+ * Check if TLS is configured for the controller.
+ */
+static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
 {
 	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
 		return 0;
@@ -368,7 +383,7 @@ static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 {
-	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+	return !nvme_tcp_queue_tls(queue) &&
 		nvme_tcp_queue_has_pending(queue);
 }
 
@@ -1427,7 +1442,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_queue_tls(queue)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
@@ -1439,7 +1454,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_queue_tls(queue)) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
@@ -1587,7 +1602,10 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 			 qid, pskid);
 		queue->tls_err = -ENOKEY;
 	} else {
-		ctrl->ctrl.tls_key = tls_key;
+		queue->tls_enabled = true;
+		if (qid == 0)
+			ctrl->ctrl.tls_pskid = key_serial(tls_key);
+		key_put(tls_key);
 		queue->tls_err = 0;
 	}
 
@@ -1768,7 +1786,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	/* If PSKs are configured try to start TLS */
-	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
+	if (nvme_tcp_tls_configured(nctrl) && pskid) {
 		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
 		if (ret)
 			goto err_init_connect;
@@ -1829,6 +1847,8 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
+	/* Stopping the queue will disable TLS */
+	queue->tls_enabled = false;
 	mutex_unlock(&queue->queue_lock);
 }
 
@@ -1925,16 +1945,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (nvme_tcp_tls(ctrl)) {
+	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
-		else
+		else {
 			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
 						      ctrl->opts->host->nqn,
 						      ctrl->opts->subsysnqn);
-		if (!pskid) {
-			dev_err(ctrl->device, "no valid PSK found\n");
-			return -ENOKEY;
+			if (!pskid) {
+				dev_err(ctrl->device, "no valid PSK found\n");
+				return -ENOKEY;
+			}
 		}
 	}
 
@@ -1957,13 +1978,14 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
-	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
+	if (nvme_tcp_tls_configured(ctrl) && !ctrl->tls_pskid) {
 		dev_err(ctrl->device, "no PSK negotiated\n");
 		return -ENOKEY;
 	}
+
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i,
-				key_serial(ctrl->tls_key));
+				ctrl->tls_pskid);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2144,6 +2166,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
+	if (ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
+			ctrl->tls_pskid);
+		ctrl->tls_pskid = 0;
+	}
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-- 
2.35.3


