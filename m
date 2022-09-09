Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4561EECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k04JpT/Stk+B/Zc/3fGfPQL4s7cQC+RHy2d6ex7akDU=; b=KWfBQwtIQiuCeI7TOu25ySm92G
	WzlvbhnDAponqi9kSbdo08zcYeOR6/mPEGVHMtfKv1yE0oAsvqQv0LNlJU8KY8F5LdDByQL8AHLBI
	MEBhAez0HGoFn7n9tSu5fhvFg9FB+rLDbjQi+4grnPQz1obIIwgFzNLJEjv6nndBPY6BN3GAAzGxl
	AqrQvi2/oCS9q32wGUnNatk8XE4ForUaZrgXNjwTBMfE4E3P/gD+hfqpXkZ5Ok2zBPw1psuVSGUwl
	JJWLEbJ+C3uHZwEXQ+cR36LRS3wQ6/FcZQESPYF04mkeKqgkvp+8O3jFBDEgdGBNMxrrooGlqwR3q
	mmZD495A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWjXc-001ikE-Jv; Fri, 09 Sep 2022 19:19:52 +0000
Received: from mail.baikalelectronics.com ([87.245.175.230])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWjXP-001idC-Vc
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 19:19:41 +0000
Received: from mail (mail.baikal.int [192.168.51.25])
	by mail.baikalelectronics.com (Postfix) with ESMTP id 3D9A2DBB;
	Fri,  9 Sep 2022 22:23:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 3D9A2DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=baikalelectronics.ru; s=mail; t=1662751391;
	bh=k04JpT/Stk+B/Zc/3fGfPQL4s7cQC+RHy2d6ex7akDU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=O4gzvBhHAEGnSNm1f2kkZ6UEROqGLedhiAQeKD2i2IPo4oHcWkAVshH5GltVljce7
	 PudFDDrmSGjqMFYD5fBijw38Upb/+TrRtwNPdD3nUpAlpRee9joZr4YINs3kF+CCCd
	 YSIPFPKpAb7az2+yxffnEs0ilQlNlpMIxlPTfu5g=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:19:21 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Jonathan Derrick <jonathan.derrick@intel.com>, Revanth Rajashekar
	<revanth.rajashekar@intel.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Rafael Antognolli
	<Rafael.Antognolli@intel.com>, Scott Bauer <scott.bauer@intel.com>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Pavel Parkhomenko
	<Pavel.Parkhomenko@baikalelectronics.ru>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] block: sed-opal: Cache-line-align the cmd/resp buffers
Date: Fri, 9 Sep 2022 22:19:16 +0300
Message-ID: <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_121940_217409_C235876F 
X-CRM114-Status: GOOD (  11.65  )
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

In accordance with [1] the DMA-able memory buffers must be
cacheline-aligned otherwise the cache writing-back and invalidation
performed during the mapping may cause the adjacent data being lost. It's
specifically required for the DMA-noncoherent platforms. Seeing the
opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
respectively we must make sure the passed buffers are cacheline-aligned to
prevent the denoted problem.

[1] Documentation/core-api/dma-api.rst

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 block/sed-opal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9700197000f2..222acbd1f03a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -73,6 +73,7 @@ struct parsed_resp {
 	struct opal_resp_tok toks[MAX_TOKS];
 };
 
+/* Presumably DMA-able buffers must be cache-aligned */
 struct opal_dev {
 	bool supported;
 	bool mbr_enabled;
@@ -88,8 +89,8 @@ struct opal_dev {
 	u64 lowest_lba;
 
 	size_t pos;
-	u8 cmd[IO_BUFFER_LENGTH];
-	u8 resp[IO_BUFFER_LENGTH];
+	u8 cmd[IO_BUFFER_LENGTH] ____cacheline_aligned;
+	u8 resp[IO_BUFFER_LENGTH] ____cacheline_aligned;
 
 	struct parsed_resp parsed;
 	size_t prev_d_len;
-- 
2.37.2


