Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ACEC001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zn9O59n4EyhtBi2uiMOqS+NFwJftwB7B6uQqbpHFzkc=; b=3OAWwj9NNxpL1uR5LljavSsvAT
	wp+hWRrvSXG5z4rz2vFtPX6AHA2Y8BShhLm4vZ7eLtS+DO8PPxkrBMe6zH9EiIpn1kAOsEdktJcl1
	Z2Z7fIdEzHRCn9q1DHuFlEUt61BPu6ivryVXmkLwFQxaYVg3K9cZIWxwASmFMp7fZfjzxKQcUL25R
	aZor/cFZ6zGxaIds4iuAL/I0EnxEhDi8Qmz2n7zLSiHFZ20tAI0/pacRtL85hsvvHrV4IydTOtu79
	6E5yYk77nYiRN97kfGMIynsiY2Q9B11lo4fMn+0EZcc4/MVSXNkvHXFK4hX809Vocyb5oP0rY4j4m
	MHr0d3Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7Fj-007yRj-23;
	Thu, 10 Aug 2023 15:07:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FO-007y8U-1w
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 15:06:50 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 116A81F889;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn9O59n4EyhtBi2uiMOqS+NFwJftwB7B6uQqbpHFzkc=;
	b=uwzzV1ukya/hjJvzFUkq1i5NcL6mROfIlQnEk69DnqsxuFbrH+j8Rl6Ds5sdXQJP7DKtfU
	oe/ohXrXbZY36xxbA0jL9HJVXFhDdx9rdkWHKuImHI65t1hV2JwF1hlm34ZpUNUzTKeyAL
	FG2BFqNTqwPLsiq4s8FnK4XwUakYcBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn9O59n4EyhtBi2uiMOqS+NFwJftwB7B6uQqbpHFzkc=;
	b=4t5RZUYc7a0ZH72qZT9yFNCmi9Si1kkbc7btW3zdl0THjJ3BUbmDh5Gvr5wYuaX3kzwVz5
	pLfVXMmvBP478ADw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id EB9502C15C;
	Thu, 10 Aug 2023 15:06:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2061451CAE50; Thu, 10 Aug 2023 17:06:40 +0200 (CEST)
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
Date: Thu, 10 Aug 2023 17:06:23 +0200
Message-Id: <20230810150630.134991-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_080646_808366_3815FC83 
X-CRM114-Status: GOOD (  15.98  )
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
 drivers/nvme/host/fabrics.c | 49 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.h |  6 +++++
 drivers/nvme/host/tcp.c     | 11 ++++++---
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ddad482c3537..88246179e6b5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -643,6 +643,10 @@ static const match_table_t opt_tokens = {
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
@@ -660,9 +664,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -928,6 +933,46 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+		case NVMF_OPT_KEYRING:
+			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (match_int(args, &key_id) || key_id <= 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+			key = key_lookup(key_id);
+			if (IS_ERR(key)) {
+				pr_err("Keyring %08x not found\n", key_id);
+				ret = PTR_ERR(key);
+				goto out;
+			}
+			pr_debug("Using keyring %08x\n", key_serial(key));
+			key_put(opts->keyring);
+			opts->keyring = key;
+			break;
+		case NVMF_OPT_TLS_KEY:
+			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (match_int(args, &key_id) || key_id <= 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+			key = key_lookup(key_id);
+			if (IS_ERR(key)) {
+				pr_err("Key %08x not found\n", key_id);
+				ret = PTR_ERR(key);
+				goto out;
+			}
+			pr_debug("Using key %08x\n", key_serial(key));
+			key_put(opts->tls_key);
+			opts->tls_key = key;
+			break;
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
@@ -1168,6 +1213,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
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
index 5d373b089aca..2ca920579ef6 100644
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
@@ -1909,9 +1911,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
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
-- 
2.35.3


