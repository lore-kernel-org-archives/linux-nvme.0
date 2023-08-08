Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D9EC04FDF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xn0/wuy8LoiFMjNoLkRM5U/WkJaSqRBFMamX6Rc9UrU=; b=YnFxgPCH/7uCxUIa9lmQFe3Ios
	QJ8by2+zQLpvPwS7wLw2h64cuPTE23r7GC4HQw3MoE8hpat5ifZLmEIX5lVtQ8/72AaqynQVM5dYN
	Vi3aDgPlRoxvvp2652KoN+uoLSirITwS+NbccGFwN4DkQIeDgSkSu0TYwExm71eP0x9TYeq6yRy9M
	WffhwxGtMMFcUZnewmVqhT5MiyQG9yQtKoqqNRoblWHH9hYTW83Dl9XHPO/VfZCDbx2XxZx/RZ4Fn
	0f1lHI6rmGtfSuEQ9aXPMV0VuTCVZhz6205mNFoqk/8SE8buM3/BzJMYlRdXsCmjuaFXik2ouZR9C
	JXfHPV6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyc-0032GG-1z;
	Tue, 08 Aug 2023 16:54:34 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyM-00320K-2u
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 16:54:22 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7367120312;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691513648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn0/wuy8LoiFMjNoLkRM5U/WkJaSqRBFMamX6Rc9UrU=;
	b=FDmyckPrNPJYhV0mJAdygu2SVcod6x0oJPp/oA3YhdUdUFonOXiwk7uPaA1yVDA+sI7Cx7
	Xy1C9t1yc3qOM/k4NjrojCRK2Gfp8E3Tt1I3ALukLWGtyfB3gz/tg4cvHZtVc525TbuPnu
	8sfsH6WOJtC8JhwdmtSuLaTcdoLf7BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691513648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn0/wuy8LoiFMjNoLkRM5U/WkJaSqRBFMamX6Rc9UrU=;
	b=k0fWOGg3LxomhV344YKkxaPCLWC+86k1W+u7yBWlxCtDevjPLhMzg1Bd4BUZAJROYbZDaV
	OGAheEhDe5RzXXAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 668B82C161;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 630AC51CAD03; Tue,  8 Aug 2023 18:54:08 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Date: Tue,  8 Aug 2023 18:53:53 +0200
Message-Id: <20230808165354.123499-16-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230808165354.123499-1-hare@suse.de>
References: <20230808165354.123499-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_095419_123409_BE0A823D 
X-CRM114-Status: GOOD (  23.12  )
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
And move the 'state' lock to an irq-safe lock as the 'done'
callback from the TLS handshake will be running in interrupt
context.

Signed-off-by: Hannes Reincke <hare@suse.de>
---
 drivers/nvme/target/Kconfig    |  15 ++++
 drivers/nvme/target/configfs.c |  27 ++++++++
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 123 +++++++++++++++++++++++++++++++--
 4 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 79fc64035ee3..8a6c9cae804c 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -84,6 +84,21 @@ config NVME_TARGET_TCP
 
 	  If unsure, say N.
 
+config NVME_TARGET_TCP_TLS
+	bool "NVMe over Fabrics TCP target TLS encryption support"
+	depends on NVME_TARGET_TCP
+	select NVME_COMMON
+	select NVME_KEYRING
+	select NET_HANDSHAKE
+	select KEYS
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
index 3c2aeb763e22..49b407702ad5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -15,6 +15,7 @@
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
 #endif
+#include <linux/nvme-keyring.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
 
@@ -204,6 +205,14 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 
 found:
 	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+			pr_err("TLS is not supported\n");
+			return -EINVAL;
+		}
+		if (!port->keyring) {
+			pr_err("TLS keyring not configured\n");
+			return -EINVAL;
+		}
 		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
 			pr_warn("cannot change TREQ when TLS is not enabled\n");
 			return -EINVAL;
@@ -399,6 +408,15 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
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
@@ -1825,6 +1843,7 @@ static void nvmet_port_release(struct config_item *item)
 	flush_workqueue(nvmet_wq);
 	list_del(&port->global_entry);
 
+	key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
 }
@@ -1874,6 +1893,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
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
index 8cfd60f3b564..7f9ae53c1df5 100644
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
index a8ceef6e5a7b..75e4cb4c2f29 100644
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
+static int tls_handshake_timeout = 10;
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
+	key_serial_t		tls_pskid;
+	struct delayed_work	tls_handshake_work;
 
 	unsigned long           poll_end;
 
@@ -1285,12 +1302,12 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 
 static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 {
-	spin_lock(&queue->state_lock);
+	spin_lock_irq(&queue->state_lock);
 	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
 		queue_work(nvmet_wq, &queue->release_work);
 	}
-	spin_unlock(&queue->state_lock);
+	spin_unlock_irq(&queue->state_lock);
 }
 
 static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
@@ -1512,8 +1529,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 
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
 
@@ -1621,6 +1642,75 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static void nvmet_tcp_tls_handshake_done(void *data, int status,
+					 key_serial_t peerid)
+{
+	struct nvmet_tcp_queue *queue = data;
+
+	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
+		 queue->idx, peerid, status);
+	spin_lock_irq(&queue->state_lock);
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+		pr_warn("queue %d: TLS handshake already completed\n",
+			queue->idx);
+		spin_unlock_irq(&queue->state_lock);
+		return;
+	}
+	if (!status)
+		queue->tls_pskid = peerid;
+	queue->state = NVMET_TCP_Q_CONNECTING;
+	spin_unlock_irq(&queue->state_lock);
+
+	cancel_delayed_work_sync(&queue->tls_handshake_work);
+	if (status) {
+		nvmet_tcp_schedule_release_queue(queue);
+		return;
+	}
+
+	pr_debug("queue %d: resetting queue callbacks after TLS handshake\n",
+		 queue->idx);
+	nvmet_tcp_set_queue_sock(queue);
+}
+
+static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
+{
+	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
+			struct nvmet_tcp_queue, tls_handshake_work);
+
+	pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
+	nvmet_tcp_tls_handshake_done((void *)queue, ETIMEDOUT, 0);
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
+	memset(&args, 0, sizeof(args));
+	args.ta_sock = queue->sock;
+	args.ta_done = nvmet_tcp_tls_handshake_done;
+	args.ta_data = queue;
+	args.ta_keyring = key_serial(queue->port->nport->keyring);
+	args.ta_timeout_ms = tls_handshake_timeout * 1000;
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
@@ -1638,7 +1728,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
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
@@ -1669,6 +1763,25 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
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


