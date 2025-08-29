Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D243CA1006
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWTueWNLF+u+N6GydEfmJr0LuAPAujwuyY/GBUTIT+0=; b=DWjrEdAW4UN4ziGLTjI8XVu5Oq
	DhI7nDQQLxoqdkvlTLtG9g9105t7r0dOZ3S4o4/jEHYKp38ibVVw13bqkq394WZoRRYhalNL+aqIi
	nFUJ5A6ExqmqQdpVKLn0jinHvafoS5a2l7Tf2ia6rmPwFFnIHASDiG62s2ow7uU/hFaqdp6rWbPfv
	BafFrOsRmdBdAa3YDbrx2ImFKC09PRlu0Xgrhc8Imc35rc+wEOQArkYvIT22qD02WdSaAcvXN7OpN
	bwy/esF3If0XVv6xqPMKFS+LylOnpZ6KOxk1iWTaontlgylzeS3HjLENqHmb43YMbgD6G3mWvwzgw
	+r1rfWfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us4tM-00000006l2E-3ARF;
	Fri, 29 Aug 2025 19:36:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us1Ad-00000006DsD-10yB
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:37:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E2B6B45560;
	Fri, 29 Aug 2025 15:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD34C4CEF5;
	Fri, 29 Aug 2025 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481862;
	bh=jOI5q3SLcBs+QZqt5jDcPT92riWlRIK70SQlJd0iU9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A6QYG25ONY8hVufJssfXNil6CZxQms/EnL1n1pWE9PBrzTc0NTLlEU9IkJvEr7Pjh
	 f9G2XGTFUFAyvRDxVJctBr3wHPcVybksPycmqbm9GagvCgibp59JcxNSjKjNc9L//x
	 7Tmq9HZpw4C0aNHWnbzV8A1MCuwU2ik5MI2JfISlfrihaRjIYXy+OYUPjxZZ/kWAe9
	 iErEjnRdP2w7fJXpLxqJQr6sQW0n/r7DpbwEJU1fU6/82xOn10+qLTaGJu5nxaVC99
	 JBnXs9k0dIsA/9lzbVezqgLWUxYJ6EgFaqQU2X0uuH5ps68mrwuxZX1JYzcZGQcT6c
	 lEbrP2/7uD+eA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:37:28 +0200
Subject: [PATCH v3 4/4] nvme-fc: wait for initial connect attempt to finish
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-nvme-fc-sync-v3-4-d69c87e63aee@kernel.org>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_083743_331838_9D3A91D8 
X-CRM114-Status: GOOD (  19.23  )
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

The TCP and RDMA transport are doing synchronous connects. Thus the
write to /dev/nvme-fabrics blocks and will return either success or
fail. The FC transport offloads the connect attempt to a workqueue and
thus it's an asynchronous operation. The write will succeeds even though
the connection attempt is ongoing.

This async connect feature was introduced to mitigate problems with
transient connect errors and the task to coordinate retries with
userspace (nvme-cli).

Unfortunately, this makes the transports behave differently. Streamline
nvme-fc to wait for the initial connection attempt.

In order to support also the async connection attempt introduce a new
flag for userspace, which is an opt-in feature. This avoids breaking
existing users which are not ready for the FC transport behavior change.

Link: https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fabrics.c | 18 +++++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/fc.c      | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index cb9311c399856de54a2e4d41d41d295dd1aef31e..73e7a1e7925ef2e8ad633e8e2bd36207181dcbb6 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -709,6 +709,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TLS,			"tls"			},
 	{ NVMF_OPT_CONCAT,		"concat"		},
 #endif
+	{ NVMF_OPT_CONNECT_ASYNC,	"connect_async=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -738,6 +739,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
 	opts->concat = false;
+	/* keep backward compatibility with older nvme-cli */
+	opts->connect_async = true;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1064,6 +1067,19 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->concat = true;
 			break;
+		case NVMF_OPT_CONNECT_ASYNC:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0 || token > 1) {
+				pr_err("Invalid connect_async %d value\n",
+				       token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->connect_async = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1316,7 +1332,7 @@ EXPORT_SYMBOL_GPL(nvmf_ctrl_options_put);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_CONNECT_ASYNC)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index bcc1d5f97ee5a03852830bf3ba0a15f82c7c2c03..9015bb3f63e1d0c412cf4af5194a42411fbb516c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
 	NVMF_OPT_CONCAT		= 1 << 28,
+	NVMF_OPT_CONNECT_ASYNC	= 1 << 29,
 };
 
 /**
@@ -111,6 +112,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @connect_async: Don't wait for the initial connect attempt to succeed or fail
  */
 struct nvmf_ctrl_options {
 	struct kref		ref;
@@ -142,6 +144,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			connect_async;
 };
 
 int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5d9e193bd2525ae1a2f08e2a0a16ca41e08a7304..ccd67acb55e216602010933914afca77248b3de0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -148,6 +148,7 @@ struct nvme_fc_rport {
 #define ASSOC_ACTIVE		0
 #define ASSOC_FAILED		1
 #define FCCTRL_TERMIO		2
+#define INITIAL_SYNC_CONNECT	3
 
 struct nvme_fc_ctrl {
 	spinlock_t		lock;
@@ -168,6 +169,7 @@ struct nvme_fc_ctrl {
 
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
+	struct completion	connect_completion;
 
 	struct kref		ref;
 	unsigned long		flags;
@@ -829,6 +831,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
+			complete(&ctrl->connect_completion);
 			nvme_fc_ctrl_put(ctrl);
 		} else
 			nvme_fc_ctrl_connectivity_loss(ctrl);
@@ -3253,6 +3256,9 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
 		return;
 
+	if (test_bit(INITIAL_SYNC_CONNECT, &ctrl->flags))
+		goto delete;
+
 	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
@@ -3294,6 +3300,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 					   (ctrl->ctrl.opts->max_reconnects *
 					    ctrl->ctrl.opts->reconnect_delay)));
 
+delete:
+	complete(&ctrl->connect_completion);
 	nvme_fc_ctrl_put(ctrl);
 }
 
@@ -3353,10 +3361,14 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
-	else
+	else {
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: controller connect complete\n",
 			ctrl->cnum);
+		pr_info("%s:%d clear initial sync connect bit\n", __func__, __LINE__);
+		clear_bit(INITIAL_SYNC_CONNECT, &ctrl->flags);
+		complete(&ctrl->connect_completion);
+	}
 }
 
 
@@ -3461,6 +3473,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	init_completion(&ctrl->connect_completion);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
@@ -3539,6 +3552,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	if (!opts->connect_async) {
+		pr_info("%s:%d set initial connect bit\n", __func__, __LINE__);
+		set_bit(INITIAL_SYNC_CONNECT, &ctrl->flags);
+		nvme_fc_ctrl_get(ctrl);
+	}
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
@@ -3554,6 +3573,20 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	flush_delayed_work(&ctrl->connect_work);
 
+	if (!opts->connect_async) {
+		enum nvme_ctrl_state state;
+
+		wait_for_completion(&ctrl->connect_completion);
+		state = nvme_ctrl_state(&ctrl->ctrl);
+		nvme_fc_ctrl_put(ctrl);
+
+		if (state != NVME_CTRL_LIVE) {
+			/* Cleanup is handled by the connect state machine */
+			pr_info("%s:%d ctrl state %d\n", __func__, __LINE__, state);
+			return ERR_PTR(-EIO);
+		}
+	}
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
 		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
@@ -3895,6 +3928,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);

-- 
2.51.0


