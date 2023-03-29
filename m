Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A1CC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7yYygcy4B/WeA74cY/GHcVJdhFnXarJ6HaOjUkTS3k0=; b=coCHG+9zfKV4Ed8OHsS+MVZafb
	7oEZzvV97u8XBg3skSWorPDKOn+Zl6niCy5HDGMwS4xYN4E8TEWZtyj+mVrk+1sEOTJWTHxQ/gJwN
	5Ag6WgIO4POGijNYsowLe2r92biO92x9yjZ31a9/F6SGjTIhERaZz0Ox/dwHmM7QmJSR1gncIqvhg
	Jqu+iVEoDH1vDJUXeArFc30QfRFVNXA2+VKUA2zFyKNcbYTm1aD9M5DTMDBV1V2AiHPHli29lBhiw
	swwdv6Z0ODBZpRVRsC/IYptzCGcHesRxVY+dyDtNlmWZNcSPLPBMcFBYWXyZYzC6WTXSb4MV8OWsB
	GCV2K1+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLd-000V5q-20;
	Wed, 29 Mar 2023 14:00:21 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLI-000UlW-0c
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0406B1FDFF;
	Wed, 29 Mar 2023 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yYygcy4B/WeA74cY/GHcVJdhFnXarJ6HaOjUkTS3k0=;
	b=p+wSIoORHGKiJQ9CsHFSYmOseWZWz+o0wQo4cvwGDSajAcciOnHmjeciRzRr4rxKA5P325
	GDzh0TCLCRq/YexrJJhUmf7KfAZ7YQVHdp7umDx0pjmA/RR5mShyGa6qcSqWZOHsvWh99t
	xGUgxTK0tGx9OhKtFt0DnSqY0+Psx5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yYygcy4B/WeA74cY/GHcVJdhFnXarJ6HaOjUkTS3k0=;
	b=nE3m2vArrsW7e7y1mAlG+GJhaE+GbBfDXe2nvdYTQwpORwSed1fouvekLGcxIvZdshu7QK
	WajRGd6O+4q0x0Dw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E646F2C187;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id E3A8051BF390; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Date: Wed, 29 Mar 2023 15:59:35 +0200
Message-Id: <20230329135938.46905-16-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_070000_435311_36A73162 
X-CRM114-Status: GOOD (  21.74  )
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

Add functions to start the TLS handshake upcall when
the TCP RSAS sectype is set to 'tls1.3'.

Signed-off-by: Hannes Reincke <hare@suse.de>
---
 drivers/nvme/target/configfs.c |  32 +++++++-
 drivers/nvme/target/tcp.c      | 135 ++++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ca66ee6dc153..36fbf6a22d09 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -159,10 +159,12 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
 	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
 };
 
+#define NVMET_PORT_TREQ(port) ((port)->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK)
+
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
-	u8 treq = to_nvmet_port(item)->disc_addr.treq &
-		NVME_TREQ_SECURE_CHANNEL_MASK;
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = NVMET_PORT_TREQ(port);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
@@ -193,6 +195,17 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
+#ifdef CONFIG_NVME_TLS
+	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
+			pr_warn("cannot change TREQ when TLS is not enabled\n");
+			return -EINVAL;
+		} else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
+			pr_warn("cannot set TREQ to 'not specified' when TLS is enabled\n");
+			return -EINVAL;
+		}
+	}
+#endif
 	treq |= nvmet_addr_treq[i].type;
 	port->disc_addr.treq = treq;
 	return count;
@@ -373,6 +386,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -391,6 +405,20 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
 found:
 	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
+	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
+#ifdef CONFIG_NVME_TLS
+		if (NVMET_PORT_TREQ(port) == NVMF_TREQ_NOT_SPECIFIED)
+			treq |= NVMF_TREQ_REQUIRED;
+		else
+			treq |= NVMET_PORT_TREQ(port);
+#else
+		pr_err("TLS not supported\n");
+		return -EINVAL;
+#endif
+	} else {
+		/* Set to 'not specified' if TLS is not enabled */
+		treq |= NVMF_TREQ_NOT_SPECIFIED;
+	}
 	return count;
 }
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5931971d715f..ebec882120fd 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -11,6 +11,10 @@
 #include <linux/nvme-tcp.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#ifdef CONFIG_NVME_TLS
+#include <net/handshake.h>
+#include <linux/nvme-keyring.h>
+#endif
 #include <linux/inet.h>
 #include <linux/llist.h>
 #include <crypto/hash.h>
@@ -40,6 +44,16 @@ module_param(idle_poll_period_usecs, int, 0644);
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs");
 
