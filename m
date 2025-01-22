Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED6FC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XiYyXwjTnanxfo+ptZEMFEZwUBjbry301sSJrEkZMpM=; b=unOUylaAyXsGqoOFqWO//RNNON
	9Yyqne0DC5dzi3zXHSQDgkCFNOTRPSPiqmGglLDcoE0jOTofPIkx9To05xZ64/dfc8QYUKyq1Cakd
	KVjQt7V6PQQTYAtQ2J0dKBgzegWZgBUwe6At1mVDMw7E8hVTNQZRzjTGJP3pjTqdVphFZJRmUy/Qf
	OXgq148hyZIZFx0LgHelpZs/V1WvBfDeGmZAn631s5Mbqm2fCo2cUzWWwBL8zJhhII48EsbAn1v+R
	y+wFE0EhT30ZJ4lwrUk02F+DQY1uZqUfOArtuISR6oy/7fM4hhsnimy0jJi+3iTnm0gJFr8TThuGu
	NOMkOpng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4S-0000000AnAn-0HzV;
	Wed, 22 Jan 2025 16:59:16 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4Q-0000000An7F-16hz
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 08722A42916;
	Wed, 22 Jan 2025 16:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2DCC4CED2;
	Wed, 22 Jan 2025 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565153;
	bh=DxnR91hwh3xRs/J5gXbg6oVKRjb3d7ECwwxmYYzTHAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVOIjtxCpsGGpFkUnw7qqFqo2kt1WcXpU3fgsn8jJCB4Jct5XaKzv42x0C55OoAfb
	 2nHvHpPyq8J9HzDuGpEuxVe5VXO0k0o4aNESYXj0j4lxk6dE9QdQxhvQ/cmk2Q/ky2
	 GK+g43eqPJ2oblvENojg3OmUEdc0URCeLGLOOhe93wSP7geRvSIMQg2fPetr+8E/di
	 Pi5r++sYm5yUwzmYdKhWe0LmfwL+QvYK3mHqhi8OBVs5HPY4n64D6WMNrQEukCletT
	 RnG3r+DpaNxLslBJF/igry+Ff3gHjr2ucXuRBbIxW7791EUnLlaQTWVqXVRzQT1f2P
	 ozAknsRcngw8Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
Date: Wed, 22 Jan 2025 17:58:28 +0100
Message-Id: <20250122165829.11603-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
References: <20250122165829.11603-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085914_459181_1776FE41 
X-CRM114-Status: GOOD (  22.16  )
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

Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
the generated PSK once negotiation has finished.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/auth.c             | 72 +++++++++++++++++++++++++-
 drivers/nvme/target/core.c             |  7 +--
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++++---
 drivers/nvme/target/fabrics-cmd.c      | 25 +++++++--
 drivers/nvme/target/nvmet.h            | 38 ++++++++++++--
 drivers/nvme/target/tcp.c              | 23 +++++++-
 6 files changed, 193 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b47d675232d2..0b0645ac5df4 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 #include <linux/unaligned.h>
 
 #include "nvmet.h"
@@ -139,7 +140,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -165,6 +166,11 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		goto out_unlock;
 	}
 
+	if (nvmet_queue_tls_keyid(sq)) {
+		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
+		goto out_unlock;
+	}
+
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
 	if (ret < 0) {
 		pr_warn("Failed to setup DH group");
@@ -233,6 +239,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	sq->tls_key = 0;
+#endif
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
@@ -261,6 +270,12 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 		nvme_auth_free_key(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	if (ctrl->tls_key) {
+		key_put(ctrl->tls_key);
+		ctrl->tls_key = NULL;
+	}
+#endif
 }
 
 bool nvmet_check_auth_status(struct nvmet_req *req)
@@ -542,3 +557,58 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 
 	return ret;
 }
