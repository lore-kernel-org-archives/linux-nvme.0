Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3ABC04A6A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baDtgzBMJX6grWKglHZjX5XPBdTzthTUOG7t+NXZxYU=; b=uBNG06Bek7IJwkHZzP++gE2gou
	lEXSXKCUQPNnIYy4BeOUWy6Jolh2ZhmfolfVI4U/zlARaM1OBHHZR/L25Zh5ytAu93ct0Cyddhao+
	Wf3XCp+xy4ZtsoWizdDz3fytnVXGG/8D/g/i5FjWda30Q5zySNaN4Wyo3S3ysduASnGdmDoPs4YjD
	IfQHCQ86/neUkuvfgwXUTRz96zHGPEoPiX1XFbXWHSh24aDkFxmqP/7cgso4bQs5Z+4/EDGXO7MMy
	QcRgfQvMLcgVwbdSPtxGG/q2sxFa7dddUm1CyLnMEOf4MGAencrUyUT4jzBwkovCvBSQ5yx/jDBaV
	vQ2gt3yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5v-00AZ9u-0d;
	Fri, 11 Aug 2023 12:18:19 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5l-00AZ1E-25
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 12:18:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 281B81F890;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691756286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baDtgzBMJX6grWKglHZjX5XPBdTzthTUOG7t+NXZxYU=;
	b=XWGZAxhDjCXez9wbZEvbHsceCYY0JU4GsdWKUD8CBO09hO/W02O/T/JvKODnOKgHqMoevT
	giJf5r1ml0K+Z1csBZDIiTJPsuAPHZgqbfUwU6al44LkY79+MgjTbhYSUOIKEv04xWqOMd
	Xd3u38/bUxOb2e2o1mJJyB8kfaP6SAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691756286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baDtgzBMJX6grWKglHZjX5XPBdTzthTUOG7t+NXZxYU=;
	b=3bcr3qjWIF8vSXj1ZboJSgfXfM2p9DpjLBL4PY0W79yfhXAmpXRFFrCdYJ5Thtz7ZrEKip
	C7zsyFjKs1Xpk9CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 13D6D2C152;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0CDBC51CAEF4; Fri, 11 Aug 2023 14:18:06 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/17] nvme-tcp: enable TLS handshake upcall
Date: Fri, 11 Aug 2023 14:17:46 +0200
Message-Id: <20230811121755.24715-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811121755.24715-1-hare@suse.de>
References: <20230811121755.24715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_051809_969831_71C08C1A 
X-CRM114-Status: GOOD (  26.20  )
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

Add a fabrics option 'tls' and start the TLS handshake upcall
with the default PSK. When TLS is started the PSK key serial
number is displayed in the sysfs attribute 'tls_key'

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/Kconfig   |  15 ++++
 drivers/nvme/host/core.c    |   2 +-
 drivers/nvme/host/fabrics.c |  12 ++++
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/nvme.h    |   1 +
 drivers/nvme/host/sysfs.c   |  21 ++++++
 drivers/nvme/host/tcp.c     | 137 ++++++++++++++++++++++++++++++++++--
 7 files changed, 184 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2f6a7f8c94e8..a517030d7d50 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -92,6 +92,21 @@ config NVME_TCP
 
 	  If unsure, say N.
 
+config NVME_TCP_TLS
+	bool "NVMe over Fabrics TCP TLS encryption support"
+	depends on NVME_TCP
+	select NVME_COMMON
+	select NVME_KEYRING
+	select NET_HANDSHAKE
+	select KEYS
+	help
+	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
+
+	  The TLS handshake daemon is availble at
+	  https://github.com/oracle/ktls-utils.
+
+	  If unsure, say N.
+
 config NVME_AUTH
 	bool "NVM Express over Fabrics In-Band Authentication"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfc574d0f18d..b52e9c9bffd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4380,7 +4380,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-
+	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8175d49f2909..ddad482c3537 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -647,6 +647,9 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
 	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
+#ifdef CONFIG_NVME_TCP_TLS
+	{ NVMF_OPT_TLS,			"tls"			},
+#endif
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -671,6 +674,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->tls = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -955,6 +959,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			kfree(opts->dhchap_ctrl_secret);
 			opts->dhchap_ctrl_secret = p;
 			break;
