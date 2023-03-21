Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A08C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjxTY1/7bWq4kuNa5+9CQoImPq/ldZSbo3qe8RmT5Es=; b=FrR0ebsx1PRqab46reAH0BGYLy
	MOeB+GrPZtOj81s5zl7C6pixOZFiKYa16iR9TorCnzp7F28MDII2TBHSOoXXDeZ44lUhBHYMm/9Bu
	bDDmaZaC+BMP+NY4ST6CtTJOS6/dNzcM/7Sbcv1UqCXluax16283XhAIxKr9UgHf5+q04BeQRhKMj
	XknEN5dtC6JfqL6W59uEP3lu4N9KIfEZJzk01EYgj33bdkQTq6wmLXxFCSAfY0niVXNdlpnETxAJ8
	I4M/8IuUeq19BTM/7Cdo6x98b5USuUeDwOEOlXvPpob/S+NPm/ONCY8+PdhSCy+1ngFvmn1a7YdB2
	EVBY8N+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLf-00CNcE-2a;
	Tue, 21 Mar 2023 12:44:19 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLN-00CNOb-1a
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id ED3F320001;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjxTY1/7bWq4kuNa5+9CQoImPq/ldZSbo3qe8RmT5Es=;
	b=UKAuWqvPz8UKShPMQhAbcA4fJbMvHZhw3qulQ6YySwFqDj7VgKOsWxdnyMoSCOehoFqBqf
	LBlB+VlCX2mSBwBEOQ9bpKW9Rr97KpK4j/mZgOesyn9xvThwi0OJKDNfibc9TfBb8CRUmv
	1t1EUV9m9nqAddin/K4Ibv+MLka/usA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjxTY1/7bWq4kuNa5+9CQoImPq/ldZSbo3qe8RmT5Es=;
	b=fL1UFZIoDSlhvLTEmD5YvTtEfSG9COR1Se46R6XDrGVEFvWXm5arjTlEQrbmyNB2zUZdgZ
	mS2XblxpMXhLlKDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D92E22C152;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D276451BEEA4; Tue, 21 Mar 2023 13:43:57 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/18] nvme-tcp: enable TLS handshake upcall
Date: Tue, 21 Mar 2023 13:43:15 +0100
Message-Id: <20230321124325.77385-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
References: <20230321124325.77385-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054401_745974_42B1251E 
X-CRM114-Status: GOOD (  21.30  )
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

Select possible PSK identities and call the TLS handshake upcall
for each identity.
The TLS 1.3 RFC allows to send multiple identities with each ClientHello
request, but none of the SSL libraries implement it. As the connection
is established when the association is created we send only a single
identity for each upcall, and close the connection to restart with
the next identity if the handshake fails.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 157 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0438d42f4179..bcf24e9a08e1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -8,9 +8,12 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/key.h>
 #include <linux/nvme-tcp.h>
