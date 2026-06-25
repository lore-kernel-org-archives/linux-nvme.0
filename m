Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05E4CDE000
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CmnqN0Danv7ElOphfIciwt9WXbAOE7CWgRjRgaJy6oc=; b=X61MdA+yHGimdmZgJD2+Ydxq4W
	NgGNqWAwPnwa+MVbYvY5tcKawI7RzUII4QTB5bYtbM5RFjJ9thCppsikG/LTFCnNtO5evrSqA/mIL
	IrZwTz/O/+xxaDiZSRKprQ10PojvIyfQxwt7Hm0l1aH70P5LPawKXPoZrlST+HBUb1/dRDjI+hSHZ
	RSLrBRAvsZTnp5qnESvGLiLnsP6Jh5RFvXe59IKQvA1MKrozoOONoi6dUkY3dwGaT59LmAFxptO0f
	c4SY9d8FTDPf6HubPMGs7lrMyrUFVfjSXUcHNwtuFowi/gJTBwPEvy+COjlfyFAL+QMtw67atp08O
	vthp+TNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcoMb-00000009eTD-41KB;
	Thu, 25 Jun 2026 17:59:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcoMW-00000009eT7-2Q4t
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 17:59:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B73460098;
	Thu, 25 Jun 2026 17:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3AF1F000E9;
	Thu, 25 Jun 2026 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410379;
	bh=CmnqN0Danv7ElOphfIciwt9WXbAOE7CWgRjRgaJy6oc=;
	h=From:To:Cc:Subject:Date;
	b=ZCLqgFgtGsUwkfvcP4dshu5t8LHSeu3LN0kB240TPGIG1ghmpVN7hmLVPi30p6Vpo
	 1MeW3ZwJzh7U/ASKxgRMMlVVS+Vc2xHgDJ1Z04QRWSfT9Yb6FmHTNhT9HxcAHHFweK
	 8AB39pf19rc8rPHAe5ukP30A/VrlyWZVLYYDZdRnueEfSKmEmQT0jISf7JUVs/oVn9
	 uf9iTo0hmxV48cjVSKu/34FDigx6XRNGw/+RzrvHg9rxBhM/h/CTHdYfUdnQV9XHqk
	 XButRHv66xlHdxVV2u3JQWKoH+UVUWunuqvgDsiZaEZ68jh8TSKE1TMKD8O/t9dYro
	 sXVj50P5zd1aQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Eric Biggers <ebiggers@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme-auth: Avoid C=1 warning in nvme_auth_derive_tls_psk()
Date: Thu, 25 Jun 2026 10:59:11 -0700
Message-ID: <20260625175911.35094-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
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

The following works fine with gcc and clang, but sparse warns about
label_len not being an actual constant expression:

    const size_t label_len = sizeof(label) - 1;
    ...
    static_assert(label_len <= 255);

Avoid this by giving label an explicit length and using sizeof(label)
instead of label_len.

Reported-by: John Garry <john.g.garry@oracle.com>
Closes: https://lore.kernel.org/linux-nvme/965a37dd-f698-46b6-9623-1099a13f7e60@oracle.com
Fixes: d126cbaa7d9a ("nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 77f1d22512f8..e2e0c736540a 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -690,12 +690,11 @@ EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
  */
 int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
 			     const char *psk_digest, u8 **ret_psk)
 {
 	static const u8 default_salt[NVME_AUTH_MAX_DIGEST_SIZE];
-	static const char label[] = "tls13 nvme-tls-psk";
-	const size_t label_len = sizeof(label) - 1;
+	static const char label[18] = "tls13 nvme-tls-psk";
 	u8 prk[NVME_AUTH_MAX_DIGEST_SIZE];
 	size_t hash_len, ctx_len;
 	u8 *hmac_data = NULL, *tls_key;
 	size_t i;
 	int ret;
@@ -727,11 +726,11 @@ int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
 	 * HKDF-Expand-Label (RFC 8446 section 7.1), with output length equal to
 	 * the hash length (so only a single HMAC operation is needed)
 	 */
 
 	hmac_data = kmalloc(/* output length */ 2 +
-			    /* label */ 1 + label_len +
+			    /* label */ 1 + sizeof(label) +
 			    /* context (max) */ 1 + 3 + 1 + strlen(psk_digest) +
 			    /* counter */ 1,
 			    GFP_KERNEL);
 	if (!hmac_data) {
 		ret = -ENOMEM;
@@ -741,14 +740,14 @@ int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
 	i = 0;
 	hmac_data[i++] = hash_len >> 8;
 	hmac_data[i++] = hash_len;
 
 	/* label */
-	static_assert(label_len <= 255);
-	hmac_data[i] = label_len;
-	memcpy(&hmac_data[i + 1], label, label_len);
-	i += 1 + label_len;
+	static_assert(sizeof(label) <= 255);
+	hmac_data[i] = sizeof(label);
+	memcpy(&hmac_data[i + 1], label, sizeof(label));
+	i += 1 + sizeof(label);
 
 	/* context */
 	ctx_len = sprintf(&hmac_data[i + 1], "%02d %s", hmac_id, psk_digest);
 	if (ctx_len > 255) {
 		ret = -EINVAL;

base-commit: a142da0b2d32b68a6d1b183343bbe43de8c222f9
-- 
2.54.0