+
+void nvmet_auth_insert_psk(struct nvmet_sq *sq)
+{
+	int hash_len = nvme_auth_hmac_hash_len(sq->ctrl->shash_id);
+	u8 *psk, *digest, *tls_psk;
+	size_t psk_len;
+	int ret;
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key *tls_key = NULL;
+#endif
+
+	ret = nvme_auth_generate_psk(sq->ctrl->shash_id,
+				     sq->dhchap_skey,
+				     sq->dhchap_skey_len,
+				     sq->dhchap_c1, sq->dhchap_c2,
+				     hash_len, &psk, &psk_len);
+	if (ret) {
+		pr_warn("%s: ctrl %d qid %d failed to generate PSK, error %d\n",
+			__func__, sq->ctrl->cntlid, sq->qid, ret);
+		return;
+	}
+	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
+					sq->ctrl->subsysnqn,
+					sq->ctrl->hostnqn, &digest);
+	if (ret) {
+		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %d\n",
+			__func__, sq->ctrl->cntlid, sq->qid, ret);
+		goto out_free_psk;
+	}
+	ret = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len,
+				       digest, &tls_psk);
+	if (ret) {
+		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %d\n",
+			__func__, sq->ctrl->cntlid, sq->qid, ret);
+		goto out_free_digest;
+	}
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsysnqn,
+				       sq->ctrl->shash_id, tls_psk, psk_len, digest);
+	if (IS_ERR(tls_key)) {
+		pr_warn("%s: ctrl %d qid %d failed to refresh key, error %ld\n",
+			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(tls_key));
+		tls_key = NULL;
+		kfree_sensitive(tls_psk);
+	}
+	if (sq->ctrl->tls_key)
+		key_put(sq->ctrl->tls_key);
+	sq->ctrl->tls_key = tls_key;
+#endif
+
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_psk:
+	kfree_sensitive(psk);
+}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43c9888eea90..bc17ec4a783a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1631,7 +1631,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl);
+	dhchap_status = nvmet_setup_auth(ctrl, args->sq);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
@@ -1646,11 +1646,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 	args->status = NVME_SC_SUCCESS;
 
-	pr_info("Created %s controller %d for subsystem %s for NQN %s%s%s.\n",
+	pr_info("Created %s controller %d for subsystem %s for NQN %s%s%s%s.\n",
 		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
+		nvmet_has_auth(ctrl, args->sq) ? " with DH-HMAC-CHAP" : "",
+		nvmet_queue_tls_keyid(args->sq) ? ", TLS" : "");
 
 	return ctrl;
 
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 2022757f08dc..a7135b90f915 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,8 +43,26 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
-	if (data->sc_c)
-		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+	if (data->sc_c != NVME_AUTH_SECP_NOSC) {
+		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		/* Secure concatenation can only be enabled on the admin queue */
+		if (req->sq->qid)
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		switch (data->sc_c) {
+		case NVME_AUTH_SECP_NEWTLSPSK:
+			if (nvmet_queue_tls_keyid(req->sq))
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		case NVME_AUTH_SECP_REPLACETLSPSK:
+			if (!nvmet_queue_tls_keyid(req->sq))
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		default:
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		}
+		ctrl->concat = true;
+	}
 
 	if (data->napd != 1)
 		return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
@@ -103,6 +121,13 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			 nvme_auth_dhgroup_name(fallback_dhgid));
 		ctrl->dh_gid = fallback_dhgid;
 	}
+	if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL &&
+	    ctrl->concat) {
+		pr_debug("%s: ctrl %d qid %d: NULL DH group invalid "
+			 "for secure channel concatenation\n", __func__,
+			 ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+	}
 	pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
@@ -154,6 +179,12 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	kfree(response);
 	pr_debug("%s: ctrl %d qid %d host authenticated\n",
 		 __func__, ctrl->cntlid, req->sq->qid);
+	if (!data->cvalid && ctrl->concat) {
+		pr_debug("%s: ctrl %d qid %d invalid challenge\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+	}
+	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 	if (data->cvalid) {
 		req->sq->dhchap_c2 = kmemdup(data->rval + data->hl, data->hl,
 					     GFP_KERNEL);
@@ -163,11 +194,15 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
 			 __func__, ctrl->cntlid, req->sq->qid, data->hl,
 			 req->sq->dhchap_c2);
-	} else {
+	}
+	if (req->sq->dhchap_s2 == 0) {
+		if (ctrl->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
+		kfree(req->sq->dhchap_c2);
 		req->sq->dhchap_c2 = NULL;
-	}
-	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
+	} else if (!data->cvalid)
+		req->sq->authenticated = true;
 
 	return 0;
 }
@@ -246,7 +281,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
@@ -303,6 +338,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		}
 		goto done_kfree;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
+		if (ctrl->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
 		pr_debug("%s: ctrl %d qid %d ctrl authenticated\n",
 			 __func__, ctrl->cntlid, req->sq->qid);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index a7ff05b3be29..9c01a4b6e543 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -234,10 +234,26 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	return ret;
 }
 
