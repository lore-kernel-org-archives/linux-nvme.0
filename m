Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2748C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 19:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AC0603E8
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 19:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0AC0603E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O3C9m+BSu4PS7GXDpduHK2PTY216AhKEoFnqIEvOE58=; b=XYHmuf5qQGBSLQoZpqRL1jSKsP
	bl1g1zW1alZlbHHImqaMNui45mwkB1Zf1jkICL1uZEyyNCQVn4DZw4rBTFi9dyAOY02vdEx53b522
	1kErlJb9FY7YvuPS9eWsQr9Jw6NboGTGcKyhKLdrzsI7WIgnEu5tY9NLQxH28RqvOkz9sHoZM2nl2
	y3dImwh+6tlGApYfRcTY8DXCq9NyCOijKSVBNqRiZvLjwS5fnTyhareX2He3Z8BKn1IBUuSqcRbRD
	gVf/0eVdyQFdfG9+owWvymMLctRT7+EaPMwXGLQDs4wjErYIw5FpGyme7+HOMrY/LFqcQXLfX9n/z
	FFgslLng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPrbK-0034jk-Bk; Mon, 13 Sep 2021 19:26:46 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPrbG-0034jL-Kj
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 19:26:44 +0000
Received: by mail-ed1-f44.google.com with SMTP id 9so15959083edx.11
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 12:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=91UVeRDiFfGHeokMigmZseLHBs8gkjg9FsSV4i+h75M=;
 b=jXMWUpZAqcy6Z2M01t3VEFoPhkmsaMNOxO1JSYZq3YxbmGmgB9E4nu4ItxJo++8bJw
 xGrRL7fL0gO3LNs8O86lS15JftJGGlt+MpFNV8loqnDvX57nb/unfh0IG7z9qOdtyBw0
 hmwlNqD9IjcSN/VD49tnukWwI/+a9W2aP9gLO3NhAx6IorSywvIqMLRwcEnYDrTrueFj
 HQdSEyGdTevp1TU6GYizGtnYeDiYOG/Tb2WnUuHdNs4JwveqyHVUx3ln7HT/aKg2lFQv
 l5fF88HFqtsyJZrPvUL9Y8Q8vq30H+BhVnmN9UVDWQc8bDeRcX1BFh6hbeASuRfjExPI
 rkZg==
X-Gm-Message-State: AOAM530nUUn3sPT3+xjcNHxpbYrT8scRW74KDyjXpL6W2Xx9KfLp50ZG
 /lVCM7QRvt7o1VbaeXSsHyD7E4RTlUY=
X-Google-Smtp-Source: ABdhPJwtVYcOOMM9HfAGkMDSLTZZOUzufVhb9zf+MLq+wybYQX0eKZeb0aqoM81zxfPMbfTyq7cS2Q==
X-Received: by 2002:a05:6402:268f:: with SMTP id
 w15mr15004535edd.186.1631561200362; 
 Mon, 13 Sep 2021 12:26:40 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id n18sm3858614ejg.36.2021.09.13.12.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 12:26:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add 'gen-dhchap-key' command
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210913102415.19044-1-hare@suse.de>
 <20210913102415.19044-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a64c9dde-7c81-85d8-a1d5-5b691a2f99be@grimberg.me>
