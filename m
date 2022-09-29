Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B03BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wuhxWCVeXVlJVS/RfP/AZNvPaB2WtIt+hlprDEaQew8=; b=tizYl5xYMlZWAUmAZo+kAjqvdv
	ElnIXCfAPH158cgMwRSYtB9ML/H829wuZGKeSl4j7575cXuoYQaQaFu6f1Gx51E1Rzf4Nw/bUKaIq
	PQqWsA3vMZ9+GU3t2VKJ2rWQhb+0eRj3PpUSBOccB6LHydsGjBNDF6/zfFIXgpjA8/SqGoZfhDG2h
	SszKttt5rfY57p1tARnxOnJwQZCg+5uVG3wN11JNJYNg6YPRwRZBIZFesvtXO5f+D6bdQ+84ldzUM
	7TJSwljbDVSxf3VnOflyVYce7O7kANYeQ1J65WzhUXq1v0ZopE4NsYexVdDDkou3hjYKq4T76l0Kh
	fyelqFmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2JL-005nMp-Tw; Thu, 29 Sep 2022 22:47:19 +0000
Received: from post.baikalelectronics.com ([213.79.110.86])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2JE-005nHx-JB
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 22:47:14 +0000
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 63B39E0EB5;
	Fri, 30 Sep 2022 01:46:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=wuhxWCVeXVlJVS/RfP/AZNvPaB2WtIt+hlprDEaQew8=; b=tp0ozYnJRVZb
	3eOjGM6LN8TCwm25Q+QFgtbgIAcq6fonGNSvoBN/ax9zXSP9KuFKSHRRJhS6lHBY
	Hp9D7/pv0NAdDxGCXECCbCHCzU+5HbRntTZwP29CWCnCUKnIXExi1hNXj9wDXbL1
	rI4PnhJFrDkO3LC4RvuG+ywABgJbY1w=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 56706E0E6B;
	Fri, 30 Sep 2022 01:46:56 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:46:57 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Jonathan Derrick <jonathan.derrick@intel.com>, Revanth
 Rajashekar <revanth.rajashekar@intel.com>, Rafael Antognolli
	<Rafael.Antognolli@intel.com>, Scott Bauer <scott.bauer@intel.com>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Pavel Parkhomenko
	<Pavel.Parkhomenko@baikalelectronics.ru>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] block: sed-opal: Cache-line-align the cmd/resp buffers
Date: Fri, 30 Sep 2022 01:46:48 +0300
Message-ID: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_154713_187221_FDD6ACC8 
X-CRM114-Status: GOOD (  12.59  )
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
2.37.3



