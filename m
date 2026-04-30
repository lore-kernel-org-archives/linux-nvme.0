Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018E7FF8873
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l19SwcoHQANPNejYcLk98Rv43NxmV+iIq/6ocaZfI2k=; b=NtbVSJeBq0akqwuBiWZ74a+Sz6
	GuaIciHPPcmr22WvgAq8m1WflRkJiN3xSEtNwfRr0wdsPm8xPd+yozPk34DdAoPANwNo7HigjmQR8
	lnS9WkaoLPT7mtwEyPqNmoJ9YiJf4gjwK6HFIaEc3Y/Ig+dPjl+WK+vOUgIlH7+Y9MEg/3prHeviF
	EaYwiODGbIf9RbKTYFKVNFgaap+afZQ6NVjP1eBEp/rkP1nLsUngRg4r/hbkPFeaV1d4+yYGr8aVu
	a7zhAcbmaOwNRNV6IkWeLWOy/P3AUQqGn4VwYnd4cA6Uv5h9f1s9NhlEjzAcQVejSKsLUvPaQmgI5
	w6CpCmag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIRLp-00000005X1P-2Uvi;
	Thu, 30 Apr 2026 13:22:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIRLm-00000005X0b-2edo
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 13:22:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 653D043FB8;
	Thu, 30 Apr 2026 13:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B60C2BCB8;
	Thu, 30 Apr 2026 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555361;
	bh=3UvL58IQ8p03IcJ2F8GN6nJ1SjzNpLmmTyqSeMYgzjY=;
	h=From:To:Cc:Subject:Date:From;
	b=hXjzBTxVEyjZtwTQM3sDwKhcy6C485VllWmAH2k7YiL1sHow3HuoGd10FhoPbbp9v
	 /JqgRGvajr5elAlVgTDFaCZnoJZegTFHNC1c92E3HAYYLGpIuqDtWB6kcdO1KuXriF
	 pMs5SRUDE/GM0Sr0t8MY7a9sEzygvKxyh8FG8KhpvQufi6GQTB3SxY7eAyDo8C4fQs
	 b8fdZRmrv8w3Epckf1wBzbjln+Su4Amvh9aQt9X+QNBrchUHNcGwUUll4fDiDy5yqq
	 moXtTME6ptje3ksU0//65xgu01+LtPMe6QHNzHebBY1kiGPq58IZ/THGfgFA8iPEv/
	 gf4SdA+vKplcQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet-auth: Do not print DH-HMAC-CHAP secrets
Date: Thu, 30 Apr 2026 15:22:32 +0200
Message-ID: <20260430132232.91416-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_062242_711015_9E0670A3 
X-CRM114-Status: GOOD (  12.79  )
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

From a security standpoint we should not allow to print out the DH-HMAC-CHAP
secrets, but at the same time having them is useful for debugging
authentication failures.
So add a Kconfig option NVME_TARGET_AUTH_DEBUG to only enable debugging
if explictly requested at build time.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/Kconfig |  9 +++++++++
 drivers/nvme/target/auth.c  | 13 ++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 285a48b289c8..8bb1e38fdab4 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -125,6 +125,15 @@ config NVME_TARGET_AUTH
 
 	  If unsure, say N.
 
+config NVME_TARGET_AUTH_DEBUG
+	bool "NVMe over Fabrics In-band Authentication debug messages"
+	depends on NVME_TARGET_AUTH
+	help
+	  This enables additional debug messages including the generated
+	  DH-HMAC-CHAP secrets to help debugging authentication failures.
+
+	  If unsure, say N.
+
 config NVME_TARGET_PCI_EPF
 	tristate "NVMe PCI Endpoint Function target support"
 	depends on NVME_TARGET && PCI_ENDPOINT
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 9a2eccdc8b13..edb9627d97b0 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -144,7 +144,6 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		goto out_unlock;
 
 	list_for_each_entry(p, &ctrl->subsys->hosts, entry) {
-		pr_debug("check %s\n", nvmet_host_name(p->host));
 		if (strcmp(nvmet_host_name(p->host), ctrl->hostnqn))
 			continue;
 		host = p->host;
@@ -189,11 +188,12 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
+#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
 	pr_debug("%s: using hash %s key %*ph\n", __func__,
 		 ctrl->host_key->hash > 0 ?
 		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
 		 (int)ctrl->host_key->len, ctrl->host_key->key);
-
+#endif
 	nvme_auth_free_key(ctrl->ctrl_key);
 	if (!host->dhchap_ctrl_secret) {
 		ctrl->ctrl_key = NULL;
@@ -207,11 +207,12 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
+#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
 	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
 		 ctrl->ctrl_key->hash > 0 ?
 		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
 		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
-
+#endif
 out_free_hash:
 	if (ret) {
 		if (ctrl->host_key) {
@@ -317,7 +318,6 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		if (ret)
 			goto out_free_challenge;
 	}
-
 	pr_debug("ctrl %d qid %d host response seq %u transaction %d\n",
 		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
 		 req->sq->dhchap_tid);
@@ -434,8 +434,10 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 		ret = -EINVAL;
 	} else {
 		memcpy(buf, ctrl->dh_key, buf_size);
+#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
 		pr_debug("%s: ctrl %d public key %*ph\n", __func__,
 			 ctrl->cntlid, (int)buf_size, buf);
+#endif
 	}
 
 	return ret;
@@ -458,11 +460,12 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 					ctrl->shash_id);
 	if (ret)
 		pr_debug("failed to compute session key, err %d\n", ret);
+#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
 	else
 		pr_debug("%s: session key %*ph\n", __func__,
 			 (int)req->sq->dhchap_skey_len,
 			 req->sq->dhchap_skey);
-
+#endif
 	return ret;
 }
 
-- 
2.51.0


