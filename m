Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05257C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsEWhFoLR7Yk3fuCmZhuCZXQNVDx7uLKn2kO4jSR9pk=; b=CH529iwj8ugdqPzTuJ2yZqlk0X
	YOz5Q51AOv4WcTUSfe2Lt2vDL1Z+YhNIhG9spLOCvjzIIqXQgKsPf3zHPr4rsPpf6+VPfg6IYtU2r
	cT90JPpYaaN/j7ib/FTvAXBVDMtT0ms35R7OF9MGAYvm4dwpPwB+fDZFHML6WaTgUJdy0e1DoGgzj
	PjfNJg+jcgWESdXG3Q9eQC8pKAYHs3vDqMhYy+ZjrcIrcEv553WD0Ccmf4qg4WjXOQIVlsKYIkE5l
	TTkHiI+S3i08isnR9+IItlrqE/YZx7zYxN8LbClpc/rXejC4siDya64/qfo0MIPfiet+k3epLBliR
	/xlR3Ekg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMY9i-00AgC7-Ef; Tue, 22 Feb 2022 16:36:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMY5S-00Ado1-Mm
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:32:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8B28860AC8;
 Tue, 22 Feb 2022 16:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409E3C340F7;
 Tue, 22 Feb 2022 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645547546;
 bh=K6Y7PoEX/ei0aWx5jBUIAMLJ24UZ5DFTNrAOH1STYEg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u9njbRhtam4tj7EVawuiEHrQK/nvvMc1jbYszicWb68JbDLKKiZBRuK69/HrTdhYc
 h08qvcJoobCsKto8s1Y/9yUVkuqMZlqdE0u3qY31ALVTM1bWbKVS37YrfO7HFh36Ig
 I+1nEV2P4pH7YWFwfmUWx5Qrks60mddWWGEwexufBzWoMapCpKLv4FiZrs+Qq/mgF3
 dyQ01Ax3ziLdSxeKN7gv7YcPWYJbb8PSkTR/+DIUpYAMrhHHOgQAIRJDx0S841hSYh
 iQ1l5MHVRFFZZRj2F9CBwEOSHIYIobaMC/1XjexedLGcnPPteETqHPX+L81vaQVOSI
 JLrke3jmgBwCg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 07/10] lib: add crc64 tests
Date: Tue, 22 Feb 2022 08:31:41 -0800
Message-Id: <20220222163144.1782447-8-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_083226_854055_E510A886 
X-CRM114-Status: GOOD (  18.45  )
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

Provide a module to test the rocksoft crc64 calculations with well known
inputs and exepected values. Check the generic table implementation and
whatever module is registered from the crypto library, and compare their
speeds.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 lib/Kconfig.debug |   4 ++
 lib/Makefile      |   1 +
 lib/test_crc64.c  | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 lib/test_crc64.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..149de11ae903 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2214,6 +2214,10 @@ config TEST_UUID
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
+config TEST_CRC64
+	depends on CRC64
+	tristate "Test the crc64 code at runtime"
+
 config TEST_OVERFLOW
 	tristate "Test check_*_overflow() functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index 130bed83cdf2..0895a3fc3f5a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+obj-$(CONFIG_TEST_CRC64) += test_crc64.o
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_crc64.c b/lib/test_crc64.c
new file mode 100644
index 000000000000..281aacd20f0a
--- /dev/null
+++ b/lib/test_crc64.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests were selected from NVM Express NVM Command Set Specification 1.0a,
+ * section 5.2.1.3.5 "64b CRC Test Cases" available here:
+ *
+ *   https://nvmexpress.org/wp-content/uploads/NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified.pdf
+ *
+ * Copyright 2022 Keith Busch <kbusch@kernel.org>
+ */
+
+#include <linux/crc64.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/random.h>
+
+static unsigned int tests_passed;
+static unsigned int tests_run;
+
+#define ALL_ZEROS 0x6482D367EB22B64EULL
+#define ALL_FFS 0xC0DDBA7302ECA3ACULL
+#define INC 0x3E729F5F6750449CULL
+#define DEC 0x9A2DF64B8E9E517EULL
+
+static u8 buffer[4096];
+
+#define CRC_CHECK(c, v) do {					\
+	tests_run++;						\
+	if (c != v)						\
+		printk("BUG at %s:%d expected:%llx got:%llx\n", \
+			__func__, __LINE__, v, c);		\
+	else							\
+		tests_passed++;					\
+} while (0)
+
+static void randomize(u64 *b, int size)
+{
+	int i;
+
+	for (i = 0; i < size / 8; i++)
+		b[i] = get_random_u64();
+}
+
+static void crc_speed_tests(void)
+{
+	unsigned long size = 1 << 20;
+	unsigned test_size;
+	void *b;
+
+	b = vmalloc(size);
+	if (!b)
+		return;
+
+	test_size = 512;
+	while (test_size <= size) {
+		ktime_t start_time, end_time;
+		u64 crc1, crc2;
+		s64 t1, t2;
+		int i;
+
+		randomize(b, test_size);
+		crc1 = crc2 = ~0ULL;
+
+		start_time = ktime_get();
+		for (i = 0; i < 1024; i++)
+			crc1 = crc64_rocksoft_generic(crc1, b, test_size);
+		end_time = ktime_get();
+		t1 = ktime_us_delta(end_time, start_time);
+
+		start_time = ktime_get();
+		for (i = 0; i < 1024; i++)
+			crc2 = crc64_rocksoft_update(crc2, b, test_size);
+		end_time = ktime_get();
+		t2 = ktime_us_delta(end_time, start_time);
+
+		printk("Size:%-7u Generic:%-7lld Library:%lld\n", test_size,
+			t1, t2);
+		CRC_CHECK(crc1, crc2);
+
+		test_size <<= 1;
+	}
+
+        vfree(b);
+}
+
+static int crc_tests(void)
+{
+	__u64 crc;
+	int i;
+
+	memset(buffer, 0, sizeof(buffer));
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_ZEROS);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, ALL_ZEROS);
+
+	memset(buffer, 0xff, sizeof(buffer));
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_FFS);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, ALL_FFS);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = i & 0xff;
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, INC);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, INC);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = 0xff - (i & 0xff);
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, DEC);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, DEC);
+
+	crc_speed_tests();
+
+	printk("CRC64: %u of %u tests passed\n", tests_passed, tests_run);
+	return (tests_run == tests_passed) ? 0 : -EINVAL;
+}
+
+static void crc_exit(void)
+{
+}
+
+module_init(crc_tests);
+module_exit(crc_exit);
+MODULE_AUTHOR("Keith Busch <kbusch@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.25.4


