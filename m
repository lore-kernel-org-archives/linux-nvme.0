Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB33C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 06:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/mhTPVm1x6f0n3k4go64odOzPRnaluVvBjj0Fvdbo0=; b=YwKP3QZjUOHOqzkLRCU961PdT7
	1iivtofgXvF7ljk8G4vwyN3+q8rDRQBAplOIEdsem7z+TaGXS9VYDON4Bo31E3BDQLNXIAMljTyRB
	5QHrgNSvT/u79o+R8bLeNay41+thUT40/xp80f/VoXjz5WrN0t++nAEzE/q5o5fDA5ZB4YECmOoZr
	YwU1OhuuD3WW4eT5Q09L55qcWjyVVotjS1hBBZ3yS+2v5pPr4veidnoTLTmTP8X9tAssbMKhlUAxs
	BWBxJE0k9nYCtKKOpFt7TXB71uh9k0Q2dJbijDPmYmsTuM4+rsaBzWD6aBywAm/mJahcz7JLBh2Je
	G431DM2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1l9-004IlS-0w;
	Wed, 19 Apr 2023 06:57:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1kr-004IWk-0X
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 06:57:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6465F1FD90;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681887438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/mhTPVm1x6f0n3k4go64odOzPRnaluVvBjj0Fvdbo0=;
	b=AWafKbRyEccBEIpWOsA+arMtAACJoS6jZMrt3hMJbJPSnbNWCOIEyIGuxbCQR6C1xq5AGk
	EeZBRo+uZ/TxRU9Bd4jqFopNw5eA4F9dmlTwD6qUoKqmjzef9ZD+NMEStNdyINhSPUFAEo
	7mbFIRBxQw09rs2Zjyij5hTnSme9Nw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681887438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/mhTPVm1x6f0n3k4go64odOzPRnaluVvBjj0Fvdbo0=;
	b=k3Clsw6P75nYY9/6KX4/QAUqcp/NySVAe13oi5HEOT9/doGeu7Li/7zuUkJglxMqoErwQ0
	7wseijg/5BC/7jBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 538A52C162;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5005D51C26E7; Wed, 19 Apr 2023 08:57:18 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/17] nvmet-tcp: enable TLS handshake upcall
Date: Wed, 19 Apr 2023 08:57:13 +0200
Message-Id: <20230419065714.52076-17-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419065714.52076-1-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_235725_528231_EAE4A292 
X-CRM114-Status: GOOD (  25.91  )
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
the TCP TSAS sectype is set to 'tls1.3' and add a config
option NVME_TARGET_TCP_TLS.

Signed-off-by: Hannes Reincke <hare@suse.de>
---
 drivers/nvme/target/Kconfig    |  14 ++++
 drivers/nvme/target/configfs.c |  63 +++++++++++++++-
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 134 ++++++++++++++++++++++++++++++++-
 4 files changed, 206 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 79fc64035ee3..15af2b4341f6 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -84,6 +84,20 @@ config NVME_TARGET_TCP
 
 	  If unsure, say N.
 
+config NVME_TARGET_TCP_TLS
+	bool "NVMe over Fabrics TCP target TLS encryption support"
+	depends on NVME_TARGET_TCP
+	select NVME_COMMON
+	select NVME_KEYRING
+	select NET_HANDSHAKE
+	help
+	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
+
+	  The TLS handshake daemon is availble at
+	  https://github.com/oracle/ktls-utils.
+
+	  If unsure, say N.
+
 config NVME_TARGET_AUTH
 	bool "NVMe over Fabrics In-band Authentication support"
 	depends on NVME_TARGET
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7f826ac8b75c..49b407702ad5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -15,6 +15,7 @@
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
 #endif
+#include <linux/nvme-keyring.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
 
@@ -159,10 +160,15 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
 	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
 };
 
+static inline u8 nvmet_port_treq(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
-	u8 treq = to_nvmet_port(item)->disc_addr.treq &
-		NVME_TREQ_SECURE_CHANNEL_MASK;
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_treq(port);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
@@ -174,11 +180,16 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 	return snprintf(page, PAGE_SIZE, "\n");
 }
 
