Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E12CCAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 07:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7s0darRmpAoSF4AYzaEAKr+Som3Rl5+XVaBmiwsyicM=; b=0ROnQ/FDEO7b0QH+Od0Kkgi3Qg
	0ivHCEYZK5jmvvdgfihk2g2pbFLI8ri1/PX1HJ7keYwhjAakHFdD9ZKDCH7V5XAATomZ2D7QqIpxM
	50NwQXz7tRt6BSoJBEoCPJ530x00BZblEXmOyD12nBHOCd21B1G+di0aPUif0bTGWpzGz2Kcd+Q7j
	s/O3Fs+0Rs0xLVlNwYU2IklQcaDp8ftoFIHgJqgRV//J+EXRtNU1QVMhp9Ev5hQni3Jzcgt86KfGu
	k4T/hAJL2AJUcIFtJ0K2Sl6uiDdOtldT1Q37nsNw3BKQYyY1X9hMKMPdX8W/swg++NX2dHzCD/axb
	j5H8DkhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbzh-00000001a0E-3IbT;
	Thu, 11 Sep 2025 07:45:25 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbzf-00000001Zyz-1y9F
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 07:45:24 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-24cd340377dso2755805ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757576723; x=1758181523; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s0darRmpAoSF4AYzaEAKr+Som3Rl5+XVaBmiwsyicM=;
        b=oXvDlT3AZQOcmHaOt8SwW7nWSlnKGl37YK6KZ+CoO2QGg1eUPtyZzTzG6SpiwcMrkZ
         7oAAaZaohodkxNHMfzyYKrUhkTYvxxWDMfBn2DKvCq2pDXIRRlNH9jbkNRryGh60VPef
         gVKBs0Pihyf+oCCjOJSVfE8CxnY5OEmmO9muiSvZAvQKcOZNkVthBx8eNC2ACiFo4lU9
         8pHrIB4fYuj9LM6Nii9O+tHEUgCBL0mzNipJfWuqjWE3JQVWknnZ9upaziZcJVbV8vEq
         JLzhMaRVdc3WbG1NMBKpaWwEEnaJzNWp10sWCdoR+P64zOm2Mf4Poz4Ip5nD7/3Y+rHG
         dAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757576723; x=1758181523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s0darRmpAoSF4AYzaEAKr+Som3Rl5+XVaBmiwsyicM=;
        b=Rdo61yDhBuPG7AH5zzOKFHMlXwLu67M5YiG32/2PnUhm26ysegUaZM2RTm+Hy81MC+
         tSDkgvuYLIm2NI+AsBkfWxVmrta2Z191Vx55GOZgn8IG8xLswajVgjJ36ORQ0qWf32KU
         hrgwjE/qv9sSJsQ8PaGYgXf2N5K5WhdVWYXXVrd+d56y3nGKQEJQZ6y46vGkVpQOaeH/
         RJDvY7Moeh1i5MyILW64+kLM21hrjkjZhzxcgu8Omyw2QGMOrlZabnTxe8BWguINlIvd
         9c9OQ4eEevdMEBmehhBGOYkdOpfcha1qyL78YMa4LL9H9UR7AZyAI2cgbf8OuQ2Bgsi/
         OpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsakrEEi/7eo5YpTiZa0SrViSTTAjOsRZjBbSGOJa0aSaXCEPG01XUrLHJXYL9K6xlVZ138aMq5cQn@lists.infradead.org
X-Gm-Message-State: AOJu0Yzb51g7DaA6QteAiEM24zINSekXZBBEK9+NRZbrbfZPR9j9sko3
	j7xPUPO4gnHGtUsgxXOdNyBfV0c8mDrdQ7aNwjNftRBR/uBVrpI0n5VC4zmXPMRm4POvzONmRZI
	nurAP8G0=
X-Gm-Gg: ASbGncvcjKgK/ZhDt8gplp6NI9yPTK0cX908vLZzph7OoDlgpzZa5/awbuM3hV0/Tw9
	F7f3ApDIROqHYGtc3nVR/VVxcV1De6P/bdoNhA13n6l2DX75zFL9iJFqyshfUXBhJLZ+IG6sUTa
	11qSR0DpjB6qTmhCgXWr4FONWXWYonNgNlnXgSoO6aeCe/Dkbq9onGIS+MKQOmAok41a5pENs8T
	OcWG6JNJD3rJ7cYfG/nw475G8r92BooefwyE6+aKiRsnwIirU5Xzhcws171KAD92NR+sAJ3Z2yl
	9kf9AnveoSg0JW/jCaGput70CXewb/Q4k/JF9ECEI81A5N/jzf5UkM+aNiYVmM0keCcDv2x3OJC
	ImdBrhHOzzqtGCnd8Z5Iat/sZshfaEU0s7uQgaeahHz5XjBs=
