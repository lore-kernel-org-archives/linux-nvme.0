Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC031C25B5F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DDgosAxu1gGJoU1+nKS0UyeCyRrkrS2dfILUc3l8nIk=; b=KXytyowpGWIrdvZOAIcgUBbIsb
	Agg6kPUVFC3pvUcexQxhxg1KvR2io3LlDtssLNqYF0Xc24D0vRvSPS6oREI8Z+GcjmNxnwbHLXd3R
	Itwqg2vXa64bJSRr0I92m5X5mTobRKRSI4EnnvbywRoOHv8vg9gylfp86plNIcXCZDgW86ua1RAhU
	XwhFpXvJnwIeA8QDfHBZmFD/2zFSywSM1MDUIx0urXQ9PGGJnh8kJJyqIgduSbv4lOOFxqHpdGRWe
	MyesfTdUm7qzj6KN2a6Q3EJHqVYm/4+EeD0rNg3t0eo7BO8JvWbttN/KCQBlGpzMqgFiT3HYNDcKh
	671BJUAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fW0-0000000FEOW-3zPW;
	Wed, 08 May 2024 11:31:16 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSs-0000000EyIg-2nme
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:24:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B3401CE1812;
	Wed,  8 May 2024 10:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4E1C4AF18;
	Wed,  8 May 2024 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163836;
	bh=/0Zp9hyG0NtIUQd9+L5vprB1Fr7oFuqymdMJBlbP5Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C18i1imJyCXu06opjOq5k7ikBcfNgvMwcorK7yIxA2O+sWIlKOREJaN1YASdcgt27
	 cC0Dm4mOjJkZTTUxvpjsVZi0R25xN+2h2kngj2sMMYiA8Nh/HLyx8xfXRMaSW9TKEC
	 GSO9XkQJ0bVS01hipbwnDxFwn/yu9sJC/vStq6aqI7qQGWZ0eeC28pV7ufPN8kLPNZ
	 AplLB+As1yPWsRlpeOpclq7uNFvDwVLVXjk9KtwrnKQOfeYxgnVkWBvX5Yoi6Eg6YW
	 oXbrcufSjpaB5/CP0PriAsiwrHYaUO7jf4aTY6AlrcG1aLSk9SLxBsW41ACAiyy6hf
	 KI/Gplyh8kg4w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 19/19] nvmet-tcp: support secure channel concatenation
Date: Wed,  8 May 2024 12:23:05 +0200
Message-Id: <20240508102305.108949-20-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032359_209979_A5DA9E2C 
X-CRM114-Status: GOOD (  20.99  )
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

Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
the generated PSK once negotiation has finished.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c             | 72 +++++++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd-auth.c | 46 ++++++++++++++--
 drivers/nvme/target/fabrics-cmd.c      | 29 ++++++++---
 drivers/nvme/target/nvmet.h            | 30 ++++++++---
 drivers/nvme/target/tcp.c              | 25 ++++++++-
 5 files changed, 180 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 7013ab62d5c6..df3c2f2ee1b1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 #include <asm/unaligned.h>
 
 #include "nvmet.h"
@@ -138,7 +139,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -164,6 +165,11 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		goto out_unlock;
 	}
 
+	if (nvmet_queue_is_tls(req->sq)) {
+		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
+		goto out_unlock;
+	}
+
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
 	if (ret < 0) {
 		pr_warn("Failed to setup DH group");
@@ -232,6 +238,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	sq->tls_key = 0;
+#endif
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
@@ -260,6 +269,12 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
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
@@ -539,3 +554,58 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 
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
+				       sq->ctrl->shash_id, true, tls_psk, psk_len, digest);
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
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index d61b8c6ff3b2..affdb6b85c82 100644
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
+			if (nvmet_queue_is_tls(req->sq))
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		case NVME_AUTH_SECP_REPLACETLSPSK:
+			if (!nvmet_queue_is_tls(req->sq))
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
@@ -163,11 +194,14 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
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
 	}
