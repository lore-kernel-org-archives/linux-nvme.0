Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0943C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hdn2+rwk1xMaWaZpyj2mrWBlCLW1KaA0MuIjpVMJxUU=; b=2sfLI+SMtJTjKZ2HAQ2WgnAjqk
	Ood+g+dPvq0fFoJ/q09pPz6Opq/+n9yaghr6BQBIl0bcB1EwqTeTZ1N1fCY5dK6Uv/NS7MResWc8f
	ZB1ZSRyTbHWO4HOztDfIqEkMhYdJS2nu/AktRZHsK3J89j2ut/JZ6VMheqX1Pni7aaU7Nzb65yE+Z
	/7OKoXu1ma/jJfE41uguiqNRLi8KKuuAcSdZKM8mnYAB6TfS2lZklL7wTjBrxDUImXNmdYtrgq1OR
	woqJEd2Gd+xEwWRpIyi/ugdRJf9BylOmgtk4hiwZDzJawUSIA9WyYj4Y+FDqwJu59mNjp1aRPDP5o
	sfAdYsKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVcK-00GuyW-1h;
	Mon, 14 Aug 2023 11:20:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVc7-00GulO-0b
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 11:20:01 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 36C931FD69;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hdn2+rwk1xMaWaZpyj2mrWBlCLW1KaA0MuIjpVMJxUU=;
	b=u3H90X3SMVvz8LtL91CyQcUeup6o74qyrwPmtTReX+/4TORCfaKGbonqpRvug+WU0E/qhA
	NYR9oYweFb0lNxJkBzuICfO4uEoY0ST9P0Ni4eFilAGOTERvldV/YG2A9oyJmORnYmWd5E
	CKQzRNf2DH8VLzS/80CsoYp5OyQBv7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hdn2+rwk1xMaWaZpyj2mrWBlCLW1KaA0MuIjpVMJxUU=;
	b=AardMdmh7D3p7+9/R99xLJ9ktvVQaXAB4S4OnmpT8IVGPm/cwcY0I+SgZNmaLJE/aFzarJ
	MNqSbi1CxFMU9iDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 245442C16D;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2056151CB0D3; Mon, 14 Aug 2023 13:19:52 +0200 (CEST)
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
Subject: [PATCH 10/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Date: Mon, 14 Aug 2023 13:19:36 +0200
Message-Id: <20230814111943.68325-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_041959_391001_36916438 
X-CRM114-Status: GOOD (  17.01  )
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

Parse the fabrics options 'keyring' and 'tls_key' and store the
referenced keys in the options structure.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 52 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.h |  6 +++++
 drivers/nvme/host/tcp.c     | 14 +++++++---
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ddad482c3537..e453c3871cb1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -622,6 +622,23 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 	return NULL;
 }
 
+static struct key *nvmf_parse_key(int key_id, char *key_type)
+{
+	struct key *key;
+
+	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+		pr_err("TLS is not supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	key = key_lookup(key_id);
+	if (IS_ERR(key))
+		pr_err("%s %08x not found\n", key_type, key_id);
+	else
+		pr_debug("Using %s %08x\n", key_type, key_id);
+	return key;
+}
+
 static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
 	{ NVMF_OPT_TRADDR,		"traddr=%s"		},
@@ -643,6 +660,10 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+#ifdef CONFIG_NVME_TCP_TLS
+	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
+	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
+#endif
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
@@ -660,9 +681,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	char *options, *o, *p;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
-	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
+	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
 	uuid_t hostid;
 	char hostnqn[NVMF_NQN_SIZE];
+	struct key *key;
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -928,6 +950,32 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+		case NVMF_OPT_KEYRING:
+			if (match_int(args, &key_id) || key_id <= 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+			key = nvmf_parse_key(key_id, "Keyring");
+			if (IS_ERR(key)) {
+				ret = PTR_ERR(key);
+				goto out;
+			}
+			key_put(opts->keyring);
+			opts->keyring = key;
+			break;
+		case NVMF_OPT_TLS_KEY:
+			if (match_int(args, &key_id) || key_id <= 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+			key = nvmf_parse_key(key_id, "Key");
+			if (IS_ERR(key)) {
+				ret = PTR_ERR(key);
+				goto out;
+			}
+			key_put(opts->tls_key);
+			opts->tls_key = key;
+			break;
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
@@ -1168,6 +1216,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 void nvmf_free_options(struct nvmf_ctrl_options *opts)
 {
 	nvmf_host_put(opts->host);
+	key_put(opts->keyring);
+	key_put(opts->tls_key);
 	kfree(opts->transport);
 	kfree(opts->traddr);
 	kfree(opts->trsvcid);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dac17c3fee26..fbaee5a7be19 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -71,6 +71,8 @@ enum {
 	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
 	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
 	NVMF_OPT_TLS		= 1 << 25,
+	NVMF_OPT_KEYRING	= 1 << 26,
+	NVMF_OPT_TLS_KEY	= 1 << 27,
 };
 
 /**
@@ -103,6 +105,8 @@ enum {
  * @dhchap_secret: DH-HMAC-CHAP secret
  * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
  *              authentication
+ * @keyring:    Keyring to use for key lookups
+ * @tls_key:    TLS key for encrypted connections (TCP)
  * @tls:        Start TLS encrypted connections (TCP)
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
@@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
 	struct nvmf_host	*host;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
+	struct key		*keyring;
+	struct key		*tls_key;
 	bool			tls;
 	bool			disable_sqflow;
 	bool			hdr_digest;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e8e408dbb6ad..2677d6f2b54e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1583,6 +1583,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 
 	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
 		qid, pskid);
+	if (nctrl->opts->keyring)
+		keyring = key_serial(nctrl->opts->keyring);
 	memset(&args, 0, sizeof(args));
 	args.ta_sock = queue->sock;
 	args.ta_done = nvme_tcp_tls_done;
@@ -1908,9 +1910,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	key_serial_t pskid = 0;
 
 	if (ctrl->opts->tls) {
-		pskid = nvme_tls_psk_default(NULL,
-					      ctrl->opts->host->nqn,
-					      ctrl->opts->subsysnqn);
+		if (ctrl->opts->tls_key)
+			pskid = key_serial(ctrl->opts->tls_key);
+		else
+			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
+						      ctrl->opts->host->nqn,
+						      ctrl->opts->subsysnqn);
 		if (!pskid) {
 			dev_err(ctrl->device, "no valid PSK found\n");
 			ret = -ENOKEY;
@@ -2770,7 +2775,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.35.3


