Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52067C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ukof5/f324yim2LZGnztKk6lIIu7YaVb06Q6cbCsN+M=; b=im1RipH61tWkFofR7MoL6XHYVY
	cQcDx5NT6KBddWHMln3CQZiUvvBcA0yatM0wqUI0JezYWmj7bsXw2n7P2XztRGer2xBDMLPwmvoGv
	AfT8xGxCzI8acCmVEv6qGjhxiKBRfzH58M+LrmBfs+V7n6AAB2ghNuqD/lQDTfKrCuwz5AFyWNv/a
	RKf0LJCMUzqpFznk2LJs/JOfWdrMLquLo+xM3YaM5PvvxtMC7thLXDyDwChHXpQz+Y+Xey4mozcq0
	5x5FoJZytBmYk/UaoR+46v0gzEW6BmyklK8kalUt09dxcYD5jVrMfbETo09QzjSGLzHxe092X3k1b
	tICq47Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1l6-004IhW-0V;
	Wed, 19 Apr 2023 06:57:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1kr-004IWi-0M
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 06:57:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 582061FD8E;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681887438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ukof5/f324yim2LZGnztKk6lIIu7YaVb06Q6cbCsN+M=;
	b=exrJAesxx34SxIS/SXMncdeeCOR3xhe0LoBT7R3lAQw/tG8dwi4dvQ3l5FLYXEHzUuDKHD
	hduKDwjSCXEB0kr+HaLlmfb+vk3iRz6Gdvm4t6I2mcivT/sIqe4zFYqPnPNaHiAbKn2LcG
	l41g9/g96z5HEKs/lufibXlLXHcq/5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681887438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ukof5/f324yim2LZGnztKk6lIIu7YaVb06Q6cbCsN+M=;
	b=ErB+Jv0yTMlkuHWQRST4+v4U92XFtgJ3h/TUoHCev+9Ia/Md4wvzWn4vOUSR+HhGMHmiuW
	bVF8G/+HqSqSERAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 36A342C15B;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 266B451C26DD; Wed, 19 Apr 2023 08:57:18 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/17] nvme-tcp: enable TLS handshake upcall
Date: Wed, 19 Apr 2023 08:57:08 +0200
Message-Id: <20230419065714.52076-12-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419065714.52076-1-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_235725_333947_84885CE4 
X-CRM114-Status: GOOD (  26.89  )
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
 drivers/nvme/host/Kconfig   |  14 ++++
 drivers/nvme/host/core.c    |  23 ++++++-
 drivers/nvme/host/fabrics.c |  12 ++++
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/nvme.h    |   1 +
 drivers/nvme/host/tcp.c     | 129 ++++++++++++++++++++++++++++++++++--
 6 files changed, 174 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2f6a7f8c94e8..96a74041bb0a 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -92,6 +92,20 @@ config NVME_TCP
 
 	  If unsure, say N.
 
+config NVME_TCP_TLS
+	bool "NVMe over Fabrics TCP TLS encryption support"
+	depends on NVME_TCP
+	select NVME_COMMON
+	select NVME_KEYRING
+	select NET_HANDSHAKE
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
index 79aa215aec76..937013127c91 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3889,6 +3889,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
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
@@ -3915,6 +3928,9 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+#endif
+#ifdef CONFIG_NVME_TCP_TLS
+	&dev_attr_tls_key.attr,
 #endif
 	NULL
 };
@@ -3945,7 +3961,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
-
+#ifdef CONFIG_NVME_TCP_TLS
+	if (a == &dev_attr_tls_key.attr && !ctrl->opts)
+		return 0;
+#endif
 	return a->mode;
 }
 
@@ -5080,7 +5099,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-
+	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..2aa8fb991455 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -609,6 +609,9 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
 	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
+#ifdef CONFIG_NVME_TCP_TLS
+	{ NVMF_OPT_TLS,			"tls"			},
+#endif
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -632,6 +635,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->tls = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -918,6 +922,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
index dcac3df8a5f7..5db36e250e7a 100644
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
 	int			max_reconnects;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
+	bool			tls;
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..fbcc0ccf2ef2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -347,6 +347,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
+	struct key *tls_key;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9deba481ae6a..d25695cf4e03 100644
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
@@ -1502,7 +1519,79 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
+	if (wait_for_completion_timeout(&queue->tls_complete, tmo) == 0) {
+		dev_err(nctrl->device,
+			"queue %d: TLS handshake timeout\n", qid);
+		ret = -ETIMEDOUT;
+	} else {
+		dev_dbg(nctrl->device,
+			"queue %d: TLS handshake complete, error %d\n",
+			qid, queue->tls_err);
+		ret = queue->tls_err;
+	}
+	return ret;
+}
+#endif
+
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
+				key_serial_t pskid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1626,6 +1715,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_rcv_pdu;
 	}
 
+#ifdef CONFIG_NVME_TCP_TLS
+	/* If PSKs are configured try to start TLS */
+	if (pskid) {
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		if (ret)
+			goto err_init_connect;
+	}
+#endif
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
@@ -1769,10 +1866,22 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
 static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
+	key_serial_t psk_id = 0;
+
+	if (ctrl->opts->tls) {
+		psk_id = nvme_tls_psk_default(NULL,
+					      ctrl->opts->host->nqn,
+					      ctrl->opts->subsysnqn);
+		if (!psk_id) {
+			dev_err(ctrl->device, "no valid PSK found\n");
+			ret = -ENOKEY;
+			goto out_free_queue;
+		}
+	}
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
+	ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
 	if (ret)
-		return ret;
+		goto out_free_queue;
 
 	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
 	if (ret)
@@ -1788,9 +1897,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
+	key_serial_t psk_id = 0;
 
+	if (ctrl->opts->tls) {
+		if (!ctrl->tls_key) {
+			dev_err(ctrl->device, "no PSK negotiated\n");
+			return -ENOKEY;
+		}
+		psk_id = key_serial(ctrl->tls_key);
+	}
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
+		ret = nvme_tcp_alloc_queue(ctrl, i, psk_id);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2699,7 +2816,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.35.3


