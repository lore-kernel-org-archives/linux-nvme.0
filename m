Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF06C25B5F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmYLKiO1uW4FIRGtB6/A8Gq0hSR6GXwrV8tUv6CgCp4=; b=S8fFtxjOtnVXODXeWtSuu4lSfy
	Z7vJi3vb7t8qnHrzNWAL7g2h64/MFA7JF8ysTk88TTsEua2wVDZjbU34duOOTl6TDZX8bmcVYD3r7
	wI7T2N4/QDqyYCIPxXH2UkhYQDPl56Z5sEfqUymfwAjd9fMiIKv5yXVHn4QgkUS3xo9w6xBjTwlmA
	KIjdERx0d8eyUkg7lasGlFzmHT7S+1fIPUkbg2oeDNScBOyBy3g66qMkGnc1G8efeFWgxECz5rQan
	iNYV6KrpXpkqkSoVr19DQKoNpR8ck1G1r6ieYZJDWO5sB+2+0nh/VwVWupnnpBzG2x4lkBSvbgcJK
	TryM54PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fVw-0000000FEMF-2qAn;
	Wed, 08 May 2024 11:31:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSg-0000000Ey9Z-1pO6
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5EC61CE180D;
	Wed,  8 May 2024 10:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5704DC113CC;
	Wed,  8 May 2024 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163823;
	bh=/XmEc5VRqv5wO156+MawfJp4IprdmkcS/JeaDZeNFtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GktCy3UPoH5okAGO1i/Wpb45YRfOgSo5BSzGCPBbBUqbwZ9eYIUCTYHNI9GI7sIgF
	 eLBCND9TAgh4B/adGbul1IbHpT9dyZImjoXMTGzw+y2HpjkBfrAY2If4TPp9Q4QWxd
	 LY9eGuv37LjooTP3n/T3tonZBXLlA550LG3wYK6NwKQQEWWZOFO24VNnJdPp3K2/Wa
	 Es4WxBOE95DXaPEBKT2PQL0bngkbpakVXkNimZaBUH5uz3Lg2o+hc/EAi5I07CnLzQ
	 OF9kbS5fltp6npc3vqmdXozvyfiBdDmtf8oY4Rbw7FEakgl01bCW1/mGaLjuoaP2XV
	 hjPBAfdJPWmew==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 12/19] nvme-tcp: request secure channel concatenation
Date: Wed,  8 May 2024 12:22:58 +0200
Message-Id: <20240508102305.108949-13-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032347_400301_390BE8F0 
X-CRM114-Status: GOOD (  27.50  )
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

Add a fabrics option 'concat' to request secure channel concatenation.
When secure channel concatenation is enabled a 'generated PSK' is inserted
into the keyring such that it's available after reset.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/auth.c    | 105 ++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c |  32 ++++++++++-
 drivers/nvme/host/fabrics.h |   3 ++
 drivers/nvme/host/tcp.c     |  54 ++++++++++++++++---
 include/linux/nvme.h        |   7 +++
 5 files changed, 189 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a264b3ae078b..25a3b5e76983 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -12,6 +12,7 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 
 #define CHAP_BUF_SIZE 4096
 static struct kmem_cache *nvme_chap_buf_cache;
@@ -131,7 +132,12 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
 	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 	data->t_id = cpu_to_le16(chap->transaction);
-	data->sc_c = 0; /* No secure channel concatenation */
+	if (!ctrl->opts->concat || chap->qid != 0)
+		data->sc_c = NVME_AUTH_SECP_NOSC;
+	else if (ctrl->opts->tls_key)
+		data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
+	else
+		data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
 	data->napd = 1;
 	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
 	data->auth_protocol[0].dhchap.halen = 3;
@@ -311,8 +317,9 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->hl = chap->hash_len;
 	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
