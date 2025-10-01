Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB669CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGg9ECmpIk+y9gKhVf8v3iQuBRLzgs1viDz4oMh7EbU=; b=aj0GpiVsK1+G8i83cI0WTM8FpJ
	RYd8okLXXZXx7KjOjBfMAfHlsiNhhEeLG2zZQd4R/DmklZeykJ+otGjolMsD1xjK2xW5RJVWtiRY0
	qHi+vBPXqjB2NqfMWBe5k8GzMdc54TO9xDCAkNqOKM6D1PDnRXPmwCEOLfpu5gt18rq3b0jeWFvsx
	zheHMKKcQcE6wk7QkdxVt8+MLNi36Z0eBBoQE/Nb9j2qUVZG7ALSMZXk69CfIkFUuR0pXPiunPRic
	TItoYarN6waiL1xxQm81lqrbNY57hidrltPdKmd52SeGmgmOHYjosZm6esdCLsR6YEifh28m/K61D
	qcXg+u1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xim-00000008A5X-0VoL;
	Wed, 01 Oct 2025 14:22:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xij-00000008A3P-0dig
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 14:22:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 915714559A;
	Wed,  1 Oct 2025 14:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C13DC4CEF1;
	Wed,  1 Oct 2025 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328536;
	bh=kkBXSDS6mb3i6mhxEC+vg93qVM7i851nyLV1eCWg1ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LebMvpxwbOGB8wjElUwG7/Cjco9RpJ+JoQ11hXas6TW8jAoIkQGZt47u6rxvLdXRU
	 C64DGXtXfEBliEuW8AaVUMaVCn2d/pY/JUvu6MdyIDsWKawVycmX7qhAWJq2YCfKXk
	 meTSGNOEyFtvB6XzgvNb8PeaJ3ecv21wukmNlv6QopV6Lrv2qSuylYsIrw/3d/LczJ
	 +943svzubQPeVirZAj8A9dAE1NKSKKiwXtjwPBGXZnMq2HUA/7uM3+8YY744c83i14
	 dQ/ezyvm1KIXqc1Hlss9NvKzt70sYGbocTLen00yORfkIda9ibuQ9oJWe4+fVjpfeJ
	 onkV1VbudTP2w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] nvme-auth: move declaration of nvme_auth_extract_key()
Date: Wed,  1 Oct 2025 16:22:00 +0200
Message-ID: <20251001142200.61696-4-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001142200.61696-1-hare@kernel.org>
References: <20251001142200.61696-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_072217_230742_87C1F229 
X-CRM114-Status: GOOD (  12.60  )
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

nvme_auth_extract_key() is used outside of the authentication code,
so we need to provide a stub function if it's not available.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509302359.TL1868ni-lkp@intel.com/
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/nvme.h    | 9 +++++++++
 drivers/nvme/target/nvmet.h | 9 +++++++++
 include/linux/nvme-auth.h   | 2 --
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index de24185dfbea..8dfd3db8761d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1179,6 +1179,8 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl);
+struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
+				  size_t secret_len, bool *generated);
 #else
 static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1202,6 +1204,13 @@ static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
+static inline struct key *nvme_auth_extract_key(struct key *keyring,
+						const u8 *secret,
+						size_t secret_len,
+						bool *generated)
+{
+	return ERR_PTR(-ENOKEY);
+}
 #endif
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b73d9589e043..49d397e1b678 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -895,6 +895,8 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
+struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
+				  size_t secret_len, bool *generated);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
 u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
@@ -937,6 +939,13 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl,
 }
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
 static inline void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
+static inline struct key *nvme_auth_extract_key(struct key *keyring,
+						const u8 *secret,
+						size_t secret_len,
+						bool *generated)
+{
+	return ERR_PTR(-ENOKEY);
+}
 #endif
 
 int nvmet_pr_init_ns(struct nvmet_ns *ns);
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index a9ae1d60a5f9..79671dfaa0ac 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -18,8 +18,6 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
-struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret, size_t secret_len,
-				  bool *generated);
 int nvme_auth_transform_key(struct key *key, char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.43.0


