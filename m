Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424A4C04A6A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+XUDeVX1gcI/aI/l56iFgAiYFRCxJrV+/DINkQxISJQ=; b=VaNZKABVbPFKjcTkb+zEJwRyym
	5iyXe9GgZaR1LxP7BNqTSXvRLE5jN2aK+1kminvNMx4a2JKFDLZrCAljpxJthJLLXGlZyomo0hGNW
	esB1S2rLN/PU5yDIT+9CHg9aIHDrO8zPYh5DyT6JnvhXzpfbm1Xd/Vp9IA3iNxlXnQu6stSbsn7Mw
	k3Ru15viGSuhORHgffRrix9ARPEiLT8Yf0klMxtF6Bybg0iqLqxiSsk6tGu5FvHX6Ut0xDh72HCG1
	Hj4+M74JHSLjf7THnYzlwe6uyk/K83DAgxfkt22x6FfA9J50q0VLzZ0YLI1gR2S//BBPQjk00cf/u
	eUeoh1Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxJ-007XFw-06;
	Thu, 03 Aug 2023 10:53:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVx8-007X7s-2m
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:53:15 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7CE101F890;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691059989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XUDeVX1gcI/aI/l56iFgAiYFRCxJrV+/DINkQxISJQ=;
	b=i4sknoFYn+3AWsBuI72VvLYkTgrWZxWZt+vpmyPO0WULEyIRtUGvLSTaE68argsVXMD/69
	dJ7V+dohzzJx2HWY4Hr4kpLVWbNUD54vWGYfBXIyNem8MF+u9qTxqHoph2S9JJkAd42Uav
	3lXZiXoTCeK9DM7S+a5TfrDnAvT5Z10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691059989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XUDeVX1gcI/aI/l56iFgAiYFRCxJrV+/DINkQxISJQ=;
	b=ear4B/NfbtgKGM+ZIQQF79hB/pUGFvzkrwmbUnD1O4JAoWdVRFWqGivT/T+mt6tGvX35dF
	DUfzfhJuDLtvD9BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 70D6D2C15A;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 6DAF851CA7D3; Thu,  3 Aug 2023 12:53:09 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/14] nvme-fabrics: parse options 'keyring' and 'tls_key'
Date: Thu,  3 Aug 2023 12:50:58 +0200
Message-Id: <20230803105102.30949-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230803105102.30949-1-hare@suse.de>
References: <20230803105102.30949-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_035311_160710_8C25516B 
X-CRM114-Status: GOOD (  16.67  )
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
index ddad482c3537..6bdcd505a477 100644
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
+	struct key *key = NULL;
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -928,6 +933,66 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -1168,6 +1233,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
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
index 4d0e3de39c26..cc6a672b8d3f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1584,6 +1584,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 
 	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
 		qid, pskid);
+	if (nctrl->opts->keyring)
+		keyring = key_serial(nctrl->opts->keyring);
 	memset(&args, 0, sizeof(args));
 	args.ta_sock = queue->sock;
 	args.ta_done = nvme_tcp_tls_done;
@@ -1899,9 +1901,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
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