-	if (ctrl->ctrl_key) {
+	if (ctrl->ctrl_key)
 		chap->bi_directional = true;
+	if (ctrl->ctrl_key || ctrl->opts->concat) {
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
 		memcpy(data->rval + chap->hash_len, chap->c2,
@@ -322,7 +329,10 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	} else {
 		memset(chap->c2, 0, chap->hash_len);
 	}
-	chap->s2 = nvme_auth_get_seqnum();
+	if (ctrl->opts->concat)
+		chap->s2 = 0;
+	else
+		chap->s2 = nvme_auth_get_seqnum();
 	data->seqnum = cpu_to_le32(chap->s2);
 	if (chap->host_key_len) {
 		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
@@ -677,6 +687,76 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 		crypto_free_kpp(chap->dh_tfm);
 }
 
+static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
+				   struct nvme_dhchap_queue_context *chap)
+{
+	u8 *psk, *digest, *tls_psk;
+	struct key *tls_key;
+	size_t psk_len;
+	int ret = 0;
+
+	if (!chap->sess_key) {
+		dev_warn(ctrl->device,
+			 "%s: qid %d no session key negotiated\n",
+			 __func__, chap->qid);
+		return -ENOKEY;
+	}
+
+	ret = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
+				     chap->sess_key_len,
+				     chap->c1, chap->c2,
+				     chap->hash_len, &psk, &psk_len);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to generate PSK, error %d\n",
+			 __func__, chap->qid, ret);
+		return ret;
+	}
+	dev_dbg(ctrl->device,
+		  "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
+
+	ret = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
+					ctrl->opts->subsysnqn,
+					ctrl->opts->host->nqn, &digest);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to generate digest, error %d\n",
+			 __func__, chap->qid, ret);
+		goto out_free_psk;
+	};
+	dev_dbg(ctrl->device, "%s: generated digest %s\n",
+		 __func__, digest);
+	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest, &tls_psk);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to derive TLS psk, error %d\n",
+			 __func__, chap->qid, ret);
+		goto out_free_digest;
+	};
+
+	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl->opts->host->nqn,
+				       ctrl->opts->subsysnqn, chap->hash_id,
+				       true, tls_psk, psk_len, digest);
+	if (IS_ERR(tls_key)) {
+		ret = PTR_ERR(tls_key);
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to insert generated key, error %d\n",
+			 __func__, chap->qid, ret);
+		tls_key = NULL;
+		kfree_sensitive(tls_psk);
+	}
+	if (ctrl->opts->tls_key) {
+		key_revoke(ctrl->opts->tls_key);
+		key_put(ctrl->opts->tls_key);
+	}
+	ctrl->opts->tls_key = tls_key;
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_psk:
+	kfree_sensitive(psk);
+	return ret;
+}
+
 static void nvme_queue_auth_work(struct work_struct *work)
 {
 	struct nvme_dhchap_queue_context *chap =
@@ -831,10 +911,21 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		if (ret)
 			chap->error = ret;
 	}
-	if (!ret) {
+	if (ret)
+		goto fail2;
+	if (chap->qid || !ctrl->opts->concat) {
 		chap->error = 0;
 		return;
 	}
+	ret = nvme_auth_secure_concat(ctrl, chap);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to enable secure concatenation\n",
+			 __func__, chap->qid);
+		chap->error = ret;
+	} else
+		chap->error = 0;
+	return;
 
 fail2:
 	if (chap->status == 0)
@@ -912,6 +1003,12 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 			 "qid 0: authentication failed\n");
 		return;
 	}
+	/*
+	* Only run authentication on the admin queue for
+	* secure concatenation
+	 */
+	if (ctrl->opts->concat)
+		return;
 
 	for (q = 1; q < ctrl->queue_count; q++) {
 		ret = nvme_auth_negotiate(ctrl, q);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 03004ef57a10..f916c9cac9db 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -463,8 +463,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	result = le32_to_cpu(res.u32);
 	ctrl->cntlid = result & 0xFFFF;
 	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-		/* Secure concatenation is not implemented */
-		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
+		/* Check for secure concatenation */
+		if ((result & NVME_CONNECT_AUTHREQ_ASCR) &&
+		    !ctrl->opts->concat) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
 			ret = -EOPNOTSUPP;
@@ -679,6 +680,7 @@ static const match_table_t opt_tokens = {
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
+	{ NVMF_OPT_CONCAT,		"concat"		},
 #endif
 	{ NVMF_OPT_ERR,			NULL			}
 };
@@ -708,6 +710,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls = false;
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
+	opts->concat = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1026,6 +1029,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tls = true;
 			break;
+		case NVMF_OPT_CONCAT:
+			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->concat = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1052,6 +1063,23 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
 				opts->fast_io_fail_tmo, ctrl_loss_tmo);
 	}
