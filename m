Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F06C47DDB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pQZOp7QRdJiOAbJ3/srPDHJJsGv6v6ZCr3tz3OC/OY=; b=AOFX7QDL5/WKpFifJCnrrhmeyd
	+GFQMiRFeMYk1ryPOO+//35hW33nIkAiaXT/1u9+oCY2WAfWRcYqZFUarHPP+4pSzw2IENV3sn26T
	8jppwDgg/2uWi/jilH66d8y7D/PTMk9Ss380wmTjn3XP+Ef/+RAphF8rAIuxp2zV7w39Pi/4ph/1Q
	OgqFgCFVSPTAsu0rfkRGp9WWKWEdVN2xSKWaEud+llKyFAj80hGJaDzTx5jvrn52+nFOt3gvJT5e7
	FWJnMmvJ4y2Fw0dG2qrK453iaX0mfmBP/RVeyXRnVc5a3+m2+5nsqENUO5jgPKWPhuKPwv+/3Eq+z
	WadA6uLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf2D-00000007FmP-1rkn;
	Sat, 27 Jan 2024 09:31:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1z-00000007FYW-0cxZ
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9A1C360B07;
	Sat, 27 Jan 2024 09:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEE7C43394;
	Sat, 27 Jan 2024 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347878;
	bh=yeqw8eG41pFq6hH9Ruwnq4SnD7U2e46CeregiHtgVO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQhDvyRduBk+NpFl55+36eoFaCKlX1yc7dqq//FY4o3I0U3gAlR+LEkL1LeCQ8OSF
	 3XExuHWOaFfzLdGM3ydBedF5qWdXlXaUK48vLatUO3JaPF1uP5r/XWwUWeP/l67SIr
	 nzITuWTbk8RZLdeVEVmfuvqcaebfIFXweAN+dzhqDxKkx0FiNzwpiFDSBiAFWmvct4
	 4fNhISDWt9kdv5cyzAdgK4OCe9KSvo9RExFJ23eyz1Y+NdewN+uBELH0cacPELxu1x
	 CyTdP4BuG1ZY6MfKy9/sgT7iTl3GTGGbf0kCU4hl5msqvUApvJ3GI1pswQSQM0Qg3F
	 k+I9ltWGXG26Q==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/13] nvme-tcp: sanitize TLS key handling
Date: Sat, 27 Jan 2024 10:30:54 +0100
Message-Id: <20240127093058.15699-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013119_529647_F1A05FEA 
X-CRM114-Status: GOOD (  18.46  )
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
is encrypted with TLS).
So to differentiate between those two states store the provisioned
key in opts->tls_key (as we're using the same TLS key for all queues)
and the key serial of the key negotiated by the TLS handshake
in queue->tls_key.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c  |  1 -
 drivers/nvme/host/nvme.h  |  1 -
 drivers/nvme/host/sysfs.c |  2 +-
 drivers/nvme/host/tcp.c   | 40 +++++++++++++++++++++++----------------
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50818dbcfa1a..376efb310eb2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4450,7 +4450,6 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6092cc361837..396e6e72b6a3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -357,7 +357,6 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
-	struct key *tls_key;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 1076b5b59b35..dd18a118d053 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -617,7 +617,7 @@ static ssize_t tls_key_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct key *key = ctrl->tls_key;
+	struct key *key = ctrl->opts->tls_key;
 
 	if (!key)
 		return 0;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 65d9a817e752..642c0fc0941b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -163,6 +163,7 @@ struct nvme_tcp_queue {
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
 	int                     tls_err;
+	key_serial_t		tls_key;
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
+	return (queue->tls_key != 0);
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
@@ -1581,7 +1590,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		key_put(tls_key);
 		queue->tls_err = -EKEYREVOKED;
 	} else {
-		ctrl->ctrl.tls_key = tls_key;
+		queue->tls_key = pskid;
+		key_put(tls_key);
 		queue->tls_err = 0;
 	}
 
@@ -1762,7 +1772,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	/* If PSKs are configured try to start TLS */
-	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
+	if (nvme_tcp_tls_configured(nctrl) && pskid) {
 		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
 		if (ret)
 			goto err_init_connect;
@@ -1919,16 +1929,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
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
 
@@ -1949,15 +1960,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
+	struct nvme_tcp_ctrl *tcp_ctrl = to_tcp_ctrl(ctrl);
+	key_serial_t pskid = tcp_ctrl->queues[0].tls_key;
 	int i, ret;
 
-	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
-		dev_err(ctrl->device, "no PSK negotiated\n");
-		return -ENOKEY;
-	}
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i,
-				key_serial(ctrl->tls_key));
+		ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
 		if (ret)
 			goto out_free_queues;
 	}
-- 
2.35.3


