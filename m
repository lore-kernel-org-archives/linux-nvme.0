Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30511D58E7D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9p20XPJoNRiLXv2IBANsHIbiS8fe1UZ+GRDerFSuFhY=; b=pdYGXFTNwEICRDgHvDCePRnF9l
	bb+6rmzjiMcTfthbGzp4jVAk6hWiGb4uES6QqcUuzZoviECukYmv6ampivu2WXUEco3G5OBbr8AU1
	S5WkduF4QvNBlBA0KKrteQ1ocKqGZ93M7KfB9TFrofA5bVqKI9aRDw+mBI7gHTvLSxBeqKXaVZhzd
	UmldubPulOCD/3derXwGA5o2/IAHU+4YfKRyDNVGl9NlwWMtZCJRBhp6tCkNdFhXB1F1B0VZ72Gjy
	ZB4L469tZuRRfgpKLNt6FTks3UJzcOXBoai6p0AEXXlHYfRlriVYHHXxZD80HeNdhB8PsmZbx+zr8
	dylGwlPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDS-0000000CSYJ-2nCJ;
	Mon, 02 Mar 2026 08:01:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDQ-0000000CSXQ-3YmE
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 342CB6012B;
	Mon,  2 Mar 2026 08:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD821C4AF09;
	Mon,  2 Mar 2026 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438480;
	bh=xQ5RtD94C3LBzXx6yIdHXsl3lt/lINUQ+CN4ouJkUEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOI8/EPzmL6q6C262MSNJOTpavVZ7BbeYmZTnf0E5xzXcOevrwwCwO2/xB2j5nDPn
	 Ebg6zddVEZ/DcQB0k4soRK4v7FuBRPPyL74+cf+iQy9hTw1lWTSZu6/U7FKOycgLN3
	 hhiOcOa0gYmgRDC+IryfI4ULSa918wNK8uiivOp7E4AW6LPFLQoW+wqKSUQ4QzJ996
	 XfMykgBIFQwTeeE0Py60XXxaLpxThXpS2YniuTM31Ix8D8+6cK8qIdFWDhkqfYenIE
	 bMxvKg1sHGTuUPUl0mMeh5U2E+IBBH5K9dxZOrfO2Gatq8zFM8ts1GeQiUdU7+2On7
	 Et1qcp4m/AK3Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 01/21] nvme-auth: add NVME_AUTH_MAX_DIGEST_SIZE constant
Date: Sun,  1 Mar 2026 23:59:39 -0800
Message-ID: <20260302075959.338638-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Define a NVME_AUTH_MAX_DIGEST_SIZE constant and use it in the
appropriate places.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 6 ++----
 drivers/nvme/host/auth.c   | 6 +++---
 include/linux/nvme.h       | 5 +++++
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index e07e7d4bf8b68..78d751481fe31 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -13,12 +13,10 @@
 #include <crypto/dh.h>
 #include <crypto/hkdf.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
 
-#define HKDF_MAX_HASHLEN 64
-
 static u32 nvme_dhchap_seqnum;
 static DEFINE_MUTEX(nvme_dhchap_mutex);
 
 u32 nvme_auth_get_seqnum(void)
 {
@@ -767,11 +765,11 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 		u8 *psk_digest, u8 **ret_psk)
 {
 	struct crypto_shash *hmac_tfm;
 	const char *hmac_name;
 	const char *label = "nvme-tls-psk";
-	static const char default_salt[HKDF_MAX_HASHLEN];
+	static const char default_salt[NVME_AUTH_MAX_DIGEST_SIZE];
 	size_t prk_len;
 	const char *ctx;
 	unsigned char *prk, *tls_key;
 	int ret;
 
@@ -796,11 +794,11 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 	if (!prk) {
 		ret = -ENOMEM;
 		goto out_free_shash;
 	}
 
-	if (WARN_ON(prk_len > HKDF_MAX_HASHLEN)) {
+	if (WARN_ON(prk_len > NVME_AUTH_MAX_DIGEST_SIZE)) {
 		ret = -EINVAL;
 		goto out_free_prk;
 	}
 	ret = hkdf_extract(hmac_tfm, psk, psk_len,
 			   default_salt, prk_len, prk);
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cfe..301c858b7c577 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -36,13 +36,13 @@ struct nvme_dhchap_queue_context {
 	u8 status;
 	u8 dhgroup_id;
 	u8 hash_id;
 	u8 sc_c;
 	size_t hash_len;
-	u8 c1[64];
-	u8 c2[64];
-	u8 response[64];
+	u8 c1[NVME_AUTH_MAX_DIGEST_SIZE];
+	u8 c2[NVME_AUTH_MAX_DIGEST_SIZE];
+	u8 response[NVME_AUTH_MAX_DIGEST_SIZE];
 	u8 *ctrl_key;
 	u8 *host_key;
 	u8 *sess_key;
 	int ctrl_key_len;
 	int host_key_len;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e722..edfebbce67453 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1835,10 +1835,15 @@ enum {
 	NVME_AUTH_HASH_SHA384	= 0x02,
 	NVME_AUTH_HASH_SHA512	= 0x03,
 	NVME_AUTH_HASH_INVALID	= 0xff,
 };
 
+/* Maximum digest size for any NVME_AUTH_HASH_* value */
+enum {
+	NVME_AUTH_MAX_DIGEST_SIZE = 64,
+};
+
 /* Defined Diffie-Hellman group identifiers for DH-HMAC-CHAP authentication */
 enum {
 	NVME_AUTH_DHGROUP_NULL		= 0x00,
 	NVME_AUTH_DHGROUP_2048		= 0x01,
 	NVME_AUTH_DHGROUP_3072		= 0x02,
-- 
2.53.0