+	if (opts->concat) {
+		if (opts->tls) {
+			pr_err("Secure concatenation over TLS is not supported\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (opts->tls_key) {
+			pr_err("Cannot specify a TLS key for secure concatenation\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (!opts->dhchap_secret) {
+			pr_err("Need to enable DH-CHAP for secure concatenation\n");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 
 	opts->host = nvmf_host_add(hostnqn, &hostid);
 	if (IS_ERR(opts->host)) {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 37c974c38dcb..fa9dbfe99d66 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -66,6 +66,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_CONCAT		= 1 << 28,
 };
 
 /**
@@ -101,6 +102,7 @@ enum {
  * @keyring:    Keyring to use for key lookups
  * @tls_key:    TLS key for encrypted connections (TCP)
  * @tls:        Start TLS encrypted connections (TCP)
+ * @concat:     Enabled Secure channel concatenation (TCP)
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
@@ -130,6 +132,7 @@ struct nvmf_ctrl_options {
 	struct key		*keyring;
 	struct key		*tls_key;
 	bool			tls;
+	bool			concat;
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7a29d47dea28..42d11c783244 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -227,7 +227,7 @@ static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
 	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
 		return 0;
 
-	return ctrl->opts->tls;
+	return ctrl->opts->tls || ctrl->opts->concat;
 }
 
 static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *queue)
@@ -1942,7 +1942,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
-		else {
+		else if (ctrl->opts->tls) {
 			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
 						      ctrl->opts->host->nqn,
 						      ctrl->opts->subsysnqn);
@@ -1972,9 +1972,25 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
-	if (nvme_tcp_tls_configured(ctrl) && !ctrl->tls_pskid) {
-		dev_err(ctrl->device, "no PSK negotiated\n");
-		return -ENOKEY;
+	if (nvme_tcp_tls_configured(ctrl)) {
+		if (ctrl->opts->concat) {
+			/*
+			 * The generated PSK is stored in the
+			 * fabric options
+			 */
+			if (!ctrl->opts->tls_key) {
+				dev_err(ctrl->device, "no PSK generated\n");
+				return -ENOKEY;
+			}
+			if (ctrl->tls_pskid &&
+			    ctrl->tls_pskid != key_serial(ctrl->opts->tls_key)) {
+				dev_err(ctrl->device, "Stale PSK id %08x\n", ctrl->tls_pskid);
+				ctrl->tls_pskid = 0;
+			}
+		} else if (!ctrl->tls_pskid) {
+			dev_err(ctrl->device, "no PSK negotiated\n");
+			return -ENOKEY;
+		}
 	}
 
 	for (i = 1; i < ctrl->queue_count; i++) {
@@ -2206,6 +2222,27 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
 	}
 }
 
+static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts->concat)
+		return;
+	/* No key generated, nothing to do */
+	if (!ctrl->opts->tls_key)
+		return;
+	/* TLS is not enabled, do not wipe the key */
+	if (!ctrl->tls_pskid)
+		return;
+	/*
+	 * Key generated, and TLS enabled:
+	 * Revoke the generated key.
+	 */
+	dev_dbg(ctrl->device, "Wipe generated TLS PSK %08x\n",
+		key_serial(ctrl->opts->tls_key));
+	key_revoke(ctrl->opts->tls_key);
+	key_put(ctrl->opts->tls_key);
+	ctrl->opts->tls_key = NULL;
+}
+
 static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 {
 	struct nvmf_ctrl_options *opts = ctrl->opts;
@@ -2309,6 +2346,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	nvme_tcp_revoke_generated_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
@@ -2349,6 +2387,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	nvme_tcp_revoke_generated_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
 
@@ -2639,6 +2678,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return len;
+
 	mutex_lock(&queue->queue_lock);
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
@@ -2824,7 +2866,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
-			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 425573202295..3637e8c543a0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1664,6 +1664,13 @@ enum {
 	NVME_AUTH_DHGROUP_INVALID	= 0xff,
 };
 
+enum {
+	NVME_AUTH_SECP_NOSC		= 0x00,
+	NVME_AUTH_SECP_SC		= 0x01,
+	NVME_AUTH_SECP_NEWTLSPSK	= 0x02,
+	NVME_AUTH_SECP_REPLACETLSPSK	= 0x03,
+};
+
 union nvmf_auth_protocol {
 	struct nvmf_auth_dhchap_protocol_descriptor dhchap;
 };
-- 
2.35.3


