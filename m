Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63A606A683
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v5p3VP3l;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMxmOdxB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kpbtvaB7rNc831AdB8kZYufsKmb653WR+Us6fw/+9uI=; b=v5p3VP3ln4vD94
	ba+fiVfFbFK7F3LnYdjPFFWETy/c9AKqNGWa6vg0ZkaZM+yFx54nYZ1Vl4jTuHxkMuH+qwqXvvDjW
	KUzs+5m1hPz1D5UcuB3oDskHNFH5bZl//TYYeQaNC2HjgtXRsb1wXOg7zauKOK5GINLEEqHS/DLTt
	WNgkjivuWd9oHCcnLPSRHxVdT1cOFBIWt7h8pgFh9wT1pRuiqQcsYWahJ1yEChGmjV44Ya5F7t8wX
	3i5aBZFKgLeiVn049TH0PlVTik1CCU7RncxVOWazGKUNI7tmv/FTvT4Wa+JouSw/vZS4XnHJoVkBP
	RV/dQhR7gHcuJBg7vdSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaER-0000000DV6B-1u2X;
	Thu, 26 Nov 2026 14:13:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaEJ-0000000DUwP-0DZB
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:13:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3615761E32;
	Thu, 26 Nov 2026 14:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6C61F00A00;
	Thu, 26 Nov 2026 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702421;
	bh=kpbtvaB7rNc831AdB8kZYufsKmb653WR+Us6fw/+9uI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MMxmOdxBybnpInwt7Y6I37NxFkooNloQKnjqtU00PD57zASzSpnTcD2kEuR+wZeMZ
	 +epb6TmP7lTHAPJXiZiCvDYPqw2D2g0QiYRJGK1rLo8m005lH02fD/Z5o8H9k8J1sH
	 MpxM3lD4z76146bzyaRrnfG2Lm3s6Cne9Ysq7FyKdpwC08n91kaqof2V4a5sBM/rDJ
	 Mm2GOW78J7w6FI/emrcb07p/wUZ/dnmqlk2T+SMGuhSk52AUScg1gNFykJvFs1XVUG
	 ofYdP71E03K0V10U3K9J58kq09eOdtKryN7CVtz+SfLegFjm/pf3A1gNXH3Pf8T5L5
	 TBwvWTw2ls6+A==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:31 +0100
Subject: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into .nvme
 keyring
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=6313;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=3+ZJ/ZSIa4DS9ocE1tV9Oje8uvDyUQ0rqwrR9ddzSXw=;
 b=DryPDsJ3DrYLFe0K/yfjWGiiDcjj+WKsTwuKaZJNzKvzt1BifD6TCE87aDuPxT1S/3iMO00qE
 DBeg5fJFJ+hCbWjiGttHR+V48nMvZQ7ijFT/at1SBmyrLAX3hmOzTBn
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pre-provisioned keys might live in a different keyring which might
have a different lifetime than the structures referencing the key.
So to ensure the key remains accessible link the pre-provisioned key
into the .nvme keyring, and unlink it once it's no longer needed.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/fabrics.c | 48 +++++++++++++++++++++++++++++++++------------
 drivers/nvme/target/auth.c  | 39 +++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 12a30ed16f9ef32c74a51a0ae6ff8ce0ea628301..e7f51474ab5e1f67fca21d84c4bddcbe9e557571 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1115,7 +1115,17 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			ret = PTR_ERR(key);
 			goto out;
 		}
-		pr_debug("using dhchap host key %08x\n", key_serial(key));
+		if (!opts->dhchap_key_generated) {
+			pr_debug("linking dhchap host key %08x\n", key_serial(key));
+			ret = nvme_keyring_link(key);
+			if (ret) {
+				pr_debug("failed to link dhchap host key %08x\n",
+					 key_serial(key));
+				key_put(key);
+				goto out;
+			}
+		} else
+			pr_debug("using dhchap host key %08x\n", key_serial(key));
 		opts->dhchap_key = key_serial(key);
 		key_put(key);
 #endif
@@ -1133,7 +1143,17 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			ret = PTR_ERR(key);
 			goto out;
 		}
-		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
+		if (!opts->dhchap_ctrl_key_generated) {
+			pr_debug("linking dhchap ctrl key %08x\n", key_serial(key));
+			ret = nvme_keyring_link(key);
+			if (ret) {
+				pr_warn("failed to link dhchap ctrl key %08x\n",
+					key_serial(key));
+				key_put(key);
+				goto out;
+			}
+		} else
+			pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
 		opts->dhchap_ctrl_key = key_serial(key);
 		key_put(key);
 #endif
@@ -1346,23 +1366,27 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	struct key *key;
 
 	nvmf_host_put(opts->host);
