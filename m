Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC969C77B6C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qG+hQp3mvVjom23LaPWsXAZsLpjQhSfnvg8Qq8X97zM=; b=dew3PHsRKBMI+WWtaixjUwEZFd
	qoJNmHiZgnCXJN/FJZy0uUB5LqF+tVdFDYEuQpUHrpaNcuf+UpF1CgNkL7LdRB7v0tUN4JiluW7w1
	TVaFaSLclwmizcSEsCRywUDRROcMxrrpQAWP/NN7GM+YRwuWpW7Q7qPzIRrvU4gLQjOk9Q3rIR6Ee
	3haSLvOk8zEvaWIqjm6ZQQdlVhLWWX11jOhsaUYJF8c0s1q26U6F5tpXvUgm6hHEGNQNptxonj4jf
	Ku/t6jtmIOiRiS5dza6kY8rKhvRFiRe8FCojPJQ5rH8jaOzqJNcubIEo91trmT4Iirj6c3syEdFKj
	vG/m+YBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLT-000Uvq-1J;
	Wed, 29 Mar 2023 14:00:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLG-000Uk5-0P
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:01 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C89C11FDF3;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qG+hQp3mvVjom23LaPWsXAZsLpjQhSfnvg8Qq8X97zM=;
	b=TTXcrONgGjs5Lez22kPKhtDft4V7E1s+Le0WjGEUsMkHI7VisUExPr58Q4AMfGJrzVBoGE
	ZTBg8vlURSoFQc1xvWNISCoqdFWY4UOd2iQw12fnqFFSElCr8uw1/1VzA7QRaCSri55O6u
	lTx2+UDHHXdSlWBT6xZCm8bVz5V/Iko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qG+hQp3mvVjom23LaPWsXAZsLpjQhSfnvg8Qq8X97zM=;
	b=iK3ouSWmQNEkiPdfcQuoMJyum6XCJ7f7m/wR5+CkITN2f3h/4OP6BmlslvtGLAMeiRCs7F
	hThjXmdyRwW2vXDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B63552C17A;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B3C9751BF384; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/18] nvme-tcp: enable TLS handshake upcall
Date: Wed, 29 Mar 2023 15:59:29 +0200
Message-Id: <20230329135938.46905-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065958_477197_B8E0A9EB 
X-CRM114-Status: GOOD (  26.02  )
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
 drivers/nvme/host/core.c    |  25 ++++++-
 drivers/nvme/host/fabrics.c |  11 +++
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/nvme.h    |   4 +-
 drivers/nvme/host/tcp.c     | 141 ++++++++++++++++++++++++++++++++++--
 5 files changed, 174 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 416d0a898f56..869396058e2e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3901,6 +3901,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+#ifdef CONFIG_NVME_TLS
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
@@ -3927,6 +3940,9 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+#endif
+#ifdef CONFIG_NVME_TLS
+	&dev_attr_tls_key.attr,
 #endif
 	NULL
 };
@@ -3956,6 +3972,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
+#endif
+#ifdef CONFIG_NVME_TLS
+	if (a == &dev_attr_tls_key.attr && !ctrl->opts)
+		return 0;
 #endif
 	return a->mode;
 }
@@ -5094,7 +5114,10 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-
+#ifdef CONFIG_NVME_TLS
+	if (ctrl->tls_key)
+		key_put(ctrl->tls_key);
+#endif
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..3e4f0e45b58f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
 	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
+	{ NVMF_OPT_TLS,			"tls"			},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -632,6 +633,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->tls = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -918,6 +920,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			kfree(opts->dhchap_ctrl_secret);
 			opts->dhchap_ctrl_secret = p;
 			break;
+		case NVMF_OPT_TLS:
+#ifdef CONFIG_NVME_TLS
+			opts->tls = true;
+			break;
+#else
+			pr_err("TLS is not supported\n");
+			ret = -EINVAL;
+			goto out;
+#endif
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
index bf46f122e9e1..421d01f849d1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -347,7 +347,9 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
-
+#ifdef CONFIG_NVME_TLS
+	struct key *tls_key;
+#endif
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 	bool apst_enabled;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fddf785aba74..fdb564d0b9f4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -8,9 +8,15 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#ifdef CONFIG_NVME_TLS
+#include <linux/nvme-keyring.h>
+#include <net/tls.h>
+#include <net/handshake.h>
+#endif
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
@@ -31,6 +37,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#ifdef CONFIG_NVME_TLS
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
@@ -147,7 +163,10 @@ struct nvme_tcp_queue {
 	struct ahash_request	*snd_hash;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
-
+#ifdef CONFIG_NVME_TLS
+	struct completion       *tls_complete;
+	int                     tls_err;
+#endif
 	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
@@ -1503,7 +1522,80 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
+#ifdef CONFIG_NVME_TLS
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t peerid)
+{
+	struct nvme_tcp_queue *queue = data;
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+	int qid = nvme_tcp_queue_id(queue);
+
+	dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, status %d\n",
+		qid, peerid, status);
+
+	if (status)
+		queue->tls_err = -status;
+	else {
+		struct key *tls_key = key_lookup(peerid);
+		if (IS_ERR(tls_key)) {
+			dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
+				 qid, peerid);
+			queue->tls_err = -ENOKEY;
+		} else {
+			ctrl->ctrl.tls_key = tls_key;
+			queue->tls_err = 0;
+		}
+	}
+
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
+	key_serial_t keyring = nvme_keyring_id();
+
+	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
+		qid, peerid);
+	args.ta_sock = queue->sock;
+	args.ta_done = nvme_tcp_tls_done;
+	args.ta_data = queue;
+	args.ta_my_peerids[0] = peerid;
+	args.ta_num_peerids = 1;
+	args.ta_keyring = keyring;
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
+	return ret;
+}
+#endif
+
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
+				key_serial_t peerid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1627,6 +1719,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_rcv_pdu;
 	}
 
+#ifdef CONFIG_NVME_TLS
+	/* If PSKs are configured try to start TLS */
+	if (peerid) {
+		ret = nvme_tcp_start_tls(nctrl, queue, peerid);
+		if (ret)
+			goto err_init_connect;
+	}
+#endif
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
@@ -1771,10 +1871,23 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
 static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
-
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
+	key_serial_t psk_id = 0;
+
+#ifdef CONFIG_NVME_TLS
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
+#endif
+	ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
 	if (ret)
-		return ret;
+		goto out_free_queue;
 
 	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
 	if (ret)
@@ -1790,9 +1903,21 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
-
+	key_serial_t psk_id = 0;
+
+#ifdef CONFIG_NVME_TLS
+	if (ctrl->opts->tls) {
+		psk_id = nvme_tls_psk_default(NULL,
+					      ctrl->opts->host->nqn,
+					      ctrl->opts->subsysnqn);
+		if (!psk_id) {
+			dev_err(ctrl->device, "no valid PSK found\n");
+			return -ENOKEY;
+		}
+	}
+#endif
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
+		ret = nvme_tcp_alloc_queue(ctrl, i, psk_id);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2701,7 +2826,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.35.3


