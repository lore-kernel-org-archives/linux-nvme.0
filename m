Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F7FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 10:25:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961D060FA0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 961D060FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6nP7nonNUElgQHmKZ0pkKJD90z6DER/R1WHF2XvY9wk=; b=DvzLk9ArMpDOeL
	vnuizeY6lZJXqa6G7kp7LBDSEMAsYPhHay9rUmzH8SXPf8t8RzgIZKD2TWXra9DqTg4zRmDE2ThjP
	2KQLe06+SlMDP1GqntRrqV6HGVBTrpJNSBpEFNFQg7wMuGhGGmhxsQ8s0hGoOmpwOB2N9kM0IKV4j
	2Egpb6SuCtqZJGM8bYwfqF/CkJPZOxSoIBCjnc0ASK0Om+L0x2yVWFVMWafPxp2IQqYdsUaPRCieS
	cl/3DzgKyfEVow/+ijgOtrgSm+96+WBM/sJV18AEx1fQbAa96Kx4y6YD8NGrfeo4wuRntVjM3S66g
	xAhXSmCAg1No0OcuPWrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPj98-001GD0-Nc; Mon, 13 Sep 2021 10:25:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPj8T-001FqH-Ak
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 10:24:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C50BC21FD1;
 Mon, 13 Sep 2021 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631528663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sX5UlGz7GQwCeZ6yhyi3FEX61WEWH4EaMC/7n9VSXw=;
 b=A54nP1vXxOn7yLjEE9qz3BKtkyoLlx+BbfI6I/HGX947XbuLlUpPcmoFPH5yIBNc2zX3ep
 lQ746kSLgo+AxEuVe4kOzyyQ0ZibI83BwRSe9ugAtuIQ9uikZsRK5wnx1kuK7SffkiMeKr
 80mrYCQD1j+2bIYutyHIhwi3oUfkItY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631528663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sX5UlGz7GQwCeZ6yhyi3FEX61WEWH4EaMC/7n9VSXw=;
 b=vNggNsnKNZy2+KgxqUXxuu+vxPLllCrg9UgpON9Mm71uaKZDtJPj34YeCjdqHxXKwaYKL/
 IB/pnnR7tly8kGDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 6EFEBA3B8E;
 Mon, 13 Sep 2021 10:24:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 62340518E59E; Mon, 13 Sep 2021 12:24:23 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] Add 'gen-dhchap-key' command
Date: Mon, 13 Sep 2021 12:24:14 +0200
Message-Id: <20210913102415.19044-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913102415.19044-1-hare@suse.de>
References: <20210913102415.19044-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_032425_624850_950AB9A7 
X-CRM114-Status: GOOD (  33.36  )
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

Add command 'gen-dhchap-key' to generate an DH-HMAC-CHAP host key
for NVMe in-band authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/nvme-gen-dhchap-key.txt |  52 +++++++++
 Makefile                              |  17 ++-
 nvme-builtin.h                        |   1 +
 nvme.c                                | 155 ++++++++++++++++++++++++++
 util/argconfig.h                      |   1 +
 util/base64.c                         |  62 +++++++++++
 util/base64.h                         |   6 +
 7 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme-gen-dhchap-key.txt
 create mode 100644 util/base64.c
 create mode 100644 util/base64.h

