Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B513CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:16:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E9961039
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70E9961039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7KxnJFupAdGXOQ/BIRz0D4JhiyrPAvcRfY2W+GqyVk=; b=3fTWIfbbx7Jn2KlPNFX1qgxRJE
	mxChcWAdEox8IRfMlLKLO2UZ6VxhJUA7MuyCr5Np19HXnLwW6e8Ti8eqwkr7ZiusefLXRQ0jtnroo
	3+sTloVlpaoDOn1j8sQWYws3wfgYsa+kF6+USTt2E8JJCxRZ9CkfsUjNrBHq8a9DtumeJYEwXXQqz
	ZhMxn6OwYqCEBJjTd7pEzYN/APgRm0ocNYoFAIwWWVx+Ht3oA6NfAqSfd5Y0stG45SnzxGl7wJnK7
	1rURDY2zLeUA1vb5r0QbaaB5jX898Ff4YdNV3XQOiCERUVhVADgb5bN3xxINVOaaB17DW5MEvRrMp
	B/tuSocQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlWPs-00AVJi-RY; Fri, 12 Nov 2021 13:16:28 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlWKu-00AUCr-7y
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 13:11:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CA85C2198E;
 Fri, 12 Nov 2021 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636722678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7KxnJFupAdGXOQ/BIRz0D4JhiyrPAvcRfY2W+GqyVk=;
 b=1Pms8szDi0pu2wMOUhYuwjyqboFxlQdX3fhT+Ge97LoO8ZXW95rg9rTlwZThfGMOd16P1w
 DyJxxcO47D/R2wo0P/Qn7Ikw+bjH6QSuQCJjZCGcVta/kTSZIUaVooCRJLCJ47/b2Ipn5l
 QX9BLC7wdhKl/u+YAo1yolTtQRYRd0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636722678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7KxnJFupAdGXOQ/BIRz0D4JhiyrPAvcRfY2W+GqyVk=;
 b=P/KV57B5Fxqpl64cdSaj+gQzjGNT1cCYeTX51FC7blb5iBxCd3qCCbABooyJ+s8Jdou69o
 dF9c37GoQ3Hvu/AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id A1081A3B88;
 Fri, 12 Nov 2021 13:11:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 935A75191274; Fri, 12 Nov 2021 14:11:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH nvme-cli 2/3] Add 'check-dhchap-key' function
Date: Fri, 12 Nov 2021 14:11:10 +0100
Message-Id: <20211112131111.97599-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112131111.97599-1-hare@suse.de>
References: <20211112131111.97599-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_051120_521145_A23EE3E2 
X-CRM114-Status: GOOD (  24.67  )
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

Add a function to validate a given DH-HMAC-CHAP key in transport
encoding for NVMe in-band authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/nvme-check-dhchap-key.txt | 31 ++++++++
 nvme-builtin.h                          |  1 +
 nvme.c                                  | 98 +++++++++++++++++++++++++
 util/base64.c                           | 43 +++++++++++
 util/base64.h                           |  1 +
 5 files changed, 174 insertions(+)
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
index 4ad91da..4f8ba8c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -6093,6 +6093,104 @@ static int gen_dhchap_key(int argc, char **argv, struct command *command, struct
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
+	switch (hmac) {
+	case 0:
+		break;
+	case 1:
+		if (strlen(cfg.key) != 59) {
+			fprintf(stderr, "Invalid key length for SHA(256)\n");
+			return -EINVAL;
+		}
+		break;
+	case 2:
+		if (strlen(cfg.key) != 83) {
+			fprintf(stderr, "Invalid key length for SHA(384)\n");
+			return -EINVAL;
+		}
+		break;
+	case 3:
+		if (strlen(cfg.key) != 103) {
+			fprintf(stderr, "Invalid key length for SHA(512)\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		fprintf(stderr, "Invalid HMAC identifier %d\n", hmac);
+		return -EINVAL;
+		break;
+	}
+
+	err = base64_decode(cfg.key + 10, strlen(cfg.key) - 11,
+			    decoded_key);
+	if (err < 0) {
+		fprintf(stderr, "Base64 decoding failed, error %d\n",
+			err);
+		return err;
+	}
+	decoded_len = err;
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
index d9b8f01..e386c11 100644
--- a/util/base64.c
+++ b/util/base64.c
@@ -20,6 +20,8 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 
 static const char base64_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@@ -60,3 +62,44 @@ int base64_encode(const unsigned char *src, int srclen, char *dst)
 
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
+			bits += 6;
+			if (bits >= 8)
+				bits -= 8;
+                        continue;
+                }
+                if (p == NULL || src[i] == 0)
+                        return -EINVAL;
+                ac = (ac << 6) | (p - base64_table);
+                bits += 6;
+                if (bits >= 8) {
+                        bits -= 8;
+                        *bp++ = (unsigned char)(ac >> bits);
+                }
+	}
+	if (ac && ((1 << bits) - 1))
+		return -EAGAIN;
+
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
2.31.1


