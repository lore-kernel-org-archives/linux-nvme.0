Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C19FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 10:25:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C0560FA0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 10:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17C0560FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D9udCluHlbDjU6nrBgYD9gmt7UJLZfqMPUqsuhr006I=; b=FuXxjlm51/aUUD
	tAD/kGfhbCmyXNFm/infl+wW/7o53yvMRJ4WnYPtbJHhkT7dPy3uAoBwORq34qJmNhMI+Xv35jFOu
	a3H0Lz4Uh4LPMg5slKwvGSUIA3BBo5jXjiPFzvbwp0kkQbzONDoyc9VcgevUgE+wsqZu6khuut0Ef
	IdbvCblpIakwKtv1b2zYtt888qolsHX99BZ7PHgx38efxTLAgj+r5fQG6UFoKtavrsJTeIxG+KDsG
	Hj7jn1Mez4l4heuJ+pco2r1/1TjNIy4nK5vmgqx7KGcfcWxiw7lqUG4RayyR8NjEy+SCuLllHfTza
	Dko/O6LwOz3ew+CNsKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPj8o-001G2i-6F; Mon, 13 Sep 2021 10:24:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPj8T-001FqO-Al
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 10:24:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C56F91FFBF;
 Mon, 13 Sep 2021 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631528663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQq7im/VufgnvNduwQTvKZp5HPQrPntvfIXdqH4keIk=;
 b=zUNWPkWb6X1CSJLpS2ENkwIJ1RLkcojOTux1QpoNd8/otEq2DFkL0yC0Cl68e2z2Jn1/WZ
 BEkJghJ/R+YzLbb0+f9BXteQ+qdSWwfFNDcZRNd2ujYb9QTBbXKXxk4bVPyN1ZQCu8i10Y
 XE9zdgyXPMTDgI3N5ZUHAMfnD/7cxNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631528663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQq7im/VufgnvNduwQTvKZp5HPQrPntvfIXdqH4keIk=;
 b=6lDSMWZ4dluh+X19Xsb0/Bmr1zzRhzbDP6FwO1/qdq5g83Rbf4fFri2ZNzAyv5wTrjQJM8
 0dNo4IVm/BunHIDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 76230A3B92;
 Mon, 13 Sep 2021 10:24:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 6476D518E5A0; Mon, 13 Sep 2021 12:24:23 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] Add 'check-dhchap-key' function
Date: Mon, 13 Sep 2021 12:24:15 +0200
Message-Id: <20210913102415.19044-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913102415.19044-1-hare@suse.de>
References: <20210913102415.19044-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_032425_571045_28171EF6 
X-CRM114-Status: GOOD (  24.71  )
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

Add a function to validate a given DH-HMAC-CHAP key in transport
encoding for NVMe in-band authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/nvme-check-dhchap-key.txt | 31 +++++++++++
 nvme-builtin.h                          |  1 +
 nvme.c                                  | 69 +++++++++++++++++++++++++
 util/base64.c                           | 38 ++++++++++++++
 util/base64.h                           |  1 +
 5 files changed, 140 insertions(+)
 create mode 100644 Documentation/nvme-check-dhchap-key.txt