diff --git a/Documentation/nvme-gen-dhchap-key.txt b/Documentation/nvme-gen-dhchap-key.txt
new file mode 100644
index 0000000..eecde76
--- /dev/null
+++ b/Documentation/nvme-gen-dhchap-key.txt
@@ -0,0 +1,52 @@
+nvme-gen-dhchap-key(1)
+===================
+
+NAME
+----
+nvme-gen-dhchap-key - Generate a host DH-HMAC-CHAP key
+
+SYNOPSIS
+--------
+[verse]
+'nvme gen-dhchap-key' [--hmac=<hmac-id> | -h <hmac-id>]
+		      [--secret=<secret> | -s <secret> ]
+		      [--key-length=<len> | -l <len> ]
+		      [--nqn=<host-nqn> | -n <host-nqn> ]
+
+DESCRIPTION
+-----------
+Generate a base64-encoded DH-HMAC-CHAP host key in the form:
+DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
+and prints it to stdout.
+
+OPTIONS
+-------
+-h <hmac-id>::
+--hmac=<hmac-id>::
+	Select a HMAC algorithm to use. Possible values are:
+	0 - No HMAC algorithm
+	1 - SHA-256
+	2 - SHA-384
+	3 - SHA-512
+
+-s <secret>::
+--secret=<secret>::
+	Secret value (in hexadecimal) to be used for the key. If none are
+	provided a random value is used.
+
+-l <len>::
+--key-length=<len>::
+	Length of the resulting key. Possible values are 32, 48, or 64.
+
+-n <hostnqn>::
+--nqn=<hostnqn>::
+	Host-NQN to be used for the transformation. This parameter is only
+	valid if a non-zero HMAC function has been specified.
+
+EXAMPLES
+--------
+No Examples
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/Makefile b/Makefile
index 5fbdfd0..984b380 100644
--- a/Makefile
+++ b/Makefile
@@ -5,6 +5,8 @@ LIBUUID = $(shell $(LD) -o /dev/null -luuid >/dev/null 2>&1; echo $$?)
 LIBHUGETLBFS = $(shell $(LD) -o /dev/null -lhugetlbfs >/dev/null 2>&1; echo $$?)
 HAVE_SYSTEMD = $(shell pkg-config --exists libsystemd  --atleast-version=242; echo $$?)
 LIBJSONC = $(shell $(LD) -o /dev/null -ljson-c >/dev/null 2>&1; echo $$?)
+LIBZ = $(shell $(LD) -o /dev/null -lz >/dev/null 2>&1; echo $$?)
+LIBOPENSSL = $(shell $(LD) -o /dev/null -lssl >/dev/null 2>&1; echo $$?)
 NVME = nvme
 INSTALL ?= install
 DESTDIR =
@@ -33,6 +35,18 @@ ifeq ($(LIBHUGETLBFS),0)
 	override LIB_DEPENDS += hugetlbfs
 endif
 
+ifeq ($(LIBZ),0)
+	override LDFLAGS += -lz
+	override CFLAGS += -DLIBZ
+	override LIB_DEPENDS += zlib
+endif
+
+ifeq ($(LIBOPENSSL),0)
+	override LDFLAGS += -lssl -lcrypto
+	override CFLAGS += -DOPENSSL
+	override LIB_DEPENDS += openssl
+endif
+
 INC=-Iutil
 
 ifeq ($(HAVE_SYSTEMD),0)
@@ -70,7 +84,8 @@ OBJS := nvme-print.o nvme-rpmb.o \
 	fabrics.o nvme-models.o plugin.o
 
 UTIL_OBJS := util/argconfig.o util/suffix.o util/parser.o \
-	util/cleanup.o
+	util/cleanup.o util/base64.o
+
 ifneq ($(LIBJSONC), 0)
 override UTIL_OBJS += util/json.o
 endif