+		case NVMF_OPT_TLS:
+			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->tls = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 82e7a27ffbde..dac17c3fee26 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -70,6 +70,7 @@ enum {
 	NVMF_OPT_DISCOVERY	= 1 << 22,
 	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
 	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
+	NVMF_OPT_TLS		= 1 << 25,
 };
 
 /**
@@ -102,6 +103,7 @@ enum {
  * @dhchap_secret: DH-HMAC-CHAP secret
  * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
  *              authentication
+ * @tls:        Start TLS encrypted connections (TCP)
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
@@ -128,6 +130,7 @@ struct nvmf_ctrl_options {
 	struct nvmf_host	*host;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
+	bool			tls;
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..6fe7966f720b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -357,6 +357,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
+	struct key *tls_key;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d298..d0966159981c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -527,6 +527,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+#ifdef CONFIG_NVME_TCP_TLS
+static ssize_t tls_key_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (!ctrl->tls_key)
+		return 0;
+	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
+}
+static DEVICE_ATTR_RO(tls_key);
+#endif
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -553,6 +566,9 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+#endif
+#ifdef CONFIG_NVME_TCP_TLS
+	&dev_attr_tls_key.attr,
 #endif
 	NULL
 };
@@ -583,6 +599,11 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
+#ifdef CONFIG_NVME_TCP_TLS
+	if (a == &dev_attr_tls_key.attr &&
+	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
+#endif
 
 	return a->mode;
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 324d3bce65b8..b50753903194 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
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
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
@@ -31,6 +35,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#ifdef CONFIG_NVME_TCP_TLS
+/*
+ * TLS handshake timeout
+ */
+static int tls_handshake_timeout = 10;
+module_param(tls_handshake_timeout, int, 0644);
+MODULE_PARM_DESC(tls_handshake_timeout,
+		 "nvme TLS handshake timeout in seconds (default 10)");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -146,7 +160,10 @@ struct nvme_tcp_queue {
 	struct ahash_request	*snd_hash;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
-
+#ifdef CONFIG_NVME_TCP_TLS
+	struct completion       tls_complete;
+	int                     tls_err;
+#endif
 	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
@@ -1509,7 +1526,91 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
+#ifdef CONFIG_NVME_TCP_TLS
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+{
+	struct nvme_tcp_queue *queue = data;
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+	int qid = nvme_tcp_queue_id(queue);
+	struct key *tls_key;
+
+	dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, status %d\n",
+		qid, pskid, status);
+
+	if (status) {
+		queue->tls_err = -status;
+		goto out_complete;
+	}
+
+	tls_key = key_lookup(pskid);
+	if (IS_ERR(tls_key)) {
+		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
+			 qid, pskid);
+		queue->tls_err = -ENOKEY;
+	} else {
+		ctrl->ctrl.tls_key = tls_key;
+		queue->tls_err = 0;
+	}
+
+out_complete:
+	complete(&queue->tls_complete);
+}
+
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+	struct tls_handshake_args args;
+	unsigned long tmo = tls_handshake_timeout * HZ;
+	key_serial_t keyring = nvme_keyring_id();
+
+	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
+		qid, pskid);
+	memset(&args, 0, sizeof(args));
+	args.ta_sock = queue->sock;
+	args.ta_done = nvme_tcp_tls_done;
+	args.ta_data = queue;
+	args.ta_my_peerids[0] = pskid;
+	args.ta_num_peerids = 1;
+	args.ta_keyring = keyring;
+	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	queue->tls_err = -EOPNOTSUPP;
+	init_completion(&queue->tls_complete);
+	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	if (ret) {
+		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
+			qid, ret);
+		return ret;
+	}
+	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, tmo);
+	if (ret == 0) {
+		dev_err(nctrl->device,
+			"queue %d: TLS handshake timeout\n", qid);
+		ret = -ETIMEDOUT;
+	} else if (ret < 0) {
+		dev_err(nctrl->device,
+			"queue %d: TLS handshake interrupted\n", qid);
+	} else {
+		dev_dbg(nctrl->device,
+			"queue %d: TLS handshake complete, error %d\n",
+			qid, queue->tls_err);
+		ret = queue->tls_err;
+	}
+	return ret;
+}
+#else
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid)
+{
+	return -EPROTONOSUPPORT;
+}
+#endif
+
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
+				key_serial_t pskid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1632,6 +1733,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_rcv_pdu;
 	}
 
+	/* If PSKs are configured try to start TLS */
+	if (pskid) {
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		if (ret)
+			goto err_init_connect;
+	}
+
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
@@ -1781,10 +1889,22 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
 static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
+	key_serial_t pskid = 0;
+
+	if (ctrl->opts->tls) {
+		pskid = nvme_tls_psk_default(NULL,
+					      ctrl->opts->host->nqn,
+					      ctrl->opts->subsysnqn);
+		if (!pskid) {
+			dev_err(ctrl->device, "no valid PSK found\n");
+			ret = -ENOKEY;
+			goto out_free_queue;
+		}
+	}
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
+	ret = nvme_tcp_alloc_queue(ctrl, 0, pskid);
 	if (ret)
-		return ret;
+		goto out_free_queue;
 
 	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
 	if (ret)
@@ -1801,8 +1921,13 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
+	if (ctrl->opts->tls && !ctrl->tls_key) {
+		dev_err(ctrl->device, "no PSK negotiated\n");
+		return -ENOKEY;
+	}
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
+		ret = nvme_tcp_alloc_queue(ctrl, i,
+				key_serial(ctrl->tls_key));
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2629,7 +2754,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.35.3


