Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1F2CA0EEB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 03:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5i20GP63u2qqR/CFD3DZ5ARyopi8xiCc7jkM0fjQKEU=; b=OKaYmCpJE7mymrGXtoC8HGKz97
	zrieajn2lzTI+mEklD9fKUGIC2Tb2Whp6jc9U4HbzJwCQJxu8dl86mzcxqabFGWFFS62tWyulyBvx
	ousANxuWkqnpcgEVKGu6oeE4XZtlWQFULC5KbV1Cm/UPB2CCd/ZGnzupqat5741I07Uh+x1QYwvPn
	ZLiBOsfDG89pMWaw9gkHFqPzpsRwSQANl5EYr1cLmp9O4D/+8YrNPiwP+Uf/IoM8/8YVIKP55qj93
	6nyyqNcan8L0pVc983m0k/q4n26EFjsVuR6jkCFe4/W+9DzzaX8PvjBHi6SWPq8PonCsJHmcKkqGd
	4ua7w9Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upIJ5-00000001MiR-2UOk;
	Fri, 22 Aug 2025 03:19:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upCDU-00000000XvZ-02nX
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 20:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755809339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5i20GP63u2qqR/CFD3DZ5ARyopi8xiCc7jkM0fjQKEU=;
	b=jGeqCvctksXwK5N+Xo4dyAEgkcxKOxsstx6UStOp3QSOiafrGQF8QjhduBS6GElZxvvpsH
	zJk0GrTLfNAWzjtsaxor+5Oyc6f6DFuNZRbesayn2nh6IVEE/sxfva38HeorC3ZvJvdBZJ
	0uWHR6VIrO4Y5jamRQuplVMhNwEdPf8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-y7e1yRIHPc2hefvWdAitQg-1; Thu,
 21 Aug 2025 16:48:57 -0400
X-MC-Unique: y7e1yRIHPc2hefvWdAitQg-1
X-Mimecast-MFC-AGG-ID: y7e1yRIHPc2hefvWdAitQg_1755809335
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83D1819560A2;
	Thu, 21 Aug 2025 20:48:54 +0000 (UTC)
Received: from my-developer-toolbox-latest.redhat.com (unknown [10.2.16.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F40D1977689;
	Thu, 21 Aug 2025 20:48:51 +0000 (UTC)
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
Subject: [PATCH v2 1/2] nvme-auth: add hkdf_expand_label()
Date: Thu, 21 Aug 2025 13:48:15 -0700
Message-ID: <20250821204816.2091293-2-cleech@redhat.com>
In-Reply-To: <20250821204816.2091293-1-cleech@redhat.com>
References: <20250821204816.2091293-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_134900_117765_2B41D968 
X-CRM114-Status: GOOD (  12.59  )
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

Provide an implementation of RFC 8446 (TLS 1.3) HKDF-Expand-Label

Signed-off-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 91e273b89fea3..c6eae8e6b6f99 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -683,6 +683,59 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
 
+/**
+ * hkdf_expand_label - HKDF-Expand-Label (RFC 8846 section 7.1)
+ * @hmac_tfm: hash context keyed with pseudorandom key
+ * @label: ASCII label without "tls13 " prefix
+ * @labellen: length of @label
+ * @context: context bytes
+ * @contextlen: length of @context
+ * @okm: output keying material
+ * @okmlen: length of @okm
+ *
+ * Build the TLS 1.3 HkdfLabel structure and invoke hkdf_expand().
+ *
+ * Returns 0 on success with output keying material stored in @okm,
+ * or a negative errno value otherwise.
+ */
+static int hkdf_expand_label(struct crypto_shash *hmac_tfm,
+		const u8 *label, unsigned int labellen,
+		const u8 *context, unsigned int contextlen,
+		u8 *okm, unsigned int okmlen)
+{
+	int err;
+	u8 *info;
+	unsigned int infolen;
+	const char *tls13_prefix = "tls13 ";
+	unsigned int prefixlen = strlen(tls13_prefix);
+
+	if (WARN_ON(labellen > (255 - prefixlen)))
+		return -EINVAL;
+	if (WARN_ON(contextlen > 255))
+		return -EINVAL;
+
+	infolen = 2 + (1 + prefixlen + labellen) + (1 + contextlen);
+	info = kzalloc(infolen, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	/* HkdfLabel.Length */
+	put_unaligned_be16(okmlen, info);
+
+	/* HkdfLabel.Label */
+	info[2] = prefixlen + labellen;
+	memcpy(info + 3, tls13_prefix, prefixlen);
+	memcpy(info + 3 + prefixlen, label, labellen);
+
+	/* HkdfLabel.Context */
+	info[3 + prefixlen + labellen] = contextlen;
+	memcpy(info + 4 + prefixlen + labellen, context, contextlen);
+
+	err = hkdf_expand(hmac_tfm, info, infolen, okm, okmlen);
+	kfree_sensitive(info);
+	return err;
+}
+
 /**
  * nvme_auth_derive_tls_psk - Derive TLS PSK
  * @hmac_id: Hash function identifier
-- 
2.50.1