diff --git a/nvme-builtin.h b/nvme-builtin.h
index a413d00..a256f05 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -81,6 +81,7 @@ COMMAND_LIST(
 	ENTRY("disconnect-all", "Disconnect from all connected NVMeoF subsystems", disconnect_all_cmd)
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("show-hostnqn", "Show NVMeoF host NQN", show_hostnqn_cmd)
+	ENTRY("gen-dhchap-key", "Generate NVMeoF DH-HMAC-CHAP host key", gen_dhchap_key)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
 	ENTRY("virt-mgmt", "Manage Flexible Resources between Primary and Secondary Controller ", virtual_mgmt)
diff --git a/nvme.c b/nvme.c
index 79605f5..5791357 100644
--- a/nvme.c
+++ b/nvme.c
@@ -36,22 +36,31 @@
 #include <math.h>
 #include <dirent.h>
 #include <libgen.h>
+#include <zlib.h>
 
 #ifdef LIBHUGETLBFS
 #include <hugetlbfs.h>
 #endif
 
+#ifdef OPENSSL
+#include <openssl/engine.h>
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
+#endif
+
 #include <linux/fs.h>
 
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/random.h>
 
 #include "common.h"
 #include "nvme.h"
 #include "libnvme.h"
 #include "nvme-print.h"
 #include "plugin.h"
+#include "base64.h"
 
 #include "argconfig.h"
 #include "fabrics.h"
@@ -5750,6 +5759,152 @@ static int show_hostnqn_cmd(int argc, char **argv, struct command *command, stru
 	return 0;
 }
 
+static int gen_dhchap_key(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+	const char *desc = "Generate a DH-HMAC-CHAP host key usable "\
+		"for NVMe In-Band Authentication.";
+	const char *secret = "Optional secret (in hexadecimal characters) "\
+		"to be used to initialize the host key.";
+	const char *key_len = "Length of the resulting key "\
+		"(32, 48, or 64 bytes).";
+	const char *hmac = "HMAC function to use for key transformation "\
+		"(0 = none, 1 = SHA-256, 2 = SHA-384, 3 = SHA-512).";
+	const char *nqn = "Host NQN to use for key transformation.";
+
+	char *hostnqn;
+	char *raw_secret;
+	unsigned char key[68];
+	char encoded_key[128];
+	unsigned long crc = crc32(0L, NULL, 0);
+	int err = 0;
+#ifdef OPENSSL
+	const EVP_MD *md = NULL;
+#else
+	const char *md = NULL;
+#endif
+	struct config {
+		char *secret;
+		unsigned int key_len;
+		char *nqn;
+		unsigned int hmac;
+	};
+
+	struct config cfg = {
+		.secret = NULL,
+		.key_len = 32,
+		.nqn = NULL,
+		.hmac = 0,
+	};
+
+	OPT_ARGS(opts) = {
+		OPT_STR("secret", 's', &cfg.secret, secret),
+		OPT_UINT("key-length", 'l', &cfg.key_len, key_len),
+		OPT_STR("nqn", 'n', &cfg.nqn, nqn),
+		OPT_UINT("hmac", 'h', &cfg.hmac, hmac),
+		OPT_END()
+	};
+
+	err = argconfig_parse(argc, argv, desc, opts);
+	if (err)
+		return err;
+
+	if (cfg.key_len != 32 && cfg.key_len != 48 && cfg.key_len != 64) {
+		fprintf(stderr, "Invalid key length %u\n", cfg.key_len);
+		return -EINVAL;
+	}
+	if (cfg.hmac > 3) {
+		fprintf(stderr, "Invalid HMAC identifier %u\n", cfg.hmac);
+		return -EINVAL;
+	}
+	if (cfg.hmac > 0) {
+#ifdef OPENSSL
+		if (!cfg.nqn) {
+			hostnqn = nvmf_hostnqn_from_file();
+			if (!hostnqn) {
+				fprintf(stderr, "Could not read host NQN\n");
+				return -ENOENT;
+			}
+		} else {
+			hostnqn = cfg.nqn;
+		}
+		switch (cfg.hmac) {
+		case 1:
+			md = EVP_sha256();
+			break;
+		case 2:
+			md = EVP_sha384();
+			break;
+		case 3:
+			md = EVP_sha512();
+			break;
+		default:
+			break;
+		}
+#else
+		fprintf(stderr, "HMAC transformation not supported; "\
+			"recompile with OpenSSL support.\n");
+		return -EINVAL;
+#endif
+	}
+	raw_secret = malloc(cfg.key_len);
+	if (!raw_secret)
+		return -ENOMEM;
+	if (!cfg.secret) {
+		if (getrandom(raw_secret, cfg.key_len, GRND_NONBLOCK) < 0)
+			return errno;
+	} else {
+		int secret_len = 0, i;
+		unsigned int c;
+
+		for (i = 0; i < strlen(cfg.secret); i+=2) {
+			if (sscanf(&cfg.secret[i], "%02x", &c) != 1) {
+				fprintf(stderr, "Invalid secret '%s'\n",
+					cfg.secret);
+				return -EINVAL;
+			}
+			raw_secret[secret_len++] = (unsigned char)c;
+		}
+		if (secret_len != cfg.key_len) {
+			fprintf(stderr, "Invalid key length (%d bytes)\n",
+				secret_len);
+			return -EINVAL;
+		}
+	}
+
+	if (md) {
+#ifdef OPENSSL
+		HMAC_CTX *hmac_ctx = HMAC_CTX_new();
+		const char hmac_seed[] = "NVMe-over-Fabrics";
+		unsigned int key_len;
+
+		ENGINE_load_builtin_engines();
+		ENGINE_register_all_complete();
+
+		HMAC_Init_ex(hmac_ctx, raw_secret, cfg.key_len,md, NULL);
+		HMAC_Update(hmac_ctx, (unsigned char *)hostnqn,
+			    strlen(hostnqn));
+		HMAC_Update(hmac_ctx, (unsigned char *)hmac_seed,
+			    strlen(hmac_seed));
+		HMAC_Final(hmac_ctx, key, &key_len);
+		HMAC_CTX_free(hmac_ctx);
+#endif
+	} else {
+		memcpy(key, raw_secret, cfg.key_len);
+	}
+
+	crc = crc32(crc, key, cfg.key_len);
+	key[cfg.key_len++] = crc & 0xff;
+	key[cfg.key_len++] = (crc >> 8) & 0xff;
+	key[cfg.key_len++] = (crc >> 16) & 0xff;
+	key[cfg.key_len++] = (crc >> 24) & 0xff;
+
+	memset(encoded_key, 0, sizeof(encoded_key));
+	base64_encode(key, cfg.key_len, encoded_key);
+
+	printf("DHHC-1:%02x:%s:\n", cfg.hmac, encoded_key);
+	return 0;
+}
+
 static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Send Get Log Page request to Discovery Controller.";
diff --git a/util/argconfig.h b/util/argconfig.h
index 1a5c693..3b6da4c 100644
--- a/util/argconfig.h
+++ b/util/argconfig.h
@@ -100,6 +100,7 @@ enum argconfig_types {
 #define OPT_FMT(l, s, v, d)  OPT_STRING(l, s, "FMT", v, d)
 #define OPT_FILE(l, s, v, d) OPT_STRING(l, s, "FILE", v, d)
 #define OPT_LIST(l, s, v, d) OPT_STRING(l, s, "LIST", v, d)
+#define OPT_STR(l, s, v, d) OPT_STRING(l, s, "STRING", v, d)
 
 struct argconfig_commandline_options {
 	const char *option;
diff --git a/util/base64.c b/util/base64.c
new file mode 100644
index 0000000..328c8ea
--- /dev/null
+++ b/util/base64.c
@@ -0,0 +1,62 @@
+/*
+ * base64.c - RFC4648-compliant base64 encoding
+ *
+ * Copyright (c) 2020 Hannes Reinecke, SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ */
+
+#include <stdlib.h>
+
+static const char base64_table[65] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+/**
+ * base64_encode() - base64-encode some bytes
+ * @src: the bytes to encode
+ * @srclen: number of bytes to encode
+ * @dst: (output) the base64-encoded string.  Not NUL-terminated.
+ *
+ * Encodes the input string using characters from the set [A-Za-z0-9+,].
+ * The encoded string is roughly 4/3 times the size of the input string.
+ *
+ * Return: length of the encoded string
+ */
+int base64_encode(const unsigned char *src, int srclen, char *dst)
+{
+	int i, bits = 0;
+	u_int32_t ac = 0;
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
+		bits -= 6;
+		*cp++ = base64_table[(ac >> bits) & 0x3f];
+	}
+	while (bits < 0) {
+		*cp++ = '=';
+		bits += 2;
+	}
+
+	return cp - dst;
+}
diff --git a/util/base64.h b/util/base64.h
new file mode 100644
index 0000000..374f5e6
--- /dev/null
+++ b/util/base64.h
@@ -0,0 +1,6 @@
+#ifndef _BASE64_H
+#define _BASE64_H
+
+int base64_encode(const unsigned char *src, int len, char *dst);
+
+#endif /* _BASE64_H */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
