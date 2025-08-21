Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE90CA0FE4
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 03:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8r0AdniSkpUyDQzUhdxUS1CDdb6tGNCWglBSYFRm2/I=; b=ZLFOx0MgyJB2TbvcvF/WOJZZHx
	jyOiMzdm0EoO5GGU2dPQGb7mDjyMjhsyvcwBYKXh7pa+zrJT2koYqe9JG6MGaia8ZtanZcATO2SpF
	CBKX2jyiA6sYTCtfDks2vn/vMY0MuV+JG+TbD5mU6Bb6q8E4ouHB/Qxe3eZGNq2Lj/iakT4LF5Fhn
	ad2A/I2MbSkajvabEjZetHsoTe+Sol2DG35jgpyQrK2JsMaG+ycZ2wnXrYv7WWrIpowrOkHCZr/5K
	soEcShSnL7BV4z4ZozJIUNf1T3ZpsUNzSZ154EGLjQNysV2SzKLdLEQZ1hD8+IASd7VwwSPZ/TtIw
	FB9VTadA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upIJ7-00000001Mk3-0Kaa;
	Fri, 22 Aug 2025 03:19:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upCDX-00000000XwD-1ru4
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 20:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755809342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8r0AdniSkpUyDQzUhdxUS1CDdb6tGNCWglBSYFRm2/I=;
	b=LspsHzBClW036jnN9OHwblO/4L6aiWQGb3sJGmV2wqtUG8gqmum9JF25mI7FJzlEozwyzX
	JECI7jCoc2HEWQBhVxRJAiWaMyoJmLNW4BVQzn5VnAjUXaCX2kk+ihWisD2big3vYaYRNe
	pR0JtwhUkDKAIjh3Cndp98psPfrx0FM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-4rEoukLGMlOEPPtxn-9yRw-1; Thu,
 21 Aug 2025 16:48:59 -0400
X-MC-Unique: 4rEoukLGMlOEPPtxn-9yRw-1
X-Mimecast-MFC-AGG-ID: 4rEoukLGMlOEPPtxn-9yRw_1755809338
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BCA18003FC;
	Thu, 21 Aug 2025 20:48:57 +0000 (UTC)
Received: from my-developer-toolbox-latest.redhat.com (unknown [10.2.16.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10CBE1977687;
	Thu, 21 Aug 2025 20:48:54 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 2/2] nvme-auth: use hkdf_expand_label()
Date: Thu, 21 Aug 2025 13:48:16 -0700
Message-ID: <20250821204816.2091293-3-cleech@redhat.com>
In-Reply-To: <20250821204816.2091293-1-cleech@redhat.com>
References: <20250821204816.2091293-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_134903_552351_490C87F4 
X-CRM114-Status: GOOD (  14.28  )
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
index c6eae8e6b6f99..1f51fbebd9fac 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -768,10 +768,10 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
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
 
@@ -811,36 +811,29 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
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
2.50.1


