Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E06DC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxpvNWuZPRixenjSXLOTn4h3dQ9E8BmvEwtZIVLJfn4=; b=s2+QBnJdhaFDbeAe19TOmr7XLI
	Dc2iiC4DS1nzqddV9rs3lJAImM3RvOG0g3SQTJZvxv+zmXrIezWfracTUECSEx/Xcaq3cVDAguidE
	2OzKmQIt3vM+VUXHZBZuCJWvfLXRI4JxzwpgqkiPXQzlNAoNrPh3jM65MAPUULXr6rpyiI88GZyIC
	BZPMYuY7SrMWVLg6YpB7HFwvvRktY65YYP/KICs8KAXNF3w1jtrQc3wgxevu2d54TbTkLxpVqudM1
	O9U83StRMpHHXUEXXDHYH4XumXmI/X/sCANlj89Tiv59KaZcaCgqA4xQgILLa0v2ROfKDiqRlmTla
	zaI3lZWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHdP-00GmO1-0Q;
	Tue, 23 Jan 2024 14:20:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHdL-00GmLX-1s
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:20:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EA7B061E0F;
	Tue, 23 Jan 2024 14:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8D0C43390;
	Tue, 23 Jan 2024 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019580;
	bh=tYkVHUkD3VWpaDi+kMnu9fsIQPW1oQ6MW8BySLlYzuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMphB3us9d4gBDwJXPcVXNlDomYffHbLf3totU/3Q9Hus1LpNAiHnaTK25ELlIIqm
	 RldzXXfflafE+ua2WY5pKxVMD6hLQ3ArnwNE5vyUqUyTajFk1xRLNM35EoIikZDhXc
	 iHwy6Bhm6zcWSn6W/UBAmyzucu9vff37J9bwO0R1aElN/eNtoosGRIzzU1gYpn94+4
	 2HGzYS9qGqW20Vz6uzmYO5LJYfd+n7mVl35Mv68wj6D3ooZ2oeMogKN8p/nI5LNbnF
	 ay2lLSeI6FdujjJVIGvyZp62Y3k/QOrvHpn5xg2T9/B3eWZ9AdSAaJkRd3yA0sQ7+P
	 zIsRr6bSjHvlA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/11] nvmet-tcp: support secure channel concatenation
Date: Tue, 23 Jan 2024 15:19:09 +0100
Message-Id: <20240123141909.79061-12-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123141909.79061-1-hare@kernel.org>
References: <20240123141909.79061-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_062011_710362_E961DB1B 
X-CRM114-Status: GOOD (  22.24  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c             | 62 +++++++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd-auth.c | 43 +++++++++++++++---
 drivers/nvme/target/fabrics-cmd.c      | 27 +++++++----
 drivers/nvme/target/nvmet.h            | 16 ++++---
 drivers/nvme/target/tcp.c              | 26 +++++++++++
 5 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..b406afbf8c7a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 #include <asm/unaligned.h>
 
 #include "nvmet.h"
@@ -124,7 +125,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+int nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -151,6 +152,11 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		goto out_unlock;
 	}
 
+	if (req->sq->tls_key) {
+		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
+		goto out_unlock;
+	}
+
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
 	if (ret < 0)
 		pr_warn("Failed to setup DH group");
@@ -222,6 +228,10 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
+	if (sq->tls_key) {
+		key_put(sq->tls_key);
+		sq->tls_key = NULL;
+	}
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
@@ -529,3 +539,53 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 
 	return ret;
 }
+
+void nvmet_auth_insert_psk(struct nvmet_sq *sq)
+{
+	int hash_len = nvme_auth_hmac_hash_len(sq->ctrl->shash_id);
+	u8 *psk, *digest, *tls_psk;
+	size_t psk_len;
+	struct key *tls_key = NULL;
+
+	psk = nvme_auth_generate_psk(sq->ctrl->shash_id,
+				     sq->dhchap_skey,
+				     sq->dhchap_skey_len,
+				     sq->dhchap_c1, sq->dhchap_c2,
+				     hash_len, &psk_len);
+	if (IS_ERR(psk)) {
+		pr_warn("%s: ctrl %d qid %d failed to generate PSK, error %ld\n",
+			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(psk));
+		return;
+	}
+	digest = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
+					   sq->ctrl->subsysnqn,
+					   sq->ctrl->hostnqn);
+	if (IS_ERR(digest)) {
+		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %ld\n",
+			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(digest));
+		goto out_free_psk;
+	}
+	tls_psk = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len, digest);
+	if (IS_ERR(tls_psk)) {
+		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %ld\n",
+			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(tls_psk));
+		goto out_free_digest;
+	}
+	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsysnqn,
+				       sq->ctrl->shash_id, true, tls_psk, psk_len, digest);
+	if (IS_ERR(tls_key)) {
+		pr_warn("%s: ctrl %d qid %d failed to refresh key, error %ld\n",
+			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(tls_key));
+		tls_key = NULL;
+		kfree_sensitive(tls_psk);
+	}
+	if (sq->tls_key) {
+		key_revoke(sq->tls_key);
+		key_put(sq->tls_key);
+	}
+	sq->tls_key = tls_key;
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_psk:
+	kfree_sensitive(psk);
+}
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca7..3abced314d71 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,8 +43,23 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
-	if (data->sc_c)
-		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+	if (data->sc_c != NVME_AUTH_SECP_NOSC) {
+		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		switch (data->sc_c) {
+		case NVME_AUTH_SECP_NEWTLSPSK:
+			if (req->sq->tls_key)
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		case NVME_AUTH_SECP_REPLACETLSPSK:
+			if (!req->sq->tls_key)
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		default:
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		}
+		req->sq->concat = true;
+	}
 
 	if (data->napd != 1)
 		return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