X-Google-Smtp-Source: AGHT+IEqJNXLNJAINV677IYIL5EReMelpFkf7dFD6n7F4RIuL6WJn8Kv9Y6X1eDhV8xZE+Ct5kotng==
X-Received: by 2002:a17:902:ea06:b0:24c:e6fa:2a3b with SMTP id d9443c01a7336-25170e41037mr262573745ad.38.1757576722587;
        Thu, 11 Sep 2025 00:45:22 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b44sm10499645ad.45.2025.09.11.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:45:21 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: [PATCH v2 3/5] lib: add KUnit tests for base64 encoding/decoding
Date: Thu, 11 Sep 2025 15:45:10 +0800
Message-Id: <20250911074510.685568-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_004523_512959_B5F1FAA1 
X-CRM114-Status: GOOD (  19.06  )
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

Add a KUnit test suite for the base64 helpers. The tests exercise both
encoding and decoding, cover padded and unpadded forms per RFC 4648, and
include negative cases for malformed inputs and padding errors. The suite
also validates behavior with a caller-supplied encoding table.

In addition to functional checks, the suite includes simple microbenchmarks
which report average encode/decode latency for small (64B) and larger (1KB)
inputs. These numbers are informational only and do not gate the tests.

Kconfig (BASE64_KUNIT) and lib/tests/Makefile are updated accordingly.

Sample KUnit output:

    KTAP version 1
    # Subtest: base64
    # module: base64_kunit
    1..3
    # base64_performance_tests: [64B] encode run : 32ns
    # base64_performance_tests: [64B] decode run : 122ns
    # base64_performance_tests: [1KB] encode run : 507ns
    # base64_performance_tests: [1KB] decode run : 1870ns
    ok 1 base64_performance_tests
    ok 2 base64_encode_tests
    ok 3 base64_decode_tests
    # base64: pass:3 fail:0 skip:0 total:3
    # Totals: pass:3 fail:0 skip:0 total:3

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/Kconfig.debug        |  19 +++-
 lib/tests/Makefile       |   1 +
 lib/tests/base64_kunit.c | 230 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 lib/tests/base64_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed..1cfb12d02 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2794,8 +2794,25 @@ config CMDLINE_KUNIT_TEST
 
 	  If unsure, say N.
 
