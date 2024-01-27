Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFAEC47DDB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7agKldSIz+1tpDHPv4IkrT10EtjRZU6jj/Hdc8WJvgo=; b=OP25k+CH5Dkv9njFGK/sQVMUJh
	VkzHcz9i1OvRykx/GXfo2Y7QgmkbqJsIfqHLkVEuvLBm0vbfRNcEhlEqJTMenJ/xp5xa9+d69R4l5
	BV1zHXvv9eutbboRkd5m3tpoY9ayMtWWTJbQmDEt2inp5B2OK6zpB01gZcBylz17kSE6qNsMVwG47
	6uP824yvbEpGNuToDQDadA3as2k2Cjkl1ElQPIDiavDZb8Fk0gInx/e9NGhNl4JZwvCPuoboPbXSJ
	ujWp4xfJisK4JrZCm8dio+Wm4GLfEPLV0J9+o2ioYiCaMEVSJV/V3CgW4G0IbcCr/C+nbp1P7kwhI
	p3OVL/gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf2J-00000007FsH-2NKA;
	Sat, 27 Jan 2024 09:31:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf21-00000007Fa0-0O2L
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 76E6960C24;
	Sat, 27 Jan 2024 09:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91DDC43394;
	Sat, 27 Jan 2024 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347880;
	bh=vtD/YG8ZlclPk9Z+giaS2K0pyH/gQQFkxjkMKvprP+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDSrS9psOrsZ0YFjrLkrqO+uSIQHx2XjmYwpP6b4gY9Leyemp+D++XRlYOFFvSPbK
	 FEbQ4Sf3TEuWdIyLjSCm3Gp6TqjMDVG0WlBQmh8e8miUL/zNtQT9E/11KgYsgXYQVN
	 K6tw1TIhwhxtQz2iygZTCFNPVS9r1zyL5w3Ws1p36qH5wWTNBw9Ed6qjSfafXUJyEt
	 J7gjxxiyijg0Ogi/cWd0pKyDtXz4VI3gzmCjNzogJRyMs8RE61l7bLESI1cLhZikBa
	 saMiHFGQQC56kMRandqUi09RH3XQa/2DDWMbFD3eYC5VnhZPn1Sk2Lv2+QGOPHkKXf
	 AN/+EbGxKq0Xg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/13] nvme-tcp: request secure channel concatenation
Date: Sat, 27 Jan 2024 10:30:55 +0100
Message-Id: <20240127093058.15699-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013121_391586_410870BF 
X-CRM114-Status: GOOD (  25.16  )
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

From: Hannes Reinecke <hare@suse.de>

Add a fabrics option 'concat' to request secure channel concatenation.
When secure channel concatenation is enabled a 'generated PSK' is inserted
into the keyring such that it's available for the next connection attempt.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    | 108 ++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c |  31 ++++++++++-
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/tcp.c     |   9 ++-
 include/linux/nvme.h        |   7 +++
 5 files changed, 148 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 72c0525c75f5..35a460cfb4bf 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -12,6 +12,7 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 
 #define CHAP_BUF_SIZE 4096
 static struct kmem_cache *nvme_chap_buf_cache;
@@ -132,7 +133,12 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
 	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 	data->t_id = cpu_to_le16(chap->transaction);
-	data->sc_c = 0; /* No secure channel concatenation */
+	if (!ctrl->opts->concat)
+		data->sc_c = NVME_AUTH_SECP_NOSC;
+	else if (ctrl->opts->tls_key)
+		data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
+	else
+		data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
 	data->napd = 1;
 	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
 	data->auth_protocol[0].dhchap.halen = 3;
