Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B362BD58E7A
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajYyJinueABn4Wn0ep1sQ+xreG/RfgDwgN+/qrYN/sM=; b=AHUppKfI6BUzAxMwrTdy/upzwf
	6EFUvklgimdxgo/HkQTZ4PU3D17JjU9WvSQPxpGUGp37B0b11hITdZWfObaTVrTcfzFi+jI6b1ryR
	FwRNQAZm9Sks/uvcBnKX69s3uvJ8uZPy6CIIYo6pRdvmK79Zenb+8KB6Sk7nsY3aJALzVUQC4S94s
	CjHE0PIZ/1fb9txU3c9GJBU34sOqpUS4FGfQOJWVgls0K6glyed9IZiHgUicSL4zkeO6CvoXsOgWA
	N+j2yg/Xk18S1tdzWzQJH3qZt8NfUx6H1RWOlVNAZ7L6tooxa77tQek/0Nx8kVSa8yGW4KB39b1e0
	E9+Hmsyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDU-0000000CSad-3suf;
	Mon, 02 Mar 2026 08:01:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDS-0000000CSY6-1mfZ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8CA67600AE;
	Mon,  2 Mar 2026 08:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12525C19423;
	Mon,  2 Mar 2026 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438481;
	bh=R/uN40OdWl8W8jZ5+DQFOQLamKy+g4n07BO+//jSvv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+6DZ1UZfG+V0zmaR8Q6Ccs3P//SkIF+FfjXAClh+83+Cdaq8ZgYOytPpISDmE/Zl
	 NPgXaWf9KoXC65qq4RCQOlzmF7INvHo/jvGfxtVVMzv+UbuPLwDnVj9Z/8xGbLAmjX
	 38lEB66Ejl28/vb7xBwB34/CHGXGkXLDG/f3tF0mqJVjQQ0u1kYxPs+CvbxfxGY2bh
	 6qaE9IQNfoFq2gd3Pz8vCERGLgEiFuwJTCZa4mJEkYi3zvjEl3aoyxHwcUuOEfXyxJ
	 W7doU5RFcVXIGGpXpPf4QtvtFwHTa3JOX7io1e9zliiivS4bC7ym/gptTRc9AAIzyj
	 sxaRfLQtSH21Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 04/21] nvme-auth: common: add KUnit tests for TLS key derivation
Date: Sun,  1 Mar 2026 23:59:42 -0800
Message-ID: <20260302075959.338638-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
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

Unit-test the sequence of function calls that derive tls_psk, so that we
can be more confident that changes in the implementation don't break it.

Since the NVMe specification doesn't seem to include any test vectors
for this (nor does its description of the algorithm seem to match what
was actually implemented, for that matter), I just set the expected
values to the values that the code currently produces.  In the case
of SHA-512, nvme_auth_generate_digest() currently returns -EINVAL, so
for now the test tests for that too.  If it is later determined that
some other behavior is needed, the test can be updated accordingly.

Tested with:

    tools/testing/kunit/kunit.py run --kunitconfig drivers/nvme/common/

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/.kunitconfig       |   6 +
 drivers/nvme/common/Kconfig            |   8 ++
 drivers/nvme/common/Makefile           |   2 +
 drivers/nvme/common/tests/auth_kunit.c | 175 +++++++++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 drivers/nvme/common/.kunitconfig
 create mode 100644 drivers/nvme/common/tests/auth_kunit.c

diff --git a/drivers/nvme/common/.kunitconfig b/drivers/nvme/common/.kunitconfig
new file mode 100644
index 0000000000000..60a038dc9423d
--- /dev/null
+++ b/drivers/nvme/common/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_BLOCK=y
+CONFIG_BLK_DEV_NVME=y
+CONFIG_NVME_HOST_AUTH=y
+CONFIG_NVME_AUTH_KUNIT_TEST=y
diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index da963e4f3f1f8..d19988c13af5f 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -11,5 +11,13 @@ config NVME_AUTH
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_DH
 	select CRYPTO_DH_RFC7919_GROUPS
 	select CRYPTO_HKDF
+
+config NVME_AUTH_KUNIT_TEST
+	tristate "KUnit tests for NVMe authentication" if !KUNIT_ALL_TESTS
+	depends on KUNIT && NVME_AUTH
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for some of the common code for NVMe over Fabrics
+	  In-Band Authentication.
diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
index 681514cf2e2f5..fd9d01a609463 100644
--- a/drivers/nvme/common/Makefile
+++ b/drivers/nvme/common/Makefile
@@ -5,5 +5,7 @@ ccflags-y			+= -I$(src)
 obj-$(CONFIG_NVME_AUTH)		+= nvme-auth.o
 obj-$(CONFIG_NVME_KEYRING)	+= nvme-keyring.o
 
 nvme-auth-y			+= auth.o
 nvme-keyring-y			+= keyring.o