@@ -103,6 +118,13 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			 nvme_auth_dhgroup_name(fallback_dhgid));
 		ctrl->dh_gid = fallback_dhgid;
 	}
+	if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL &&
+	    req->sq->concat) {
+		pr_debug("%s: ctrl %d qid %d: NULL DH group invalid "
+			 "for secure channel concatenation\n", __func__,
+			 ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+	}
 	pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
@@ -154,6 +176,12 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	kfree(response);
 	pr_debug("%s: ctrl %d qid %d host authenticated\n",
 		 __func__, ctrl->cntlid, req->sq->qid);
+	if (!data->cvalid && req->sq->concat) {
+		pr_debug("%s: ctrl %d qid %d invalid challenge\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+	}
+	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 	if (data->cvalid) {
 		req->sq->dhchap_c2 = kmemdup(data->rval + data->hl, data->hl,
 					     GFP_KERNEL);
@@ -163,11 +191,14 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
 			 __func__, ctrl->cntlid, req->sq->qid, data->hl,
 			 req->sq->dhchap_c2);
-	} else {
+	}
+	if (req->sq->dhchap_s2 == 0) {
+		if (req->sq->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
+		kfree(req->sq->dhchap_c2);
 		req->sq->dhchap_c2 = NULL;
 	}
-	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 
 	return 0;
 }
@@ -240,7 +271,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
 				 ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				if (nvmet_setup_auth(ctrl) < 0) {
+				if (nvmet_setup_auth(ctrl, req) < 0) {
 					status = NVME_SC_INTERNAL;
 					pr_err("ctrl %d qid 0 failed to setup"
 					       "re-authentication",
@@ -296,6 +327,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		}
 		goto done_kfree;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
+		if (req->sq->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
 		pr_debug("%s: ctrl %d qid %d ctrl authenticated\n",
 			 __func__, ctrl->cntlid, req->sq->qid);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0e..9e9a1b96bc98 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -198,10 +198,20 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	return ret;
 }
 
-static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl)
+static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
+	bool needs_auth = nvmet_has_auth(ctrl, req);
+
+	/*
+	 * For secure concatenation the DH-HMAC-CHAP negotiation
+	 * should only run on the admin queue; the I/O queues should
+	 * be using TLS with the generated PSK.
+	 */
+	if (req->sq->concat && req->sq->qid)
+		needs_auth = false;
+
 	return (u32)ctrl->cntlid |
-		(nvmet_has_auth(ctrl) ? NVME_CONNECT_AUTHREQ_ATR : 0);
+		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
 
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
@@ -255,7 +265,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
-	ret = nvmet_setup_auth(ctrl);
+	ret = nvmet_setup_auth(ctrl, req);
 	if (ret < 0) {
 		pr_err("Failed to setup authentication, error %d\n", ret);
 		nvmet_ctrl_put(ctrl);
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
+		req->sq->tls_key ? ", TLS" : "");
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
@@ -336,7 +347,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..dcf13cbe7424 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -112,6 +112,7 @@ struct nvmet_sq {
 #ifdef CONFIG_NVME_TARGET_AUTH
 	bool			authenticated;
 	struct delayed_work	auth_expired_work;
+	bool			concat;
 	u16			dhchap_tid;
 	u16			dhchap_status;
 	int			dhchap_step;
@@ -121,6 +122,7 @@ struct nvmet_sq {
 	u32			dhchap_s2;
 	u8			*dhchap_skey;
 	int			dhchap_skey_len;
+	struct key		*tls_key;
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
@@ -711,7 +713,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+int nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -721,16 +723,18 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
-	return ctrl->host_key != NULL;
+	return ctrl->host_key != NULL && !req->sq->tls_key;
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 				u8 *buf, int buf_size);
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
+void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
-static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl,
+				   struct nvmet_req *req)
 {
 	return 0;
 }
@@ -743,11 +747,13 @@ static inline bool nvmet_check_auth_status(struct nvmet_req *req)
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
+static void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
 #endif
 
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3d606ab01506..87d818a1da0c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1812,6 +1812,32 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	spin_unlock_bh(&queue->state_lock);
 
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
+
+	if (!status) {
+		struct key *tls_key = key_lookup(peerid);
+
+		if (IS_ERR(tls_key)) {
+			pr_warn("%s: queue %d failed to lookup key %x\n",
+				__func__, queue->idx, peerid);
+			spin_lock_bh(&queue->state_lock);
+			queue->state = NVMET_TCP_Q_FAILED;
+			spin_unlock_bh(&queue->state_lock);
+			status = PTR_ERR(tls_key);
+		} else if (test_bit(KEY_FLAG_REVOKED, &tls_key->flags) ||
+			   test_bit(KEY_FLAG_INVALIDATED, &tls_key->flags)) {
+			pr_warn("%s: queue %d key %08x invalid\n",
+				__func__, queue->idx, peerid);
+			key_put(tls_key);
+			spin_lock_bh(&queue->state_lock);
+			queue->state = NVMET_TCP_Q_FAILED;
+			spin_unlock_bh(&queue->state_lock);
+			status = -EKEYREVOKED;
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


