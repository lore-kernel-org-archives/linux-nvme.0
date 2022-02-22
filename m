Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9D7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ORKwziF4GNUsKZlBwR9x/E/eRqOzTy2uYNS+VpjYwSs=; b=2aKxrvib863ivB+EL+9m9Fxy6L
	6YKW/PMpfmUZKmdL9OsyxcJUXbDJExzVIsS8bas6VS0idIgdJfhb2zYzl0FpSMyqOpqxZj5id1hGV
	f+i/158yvyb81d4FbkX88ZKOp02bp6tiuX4Ht67vyCGbzuAXNVf/Eg9Ynyr3DB0/ViUT6K6SJpUg9
	cR7vSMhPqSB0/dmxIrMyBoMrElSQXc2A1lrCWQb+C70jvhfnYZ/WyOoVyqHaTRHE9WUTH4JwdtMHG
	FhmLLAVjO8kqa9gSxS+ubHj/XHuBm9pw6JdmpyXX8kSJC/5rCHlIBJYKryn30hAJDiDQLZmeA5/c9
	gTztQEsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYB6-00AgiV-Oi; Tue, 22 Feb 2022 16:38:16 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMY5U-00Adsf-BI
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:32:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id C1E8BCE1798;
 Tue, 22 Feb 2022 16:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B39DC340F4;
 Tue, 22 Feb 2022 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645547544;
 bh=+gTC657SZ7HRL8KJMe+FqsdlN+UbmUKFnKMiHsvqQMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uzn30o09RieMV1OCvF4cjk8HMJuKah2+DUNnrklbHLGdJUd26+uLH5zdtdBAO64pa
 is76X1snwXQjKeM3jPILNzp44BmLQ4p2Ss6xACpuo8vQJoVPFA4DXYDw9xUQ33nb8q
 WHw7GAodN/6U3Q9oIWD3CG7v4s6WzH0DVj3b7GR/ul8pvjfJiUZDX6Er2LzkgbhcdW
 ANCtXi7diKPS3HjgtdtDAB5bCdNmkBCtIGzICpSFgPM0v9mxBU8LnI+DJNlQEql3v4
 lfwfDzBXth3q9lclJKiR+IMOVYoFnzO1iAgkVa0Pr2n8+YKSGUNxUogUyw5FBA+Ms0
 +IsjhSnUnymVg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 05/10] lib: add rocksoft model crc64
Date: Tue, 22 Feb 2022 08:31:39 -0800
Message-Id: <20220222163144.1782447-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_083228_760020_66C85898 
X-CRM114-Status: GOOD (  19.96  )
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

The NVM Express specification extended data integrity fields to 64 bits
using the Rocksoft^TM parameters. Add the poly to the crc64 table
generation, and provide a generic library routine implementing the
algorithm.

The Rocksoft 64-bit CRC model parameters are as follows:
    Poly: 0xAD93D23594C93659
    Initial value: 0xFFFFFFFFFFFFFFFF
    Reflected Input: True
    Reflected Output: True
    Xor Final: 0xFFFFFFFFFFFFFFFF

Since this model used reflected bits, the implementation generates the
reflected table so the result is ordered consistently.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/crc64.h |  2 ++
 lib/crc64.c           | 26 ++++++++++++++++++++++
 lib/gen_crc64table.c  | 51 +++++++++++++++++++++++++++++++++----------
 3 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index c756e65a1b58..9480f38cc7cf 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -8,4 +8,6 @@
 #include <linux/types.h>
 
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);
+u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
+
 #endif /* _LINUX_CRC64_H */
diff --git a/lib/crc64.c b/lib/crc64.c
index 9f852a89ee2a..80072fa007a9 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -22,6 +22,13 @@
  * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
  * x^7 + x^4 + x + 1
  *
+ * crc64rocksoft[256] table is from the Rocksoft specification polynomial
+ * defined as,
+ *
+ * x^64 + x^63 + x^61 + x^59 + x^58 + x^56 + x^55 + x^52 + x^49 + x^48 + x^47 +
+ * x^46 + x^44 + x^41 + x^37 + x^36 + x^34 + x^32 + x^31 + x^28 + x^26 + x^23 +
+ * x^22 + x^19 + x^16 + x^13 + x^12 + x^10 + x^9 + x^6 + x^4 + x^3 + 1
+ *
  * Copyright 2018 SUSE Linux.
  *   Author: Coly Li <colyli@suse.de>
  */
