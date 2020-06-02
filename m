Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D6C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC9D2068D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qO2IGoHs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hGZhtpad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5JKRcTZpcKcQP19HQBbKJL8oTuTEMYaPSoo4du8TUlo=; b=qO2IGoHsYC2mPT
	LBD78CesjBcghigbBPQ3AjWZ26qFKj+nKOVe41pKMs0ZenHurxUm02vws3jMASEAmoilpdNFSRVwu
	B3/ZEtTCj1cIfQS2YC08cn6/Mnvj10vDW/bCSE22k5HWRPHPY36pochu7siiNXoInIPqrW9VgrbQU
	theOHFPbay44w2nRt32lU75k80KaUqtsc40s+XjnkrTFpFXKNqWlzSbV7Ic5QZVCzlLonE1ieDItL
	wgY77KUccQkabXUOqMsaeJIIKrKS/Lbb35fpxFT4Om65q9LaJz4kwDGP193QiNuyQ0yQ7uJScEnAM
	/ItxW40UUoFMSfjsNNoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jfwsM-00052v-H0; Tue, 02 Jun 2020 02:42:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfws5-0004o9-Gy
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 02:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591065705; x=1622601705;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7mkqgr6TLzXdnYKpPKKVJr4CleYGHp4v8A2Jptz4IjM=;
 b=hGZhtpado0+lVqe4Q4hzY3LKkZYqXEZnVqNVsK6aTVawi/3tHGLxJckG
 5KZ7hNdhR/0khx6kOwLV0QH1jfLUmsK/nlcEMHWA+wOS7cEl5iLYL20KV
 t6ogYZ0yBuAAkK9QHMxcUxAiG4cq4s2hY5284q74q97i6/ILyDFerVPxF
 IaImhacSexc2mzjLgkOkyyKl8TqnAMGxRcAPy1nnLBwS3S2yxA18siIUs
 z97n0bW6HV3mJaehVrgZFvODZcR2Z7GQ4EdlsWETgVRGCSrPBDcdRX5sy
 FD9JLLvpPwpI4IqZ7lesTXfcUkzZiAY/ZaHXZt6ux4wabu/4vFzCemR9P Q==;
IronPort-SDR: LAF+uzF/heWAvohaqNZbUCeoSAR/+/F9hJ5oE/B71CLG0old44v5AQwoMjaOd21y9xwb9Dg/kX
 O3YdzOdIzFYsdmuF9MhCd1H0VaypriUQRrcjy+gOBucCWoSIDg9VJsaXaT2yfTXld+9YqIy7tD
 rspWRhU4yBoedVYJqV/qEGzA2Hl7C/DYeUeRz3D9JzLtqJwXVZEdgYlRV3tJbMhheizS40Tip2
 OcUhWQq6Uldh1u5i4z1gl2A0I5WR/TRI4iy7i0tUegY0GIxA9B4P8SI0zxTkQvophNkwVElCqt
 ZTM=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; d="scan'208";a="248077884"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 10:41:41 +0800
IronPort-SDR: TP/2/P9t6ZLIXA9keBIamGj7aQFM8pow84+3elfCNti/15hEuJ41mdvJr1Yksfe/XkGVfrDZSm
 WFbf15FSR/DoLOOizs/qcMXl6NLM0g4bc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 19:31:22 -0700
IronPort-SDR: iSiYrZVCLQp1ICQAzcvO4miQVkXDIP5Zdt3MwjA2Uyvkeo+cpZoiwWTb4tGApDeKF5J7+j13nb
 w9jeenqqO7BQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 19:41:41 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme-pci: code cleanup for nvme_alloc_host_mem()
Date: Mon,  1 Jun 2020 19:41:14 -0700
Message-Id: <20200602024114.5153-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_194145_846102_014C4D24 
X-CRM114-Status: GOOD (  10.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Although use of for loop is preferred it is not a common practice to
have 80 char long for loop initialization and comparison section.

Use temp variables for calculating values and replace them in the
for loop with size of all variables to set to u64 since preferred
variable is declared as u64.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bf8514bbbfb..171185d75194 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1922,12 +1922,12 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
-	u32 chunk_size;
+	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
+	u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
+	u64 chunk_size;
 
 	/* start big and work our way down */
-	for (chunk_size = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
-	     chunk_size >= max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
-	     chunk_size /= 2) {
+	for (chunk_size = min_chunk; chunk_size >= hmminds; chunk_size /= 2) {
 		if (!__nvme_alloc_host_mem(dev, preferred, chunk_size)) {
 			if (!min || dev->host_mem_size >= min)
 				return 0;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
