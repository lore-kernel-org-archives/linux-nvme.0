Return-Path: <SRS0=S/y/=OA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD8C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 06:46:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58446109F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 06:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A58446109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=envJk+sEwV+yW2FS43HsTV+ywaLwR1KRG9wChfgHg74=; b=l46fUe0KqSolBK
	7p4Jc3M8dRQnZpaFUIwfM/YWATEZwAnDbVpH4Kp7PXjdwwRX4tp5bV82hO7+y284OaHtsQlIyJ6hY
	scdfCBzAoz64taA7nDZ1VnG4cbgGVmZNXkPmF+jwZtVoxv/Ehw+M39w3zrud7/SPbzDzIQsFhOWJg
	zjvzspa4yavIMPE7zFKCxm9nxqW9RZ3zE8JY+MsZhp3MnxutCezIyAd6r669JIsrJPSYInAQnvo+Z
	ZyzJ3lTiT82sdLwtbYKzTTDQxDMTB2f1hMDvI0WacX2kBpXIdaUcdwTHOASQ3COOeaiD8lmF740yH
	TifEUSkBW3m95PXjw/3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOaIQ-00BzKQ-Kl; Fri, 10 Sep 2021 06:45:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOaGH-00ByiI-5L
 for linux-nvme@lists.infradead.org; Fri, 10 Sep 2021 06:43:50 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2D27520207;
 Fri, 10 Sep 2021 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631256219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8un4PKeR6L7QoTK65EhYsB7UQCSve8TLUHAyYCXVdw=;
 b=slC3L+DXnfJOdvBYcCnTf5O3rxayIx+zsIxSyJwKfXWOi5EE7ip8MwQJT+KK2wJi+zD5SB
 l4jESECG/RvLJkcuJ9bI6s7FxmPJJjmICPq9+RafQKjCb8hKv8ONcEsKq/yASSqT+rC2O6
 h8XtHcDErVcGGXk3MgEGcn9ZuTP7Z0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631256219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8un4PKeR6L7QoTK65EhYsB7UQCSve8TLUHAyYCXVdw=;
 b=EzDZYfpZVjq5Uacf7U3ABcITx2RMxf6lYTRUMBYO6wGfvsa9PE2aP7NsU+1XxYqRR/K32H
 JqbipCpr8WbbrgBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id D6B05A3B97;
 Fri, 10 Sep 2021 06:43:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 9FDA7518E322; Fri, 10 Sep 2021 08:43:36 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/12] lib/base64: RFC4648-compliant base64 encoding
Date: Fri, 10 Sep 2021 08:43:14 +0200
Message-Id: <20210910064322.67705-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210910064322.67705-1-hare@suse.de>
References: <20210910064322.67705-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_234345_536486_3590A707 
X-CRM114-Status: GOOD (  22.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add RFC4648-compliant base64 encoding and decoding routines, based on
the base64url encoding in fs/crypto/fname.c.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/base64.h |  16 +++++++
 lib/Makefile           |   2 +-
 lib/base64.c           | 100 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/base64.h
 create mode 100644 lib/base64.c

diff --git a/include/linux/base64.h b/include/linux/base64.h
new file mode 100644
index 000000000000..660d4cb1ef31
--- /dev/null
+++ b/include/linux/base64.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * base64 encoding, lifted from fs/crypto/fname.c.
+ */
+
+#ifndef _LINUX_BASE64_H
+#define _LINUX_BASE64_H
+
+#include <linux/types.h>
+
+#define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
+
+int base64_encode(const u8 *src, int len, char *dst);
+int base64_decode(const char *src, int len, u8 *dst);
+
+#endif /* _LINUX_BASE64_H */
diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37..ce964f013412 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -46,7 +46,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
-	 percpu-refcount.o rhashtable.o \
+	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
diff --git a/lib/base64.c b/lib/base64.c
new file mode 100644
index 000000000000..9f271665cbb1
--- /dev/null
+++ b/lib/base64.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * base64.c - RFC4648-compliant base64 encoding
+ *
+ * Copyright (c) 2020 Hannes Reinecke, SUSE
+ *
+ * Based on the base64url routines from fs/crypto/fname.c
+ * (which are using the URL-safe base64 encoding),
+ * modified to use the standard coding table from RFC4648 section 4.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/string.h>
+#include <linux/base64.h>
+
+static const char base64_table[65] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+/**
+ * base64_encode() - base64-encode some binary data
+ * @src: the binary data to encode
+ * @srclen: the length of @src in bytes
+ * @dst: (output) the base64-encoded string.  Not NUL-terminated.
+ *
+ * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" specified
+ * by RFC 4648, including the  '='-padding.
+ *
+ * Return: the length of the resulting base64url-encoded string in bytes.
+ */
+int base64_encode(const u8 *src, int srclen, char *dst)
+{
+	u32 ac = 0;
+	int bits = 0;
+	int i;
+	char *cp = dst;
+
+	for (i = 0; i < srclen; i++) {
+		ac = (ac << 8) | src[i];
+		bits += 8;
+		do {
+			bits -= 6;
+			*cp++ = base64_table[(ac >> bits) & 0x3f];
+		} while (bits >= 6);
+	}
+	if (bits) {
+		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
+		bits -= 6;
+	}
+	while (bits < 0) {
+		*cp++ = '=';
+		bits += 2;
+	}
+	return cp - dst;
+}
+EXPORT_SYMBOL_GPL(base64_encode);
+
+/**
+ * base64_decode() - base64-decode a string
+ * @src: the string to decode.  Doesn't need to be NUL-terminated.
+ * @srclen: the length of @src in bytes
+ * @dst: (output) the decoded binary data
+ *
+ * Decodes a string using base64url encoding, i.e. the "Base 64 Encoding"
+ * specified by RFC 4648, including the  '='-padding.
+ *
+ * This implementation hasn't been optimized for performance.
+ *
+ * Return: the length of the resulting decoded binary data in bytes,
+ *	   or -1 if the string isn't a valid base64 string.
+ */
+int base64_decode(const char *src, int srclen, u8 *dst)
+{
+	u32 ac = 0;
+	int bits = 0;
+	int i;
+	u8 *bp = dst;
+
+	for (i = 0; i < srclen; i++) {
+		const char *p = strchr(base64_table, src[i]);
+
+		if (src[i] == '=') {
+			ac = (ac << 6);
+			continue;
+		}
+		if (p == NULL || src[i] == 0)
+			return -1;
+		ac = (ac << 6) | (p - base64_table);
+		bits += 6;
+		if (bits >= 8) {
+			bits -= 8;
+			*bp++ = (u8)(ac >> bits);
+		}
+	}
+	if (ac & ((1 << bits) - 1))
+		return -1;
+	return bp - dst;
+}
+EXPORT_SYMBOL_GPL(base64_decode);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
