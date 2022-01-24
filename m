Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+otzx+ueF7CROJ93T5xOG7ZQqRzwLDnacalzrC5MMpk=; b=TjRJadZnT9YulB4v9xjaRUhHew
	6vHNKwsC9tDYoefielao9MOkFr9Ozh0Dv6HppXisGGELDMv/4rHkY66HaOfLXlAHdtFfWBDxrd8VQ
	C57RQvI0JVF8/KG7p1hXFbI7uIdU0awHZJ0foT+ci0js2oGIB8KWgtdlMRuWLIMsyvbYkAW3kqf4V
	3RFRwRkCclPP2lmKR60CztfcinbQvrJRFQhsW1HPusm4SMkE4OAr6GPmdFfWU2KwEp3HWkExG6JPv
	SuJk/ctQlyZiSIcf9XUkODg3qTx21T05FRT+HtV2sjvhf1ORPPJ1zPTqJpc0xf9zB/Y1eN3KXczu0
	AXgF3q3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC1n0-003tJi-Px; Mon, 24 Jan 2022 16:01:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC1mM-003t1G-Hy
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 16:01:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 089D4614D2;
 Mon, 24 Jan 2022 16:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F3EC340EA;
 Mon, 24 Jan 2022 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643040073;
 bh=sS9Rm7Z5b9L8FU4QcAY05N2W4x4A7A3U2xE4Ud2uv0k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pAhc0rhCEWxOub6v5yQ1xEmH6lAye0myM0X5uWJHXwUAfSRxtGvYF5+yIuUHkv8ju
 ZCsf8wNwnZE90LmpONZCaX6B65HwBbogndqU0EWvuajLjUwa+QPyaBRnJbzKniYjm1
 x/T9gBIGL1xC49DuICpoF5F1Nrak5vhPFw80yr/BSHdUZ/g1ZLz4xz4PFNjcmMe83V
 CPsvxTAtva6ikQIcW0A7DV0ly9hh3YaO+Os5izJqq95x2uQ9xIKe4Oy0uSQsYy5u9+
 8VTr5vssQF4joJYkYSO2UstNSaJjtmcyLeq83hJQ9volscCypHE5J+EWmEyfcjpJbG
 QRhOiq2CpJDYQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 4/7] lib: add crc64 tests
Date: Mon, 24 Jan 2022 08:01:04 -0800
Message-Id: <20220124160107.1683901-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_080114_709478_4E1F8673 
X-CRM114-Status: GOOD (  17.03  )
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
inputs and exepected values.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 lib/Kconfig.debug |  3 +++
 lib/Makefile      |  1 +
 lib/test_crc64.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 lib/test_crc64.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c77fe36bb3d8..97711884b270 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2212,6 +2212,9 @@ config TEST_UUID
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
+config TEST_CRC64
+	tristate "Test the crc64 code at runtime"
+
 config TEST_OVERFLOW
 	tristate "Test check_*_overflow() functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index b213a7bbf3fd..423ef5ac3427 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+obj-$(CONFIG_TEST_CRC64) += test_crc64.o
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_crc64.c b/lib/test_crc64.c
new file mode 100644
index 000000000000..283fef8f110e
--- /dev/null
+++ b/lib/test_crc64.c
@@ -0,0 +1,68 @@
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
+
+static int crc_tests(void)
+{
+	__u64 crc;
+	int i;
+
+	memset(buffer, 0, sizeof(buffer));
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_ZEROS);
+
+	memset(buffer, 0xff, sizeof(buffer));
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_FFS);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = i & 0xff;
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, INC);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = 0xff - (i & 0xff);
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, DEC);
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