@@ -55,3 +62,22 @@ u64 __pure crc64_be(u64 crc, const void *p, size_t len)
 	return crc;
 }
 EXPORT_SYMBOL_GPL(crc64_be);
+
+/**
+ * crc64_rocksoft_generic - Calculate bitwise Rocksoft CRC64
+ * @crc: seed value for computation. (u64)~0 for a new CRC calculation, or the
+ * 	 previous crc64 value if computing incrementally.
+ * @p: pointer to buffer over which CRC64 is run
+ * @len: length of buffer @p
+ */
+u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len)
+{
+	const unsigned char *_p = p;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		crc = (crc >> 8) ^ crc64rocksofttable[(crc & 0xff) ^ *_p++];
+
+	return crc ^ (u64)~0;
+}
+EXPORT_SYMBOL_GPL(crc64_rocksoft_generic);
diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
index 094b43aef8db..55e222acd0b8 100644
--- a/lib/gen_crc64table.c
+++ b/lib/gen_crc64table.c
@@ -17,10 +17,30 @@
 #include <stdio.h>
 
 #define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
+#define CRC64_ROCKSOFT_POLY 0x9A6C9329AC4BC9B5ULL
 
 static uint64_t crc64_table[256] = {0};
+static uint64_t crc64_rocksoft_table[256] = {0};
 
-static void generate_crc64_table(void)
+static void generate_reflected_crc64_table(uint64_t table[256], uint64_t poly)
+{
+	uint64_t i, j, c, crc;
+
+	for (i = 0; i < 256; i++) {
+		crc = 0ULL;
+		c = i;
+
+		for (j = 0; j < 8; j++) {
+			if ((crc ^ (c >> j)) & 1)
+				crc = (crc >> 1) ^ poly;
+			else
+				crc >>= 1;
+		}
+		table[i] = crc;
+	}
+}
+
+static void generate_crc64_table(uint64_t table[256], uint64_t poly)
 {
 	uint64_t i, j, c, crc;
 
@@ -30,26 +50,22 @@ static void generate_crc64_table(void)
 
 		for (j = 0; j < 8; j++) {
 			if ((crc ^ c) & 0x8000000000000000ULL)
-				crc = (crc << 1) ^ CRC64_ECMA182_POLY;
+				crc = (crc << 1) ^ poly;
 			else
 				crc <<= 1;
 			c <<= 1;
 		}
 
-		crc64_table[i] = crc;
+		table[i] = crc;
 	}
 }
 
-static void print_crc64_table(void)
+static void output_table(uint64_t table[256])
 {
 	int i;
 
-	printf("/* this file is generated - do not edit */\n\n");
-	printf("#include <linux/types.h>\n");
-	printf("#include <linux/cache.h>\n\n");
-	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
 	for (i = 0; i < 256; i++) {
-		printf("\t0x%016" PRIx64 "ULL", crc64_table[i]);
+		printf("\t0x%016" PRIx64 "ULL", table[i]);
 		if (i & 0x1)
 			printf(",\n");
 		else
@@ -58,9 +74,22 @@ static void print_crc64_table(void)
 	printf("};\n");
 }
 
+static void print_crc64_tables(void)
+{
+	printf("/* this file is generated - do not edit */\n\n");
+	printf("#include <linux/types.h>\n");
+	printf("#include <linux/cache.h>\n\n");
+	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
+	output_table(crc64_table);
+
+	printf("\nstatic const u64 ____cacheline_aligned crc64rocksofttable[256] = {\n");
+	output_table(crc64_rocksoft_table);
+}
+
 int main(int argc, char *argv[])
 {
-	generate_crc64_table();
-	print_crc64_table();
+	generate_crc64_table(crc64_table, CRC64_ECMA182_POLY);
+	generate_reflected_crc64_table(crc64_rocksoft_table, CRC64_ROCKSOFT_POLY);
+	print_crc64_tables();
 	return 0;
 }
-- 
2.25.4