-	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 
 	return 0;
 }
@@ -241,7 +275,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl);
+				dhchap_status = nvmet_setup_auth(ctrl, req);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
@@ -298,6 +332,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		}
 		goto done_kfree;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
+		if (ctrl->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
 		pr_debug("%s: ctrl %d qid %d ctrl authenticated\n",
 			 __func__, ctrl->cntlid, req->sq->qid);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 042b379cbb36..a819bde2a3a3 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -199,10 +199,20 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	return ret;
 }
 
-static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl)
+static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
+	bool needs_auth = nvmet_has_auth(ctrl, req);
+
+	/* Do not authenticate I/O queues for secure concatenation */
+	if (ctrl->concat && req->sq->qid)
+		needs_auth = false;
+
+	pr_debug("%s: ctrl %d qid %d should %sauthenticate, tls psk %08x\n",
+		 __func__, ctrl->cntlid, req->sq->qid,
+		 needs_auth ? "" : "not ",
+		 req->sq->tls_key ? key_serial(req->sq->tls_key) : 0);
 	return (u32)ctrl->cntlid |
-		(nvmet_has_auth(ctrl) ? NVME_CONNECT_AUTHREQ_ATR : 0);
+		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
 
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
@@ -254,7 +264,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl);
+	dhchap_status = nvmet_setup_auth(ctrl, req);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
@@ -272,12 +282,13 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating %s controller %d for subsystem %s for NQN %s%s%s.\n",
+	pr_info("creating %s controller %d for subsystem %s for NQN %s%s%s%s.\n",
 		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
-		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+		ctrl->pi_support ? ", T10-PI" : "",
+		nvmet_has_auth(ctrl, req) ? ", DH-HMAC-CHAP" : "",
+		nvmet_queue_is_tls(req->sq) ? ", TLS" : "");
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
@@ -320,6 +331,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
+		pr_warn("invalid controller (%x)\n",
+			le16_to_cpu(d->cntlid));
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
 	}
@@ -336,7 +349,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e4ba54b85511..73368942f062 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -121,6 +121,9 @@ struct nvmet_sq {
 	u32			dhchap_s2;
 	u8			*dhchap_skey;
 	int			dhchap_skey_len;
+#endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key		*tls_key;
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
@@ -235,6 +238,7 @@ struct nvmet_ctrl {
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 	bool			pi_support;
+	bool			concat;
 #ifdef CONFIG_NVME_TARGET_AUTH
 	struct nvme_dhchap_key	*host_key;
 	struct nvme_dhchap_key	*ctrl_key;
@@ -244,6 +248,9 @@ struct nvmet_ctrl {
 	u8			*dh_key;
 	size_t			dh_keysize;
 #endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key		*tls_key;
+#endif
 };
 
 struct nvmet_subsys {
@@ -707,13 +714,21 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static inline bool nvmet_queue_is_tls(struct nvmet_sq *sq)
+{
+	return !!sq->tls_key;
+}
+#else
+static inline bool nvmet_queue_is_tls(struct nvmet_sq *sq) { return false; }
+#endif
 #ifdef CONFIG_NVME_TARGET_AUTH
 void nvmet_execute_auth_send(struct nvmet_req *req);
 void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -723,16 +738,18 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
-	return ctrl->host_key != NULL;
+	return ctrl->host_key != NULL && !nvmet_queue_is_tls(req->sq);
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 				u8 *buf, int buf_size);
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
+void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
-static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_req *req)
 {
 	return 0;
 }
@@ -745,11 +762,12 @@ static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
 }
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_req *req)
 {
 	return false;
 }
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
+static inline void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
 #endif
-
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a5422e2c979a..12ca6b11d061 100644
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
@@ -1605,6 +1606,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
+	if (queue->nvme_sq.tls_key)
+		key_put(queue->nvme_sq.tls_key);
+
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
@@ -1810,6 +1814,23 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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


