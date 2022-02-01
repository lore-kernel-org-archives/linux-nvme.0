Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E323C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3LqISi/a3vgBfzeiMMkun9gN2jMZ8wPT5xVeVM3lXRY=; b=wMUaqk9i+FXrnCvyF0qhvY21Lu
	M9NTc9o7SgVRveQ4FNRXgzboioeVI5GfMzfduIfHjkfrV6/1D8CArCJaTwByYpZPOiY0QMyBGQkAB
	ajEsvdN7RctRF/F9vGiZ46lcci8YBthmoptXhrehgHIHubTtoTPMfqzgHUabWJyqkC6qlh6XRRZdW
	6t3hGyKR/L4VBlWdPqDcLvOyGFXbOfX6hre8A9AZnH8bvMHEZRvXPNUcmInM+yfi1ltMeTz0IflOm
	gn3WOxGtZSJqxZCsSLnNyZyxxIFD3KRDQpKBwFt0zZza5gr0raVykuF2GeRJbhxCFRyS8/BDDn5v3
	crc4Gp5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyQ7-00DT15-I7; Tue, 01 Feb 2022 19:02:27 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPJ-00DSg3-LN
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 69011B82F5C;
 Tue,  1 Feb 2022 19:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEEDC340EB;
 Tue,  1 Feb 2022 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742096;
 bh=v/Q8ZZo7quyOd6plKn0NPo653Dll/VicuADDW6MUnw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TkQ63Gj6FV7VVaG9hwNnctBUpCi+9O5MuiKVANM2KUj682vyIg9LN0wyh3BKQ5zpB
 Bm6uF8lKJq1BEuSKeCPPTwX1ifJYnjsG0thJG2rldMCUsjL2XQevp09Fr0fZvxLKjN
 6Omg4I8Qe6do+WVg4i3e1iWDSTy1Sr9RcMgDUOZFFs3iVJ3kCRoxlTJcQIjveNwMdY
 D/CoHj1CgZrnDB/Ea91es8x2aPkAxts7vMgw0Zi0U45vxGxf+TxgNLjF7fRSGhI8ZC
 QnnCYGy/59XDLFjH2izw4NpIj4nWlUG8H5ODsFOPb0t/183wgqnQ//3hRt9AL4gnxv
 AKQyRL5ghu17g==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/7] lib: add crc64 tests
Date: Tue,  1 Feb 2022 11:01:25 -0800
Message-Id: <20220201190128.3075065-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110138_003247_96CA5729 
X-CRM114-Status: GOOD (  16.97  )
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
v1->v2:

  Fixed Kconfig dependency

 lib/Kconfig.debug |  4 +++
 lib/Makefile      |  1 +
 lib/test_crc64.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
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
index 300f569c626b..e100a4d6a950 100644
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