-static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl)
+static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 {
+	bool needs_auth = nvmet_has_auth(ctrl, sq);
+	key_serial_t keyid = nvmet_queue_tls_keyid(sq);
+
+	/* Do not authenticate I/O queues for secure concatenation */
+	if (ctrl->concat && sq->qid)
+		needs_auth = false;
+
+	if (keyid)
+		pr_debug("%s: ctrl %d qid %d should %sauthenticate, tls psk %08x\n",
+			 __func__, ctrl->cntlid, sq->qid,
+			 needs_auth ? "" : "not ", keyid);
+	else
+		pr_debug("%s: ctrl %d qid %d should %sauthenticate%s\n",
+			 __func__, ctrl->cntlid, sq->qid,
+			 needs_auth ? "" : "not ",
+			 ctrl->concat ? ", secure concatenation" : "");
 	return (u32)ctrl->cntlid |
-		(nvmet_has_auth(ctrl) ? NVME_CONNECT_AUTHREQ_ATR : 0);
+		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
 
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
@@ -247,6 +263,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	struct nvmet_alloc_ctrl_args args = {
 		.port = req->port,
+		.sq = req->sq,
 		.ops = req->ops,
 		.p2p_client = req->p2p_client,
 		.kato = le32_to_cpu(c->kato),
@@ -299,7 +316,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
+	args.result = cpu_to_le32(nvmet_connect_result(ctrl, req->sq));
 out:
 	kfree(d);
 complete:
@@ -357,7 +374,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req->sq));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f4df458df9db..7401d59f26df 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -157,6 +157,9 @@ struct nvmet_sq {
 	u32			dhchap_s2;
 	u8			*dhchap_skey;
 	int			dhchap_skey_len;
+#endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key		*tls_key;
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
@@ -282,6 +285,7 @@ struct nvmet_ctrl {
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 	bool			pi_support;
+	bool			concat;
 #ifdef CONFIG_NVME_TARGET_AUTH
 	struct nvme_dhchap_key	*host_key;
 	struct nvme_dhchap_key	*ctrl_key;
@@ -290,6 +294,9 @@ struct nvmet_ctrl {
 	u8			dh_gid;
 	u8			*dh_key;
 	size_t			dh_keysize;
+#endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key		*tls_key;
 #endif
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
@@ -576,6 +583,7 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 
 struct nvmet_alloc_ctrl_args {
 	struct nvmet_port	*port;
+	struct nvmet_sq		*sq;
 	char			*subsysnqn;
 	char			*hostnqn;
 	uuid_t			*hostid;
@@ -845,6 +853,22 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
+{
+	return sq->tls_key ? key_serial(sq->tls_key) : 0;
+}
+static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
+{
+	if (sq->tls_key) {
+		key_put(sq->tls_key);
+		sq->tls_key = NULL;
+	}
+}
+#else
+static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq) { return 0; }
+static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq) {}
+#endif
 #ifdef CONFIG_NVME_TARGET_AUTH
 u32 nvmet_auth_send_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_send(struct nvmet_req *req);
@@ -853,7 +877,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -863,16 +887,18 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 {
-	return ctrl->host_key != NULL;
+	return ctrl->host_key != NULL && !nvmet_queue_tls_keyid(sq);
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 				u8 *buf, int buf_size);
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
+void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
-static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_sq *sq)
 {
 	return 0;
 }
@@ -885,11 +911,13 @@ static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
 }
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_sq *sq)
 {
 	return false;
 }
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
+static inline void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
 #endif
 
 int nvmet_pr_init_ns(struct nvmet_ns *ns);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index fa59a7996efa..6d8d150a75c6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1072,10 +1072,11 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 
 	if (unlikely(!nvmet_req_init(req, &queue->nvme_cq,
 			&queue->nvme_sq, &nvmet_tcp_ops))) {
-		pr_err("failed cmd %p id %d opcode %d, data_len: %d\n",
+		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
-			le32_to_cpu(req->cmd->common.dptr.sgl.length));
+		       le32_to_cpu(req->cmd->common.dptr.sgl.length),
+		       le16_to_cpu(req->cqe->status));
 
 		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
 		return 0;
@@ -1601,6 +1602,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
+	nvmet_sq_put_tls_key(&queue->nvme_sq);
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
@@ -1806,6 +1808,23 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	spin_unlock_bh(&queue->state_lock);
 
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
+
+	if (!status) {
+		struct key *tls_key = nvme_tls_key_lookup(peerid);
+
+		if (IS_ERR(tls_key)) {
+			pr_warn("%s: queue %d failed to lookup key %x\n",
+				__func__, queue->idx, peerid);
+			spin_lock_bh(&queue->state_lock);
+			queue->state = NVMET_TCP_Q_FAILED;
+			spin_unlock_bh(&queue->state_lock);
+			status = PTR_ERR(tls_key);
+		} else {
+			pr_debug("%s: queue %d using TLS PSK %x\n",
+				 __func__, queue->idx, peerid);
+			queue->nvme_sq.tls_key = tls_key;
+		}
+	}
 	if (status)
 		nvmet_tcp_schedule_release_queue(queue);
 	else
-- 
2.35.3


