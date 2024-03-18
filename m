Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA519C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zM2718TukQ2uvrs75vMnwdFY9akBMBrAs5CRyOmgP/g=; b=y4/qUIDacYwUsbPGuqIR2NOUbb
	1206nQmkHIYjW2zZWJAeg+JnMc4TyEnUvh4O+uZkUtbgBprIBquJb2yzQ105lL2/rNsy3JX1630QR
	+cr4z+Pp5q+J1bdLt8seXFN1W9zaYuOtSmiv4Tlv1jUk3tYSCPRwYZTbN3PlIEgtdOyCnscQH0qKI
	041PR3aTFT8xAiKeyqEIgymcVeTRWb8xQsZ8LAe8uNy2JfCEn+S0T1363jFDEEKuG3if6d9w2rpC9
	fjyRLGrl6jRi96UDKIbNUZcTfw+NqLDMvllChXQFHDsX/nr/NxI515V+cKOqM6snaQQu0aTeSZVox
	AUCPRzOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWs-00000008uVN-1Vov;
	Mon, 18 Mar 2024 15:03:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWg-00000008uJo-1D4V
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 90C96CE0A29;
	Mon, 18 Mar 2024 15:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B557C433F1;
	Mon, 18 Mar 2024 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774223;
	bh=+9qVW8mYEgAC3FpgGQX5JbzVogH/84ZLpTLHeiuEHls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIExIY+KeBeozIdm4++v9bxZcIohTtOmXF/mSLAjakdxod8XYVI+TmWGVzFnsZfPE
	 CV6cugIqgonzmYv9CAqMETx4lYb1c4XGrk3NsP53JXg0zPnTqE3mRbab75d2u4tvdb
	 aDsPVemFbDUFTzFY1zzI/fSNr0gkXwoz/gnKEo9FY1vIIifHaYOxqFj+KzUQrnswR2
	 E1LboLaDxEMyiwlAVpvYq+DOIH9OjdQ3aq06MbwApKhvQn4hkuywY9dapv5G62pms0
	 cEhYolYBaX6YZUkRaRJ+Hu/NM4HiCLyPlSrlLu6Y5wVQio5mf0Wl5LiJL8buYfYSEm
	 0IzcpMaWaUK8g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/17] nvme-tcp: sanitize TLS key handling
Date: Mon, 18 Mar 2024 16:03:07 +0100
Message-Id: <20240318150316.138501-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080347_062283_CED3F119 
X-CRM114-Status: GOOD (  21.73  )
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

From: Hannes Reinecke <hare@suse.de>

There is a difference between TLS configured (ie the user has
provisioned/requested a key) and TLS enabled (ie the connection
is encrypted with TLS). This becomes important for secure concatenation,
where the initial authentication is run unencrypted (ie with
TLS configured, but not enabled), and then the queue is reset to
run over TLS (ie TLS configured _and_ enabled).
So to differentiate between those two states store the provisioned
key in opts->tls_key (as we're using the same TLS key for all queues)
and only the key serial of the key negotiated by the TLS handshake
in queue->tls_pskid.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c  |  1 -
 drivers/nvme/host/sysfs.c |  2 +-
 drivers/nvme/host/tcp.c   | 54 +++++++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2baf5786a92f..9b601655f423 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4567,7 +4567,6 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ec581608f16c..1f9e57fbfee3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -671,7 +671,7 @@ static ssize_t tls_key_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct key *key = ctrl->tls_key;
+	struct key *key = ctrl->opts->tls_key;
 
 	if (!key)
 		return 0;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4a58886e1354..7018dc0dd026 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -163,6 +163,7 @@ struct nvme_tcp_queue {
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
 	int                     tls_err;
+	key_serial_t		tls_pskid;
 	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
@@ -205,7 +206,15 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
-static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
+static inline bool nvme_tcp_tls_enabled(struct nvme_tcp_queue *queue)
+{
+	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		return 0;
+
+	return (queue->tls_pskid != 0);
+}
+
+static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
 {
 	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
 		return 0;
@@ -1418,7 +1427,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_tls_enabled(queue)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
@@ -1430,7 +1439,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_tls_enabled(queue)) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
@@ -1581,7 +1590,11 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		key_put(tls_key);
 		queue->tls_err = -EKEYREVOKED;
 	} else {
-		ctrl->ctrl.tls_key = tls_key;
+		queue->tls_pskid = key_serial(tls_key);
+		if (qid == 0)
+			ctrl->ctrl.tls_key = tls_key;
+		else
+			key_put(tls_key);
 		queue->tls_err = 0;
 	}
 
@@ -1762,7 +1775,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	/* If PSKs are configured try to start TLS */
-	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
+	if (nvme_tcp_tls_configured(nctrl) && pskid) {
 		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
 		if (ret)
 			goto err_init_connect;
@@ -1823,6 +1836,12 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
+	/* Stopping the queue will disable TLS, so clear the PSK ID */
+	if (queue->tls_pskid) {
+		dev_dbg(nctrl->device, "queue %d clear TLS PSK %08x\n",
+			qid, queue->tls_pskid);
+		queue->tls_pskid = 0;
+	}
 	mutex_unlock(&queue->queue_lock);
 }
 
@@ -1919,16 +1938,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
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
 
@@ -1949,15 +1969,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
+	struct nvme_tcp_ctrl *tcp_ctrl = to_tcp_ctrl(ctrl);
+	key_serial_t pskid = ctrl->tls_key ? key_serial(ctrl->tls_key) : 0;
 	int i, ret;
 
-	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
+	if (nvme_tcp_tls_configured(ctrl) && !pskid) {
 		dev_err(ctrl->device, "no PSK negotiated\n");
 		return -ENOKEY;
 	}
+
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i,
-				key_serial(ctrl->tls_key));
+		ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2138,6 +2160,12 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
+	if (ctrl->tls_key) {
+		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
+			key_serial(ctrl->tls_key));
+		key_put(ctrl->tls_key);
+		ctrl->tls_key = NULL;
+	}
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-- 
2.35.3