diff --git a/Documentation/nvme-check-dhchap-key.txt b/Documentation/nvme-check-dhchap-key.txt
new file mode 100644
index 0000000..75008c7
--- /dev/null
+++ b/Documentation/nvme-check-dhchap-key.txt
@@ -0,0 +1,31 @@
+nvme-check-dhchap-key(1)
+===================
+
+NAME
+----
+nvme-check-dhchap-key - Check a generated host DH-HMAC-CHAP key
+
+SYNOPSIS
+--------
+[verse]
+'nvme check-dhchap-key' [--key=<key> ]
+
+DESCRIPTION
+-----------
+Checks if the key is a valid DH-HMAC-CHAP host key of the form:
+DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
+and prints it to stdout.
+
+OPTIONS
+-------
+-k <key>::
+--key=<key>::
+	Key to be checked.
+
+EXAMPLES
+--------
+No Examples
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/nvme-builtin.h b/nvme-builtin.h
index a256f05..c2740bb 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -82,6 +82,7 @@ COMMAND_LIST(
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("show-hostnqn", "Show NVMeoF host NQN", show_hostnqn_cmd)
 	ENTRY("gen-dhchap-key", "Generate NVMeoF DH-HMAC-CHAP host key", gen_dhchap_key)
+	ENTRY("check-dhchap-key", "Validate NVMeoF DH-HMAC-CHAP host key", check_dhchap_key)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
 	ENTRY("virt-mgmt", "Manage Flexible Resources between Primary and Secondary Controller ", virtual_mgmt)
diff --git a/nvme.c b/nvme.c
index 5791357..d69a653 100644
--- a/nvme.c
+++ b/nvme.c
@@ -5905,6 +5905,75 @@ static int gen_dhchap_key(int argc, char **argv, struct command *command, struct
 	return 0;
 }
 
+static int check_dhchap_key(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+	const char *desc = "Check a DH-HMAC-CHAP host key for usability "\
+		"for NVMe In-Band Authentication.";
+	const char *key = "DH-HMAC-CHAP key (in hexadecimal characters) "\
+		"to be validated.";
+
+	unsigned char decoded_key[128];
+	unsigned int decoded_len;
+	u_int32_t crc = crc32(0L, NULL, 0);
+	u_int32_t key_crc;
+	int err = 0, hmac;
+	struct config {
+		char *key;
+	};
+
+	struct config cfg = {
+		.key = NULL,
+	};
+
+	OPT_ARGS(opts) = {
+		OPT_STR("key", 'k', &cfg.key, key),
+		OPT_END()
+	};
+
+	err = argconfig_parse(argc, argv, desc, opts);
+	if (err)
+		return err;
+
+	if (!cfg.key) {
+		fprintf(stderr, "Key not specified\n");
+		return -EINVAL;
+	}
+
+	if (sscanf(cfg.key, "DHHC-1:%02x:*s", &hmac) != 1) {
+		fprintf(stderr, "Invalid key header '%s'\n", cfg.key);
+		return -EINVAL;
+	}
+	if (hmac > 3) {
+		fprintf(stderr, "Invalid HMAC identifier %d\n", hmac);
+		return -EINVAL;
+	}
+	decoded_len = base64_decode(cfg.key + 10, strlen(cfg.key) - 11,
+				    decoded_key);
+	if (decoded_len < 32) {
+		fprintf(stderr, "Base64 decoding failed (%s, size %u)\n",
+			cfg.key + 10, decoded_len);
+		return -EINVAL;
+	}
+	decoded_len -= 4;
+	if (decoded_len != 32 && decoded_len != 48 && decoded_len != 64) {
+		fprintf(stderr, "Invalid key length %d\n", decoded_len);
+		return -EINVAL;
+	}
+	crc = crc32(crc, decoded_key, decoded_len);
+	key_crc = ((u_int32_t)decoded_key[decoded_len]) |
+		((u_int32_t)decoded_key[decoded_len + 1] << 8) |
+		((u_int32_t)decoded_key[decoded_len + 2] << 16) |
+		((u_int32_t)decoded_key[decoded_len + 3] << 24);
+	if (key_crc != crc) {
+		fprintf(stderr, "CRC mismatch (key %08x, crc %08x)\n",
+			key_crc, crc);
+		return -EINVAL;
+	}
+	printf("Key is valid (HMAC %d, length %d, CRC %08x)\n",
+	       hmac, decoded_len, crc);
+	return 0;
+}
+
 static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Send Get Log Page request to Discovery Controller.";
diff --git a/util/base64.c b/util/base64.c
index 328c8ea..2cc7ff2 100644
--- a/util/base64.c
+++ b/util/base64.c
@@ -20,6 +20,7 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 
 static const char base64_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@@ -60,3 +61,40 @@ int base64_encode(const unsigned char *src, int srclen, char *dst)
 
 	return cp - dst;
 }
+
+/**
+ * base64_decode() - base64-decode some bytes
+ * @src: the base64-encoded string to decode
+ * @len: number of bytes to decode
+ * @dst: (output) the decoded bytes.
+ *
+ * Decodes the base64-encoded bytes @src according to RFC 4648.
+ *
+ * Return: number of decoded bytes
+ */
+int base64_decode(const char *src, int srclen, unsigned char *dst)
+{
+	u_int32_t ac = 0;
+	int i, bits = 0;
+	unsigned char *bp = dst;
+
+        for (i = 0; i < srclen; i++) {
+                const char *p = strchr(base64_table, src[i]);
+
+                if (src[i] == '=') {
+                        ac = (ac << 6);
+                        continue;
+                }
+                if (p == NULL || src[i] == 0)
+                        return -1;
+                ac = (ac << 6) | (p - base64_table);
+                bits += 6;
+                if (bits >= 8) {
+                        bits -= 8;
+                        *bp++ = (unsigned char)(ac >> bits);
+                }
+	}
+	if (ac && ((1 << bits) - 1))
+		return -1;
+	return bp - dst;
+}
diff --git a/util/base64.h b/util/base64.h
index 374f5e6..609a877 100644
--- a/util/base64.h
+++ b/util/base64.h
@@ -2,5 +2,6 @@
 #define _BASE64_H
 
 int base64_encode(const unsigned char *src, int len, char *dst);
+int base64_decode(const char *src, int len, unsigned char *dst);
 
 #endif /* _BASE64_H */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
