Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:39:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4BC61074
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D4BC61074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c/fz5FqNv2TlpyBekBsEpsDulWJNX1SUhPVXKWiNzF4=; b=pXIE/bR0GX4abq
	wkd29mOy01fe6rMs4hrUMZTeequ8UTmMOy7UREzz7jatzeGpzxWbeyBMmm+E0ADDNbFzvlShDsK+H
	w7dklPdTbgc6iAplLv1pwsuG4HIyor74aVbPKGhl0DkDm0rGEV+IGO1nOOxfqMtDP0VYHyLqsMFAh
	ytkGplRaj4FqLqPfjZ7PIt2Z2q+qiEYQpYkR+o2lC3saH3of/xD5lZsSI+2kJ1LBsznrJOVX5zJWb
	nONF3Kws7fhRLYjGPxkhiA3/u0VPfU12Ds69eP18O8lWFm8VyuDcAJQId3riRi2QNOnIMmsub7c8b
	ZDpthj2uZyUIZOgvIBkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maG7g-00CfBU-6o; Tue, 12 Oct 2021 11:39:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maG7d-00CfAI-75
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=6aKAlknRtTYudyciTb9hYnKNaSyFywMQWl+eoT3Sg+c=; b=cLSNe6fg79xtA3VM5dLFe3Bubv
 MnbuV2WjtWPLLZYein4IcXChjBnIDF0UWBNw0sK7Km6nHJk5+H7ehkrt5pnIjnnuBhIBqbW4Blz2W
 G4bHx2yrQXomKrGoVIXl0L6PGyKKQsHQemtapvv7LDk8XXUdvPhkDdP+njy2XAz38iPZuasb6dSbf
 A/vENYz3L/A8shKU8JPEyvpG1UrPXUn76EsuhZv21nTrZbeJJxJ6/gV8Ih/UbwpVPGHSjLGDuCzhm
 FhbWV8+bsi1aHSEjE0l5vGugntVUMx/dP4Gw+dFLE+O+UNkp6Mgpu6cBtS1A1DoNcft2glNntnthl
 5o6I1HGg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFwA-006SBs-Qr; Tue, 12 Oct 2021 11:27:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 12/16] block: use SLAB_TYPESAFE_BY_RCU for the bio slab
Date: Tue, 12 Oct 2021 13:12:22 +0200
Message-Id: <20211012111226.760968-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This flags ensures that the pages will not be reused for non-bio
allocations before the end of an RCU grace period.  With that we can
safely use a RCU lookup for bio polling as long as we are fine with
occasionally polling the wrong device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a6fb6a0b42955..a48cf9d04b3c1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -87,7 +87,8 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 
 	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
 	bslab->slab = kmem_cache_create(bslab->name, size,
-			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
+			ARCH_KMALLOC_MINALIGN,
+			SLAB_HWCACHE_ALIGN | SLAB_TYPESAFE_BY_RCU, NULL);
 	if (!bslab->slab)
 		goto fail_alloc_slab;
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