@@ -312,8 +318,9 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
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
@@ -323,7 +330,10 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
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
@@ -678,6 +688,79 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
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
+	psk = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
+				     chap->sess_key_len,
+				     chap->c1, chap->c2,
+				     chap->hash_len, &psk_len);
+	if (IS_ERR(psk)) {
+		ret = PTR_ERR(psk);
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to generate PSK, error %d\n",
+			 __func__, chap->qid, ret);
+		return ret;
+	}
+	dev_dbg(ctrl->device,
+		  "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
+
+	digest = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
+					   ctrl->opts->subsysnqn,
+					   ctrl->opts->host->nqn);
+	if (IS_ERR(digest)) {
+		ret = PTR_ERR(digest);
+		dev_warn(ctrl->device,
+			 "%s: qid %d failed to generate digest, error %d\n",
+			 __func__, chap->qid, ret);
+		goto out_free_psk;
+	};
+	dev_dbg(ctrl->device, "%s: generated digest %s\n",
+		 __func__, digest);
+	tls_psk = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest);
+	if (IS_ERR(tls_psk)) {
+		ret = PTR_ERR(tls_psk);
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
@@ -832,10 +915,21 @@ static void nvme_queue_auth_work(struct work_struct *work)
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
@@ -913,6 +1007,12 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
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
index c6feb6e1e05f..8140d8166c3e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -461,10 +461,11 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	result = le32_to_cpu(res.u32);
 	ctrl->cntlid = result & 0xFFFF;
 	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-		/* Secure concatenation is not implemented */
-		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
+		/* Check for secure concatenation */
+		if ((result & NVME_CONNECT_AUTHREQ_ASCR) &&
+		    !ctrl->opts->concat) {
 			dev_warn(ctrl->device,
-				 "qid 0: secure concatenation is not supported\n");
+				 "qid 0: secure concatenation is not enabled\n");
 			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
@@ -678,6 +679,7 @@ static const match_table_t opt_tokens = {
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
+	{ NVMF_OPT_CONCAT,		"concat"		},
 #endif
 	{ NVMF_OPT_ERR,			NULL			}
 };
@@ -707,6 +709,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls = false;
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
+	opts->concat = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1025,6 +1028,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -1051,6 +1062,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
 				opts->fast_io_fail_tmo, ctrl_loss_tmo);
 	}
+	if (opts->concat && opts->tls) {
+		pr_err("Secure concatenation over TLS is not supported\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (opts->concat && opts->tls_key) {
+		pr_err("Cannot specify a TLS key for secure concatenation\n");
+		ret = -EINVAL;
+		goto out;
+	}
 
 	opts->host = nvmf_host_add(hostnqn, &hostid);
 	if (IS_ERR(opts->host)) {
@@ -1306,6 +1327,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 		goto out_module_put;
 	}
 
+	/* Reset controller to start TLS */
+	if (opts->concat)
+		nvme_reset_ctrl(ctrl);
+
 	module_put(ops->module);
 	return ctrl;
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index fbaee5a7be19..b6b731935dbf 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -73,6 +73,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_CONCAT		= 1 << 28,
 };
 
 /**
@@ -108,6 +109,7 @@ enum {
  * @keyring:    Keyring to use for key lookups
  * @tls_key:    TLS key for encrypted connections (TCP)
  * @tls:        Start TLS encrypted connections (TCP)
+ * @concat:     Enabled Secure channel concatenation (TCP)
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
@@ -137,6 +139,7 @@ struct nvmf_ctrl_options {
 	struct key		*keyring;
 	struct key		*tls_key;
 	bool			tls;
+	bool			concat;
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 642c0fc0941b..6c8ca08f2972 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -219,7 +219,7 @@ static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
 	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
 		return 0;
 
-	return ctrl->opts->tls;
+	return ctrl->opts->tls || ctrl->opts->concat;
 }
 
 static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *queue)
@@ -1932,7 +1932,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
-		else {
+		else if (ctrl->opts->tls) {
 			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
 						      ctrl->opts->host->nqn,
 						      ctrl->opts->subsysnqn);
@@ -2615,6 +2615,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return len;
+
 	mutex_lock(&queue->queue_lock);
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
@@ -2800,7 +2803,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
-			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 462c21e0e417..2342a0240b6f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1671,6 +1671,13 @@ enum {
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


