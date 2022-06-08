Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE00C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTyQKh7bDGaz2rQSdlA4XvUYmbPnns1ft47L9zMuBWg=; b=z4hjXjCs/Gl5dl4oF1nqU0ozP/
	6lbm+u/y3i/xJsstl8o/HBdjqQOYdis1xjjcVRuo+SdKlu8asY68xwQCyRNPGipg6Jc1x8D1Qkirr
	Yt9WE3wKt5wRFAiIQHrDyVE5+7qE1Jr7WUqDTrWevDIlG+6BMf0er8+2GOUkDB+la4PqH5IGgsOiU
	+LoGPwy+C4xucaWpJRpGNsTq5C2RFjD2CNOafePaUQP3o3MiWbl20obvm0JG+ris5fBFZb/qle/9y
	8AlfWB2viqAx4ordEwqvCw09DDG1s+QppsUtlMHEn4UC93ZyDvDdvPcgCkbh8ssG3/Xm8vCRqg4RU
	+3fKPH1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nywwg-00Djpw-F2; Wed, 08 Jun 2022 14:46:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyww3-00DjXu-MM
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 14:45:31 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 919B921AAD;
	Wed,  8 Jun 2022 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654699524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTyQKh7bDGaz2rQSdlA4XvUYmbPnns1ft47L9zMuBWg=;
	b=HvzEbVy31hfTtMI2CjA/XlxJ85SZxJVTcbY0wUgD5t1A+KhmyWiT3HNYukJVgo6Nfx6igf
	ddcrR2kKNfq5JIIjNNSQPfhIvibKQeFHbRG0GyCbQM5VsVuhzIxh1tBBa/AUoAk+NT7KAA
	rgup3k20YBNlV81j8QSu/s/xGdzxU1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654699524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTyQKh7bDGaz2rQSdlA4XvUYmbPnns1ft47L9zMuBWg=;
	b=+Mq9Xa+SglDLBxU3RjXdbV/UtfdEjJKEFTyO0/Jbt3D6UgL6CZy406kf9/yuY4TG0XGdZh
	RZrx/VdVMNlAV9Cg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B1DBA2C146;
	Wed,  8 Jun 2022 14:45:22 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DD7B251949A8; Wed,  8 Jun 2022 16:45:22 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 03/11] lib/base64: RFC4648-compliant base64 encoding
Date: Wed,  8 Jun 2022 16:45:10 +0200
Message-Id: <20220608144518.67607-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220608144518.67607-1-hare@suse.de>
References: <20220608144518.67607-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_074528_022829_63E25FFE 
X-CRM114-Status: GOOD (  22.95  )
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

Add RFC4648-compliant base64 encoding and decoding routines, based on
the base64url encoding in fs/crypto/fname.c.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/base64.h |  16 +++++++
 lib/Makefile           |   2 +-
 lib/base64.c           | 103 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
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
index 6b9ffc1bd1ee..81a8c8230148 100644
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
index 000000000000..b736a7a431c5
--- /dev/null
+++ b/lib/base64.c
@@ -0,0 +1,103 @@
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
+ * Return: the length of the resulting base64-encoded string in bytes.
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
+ * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
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
+			bits += 6;
+			if (bits >= 8)
+				bits -= 8;
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