+#ifdef CONFIG_NVME_TLS
+/*
+ * TLS handshake timeout
+ */
+static int tls_handshake_timeout = 30;
+module_param(tls_handshake_timeout, int, 0644);
+MODULE_PARM_DESC(tls_handshake_timeout,
+		 "nvme TLS handshake timeout in seconds (default 30)");
+#endif
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -130,6 +144,10 @@ struct nvmet_tcp_queue {
 	bool			data_digest;
 	struct ahash_request	*snd_hash;
 	struct ahash_request	*rcv_hash;
+#ifdef CONFIG_NVME_TLS
+	struct key		*tls_psk;
+	struct delayed_work	tls_handshake_work;
+#endif
 
 	unsigned long           poll_end;
 
@@ -1474,6 +1492,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
+#ifdef CONFIG_NVME_TLS
+	if (queue->tls_psk)
+		key_put(queue->tls_psk);
+#endif
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 	page = virt_to_head_page(queue->pf_cache.va);
 	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
@@ -1488,8 +1510,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
-	if (likely(queue))
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+	if (queue->data_ready)
+		queue->data_ready(sk);
+	if (likely(queue) &&
+	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
+			      &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1597,6 +1623,89 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
+#ifdef CONFIG_NVME_TLS
+static void nvmet_tcp_tls_queue_restart(struct nvmet_tcp_queue *queue)
+{
+	spin_lock(&queue->state_lock);
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+		pr_warn("queue %d: TLS handshake already completed\n",
+			queue->idx);
+		spin_unlock(&queue->state_lock);
+		return;
+	}
+	queue->state = NVMET_TCP_Q_CONNECTING;
+	spin_unlock(&queue->state_lock);
+
+	pr_debug("queue %d: restarting queue after TLS handshake\n",
+		 queue->idx);
+	/*
+	 * Set callbacks after handshake; TLS implementation
+	 * might have changed the socket callbacks.
+	 */
+	nvmet_tcp_set_queue_sock(queue);
+}
+
+static void nvmet_tcp_tls_handshake_done(void *data, int status,
+					 key_serial_t peerid)
+{
+	struct nvmet_tcp_queue *queue = data;
+
+	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
+		 queue->idx, peerid, status);
+	if (!status) {
+		spin_lock(&queue->state_lock);
+		queue->tls_psk = key_lookup(peerid);
+		if (IS_ERR(queue->tls_psk)) {
+			pr_warn("queue %d: TLS key %x not found\n",
+				queue->idx, peerid);
+			queue->tls_psk = NULL;
+		}
+		spin_unlock(&queue->state_lock);
+	}
+	cancel_delayed_work_sync(&queue->tls_handshake_work);
+	if (status)
+		nvmet_tcp_schedule_release_queue(queue);
+	else
+		nvmet_tcp_tls_queue_restart(queue);
+}
+
+static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
+{
+	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
+			struct nvmet_tcp_queue, tls_handshake_work);
+
+	pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
+	nvmet_tcp_schedule_release_queue(queue);
+}
+
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+{
+	int ret = -EOPNOTSUPP;
+	struct tls_handshake_args args;
+
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+		pr_warn("cannot start TLS in state %d\n", queue->state);
+		return -EINVAL;
+	}
+
+	pr_debug("queue %d: TLS ServerHello\n", queue->idx);
+	args.ta_sock = queue->sock;
+	args.ta_done = nvmet_tcp_tls_handshake_done;
+	args.ta_data = queue;
+	args.ta_keyring = nvme_keyring_id();
+	args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;
+
+	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	if (ret) {
+		pr_err("failed to start TLS, err=%d\n", ret);
+	} else {
+		queue_delayed_work(nvmet_wq, &queue->tls_handshake_work,
+				   tls_handshake_timeout * HZ);
+	}
+	return ret;
+}
+#endif
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1609,6 +1718,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
+#ifdef CONFIG_NVME_TLS
+	INIT_DELAYED_WORK(&queue->tls_handshake_work,
+			  nvmet_tcp_tls_handshake_timeout_work);
+#endif
 	queue->sock = newsock;
 	queue->port = port;
 	queue->nr_cmds = 0;
@@ -1622,6 +1735,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
 
+#ifdef CONFIG_NVME_TLS
 	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
 		queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
 		if (IS_ERR(queue->sock_file)) {
@@ -1630,6 +1744,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 			goto out_free_queue;
 		}
 	}
+#endif
 
 	queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
@@ -1651,6 +1766,22 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
+#ifdef CONFIG_NVME_TLS
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		struct sock *sk = queue->sock->sk;
+
+		/* Restore the default callbacks before starting upcall */
+		read_lock_bh(&sk->sk_callback_lock);
+		sk->sk_user_data = NULL;
+		sk->sk_data_ready = port->data_ready;
+		read_unlock_bh(&sk->sk_callback_lock);
+		if (!nvmet_tcp_tls_handshake(queue))
+			return;
+
+		/* TLS handshake failed, terminate the connection */
+		goto out_destroy_sq;
+	}
+#endif
 	ret = nvmet_tcp_set_queue_sock(queue);
 	if (ret)
 		goto out_destroy_sq;
-- 
2.35.3