+static inline u8 nvmet_port_treq_mask(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
+	u8 treq = nvmet_port_treq_mask(port);
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -193,6 +204,23 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
+	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+			pr_err("TLS is not supported\n");
+			return -EINVAL;
+		}
+		if (!port->keyring) {
+			pr_err("TLS keyring not configured\n");
+			return -EINVAL;
+		}
+		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
+			pr_warn("cannot change TREQ when TLS is not enabled\n");
+			return -EINVAL;
+		} else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
+			pr_warn("cannot set TREQ to 'not specified' when TLS is enabled\n");
+			return -EINVAL;
+		}
+	}
 	treq |= nvmet_addr_treq[i].type;
 	port->disc_addr.treq = treq;
 	return count;
@@ -371,6 +399,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_treq_mask(port);
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -379,6 +408,15 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
 		return -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+		pr_err("TLS is not supported\n");
+		return -EINVAL;
+	}
+	if (!port->keyring) {
+		pr_err("TLS keyring not configured\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
 		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name))
 			goto found;
@@ -389,6 +427,16 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
 found:
 	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
+	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
+		if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
+			treq |= NVMF_TREQ_REQUIRED;
+		else
+			treq |= nvmet_port_treq(port);
+	} else {
+		/* Set to 'not specified' if TLS is not enabled */
+		treq |= NVMF_TREQ_NOT_SPECIFIED;
+	}
+	port->disc_addr.treq = treq;
 	return count;
 }
 
@@ -1795,6 +1843,7 @@ static void nvmet_port_release(struct config_item *item)
 	flush_workqueue(nvmet_wq);
 	list_del(&port->global_entry);
 
+	key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
 }
@@ -1844,6 +1893,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (nvme_keyring_id()) {
+		port->keyring = key_lookup(nvme_keyring_id());
+		if (IS_ERR(port->keyring)) {
+			pr_warn("NVMe keyring not available, disabling TLS\n");
+			port->keyring = NULL;
+		}
+	}
+
 	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
 		if (i == NVMET_DEFAULT_ANA_GRPID)
 			port->ana_state[1] = NVME_ANA_OPTIMIZED;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..a22f817f5935 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -158,6 +158,7 @@ struct nvmet_port {
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
+	struct key			*keyring;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index b53b1163e75b..26c911ddc2de 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -8,9 +8,13 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/key.h>
 #include <linux/nvme-tcp.h>
+#include <linux/nvme-keyring.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/tls.h>
+#include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
 #include <crypto/hash.h>
@@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
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
@@ -122,6 +136,7 @@ struct nvmet_tcp_cmd {
 
 enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_CONNECTING,
+	NVMET_TCP_Q_TLS_HANDSHAKE,
 	NVMET_TCP_Q_LIVE,
 	NVMET_TCP_Q_DISCONNECTING,
 };
@@ -154,6 +169,8 @@ struct nvmet_tcp_queue {
 	bool			data_digest;
 	struct ahash_request	*snd_hash;
 	struct ahash_request	*rcv_hash;
+	struct key		*tls_psk;
+	struct delayed_work	tls_handshake_work;
 
 	unsigned long           poll_end;
 
@@ -1486,6 +1503,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
+	key_put(queue->tls_psk);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 	page = virt_to_head_page(queue->pf_cache.va);
 	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
@@ -1500,8 +1518,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 
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
 
@@ -1609,6 +1631,89 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static void nvmet_tcp_tls_queue_reset(struct nvmet_tcp_queue *queue)
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
+	pr_debug("queue %d: resetting queue callbacks after TLS handshake\n",
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
+		nvmet_tcp_tls_queue_reset(queue);
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
+	args.ta_keyring = key_serial(queue->port->nport->keyring);
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
@@ -1626,7 +1731,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->port = port;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
-	queue->state = NVMET_TCP_Q_CONNECTING;
+	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
+	    NVMF_TCP_SECTYPE_TLS13)
+		queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+	else
+		queue->state = NVMET_TCP_Q_CONNECTING;
 	INIT_LIST_HEAD(&queue->free_list);
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
@@ -1657,6 +1766,25 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	INIT_DELAYED_WORK(&queue->tls_handshake_work,
+			  nvmet_tcp_tls_handshake_timeout_work);
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
+
 	ret = nvmet_tcp_set_queue_sock(queue);
 	if (ret)
 		goto out_destroy_sq;
-- 
2.35.3