Date: Mon, 13 Sep 2021 22:26:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913102415.19044-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_122642_756885_C453291B 
X-CRM114-Status: GOOD (  49.11  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/13/21 1:24 PM, Hannes Reinecke wrote:
> Add command 'gen-dhchap-key' to generate an DH-HMAC-CHAP host key
> for NVMe in-band authentication.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   Documentation/nvme-gen-dhchap-key.txt |  52 +++++++++
>   Makefile                              |  17 ++-
>   nvme-builtin.h                        |   1 +
>   nvme.c                                | 155 ++++++++++++++++++++++++++
>   util/argconfig.h                      |   1 +
>   util/base64.c                         |  62 +++++++++++
>   util/base64.h                         |   6 +
>   7 files changed, 293 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/nvme-gen-dhchap-key.txt
>   create mode 100644 util/base64.c
>   create mode 100644 util/base64.h
> 
> diff --git a/Documentation/nvme-gen-dhchap-key.txt b/Documentation/nvme-gen-dhchap-key.txt
> new file mode 100644
> index 0000000..eecde76
> --- /dev/null
> +++ b/Documentation/nvme-gen-dhchap-key.txt
> @@ -0,0 +1,52 @@
> +nvme-gen-dhchap-key(1)
> +===================
> +
> +NAME
> +----
> +nvme-gen-dhchap-key - Generate a host DH-HMAC-CHAP key
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'nvme gen-dhchap-key' [--hmac=<hmac-id> | -h <hmac-id>]
> +		      [--secret=<secret> | -s <secret> ]
> +		      [--key-length=<len> | -l <len> ]
> +		      [--nqn=<host-nqn> | -n <host-nqn> ]

Maybe it is a good idea to have some sane defaults create
/etc/nvme/hostkey when installing nvme-cli? Or will it
take it unconditionally?

> +
> +DESCRIPTION
> +-----------
> +Generate a base64-encoded DH-HMAC-CHAP host key in the form:
> +DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
> +and prints it to stdout.
> +
> +OPTIONS
> +-------
> +-h <hmac-id>::
> +--hmac=<hmac-id>::
> +	Select a HMAC algorithm to use. Possible values are:
> +	0 - No HMAC algorithm
> +	1 - SHA-256
> +	2 - SHA-384
> +	3 - SHA-512
> +
> +-s <secret>::
> +--secret=<secret>::
> +	Secret value (in hexadecimal) to be used for the key. If none are
> +	provided a random value is used.
> +
> +-l <len>::
> +--key-length=<len>::
> +	Length of the resulting key. Possible values are 32, 48, or 64.
> +
> +-n <hostnqn>::
> +--nqn=<hostnqn>::
> +	Host-NQN to be used for the transformation. This parameter is only
> +	valid if a non-zero HMAC function has been specified.
> +
> +EXAMPLES
> +--------
> +No Examples
> +
> +NVME
> +----
> +Part of the nvme-user suite
> diff --git a/Makefile b/Makefile
> index 5fbdfd0..984b380 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -5,6 +5,8 @@ LIBUUID = $(shell $(LD) -o /dev/null -luuid >/dev/null 2>&1; echo $$?)
>   LIBHUGETLBFS = $(shell $(LD) -o /dev/null -lhugetlbfs >/dev/null 2>&1; echo $$?)
>   HAVE_SYSTEMD = $(shell pkg-config --exists libsystemd  --atleast-version=242; echo $$?)
>   LIBJSONC = $(shell $(LD) -o /dev/null -ljson-c >/dev/null 2>&1; echo $$?)
> +LIBZ = $(shell $(LD) -o /dev/null -lz >/dev/null 2>&1; echo $$?)
> +LIBOPENSSL = $(shell $(LD) -o /dev/null -lssl >/dev/null 2>&1; echo $$?)
>   NVME = nvme
>   INSTALL ?= install
>   DESTDIR =
> @@ -33,6 +35,18 @@ ifeq ($(LIBHUGETLBFS),0)
>   	override LIB_DEPENDS += hugetlbfs
>   endif
>   
> +ifeq ($(LIBZ),0)
> +	override LDFLAGS += -lz
> +	override CFLAGS += -DLIBZ
> +	override LIB_DEPENDS += zlib
> +endif
> +
> +ifeq ($(LIBOPENSSL),0)
> +	override LDFLAGS += -lssl -lcrypto
> +	override CFLAGS += -DOPENSSL
> +	override LIB_DEPENDS += openssl
> +endif
> +
>   INC=-Iutil
>   
>   ifeq ($(HAVE_SYSTEMD),0)
> @@ -70,7 +84,8 @@ OBJS := nvme-print.o nvme-rpmb.o \
>   	fabrics.o nvme-models.o plugin.o
>   
>   UTIL_OBJS := util/argconfig.o util/suffix.o util/parser.o \
> -	util/cleanup.o
> +	util/cleanup.o util/base64.o
> +
>   ifneq ($(LIBJSONC), 0)
>   override UTIL_OBJS += util/json.o
>   endif
> diff --git a/nvme-builtin.h b/nvme-builtin.h
> index a413d00..a256f05 100644
> --- a/nvme-builtin.h
> +++ b/nvme-builtin.h
> @@ -81,6 +81,7 @@ COMMAND_LIST(
>   	ENTRY("disconnect-all", "Disconnect from all connected NVMeoF subsystems", disconnect_all_cmd)
>   	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
>   	ENTRY("show-hostnqn", "Show NVMeoF host NQN", show_hostnqn_cmd)
> +	ENTRY("gen-dhchap-key", "Generate NVMeoF DH-HMAC-CHAP host key", gen_dhchap_key)
>   	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
>   	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
>   	ENTRY("virt-mgmt", "Manage Flexible Resources between Primary and Secondary Controller ", virtual_mgmt)
> diff --git a/nvme.c b/nvme.c
> index 79605f5..5791357 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -36,22 +36,31 @@
>   #include <math.h>
>   #include <dirent.h>
>   #include <libgen.h>
> +#include <zlib.h>
>   
>   #ifdef LIBHUGETLBFS
>   #include <hugetlbfs.h>
>   #endif
>   
> +#ifdef OPENSSL
> +#include <openssl/engine.h>
> +#include <openssl/evp.h>
> +#include <openssl/hmac.h>
> +#endif
> +
>   #include <linux/fs.h>
>   
>   #include <sys/mman.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
> +#include <sys/random.h>
>   
>   #include "common.h"
>   #include "nvme.h"
>   #include "libnvme.h"
>   #include "nvme-print.h"
>   #include "plugin.h"
> +#include "base64.h"
>   
>   #include "argconfig.h"
>   #include "fabrics.h"
> @@ -5750,6 +5759,152 @@ static int show_hostnqn_cmd(int argc, char **argv, struct command *command, stru
>   	return 0;
>   }
>   
> +static int gen_dhchap_key(int argc, char **argv, struct command *command, struct plugin *plugin)
> +{
> +	const char *desc = "Generate a DH-HMAC-CHAP host key usable "\
> +		"for NVMe In-Band Authentication.";
> +	const char *secret = "Optional secret (in hexadecimal characters) "\
> +		"to be used to initialize the host key.";
> +	const char *key_len = "Length of the resulting key "\
> +		"(32, 48, or 64 bytes).";
> +	const char *hmac = "HMAC function to use for key transformation "\
> +		"(0 = none, 1 = SHA-256, 2 = SHA-384, 3 = SHA-512).";
> +	const char *nqn = "Host NQN to use for key transformation.";
> +
> +	char *hostnqn;
> +	char *raw_secret;
> +	unsigned char key[68];
> +	char encoded_key[128];
> +	unsigned long crc = crc32(0L, NULL, 0);
> +	int err = 0;
> +#ifdef OPENSSL
> +	const EVP_MD *md = NULL;
> +#else
> +	const char *md = NULL;
> +#endif
> +	struct config {
> +		char *secret;
> +		unsigned int key_len;
> +		char *nqn;
> +		unsigned int hmac;
> +	};
> +
> +	struct config cfg = {
> +		.secret = NULL,
> +		.key_len = 32,
> +		.nqn = NULL,
> +		.hmac = 0,
> +	};
> +
> +	OPT_ARGS(opts) = {
> +		OPT_STR("secret", 's', &cfg.secret, secret),
> +		OPT_UINT("key-length", 'l', &cfg.key_len, key_len),
> +		OPT_STR("nqn", 'n', &cfg.nqn, nqn),
> +		OPT_UINT("hmac", 'h', &cfg.hmac, hmac),
> +		OPT_END()
> +	};
> +
> +	err = argconfig_parse(argc, argv, desc, opts);
> +	if (err)
> +		return err;
> +
> +	if (cfg.key_len != 32 && cfg.key_len != 48 && cfg.key_len != 64) {
> +		fprintf(stderr, "Invalid key length %u\n", cfg.key_len);
> +		return -EINVAL;
> +	}
> +	if (cfg.hmac > 3) {
> +		fprintf(stderr, "Invalid HMAC identifier %u\n", cfg.hmac);
> +		return -EINVAL;
> +	}
> +	if (cfg.hmac > 0) {
> +#ifdef OPENSSL
> +		if (!cfg.nqn) {
> +			hostnqn = nvmf_hostnqn_from_file();
> +			if (!hostnqn) {
> +				fprintf(stderr, "Could not read host NQN\n");
> +				return -ENOENT;
> +			}
> +		} else {
> +			hostnqn = cfg.nqn;
> +		}
> +		switch (cfg.hmac) {
> +		case 1:
> +			md = EVP_sha256();
> +			break;
> +		case 2:
> +			md = EVP_sha384();
> +			break;
> +		case 3:
> +			md = EVP_sha512();
> +			break;
> +		default:
> +			break;
> +		}
> +#else
> +		fprintf(stderr, "HMAC transformation not supported; "\
> +			"recompile with OpenSSL support.\n");
> +		return -EINVAL;
> +#endif
> +	}
> +	raw_secret = malloc(cfg.key_len);
> +	if (!raw_secret)
> +		return -ENOMEM;
> +	if (!cfg.secret) {
> +		if (getrandom(raw_secret, cfg.key_len, GRND_NONBLOCK) < 0)
> +			return errno;
> +	} else {
> +		int secret_len = 0, i;
> +		unsigned int c;
> +
> +		for (i = 0; i < strlen(cfg.secret); i+=2) {
> +			if (sscanf(&cfg.secret[i], "%02x", &c) != 1) {
> +				fprintf(stderr, "Invalid secret '%s'\n",
> +					cfg.secret);
> +				return -EINVAL;
> +			}
> +			raw_secret[secret_len++] = (unsigned char)c;
> +		}
> +		if (secret_len != cfg.key_len) {
> +			fprintf(stderr, "Invalid key length (%d bytes)\n",
> +				secret_len);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (md) {
> +#ifdef OPENSSL
> +		HMAC_CTX *hmac_ctx = HMAC_CTX_new();
> +		const char hmac_seed[] = "NVMe-over-Fabrics";
> +		unsigned int key_len;
> +
> +		ENGINE_load_builtin_engines();
> +		ENGINE_register_all_complete();
> +
> +		HMAC_Init_ex(hmac_ctx, raw_secret, cfg.key_len,md, NULL);
> +		HMAC_Update(hmac_ctx, (unsigned char *)hostnqn,
> +			    strlen(hostnqn));
> +		HMAC_Update(hmac_ctx, (unsigned char *)hmac_seed,
> +			    strlen(hmac_seed));
> +		HMAC_Final(hmac_ctx, key, &key_len);
> +		HMAC_CTX_free(hmac_ctx);
> +#endif
> +	} else {
> +		memcpy(key, raw_secret, cfg.key_len);
> +	}
> +
> +	crc = crc32(crc, key, cfg.key_len);
> +	key[cfg.key_len++] = crc & 0xff;
> +	key[cfg.key_len++] = (crc >> 8) & 0xff;
> +	key[cfg.key_len++] = (crc >> 16) & 0xff;
> +	key[cfg.key_len++] = (crc >> 24) & 0xff;
> +
> +	memset(encoded_key, 0, sizeof(encoded_key));
> +	base64_encode(key, cfg.key_len, encoded_key);
> +
> +	printf("DHHC-1:%02x:%s:\n", cfg.hmac, encoded_key);
> +	return 0;
> +}
> +
>   static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
>   {
>   	const char *desc = "Send Get Log Page request to Discovery Controller.";
> diff --git a/util/argconfig.h b/util/argconfig.h
> index 1a5c693..3b6da4c 100644
> --- a/util/argconfig.h
> +++ b/util/argconfig.h
> @@ -100,6 +100,7 @@ enum argconfig_types {
>   #define OPT_FMT(l, s, v, d)  OPT_STRING(l, s, "FMT", v, d)
>   #define OPT_FILE(l, s, v, d) OPT_STRING(l, s, "FILE", v, d)
>   #define OPT_LIST(l, s, v, d) OPT_STRING(l, s, "LIST", v, d)
> +#define OPT_STR(l, s, v, d) OPT_STRING(l, s, "STRING", v, d)
>   
>   struct argconfig_commandline_options {
>   	const char *option;
> diff --git a/util/base64.c b/util/base64.c
> new file mode 100644
> index 0000000..328c8ea
> --- /dev/null
> +++ b/util/base64.c
> @@ -0,0 +1,62 @@
> +/*
> + * base64.c - RFC4648-compliant base64 encoding
> + *
> + * Copyright (c) 2020 Hannes Reinecke, SUSE
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA  02110-1301, USA.
> + */
> +
> +#include <stdlib.h>
> +
> +static const char base64_table[65] =
> +	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> +
> +/**
> + * base64_encode() - base64-encode some bytes
> + * @src: the bytes to encode
> + * @srclen: number of bytes to encode
> + * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> + *
> + * Encodes the input string using characters from the set [A-Za-z0-9+,].
> + * The encoded string is roughly 4/3 times the size of the input string.
> + *
> + * Return: length of the encoded string
> + */
> +int base64_encode(const unsigned char *src, int srclen, char *dst)
> +{
> +	int i, bits = 0;
> +	u_int32_t ac = 0;
> +	char *cp = dst;
> +
> +	for (i = 0; i < srclen; i++) {
> +		ac = (ac << 8) | src[i];
> +		bits += 8;
> +		do {
> +			bits -= 6;
> +			*cp++ = base64_table[(ac >> bits) & 0x3f];
> +		} while (bits >= 6);
> +	}
> +	if (bits) {
> +		bits -= 6;
> +		*cp++ = base64_table[(ac >> bits) & 0x3f];
> +	}
> +	while (bits < 0) {
> +		*cp++ = '=';
> +		bits += 2;
> +	}
> +
> +	return cp - dst;
> +}
> diff --git a/util/base64.h b/util/base64.h
> new file mode 100644
> index 0000000..374f5e6
> --- /dev/null
> +++ b/util/base64.h
> @@ -0,0 +1,6 @@
> +#ifndef _BASE64_H
> +#define _BASE64_H
> +
> +int base64_encode(const unsigned char *src, int len, char *dst);
> +
> +#endif /* _BASE64_H */
> 


Overall looks good, do we want to allow different host keys
for different NVM subsystems?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
