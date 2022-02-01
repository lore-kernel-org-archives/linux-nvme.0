Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20B6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gO2HHcwdGyTevXNR5OcTUBWkTY9YfvlBvRvxz6UzZ4I=; b=W8/NXzE112GwoUGC9XSwQcFmIt
	qp3rZxmgyAep0LpID+4D8SJZTk3Ra46ElVKBPcQRQb9QdmyV1232cMuFC1fD9snGxdT+Hr1gcl/0K
	cJaV9jWY0GAJ6wO7mrEJ5rfQf7KMzjzNLfM0kF0LkUg8mU8s4W8fIvqSns/MeX5X9Ssy+NMxAR5xl
	bOGNYX+SOs6Tb1LIyP2UIHJ7Tt9OznArqzUA6UDTihNe+ytwCI9524h2NooFUqtSPKYg60XwIiG3E
	CMCxRxb2WLE80yvO6SgwGt7QY5JhCA3B/bySgczPKXDA4MfecAcxWOKHAiI97EW9wx6Z1nuj+ZygT
	INos0oMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyPs-00DSuu-C1; Tue, 01 Feb 2022 19:02:12 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPJ-00DSfp-GS
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 41D6CB82F6D;
 Tue,  1 Feb 2022 19:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE6C340ED;
 Tue,  1 Feb 2022 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742095;
 bh=cwL3Yb4NVpj+ob2OmpLnPEK7lctKEkyo+6WsvIqLm5s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hlE6jUFXela4nAgKZuQVJve3sMcSgy6npH2+MSEYxrOtxTjEW+utcSCOEcrnnzq/r
 7KUUUNWSNqaPMF9qFCmtay/jZINrNbLQtsaqqx7/r13h1nl1sA0JnDxos3WLfs99bX
 v8/Wsse/9U+hsLTfUZQt0WVZSdFzIV6AdXHMc6Y2HkyjsAmf9+mDSz8KMs+MBYYCB7
 Kuo768495Rp1NO1l39QSAJv8MAQwvoAXUCfZHqNxs+rePcRDACMpE6MPF2wAxX9aZF
 mxA2iW+a/jOuzJOMbXdVgcoNRuIjxWrxYjzh4u51RDkAgJiNlebfXULalhS/Ip7Ehe
 aWKyYT7duIX7g==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Subject: [PATCHv2 3/7] lib: add rocksoft model crc64
Date: Tue,  1 Feb 2022 11:01:24 -0800
Message-Id: <20220201190128.3075065-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110137_847374_BDABD6AC 
X-CRM114-Status: GOOD (  20.53  )
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
generation, and provide a library routine implementing the algorithm.

The Rocksoft 64-bit CRC model parameters are as follows:
    Poly: 0xAD93D23594C93659
    Initial value: 0xFFFFFFFFFFFFFFFF
    Reflected Input: True
    Reflected Output: True
    Xor Final: 0xFFFFFFFFFFFFFFFF

Since this model used reflected bits, the implementation generates the
reflected table so the result is ordered consistently.

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Generate a reflected table for the polynomial so that the inputs and
  outputs don't need to be reflected during calculating the CRC

 include/linux/crc64.h |  2 ++
 lib/crc64.c           | 26 ++++++++++++++++++++++
 lib/gen_crc64table.c  | 51 +++++++++++++++++++++++++++++++++----------
 3 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index c756e65a1b58..9f2f20216503 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -8,4 +8,6 @@
 #include <linux/types.h>
 
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);
+u64 __pure crc64_rocksoft(u64 crc, const void *p, size_t len);
+
 #endif /* _LINUX_CRC64_H */
diff --git a/lib/crc64.c b/lib/crc64.c
index 9f852a89ee2a..e223e72be44d 100644
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
+ * crc64_rocksoft - Calculate bitwise Rocksoft CRC64
+ * @crc: seed value for computation. (u64)~0 for a new CRC calculation, or the
+ * 	 previous crc64 value if computing incrementally.
+ * @p: pointer to buffer over which CRC64 is run
+ * @len: length of buffer @p
+ */
+u64 __pure crc64_rocksoft(u64 crc, const void *p, size_t len)
+{
+	const unsigned char *_p = p;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		crc = (crc >> 8) ^ crc64rocksofttable[(crc & 0xff) ^ *_p++];
+
+	return crc ^ (u64)~0;
+}
+EXPORT_SYMBOL_GPL(crc64_rocksoft);
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