+
+obj-$(CONFIG_NVME_AUTH_KUNIT_TEST) += tests/auth_kunit.o
diff --git a/drivers/nvme/common/tests/auth_kunit.c b/drivers/nvme/common/tests/auth_kunit.c
new file mode 100644
index 0000000000000..28b8dd1e3b186
--- /dev/null
+++ b/drivers/nvme/common/tests/auth_kunit.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unit tests for NVMe authentication functions
+ *
+ * Copyright 2026 Google LLC
+ */
+
+#include <crypto/sha2.h>
+#include <kunit/test.h>
+#include <linux/nvme.h>
+#include <linux/nvme-auth.h>
+#include <linux/slab.h>
+
+struct nvme_auth_test_values {
+	u8 hmac_id;
+	size_t hash_len;
+	u8 expected_psk[NVME_AUTH_MAX_DIGEST_SIZE];
+	char *expected_psk_digest;
+	u8 expected_tls_psk[NVME_AUTH_MAX_DIGEST_SIZE];
+};
+
+static void kfree_action(void *ptr)
+{
+	kfree(ptr);
+}
+
+static void kunit_add_kfree_action(struct kunit *test, void *ptr)
+{
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, kfree_action, ptr));
+}
+
+/*
+ * Test the derivation of a TLS PSK from the initial skey.  The vals parameter
+ * gives the expected value of tls_psk as well as the intermediate values psk
+ * and psk_digest.  The inputs are implicitly the fixed values set below.
+ */
+static void
+test_nvme_auth_derive_tls_psk(struct kunit *test,
+			      const struct nvme_auth_test_values *vals)
+{
+	const u8 hmac_id = vals->hmac_id;
+	const size_t hash_len = vals->hash_len;
+	const size_t skey_len = hash_len;
+	u8 skey[NVME_AUTH_MAX_DIGEST_SIZE];
+	u8 c1[NVME_AUTH_MAX_DIGEST_SIZE];
+	u8 c2[NVME_AUTH_MAX_DIGEST_SIZE];
+	const char *subsysnqn = "subsysnqn";
+	const char *hostnqn = "hostnqn";
+	u8 *psk = NULL, *tls_psk = NULL;
+	char *psk_digest = NULL;
+	size_t psk_len;
+	int ret;
+
+	for (int i = 0; i < NVME_AUTH_MAX_DIGEST_SIZE; i++) {
+		skey[i] = 'A' + i;
+		c1[i] = i;
+		c2[i] = 0xff - i;
+	}
+
+	ret = nvme_auth_generate_psk(hmac_id, skey, skey_len, c1, c2, hash_len,
+				     &psk, &psk_len);
+	kunit_add_kfree_action(test, psk);
+	KUNIT_ASSERT_EQ(test, 0, ret);
+	KUNIT_ASSERT_EQ(test, hash_len, psk_len);
+	KUNIT_ASSERT_MEMEQ(test, vals->expected_psk, psk, psk_len);
+
+	ret = nvme_auth_generate_digest(hmac_id, psk, psk_len, subsysnqn,
+					hostnqn, &psk_digest);
+	kunit_add_kfree_action(test, psk_digest);
+	if (vals->expected_psk_digest == NULL) {
+		/*
+		 * Algorithm has an ID assigned but is not supported by
+		 * nvme_auth_generate_digest().
+		 */
+		KUNIT_ASSERT_EQ(test, -EINVAL, ret);
+		return;
+	}
+	KUNIT_ASSERT_EQ(test, 0, ret);
+	KUNIT_ASSERT_STREQ(test, vals->expected_psk_digest, psk_digest);
+
+	ret = nvme_auth_derive_tls_psk(hmac_id, psk, psk_len, psk_digest,
+				       &tls_psk);
+	kunit_add_kfree_action(test, tls_psk);
+	KUNIT_ASSERT_EQ(test, 0, ret);
+	KUNIT_ASSERT_MEMEQ(test, vals->expected_tls_psk, tls_psk, psk_len);
+}
+
+static void test_nvme_auth_derive_tls_psk_hmac_sha256(struct kunit *test)
+{
+	static const struct nvme_auth_test_values vals = {
+		.hmac_id = NVME_AUTH_HASH_SHA256,
+		.hash_len = SHA256_DIGEST_SIZE,
+		.expected_psk = {
+			0x17, 0x33, 0xc5, 0x9f, 0xa7, 0xf4, 0x8f, 0xcf,
+			0x37, 0xf5, 0xf2, 0x6f, 0xc4, 0xff, 0x02, 0x68,
+			0xad, 0x4f, 0x78, 0xe0, 0x30, 0xf4, 0xf3, 0xb0,
+			0xbf, 0xd1, 0xd4, 0x7e, 0x7b, 0xb1, 0x44, 0x7a,
+		},
+		.expected_psk_digest = "OldoKuTfKddMuyCznAZojkWD7P4D9/AtzDzLimtOxqI=",
+		.expected_tls_psk = {
+			0x3c, 0x17, 0xda, 0x62, 0x84, 0x74, 0xa0, 0x4d,
+			0x22, 0x47, 0xc4, 0xca, 0xb4, 0x79, 0x68, 0xc9,
+			0x15, 0x38, 0x81, 0x93, 0xf7, 0xc0, 0x71, 0xbd,
+			0x94, 0x89, 0xcc, 0x36, 0x66, 0xcd, 0x7c, 0xc8,
+		},
+	};
+
+	test_nvme_auth_derive_tls_psk(test, &vals);
+}
+
+static void test_nvme_auth_derive_tls_psk_hmac_sha384(struct kunit *test)
+{
+	static const struct nvme_auth_test_values vals = {
+		.hmac_id = NVME_AUTH_HASH_SHA384,
+		.hash_len = SHA384_DIGEST_SIZE,
+		.expected_psk = {
+			0xf1, 0x4b, 0x2d, 0xd3, 0x23, 0x4c, 0x45, 0x96,
+			0x94, 0xd3, 0xbc, 0x63, 0xf8, 0x96, 0x8b, 0xd6,
+			0xb3, 0x7c, 0x2c, 0x6d, 0xe8, 0x49, 0xe2, 0x2e,
+			0x11, 0x87, 0x49, 0x00, 0x1c, 0xe4, 0xbb, 0xe8,
+			0x64, 0x0b, 0x9e, 0x3a, 0x74, 0x8c, 0xb1, 0x1c,
+			0xe4, 0xb1, 0xd7, 0x1d, 0x35, 0x9c, 0xce, 0x39,
+		},
+		.expected_psk_digest = "cffMWk8TSS7HOQebjgYEIkrPrjWPV4JE5cdPB8WhEvY4JBW5YynKyv66XscN4A9n",
+		.expected_tls_psk = {
+			0x27, 0x74, 0x75, 0x32, 0x33, 0x53, 0x7b, 0x3f,
+			0xa5, 0x0e, 0xb7, 0xd1, 0x6a, 0x8e, 0x43, 0x45,
+			0x7d, 0x85, 0xf4, 0x90, 0x6c, 0x00, 0x5b, 0x22,
+			0x36, 0x61, 0x6c, 0x5d, 0x80, 0x93, 0x9d, 0x08,
+			0x98, 0xff, 0xf1, 0x5b, 0xb8, 0xb7, 0x71, 0x19,
+			0xd2, 0xbe, 0x0a, 0xac, 0x42, 0x3e, 0x75, 0x90,
+		},
+	};
+
+	test_nvme_auth_derive_tls_psk(test, &vals);
+}
+
+static void test_nvme_auth_derive_tls_psk_hmac_sha512(struct kunit *test)
+{
+	static const struct nvme_auth_test_values vals = {
+		.hmac_id = NVME_AUTH_HASH_SHA512,
+		.hash_len = SHA512_DIGEST_SIZE,
+		.expected_psk = {
+			0x9c, 0x9f, 0x08, 0x9a, 0x61, 0x8b, 0x47, 0xd2,
+			0xd7, 0x5f, 0x4b, 0x6c, 0x28, 0x07, 0x04, 0x24,
+			0x48, 0x7b, 0x44, 0x5d, 0xd9, 0x6e, 0x70, 0xc4,
+			0xc0, 0x9b, 0x55, 0xe8, 0xb6, 0x00, 0x01, 0x52,
+			0xa3, 0x36, 0x3c, 0x34, 0x54, 0x04, 0x3f, 0x38,
+			0xf0, 0xb8, 0x50, 0x36, 0xde, 0xd4, 0x06, 0x55,
+			0x35, 0x0a, 0xa8, 0x7b, 0x8b, 0x6a, 0x28, 0x2b,
+			0x5c, 0x1a, 0xca, 0xe1, 0x62, 0x33, 0xdd, 0x5b,
+		},
+		/* nvme_auth_generate_digest() doesn't support SHA-512 yet. */
+		.expected_psk_digest = NULL,
+	};
+
+	test_nvme_auth_derive_tls_psk(test, &vals);
+}
+
+static struct kunit_case nvme_auth_test_cases[] = {
+	KUNIT_CASE(test_nvme_auth_derive_tls_psk_hmac_sha256),
+	KUNIT_CASE(test_nvme_auth_derive_tls_psk_hmac_sha384),
+	KUNIT_CASE(test_nvme_auth_derive_tls_psk_hmac_sha512),
+	{},
+};
+
+static struct kunit_suite nvme_auth_test_suite = {
+	.name = "nvme-auth",
+	.test_cases = nvme_auth_test_cases,
+};
+kunit_test_suite(nvme_auth_test_suite);
+
+MODULE_DESCRIPTION("Unit tests for NVMe authentication functions");
+MODULE_LICENSE("GPL");
-- 
2.53.0