-	if (opts->dhchap_key &&
-	    opts->dhchap_key_generated) {
+	if (opts->dhchap_key) {
 		key = key_lookup(opts->dhchap_key);
 		if (!IS_ERR(key)) {
-			pr_debug("revoke dhchap host key %08x\n",
-				 opts->dhchap_key);
-			key_revoke(key);
+			if (opts->dhchap_key_generated) {
+				pr_debug("revoke dhchap host key %08x\n",
+					 opts->dhchap_key);
+				key_revoke(key);
+			} else
+				nvme_keyring_unlink(key);
 			key_put(key);
 		}
 	}
-	if (opts->dhchap_ctrl_key &&
-	    opts->dhchap_ctrl_key_generated) {
+	if (opts->dhchap_ctrl_key) {
 		key = key_lookup(opts->dhchap_ctrl_key);
 		if (!IS_ERR(key)) {
-			pr_debug("revoke dhchap ctrl key %08x\n",
-				 opts->dhchap_ctrl_key);
-			key_revoke(key);
+			if (opts->dhchap_ctrl_key_generated) {
+				pr_debug("revoke dhchap ctrl key %08x\n",
+					 opts->dhchap_ctrl_key);
+				key_revoke(key);
+			} else
+				nvme_keyring_unlink(key);
 			key_put(key);
 		}
 	}
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 54e79c8a7cae67a509a9f6b993b7886e706af8e0..04a9177ffa1f48445b54f0b6ec3f63e7c111fe06 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -19,19 +19,20 @@
 
 #include "nvmet.h"
 
-static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
+static int nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
 				  struct key *new_key, bool new_generated)
 {
 	key_serial_t old_key_id = 0, new_key_id = key_serial(new_key);
 	struct key *key = NULL;
 	bool generated = false;
+	int ret;
 
 	if (set_ctrl) {
 		if (host->dhchap_ctrl_key) {
 			if (host->dhchap_ctrl_key == new_key_id) {
 				if (new_key && new_generated)
 					key_revoke(new_key);
-				return;
+				return 0;
 			}
 			old_key_id = host->dhchap_ctrl_key;
 			generated = host->dhchap_ctrl_key_generated;
@@ -44,7 +45,7 @@ static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
 			if (host->dhchap_key == new_key_id) {
 				if (new_key && new_generated)
 					key_revoke(new_key);
-				return;
+				return 0;
 			}
 			old_key_id = host->dhchap_key;
 			generated = host->dhchap_key_generated;
@@ -53,18 +54,37 @@ static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
 		host->dhchap_key = new_key_id;
 		host->dhchap_key_generated = new_generated;
 	}
+	if (new_key && !new_generated) {
+		ret = nvme_keyring_link(new_key);
+		if (ret < 0) {
+			pr_warn("%s: failed to link %s key %08x\n",
+				__func__, set_ctrl ? "ctrl" : "host",
+				key_serial(new_key));
+			return ret;
+		}
+	}
+
 	if (!old_key_id)
-		return;
+		return 0;
 
 	key = key_lookup(old_key_id);
 	if (IS_ERR(key))
-		return;
+		return PTR_ERR(key);
 	if (generated) {
 		pr_debug("%s: revoke %s key %08x\n", __func__,
 			 set_ctrl ? "ctrl" : "host", key_serial(key));
 		key_revoke(key);
+		ret = 0;
+	} else {
+		ret = nvme_keyring_unlink(key);
+		if (ret < 0) {
+			pr_warn("%s: failed to unlink %s key %08x\n",
+				__func__, set_ctrl ? "ctrl" : "host",
+				key_serial(new_key));
+		}
 	}
 	key_put(key);
+	return ret;
 }
 
 void nvmet_auth_clear_key(struct nvmet_host *host)
@@ -79,12 +99,13 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	bool generated = false;
 	struct key *key;
 	size_t len;
+	int ret;
 
 	if (!secret || !strlen(secret)) {
 		down_write(&nvmet_config_sem);
-		nvmet_auth_update_key(host, set_ctrl, NULL, false);
+		ret = nvmet_auth_update_key(host, set_ctrl, NULL, false);
 		up_write(&nvmet_config_sem);
-		return 0;
+		return ret;
 	}
 	len = strcspn(secret, "\n");
 	key = nvme_auth_extract_key(secret, len, &generated);
@@ -102,10 +123,10 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	}
 	up_read(&key->sem);
 	down_write(&nvmet_config_sem);
-	nvmet_auth_update_key(host, set_ctrl, key, generated);
+	ret = nvmet_auth_update_key(host, set_ctrl, key, generated);
 	up_write(&nvmet_config_sem);
 	key_put(key);
-	return 0;
+	return ret;
 }
 
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)

-- 
2.51.0