+config BASE64_KUNIT
+	tristate "KUnit test for base64 decoding and encoding" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the base64 unit tests.
+
+	  The tests cover the encoding and decoding logic of Base64 functions
+	  in the kernel.
+	  In addition to correctness checks, simple performance benchmarks
+	  for both encoding and decoding are also included.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config BITS_TEST
-	tristate "KUnit test for bits.h" if !KUNIT_ALL_TESTS
+	tristate "KUnit test for bit functions and macros" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index fa6d728a8..6593a2873 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -4,6 +4,7 @@
 
 # KUnit tests
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
+obj-$(CONFIG_BASE64_KUNIT) += base64_kunit.o
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_BLACKHOLE_DEV_KUNIT_TEST) += blackhole_dev_kunit.o
diff --git a/lib/tests/base64_kunit.c b/lib/tests/base64_kunit.c
new file mode 100644
index 000000000..1941ac504
--- /dev/null
+++ b/lib/tests/base64_kunit.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * base64_kunit_test.c - KUnit tests for base64 encoding and decoding functions
+ *
+ * Copyright (c) 2025, Guan-Chun Wu <409411716@gms.tku.edu.tw>
+ */
+
+#include <kunit/test.h>
+#include <linux/base64.h>
+
+static const char base64_table[65] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+/* ---------- Benchmark helpers ---------- */
+static u64 bench_encode_ns(const u8 *data, int len, char *dst, int reps)
+{
+	u64 t0, t1;
+
+	t0 = ktime_get_ns();
+	for (int i = 0; i < reps; i++)
+		base64_encode(data, len, dst, true, base64_table);
+	t1 = ktime_get_ns();
+
+	return div64_u64(t1 - t0, (u64)reps);
+}
+
+static u64 bench_decode_ns(const char *data, int len, u8 *dst, int reps)
+{
+	u64 t0, t1;
+
+	t0 = ktime_get_ns();
+	for (int i = 0; i < reps; i++)
+		base64_decode(data, len, dst, true, base64_table);
+	t1 = ktime_get_ns();
+
+	return div64_u64(t1 - t0, (u64)reps);
+}
+
+static void run_perf_and_check(struct kunit *test, const char *label, int size)
+{
+	const int reps = 1000;
+	size_t outlen = DIV_ROUND_UP(size, 3) * 4;
+	u8 *in = kmalloc(size, GFP_KERNEL);
+	char *enc = kmalloc(outlen, GFP_KERNEL);
+	u8 *decoded = kmalloc(size, GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, in);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, enc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, decoded);
+
+	get_random_bytes(in, size);
+	int enc_len = base64_encode(in, size, enc, true, base64_table);
+	int dec_len = base64_decode(enc, enc_len, decoded, true, base64_table);
+
+	/* correctness sanity check */
+	KUNIT_EXPECT_EQ(test, dec_len, size);
+	KUNIT_EXPECT_MEMEQ(test, decoded, in, size);
+
+	/* benchmark encode */
+
+	u64 t1 = bench_encode_ns(in, size, enc, reps);
+
+	kunit_info(test, "[%s] encode run : %lluns", label, t1);
+
+	u64 t2 = bench_decode_ns(enc, enc_len, decoded, reps);
+
+	kunit_info(test, "[%s] decode run : %lluns", label, t2);
+
+	kfree(in);
+	kfree(enc);
+	kfree(decoded);
+}
+
+static void base64_performance_tests(struct kunit *test)
+{
+	run_perf_and_check(test, "64B", 64);
+	run_perf_and_check(test, "1KB", 1024);
+}
+
+/* ---------- Helpers for encode ---------- */
+static void expect_encode_ok(struct kunit *test, const u8 *src, int srclen,
+			     const char *expected, bool padding)
+{
+	char buf[128];
+	int encoded_len = base64_encode(src, srclen, buf, padding, base64_table);
+
+	buf[encoded_len] = '\0';
+
+	KUNIT_EXPECT_EQ(test, encoded_len, strlen(expected));
+	KUNIT_EXPECT_STREQ(test, buf, expected);
+}
+
+/* ---------- Helpers for decode ---------- */
+static void expect_decode_ok(struct kunit *test, const char *src,
+			     const u8 *expected, int expected_len, bool padding)
+{
+	u8 buf[128];
+	int decoded_len = base64_decode(src, strlen(src), buf, padding, base64_table);
+
+	KUNIT_EXPECT_EQ(test, decoded_len, expected_len);
+	KUNIT_EXPECT_MEMEQ(test, buf, expected, expected_len);
+}
+
+static void expect_decode_err(struct kunit *test, const char *src,
+			      int srclen, bool padding)
+{
+	u8 buf[64];
+	int decoded_len = base64_decode(src, srclen, buf, padding, base64_table);
+
+	KUNIT_EXPECT_EQ(test, decoded_len, -1);
+}
+
+/* ---------- Encode Tests ---------- */
+static void base64_encode_tests(struct kunit *test)
+{
+	/* With padding */
+	expect_encode_ok(test, (const u8 *)"", 0, "", true);
+	expect_encode_ok(test, (const u8 *)"f", 1, "Zg==", true);
+	expect_encode_ok(test, (const u8 *)"fo", 2, "Zm8=", true);
+	expect_encode_ok(test, (const u8 *)"foo", 3, "Zm9v", true);
+	expect_encode_ok(test, (const u8 *)"foob", 4, "Zm9vYg==", true);
+	expect_encode_ok(test, (const u8 *)"fooba", 5, "Zm9vYmE=", true);
+	expect_encode_ok(test, (const u8 *)"foobar", 6, "Zm9vYmFy", true);
+
+	/* Extra cases with padding */
+	expect_encode_ok(test, (const u8 *)"Hello, world!", 13, "SGVsbG8sIHdvcmxkIQ==", true);
+	expect_encode_ok(test, (const u8 *)"ABCDEFGHIJKLMNOPQRSTUVWXYZ", 26,
+			 "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo=", true);
+	expect_encode_ok(test, (const u8 *)"abcdefghijklmnopqrstuvwxyz", 26,
+			 "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo=", true);
+	expect_encode_ok(test, (const u8 *)"0123456789+/", 12, "MDEyMzQ1Njc4OSsv", true);
+
+	/* Without padding */
+	expect_encode_ok(test, (const u8 *)"", 0, "", false);
+	expect_encode_ok(test, (const u8 *)"f", 1, "Zg", false);
+	expect_encode_ok(test, (const u8 *)"fo", 2, "Zm8", false);
+	expect_encode_ok(test, (const u8 *)"foo", 3, "Zm9v", false);
+	expect_encode_ok(test, (const u8 *)"foob", 4, "Zm9vYg", false);
+	expect_encode_ok(test, (const u8 *)"fooba", 5, "Zm9vYmE", false);
+	expect_encode_ok(test, (const u8 *)"foobar", 6, "Zm9vYmFy", false);
+
+	/* Extra cases without padding */
+	expect_encode_ok(test, (const u8 *)"Hello, world!", 13, "SGVsbG8sIHdvcmxkIQ", false);
+	expect_encode_ok(test, (const u8 *)"ABCDEFGHIJKLMNOPQRSTUVWXYZ", 26,
+			 "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo", false);
+	expect_encode_ok(test, (const u8 *)"abcdefghijklmnopqrstuvwxyz", 26,
+			 "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo", false);
+	expect_encode_ok(test, (const u8 *)"0123456789+/", 12, "MDEyMzQ1Njc4OSsv", false);
+}
+
+/* ---------- Decode Tests ---------- */
+static void base64_decode_tests(struct kunit *test)
+{
+	/* -------- With padding --------*/
+	expect_decode_ok(test, "", (const u8 *)"", 0, true);
+	expect_decode_ok(test, "Zg==", (const u8 *)"f", 1, true);
+	expect_decode_ok(test, "Zm8=", (const u8 *)"fo", 2, true);
+	expect_decode_ok(test, "Zm9v", (const u8 *)"foo", 3, true);
+	expect_decode_ok(test, "Zm9vYg==", (const u8 *)"foob", 4, true);
+	expect_decode_ok(test, "Zm9vYmE=", (const u8 *)"fooba", 5, true);
+	expect_decode_ok(test, "Zm9vYmFy", (const u8 *)"foobar", 6, true);
+	expect_decode_ok(test, "SGVsbG8sIHdvcmxkIQ==", (const u8 *)"Hello, world!", 13, true);
+	expect_decode_ok(test, "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo=",
+			 (const u8 *)"ABCDEFGHIJKLMNOPQRSTUVWXYZ", 26, true);
+	expect_decode_ok(test, "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo=",
+			 (const u8 *)"abcdefghijklmnopqrstuvwxyz", 26, true);
+
+	/* Error cases */
+	expect_decode_err(test, "Zg=!", 4, true);
+	expect_decode_err(test, "Zm$=", 4, true);
+	expect_decode_err(test, "Z===", 4, true);
+	expect_decode_err(test, "Zg", 2, true);
+	expect_decode_err(test, "Zm9v====", 8, true);
+	expect_decode_err(test, "Zm==A", 5, true);
+
+	{
+		char with_nul[4] = { 'Z', 'g', '\0', '=' };
+
+		expect_decode_err(test, with_nul, 4, true);
+	}
+
+	/* -------- Without padding --------*/
+	expect_decode_ok(test, "", (const u8 *)"", 0, false);
+	expect_decode_ok(test, "Zg", (const u8 *)"f", 1, false);
+	expect_decode_ok(test, "Zm8", (const u8 *)"fo", 2, false);
+	expect_decode_ok(test, "Zm9v", (const u8 *)"foo", 3, false);
+	expect_decode_ok(test, "Zm9vYg", (const u8 *)"foob", 4, false);
+	expect_decode_ok(test, "Zm9vYmE", (const u8 *)"fooba", 5, false);
+	expect_decode_ok(test, "Zm9vYmFy", (const u8 *)"foobar", 6, false);
+	expect_decode_ok(test, "TWFu", (const u8 *)"Man", 3, false);
+	expect_decode_ok(test, "SGVsbG8sIHdvcmxkIQ", (const u8 *)"Hello, world!", 13, false);
+	expect_decode_ok(test, "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo",
+			 (const u8 *)"ABCDEFGHIJKLMNOPQRSTUVWXYZ", 26, false);
+	expect_decode_ok(test, "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo",
+			 (const u8 *)"abcdefghijklmnopqrstuvwxyz", 26, false);
+	expect_decode_ok(test, "MDEyMzQ1Njc4OSsv", (const u8 *)"0123456789+/", 12, false);
+
+	/* Error cases */
+	expect_decode_err(test, "Zg=!", 4, false);
+	expect_decode_err(test, "Zm$=", 4, false);
+	expect_decode_err(test, "Z===", 4, false);
+	expect_decode_err(test, "Zg=", 3, false);
+	expect_decode_err(test, "Zm9v====", 8, false);
+	expect_decode_err(test, "Zm==v", 4, false);
+
+	{
+		char with_nul[4] = { 'Z', 'g', '\0', '=' };
+
+		expect_decode_err(test, with_nul, 4, false);
+	}
+}
+
+/* ---------- Test registration ---------- */
+static struct kunit_case base64_test_cases[] = {
+	KUNIT_CASE(base64_performance_tests),
+	KUNIT_CASE(base64_encode_tests),
+	KUNIT_CASE(base64_decode_tests),
+	{}
+};
+
+static struct kunit_suite base64_test_suite = {
+	.name = "base64",
+	.test_cases = base64_test_cases,
+};
+
+kunit_test_suite(base64_test_suite);
+
+MODULE_AUTHOR("Guan-Chun Wu <409411716@gms.tku.edu.tw>");
+MODULE_DESCRIPTION("KUnit tests for Base64 encoding/decoding, including performance checks");
+MODULE_LICENSE("GPL");
-- 
2.34.1


