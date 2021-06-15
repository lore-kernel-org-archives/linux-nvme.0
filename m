Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0131DC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:32:05 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9385861452
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9385861452
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZDdQ87l2k0tyP1xlbKhDsWN1N/BoebMt0a30Q8ltytc=; b=zUFK9pD2fOgE7Q
	1ZhkvGz+Mgu9zbyHRSFMdOmKyQXhCytNfoW0VEwlDtcREkO61ujo0ylJ7pRh2vMG9H0x7W6/CeR44
	zmhP/bHpZ3fckKi558Cvx1uulMnyCtDd072MYepi1uqxWgOo5m9P/gWWkXMoMT8rxrxyEV0utSpbN
	4tyDcAEuG+OKimop6ntJzoyuHHaexIWSj6gaWnA6tJi3zIDDivy25jHcnDLgSOiTQHT/TmsQD28p5
	A4fO8SN5aSIlRAPqF71uQdV4Ns6vqJg+8CVBlbtX0IVaP0yCILiBVKbOCTivWjmGRqixBIvBDWTDX
	d7caxROyF5bkh7btAoxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltA68-000bp6-DS; Tue, 15 Jun 2021 14:31:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9MD-000FmL-Po
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:43:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=gAw+EDJapOH99CiLXwhTpHsII+/WeUYXvhWh+ymJSpQ=; b=fE2431uQ0PQ9viz/cOBwY0PrjN
 ks6P7qyrkv1LNvZpcWXOpRZKca3Mxx0paPyzwKMwRfnZ7uI/8cIZVRsdjScgjVNN7pS8op/ufmUVq
 joclDJNzlITVS0SbpludUS30uhNp1JHV32pVWdltUGn/kG9z9Bg/Vdlnlsh/yKuoppUprZSU03YR6
 YZEj+zfgt1YoF4ulGpf9NMs/VrsuhxjppI9kKZI35fGvWKfURueH8O38zCMTkETBL97eyBrFG2IZV
 hbsBMaQgst63NGQputk/S5qrjINQxdePumTqwF6KEQRbpBDIE59jXEgAO7P7CwtUnol4NkZ0FhOZ5
 rtI5GfRw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8sy-006nNp-Cz; Tue, 15 Jun 2021 13:13:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 11/16] block: use SLAB_TYPESAFE_BY_RCU for the bio slab
Date: Tue, 15 Jun 2021 15:10:29 +0200
Message-Id: <20210615131034.752623-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
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
index 44205dfb6b60..de5505d7018e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -82,7 +82,8 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 
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
