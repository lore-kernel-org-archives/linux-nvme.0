Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B39C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkpxMGhY1MA5ByHnAK2jYlZ4UwNSE3Z7E6lf4DHHRnE=; b=Yl8TPV3pYfFp/npbMIwBu+n7Dd
	cVcKJoVLHQAXpHbmRkTNuXhUNycfSnSiSOvDC0Qmg7IC7d2RjHFt3e3RlBq6hjB+9R3/gpeewGSKm
	4OjZ7XmWcsGTYCHHJZGXjCQk8zMpDAXCtZqTtgHSz8H8uoeH3a3tZeQaX0PELZSDmhYHr6vCdFmC4
	mVUTmE9YGofmuFq+TptwbtMGaAe/t3BGGek2ak5sSOdkmw5H9RpG1Xfrri22yPrPRVdMZtSb2GuDL
	zvvPV0TFRFSbaHM1yU7PU4yqW9+LdLsyjnPNOajaxepaD84T4R7io7iWsnA0D2essZZWHZXd+NSz8
	uZWXwdoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1ky-004Ic6-1e;
	Wed, 19 Apr 2023 06:57:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1ko-004ITr-0t
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 06:57:25 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4E2551FD8A;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681887438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkpxMGhY1MA5ByHnAK2jYlZ4UwNSE3Z7E6lf4DHHRnE=;
	b=Gw5rE7yBN8T6tCeso4ggow6u5vDZ7kPamt5oNPgWNzdktj5kmGx8+U9MwQU+b6iQyZb2yJ
	zEBOE0cItOxJc5dQ3E64J0IRYqEWTBrSk8QemsYnLTNh6hF4wSSePs968+TyqJhnjYWoIa
	uNsw0KKsJtPOyyYmt4g/i+y/Xb4kzFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681887438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkpxMGhY1MA5ByHnAK2jYlZ4UwNSE3Z7E6lf4DHHRnE=;
	b=xCbhR6B+Kn7C2p09JcG52p/LPxOk9yKNrdYolJB9VK7GeRfhoo/1tlpM0WCTO+Lo+oSJz3
	L5LYO6jp2J63SVDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3AE982C15C;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 3687751C26E1; Wed, 19 Apr 2023 08:57:18 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Date: Wed, 19 Apr 2023 08:57:10 +0200
Message-Id: <20230419065714.52076-14-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419065714.52076-1-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_235722_569532_C803CBEB 
X-CRM114-Status: GOOD (  17.31  )
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
 drivers/nvme/host/fabrics.c | 69 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.h |  6 ++++
 drivers/nvme/host/tcp.c     | 11 ++++--
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2aa8fb991455..8fb80ccc38e1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -605,6 +605,10 @@ static const match_table_t opt_tokens = {
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
@@ -622,8 +626,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	char *options, *o, *p;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
-	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
+	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
 	uuid_t hostid;
+	struct key *key = NULL;
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -891,6 +896,66 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+		case NVMF_OPT_KEYRING:
+			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (match_int(args, &key_id)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (key_id < 0) {
+				pr_err("Invalid keyring id %d\n", key_id);
+				ret = -EINVAL;
+				goto out;
+			}
+			if (!key_id) {
+				pr_debug("Using default keyring\n");
+				key_put(opts->keyring);
+				opts->keyring = NULL;
+				break;
+			}
+			key = key_lookup(key_id);
+			if (!key) {
+				pr_err("Keyring id %08x not found\n", key_id);
+				ret = -ENOKEY;
+				goto out;
+			}
+			key_put(opts->keyring);
+			opts->keyring = key;
+			break;
+		case NVMF_OPT_TLS_KEY:
+			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (match_int(args, &key_id)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (key_id < 0) {
+				pr_err("Invalid key id %d\n", key_id);
+				ret = -EINVAL;
+				goto out;
+			}
+			if (!key_id) {
+				pr_debug("Using 'best' PSK\n");
+				key_put(opts->tls_key);
+				opts->tls_key = NULL;
+				break;
+			}
+			key = key_lookup(key_id);
+			if (!key) {
+				pr_err("Key id %08x not found\n", key_id);
+				ret = -ENOKEY;
+				goto out;
+			}
+			key_put(opts->tls_key);
+			opts->tls_key = key;
+			break;
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
@@ -1055,6 +1120,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 void nvmf_free_options(struct nvmf_ctrl_options *opts)
 {
 	nvmf_host_put(opts->host);
+	key_put(opts->keyring);
+	key_put(opts->tls_key);
 	kfree(opts->transport);
 	kfree(opts->traddr);
 	kfree(opts->trsvcid);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 5db36e250e7a..2ff7b7168a40 100644
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
 	int			max_reconnects;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
+	struct key		*keyring;
+	struct key		*tls_key;
 	bool			tls;
 	bool			disable_sqflow;
 	bool			hdr_digest;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a3ac512fd1cc..84bf6c80cc7c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1582,6 +1582,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 
 	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
 		qid, pskid);
+	if (nctrl->opts->keyring)
+		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_sock = queue->sock;
 	args.ta_done = nvme_tcp_tls_done;
 	args.ta_data = queue;
@@ -1890,9 +1892,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	key_serial_t psk_id = 0;
 
 	if (ctrl->opts->tls) {
-		psk_id = nvme_tls_psk_default(NULL,
-					      ctrl->opts->host->nqn,
-					      ctrl->opts->subsysnqn);
+		if (ctrl->opts->tls_key)
+			psk_id = key_serial(ctrl->opts->tls_key);
+		else
+			psk_id = nvme_tls_psk_default(ctrl->opts->keyring,
+						      ctrl->opts->host->nqn,
+						      ctrl->opts->subsysnqn);
 		if (!psk_id) {
 			dev_err(ctrl->device, "no valid PSK found\n");
 			ret = -ENOKEY;
-- 
2.35.3