+#include <linux/nvme-keyring.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/handshake.h>
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
@@ -31,6 +34,14 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+/*
+ * TLS handshake timeout
+ */
+static int tls_handshake_timeout = 10;
+module_param(tls_handshake_timeout, int, 0644);
+MODULE_PARM_DESC(tls_handshake_timeout,
+		 "nvme TLS handshake timeout in seconds (default 10)");
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -104,6 +115,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_TLS		= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -148,6 +160,9 @@ struct nvme_tcp_queue {
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 
+	struct completion       *tls_complete;
+	int                     tls_err;
+
 	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
@@ -1505,7 +1520,102 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
+/*
+ * nvme_tcp_lookup_psk - Look up PSKs to use for TLS
+ *
+ */
+static int nvme_tcp_lookup_psks(struct nvme_ctrl *nctrl,
+			       key_serial_t *keylist, int num_keys)
+{
+	enum nvme_tcp_tls_cipher cipher = NVME_TCP_TLS_CIPHER_SHA384;
+	struct key *tls_key;
+	int num = 0;
+	bool generated = false;
+
+	/* Check for pre-provisioned keys; retained keys first */
+	do {
+		tls_key = nvme_tls_psk_lookup(NULL, nctrl->opts->host->nqn,
+					      nctrl->opts->subsysnqn,
+					      cipher, generated);
+		if (!IS_ERR(tls_key)) {
+			keylist[num] = tls_key->serial;
+			num++;
+			key_put(tls_key);
+		}
+		if (cipher == NVME_TCP_TLS_CIPHER_SHA384)
+			cipher = NVME_TCP_TLS_CIPHER_SHA256;
+		else {
+			if (generated)
+				cipher = NVME_TCP_TLS_CIPHER_INVALID;
+			else {
+				cipher = NVME_TCP_TLS_CIPHER_SHA384;
+				generated = true;
+			}
+		}
+	} while(cipher != NVME_TCP_TLS_CIPHER_INVALID);
+	return num;
+}
+
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t peerid)
+{
+	struct nvme_tcp_queue *queue = data;
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+	int qid = nvme_tcp_queue_id(queue);
+
+	dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, status %d\n",
+		qid, peerid, status);
+
+	queue->tls_err = -status;
+	if (queue->tls_complete)
+		complete(queue->tls_complete);
+}
+
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t peerid)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+	struct tls_handshake_args args;
+	unsigned long tmo = tls_handshake_timeout * HZ;
+	DECLARE_COMPLETION_ONSTACK(tls_complete);
+
+	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
+		qid, peerid);
+	args.ta_sock = queue->sock;
+	args.ta_done = nvme_tcp_tls_done;
+	args.ta_data = queue;
+	args.ta_my_peerids[0] = peerid;
+	args.ta_num_peerids = 1;
+	args.ta_keyring = nvme_keyring_id();
+	args.ta_timeout_ms = tls_handshake_timeout * 2 * 1000;
+	queue->tls_err = -EOPNOTSUPP;
+	queue->tls_complete = &tls_complete;
+	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	if (ret) {
+		dev_dbg(nctrl->device, "queue %d: failed to start TLS: %d\n",
+			qid, ret);
+		return ret;
+	}
+	if (wait_for_completion_timeout(queue->tls_complete, tmo) == 0) {
+		dev_dbg(nctrl->device,
+			"queue %d: TLS handshake timeout\n", qid);
+		queue->tls_complete = NULL;
+		ret = -ETIMEDOUT;
+	} else {
+		dev_dbg(nctrl->device,
+			"queue %d: TLS handshake complete, error %d\n",
+			qid, queue->tls_err);
+		ret = queue->tls_err;
+	}
+	queue->tls_complete = NULL;
+	if (!ret)
+		set_bit(NVME_TCP_Q_TLS, &queue->flags);
+	return ret;
+}
+
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
+				key_serial_t peerid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1628,6 +1738,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_rcv_pdu;
 	}
 
+	/* If PSKs are configured try to start TLS */
+	if (peerid) {
+		ret = nvme_tcp_start_tls(nctrl, queue, peerid);
+		if (ret)
+			goto err_init_connect;
+	}
+
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
@@ -1774,11 +1891,22 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
 
 static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
-	int ret;
+	int ret = -EINVAL, num_keys, k;
+	key_serial_t keylist[4];
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
-	if (ret)
-		return ret;
+	memset(keylist, 0, sizeof(key_serial_t));
+	num_keys = nvme_tcp_lookup_psks(ctrl, keylist, 4);
+	for (k = 0; k < num_keys; k++) {
+		ret = nvme_tcp_alloc_queue(ctrl, 0, keylist[k]);
+		if (!ret)
+			break;
+	}
+	if (ret) {
+		/* Try without TLS */
+		ret = nvme_tcp_alloc_queue(ctrl, 0, 0);
+		if (ret)
+			goto out_free_queue;
+	}
 
 	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
 	if (ret)
@@ -1793,12 +1921,23 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
-	int i, ret;
+	int i, ret, num_keys = 0, k;
+	key_serial_t keylist[4];
 
+	memset(keylist, 0, sizeof(key_serial_t));
+	num_keys = nvme_tcp_lookup_psks(ctrl, keylist, 4);
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
-		if (ret)
-			goto out_free_queues;
+		ret = -EINVAL;
+		for (k = 0; k < num_keys; k++) {
+			ret = nvme_tcp_alloc_queue(ctrl, i, keylist[k]);
+			if (!ret)
+				break;
+		}
+		if (ret) {
+			ret = nvme_tcp_alloc_queue(ctrl, i, 0);
+			if (ret)
+				goto out_free_queues;
+		}
 	}
 
 	return 0;
-- 
2.35.3


