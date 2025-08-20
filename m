Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF20CA0EFC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPL09WQachXGpfEO59RvnStFncxlVshfbc7pkbF/diM=; b=OPNKfB99i0qGHB11AOmrdjUTBF
	tfJhjspZjExiDbJgje4fXi9aN/0sEXH39f06ZzUGCVyprqi5zwglk/aUiRvk2vSTFQIrqeetLUwWs
	jpCVzSn+sV8sXvYpSOwkIlcAiu79UZU7FzJL6Cqz/1Z/o/z6GSNUmb2zjm27/6mRFDwWVFQIew7GS
	h51gbmGXXQQsfSmm15kiRZyHGkAjrLCmRV2p7jL7K3W8lz4bmBn9oyZRnyOl0/op3GZKbtvTL6yCu
	WAkRHG0xiFCdAU2VnzOKAauQkCLB29wbWIQ+yqTXsi95K2RUqmCUBQga/njdMjfFqOfl18TXzXLQF
	xMf/O5wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uogbu-0000000DHeK-3OfC;
	Wed, 20 Aug 2025 11:04:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoers-0000000CrmK-06eU
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 09:12:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 713A261435;
	Wed, 20 Aug 2025 09:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D96DC116B1;
	Wed, 20 Aug 2025 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755681146;
	bh=pMfSvaExQHHkwM3rVWhpbkvPdA+fq4O1VYkNwpioE2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXL05qEgwqPke6/6Dq1D9ySgcSua1cKaQFZ91coRY5q//tD+4DF1MPtANddJIiYB9
	 QLaLKTusLyvkaLpfIJkwPf2U0Ohy7zYF3djHa+QNA/0lv1VWkram24gm++Uy4R4E4A
	 PVy7lBl8v//iekOMaYSVHOCMrdA68Ibe8nXB2mNy6ZT2O90wBYwk43XI14HuVXVHXf
	 x/R0jFEjsfTB3cPD/oTPGErhwVrowHNjZqDZuULYX5qaqP/QKhlfaPnW8tzcFXiZdy
	 2jCYoN27CkWIEP2ZaQnu2zw1qIcHRejm96faKXmfSFb8IH0AOyB9M+VCATtStwxRGA
	 YwzCxyNDXkAwQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme-auth: use hkdf_expand_label()
Date: Wed, 20 Aug 2025 11:12:11 +0200
Message-ID: <20250820091211.25368-3-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091211.25368-1-hare@kernel.org>
References: <20250820091211.25368-1-hare@kernel.org>
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

From: Hannes Reinecke <hare@kernel.org>

When generating keying material during an authentication transaction
(secure channel concatenation), the HKDF-Expand-Label function is part
of the specified key derivation process.

The current open-coded implementation misses the length prefix
requirements on the HkdfLabel label and context variable-length vectors
(RFC 8446 Section 3.4).

Instead, use the hkdf_expand_label() function.

Signed-off-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 91e273b89fea..5ea4d6d9a394 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -715,10 +715,10 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 {
 	struct crypto_shash *hmac_tfm;
 	const char *hmac_name;
-	const char *psk_prefix = "tls13 nvme-tls-psk";
+	const char *label = "nvme-tls-psk";
 	static const char default_salt[HKDF_MAX_HASHLEN];
-	size_t info_len, prk_len;
-	char *info;
+	size_t prk_len;
+	const char *ctx;
 	unsigned char *prk, *tls_key;
 	int ret;
 
@@ -758,36 +758,29 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 	if (ret)
 		goto out_free_prk;
 
-	/*
-	 * 2 additional bytes for the length field from HDKF-Expand-Label,
-	 * 2 additional bytes for the HMAC ID, and one byte for the space
-	 * separator.
-	 */
-	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;
-	info = kzalloc(info_len + 1, GFP_KERNEL);
-	if (!info) {
+	ctx = kasprintf(GFP_KERNEL, "%02d %s", hmac_id, psk_digest);
+	if (!ctx) {
 		ret = -ENOMEM;
 		goto out_free_prk;
 	}
 
-	put_unaligned_be16(psk_len, info);
-	memcpy(info + 2, psk_prefix, strlen(psk_prefix));
-	sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);
-
 	tls_key = kzalloc(psk_len, GFP_KERNEL);
 	if (!tls_key) {
 		ret = -ENOMEM;
-		goto out_free_info;
+		goto out_free_ctx;
 	}
-	ret = hkdf_expand(hmac_tfm, info, info_len, tls_key, psk_len);
+	ret = hkdf_expand_label(hmac_tfm,
+				label, strlen(label),
+				ctx, strlen(ctx),
+				tls_key, psk_len);
 	if (ret) {
 		kfree(tls_key);
-		goto out_free_info;
+		goto out_free_ctx;
 	}
 	*ret_psk = tls_key;
 
-out_free_info:
-	kfree(info);
+out_free_ctx:
+	kfree(ctx);
 out_free_prk:
 	kfree(prk);
 out_free_shash:
-- 
2.43.0


