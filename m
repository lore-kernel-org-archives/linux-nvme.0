Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70AC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:28:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107F66112F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107F66112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZHPb7Q7te6fisjMwsvVXIKVLgTeNtdhYygNkKoFHI0Q=; b=mym55CVfqq2VRBstQ1zyMc7rm
	oHVXhbGtJ6d5tAzdJumIurGAwe2auo3mutfubuhHCRyPZcch00hu4f9OHsteKBTkQ3hd8UH8nk3wK
	GhxhsLVBbEdDDhgzz5jKcmXa5lkMfitWeiGAp2dus7XA24pduABoNb6RWL+YBjloxZcr8XaB8uvP6
	SJTVt47e6HjV2/DQx9bOMZcXaeMfsvLgxTDI85mPlZNA6tU8WSj1KWKeTuSLs+O1oWjz8zTRhdAMu
	TpDnxe5Efm/iEqBGIX93lqUQGK6jpWktlhCMVMRxacAy9hpXGDDhi6CULoF9Ne845qTuoHoCkgxpJ
	s0j47e01w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddIs-00EbMp-TZ; Mon, 03 May 2021 18:28:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddIp-00EbMS-OO
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=d8XwvLbbE43n/ALvzFHI+Iof+YTcBaDuUh6ptHdqEd4=; b=Ob+551XqPDQMQyleUVBbvc97vU
 jmwMRg1Gfpcb46H9VPoS8L//1w+naOCA+xpsXEhR2/bTBOFSBYf/ZFeRY3cwwvJypR4PTG75Xa5fH
 cM0owNO12ipG0yEdl4d9iIUJCyRKifJrMU++baw/eZAYTjoohj6G8FJLWa7FrN0RGZk7k0ec0jRCf
 MRWwRdrshVs42glXSLzZ+RyilwZNKfREzoNYlZI33ETwcCSfeS4NFKqP0lvaVGHLHnZtDsvSwJ5CF
 kNoMPKvkP6V78pEeEjEOCyI8hLZixfEPx8u0aRtxHjN6+nkl04KHvk+vpmo0/2EDBv492ATcG/OTH
 t6qI1lqQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddIm-003OZH-5G
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:28:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 16D2068BEB; Mon,  3 May 2021 20:28:12 +0200 (CEST)
Date: Mon, 3 May 2021 20:28:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210503182811.GC17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
 <20210427230113.GV2047089@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427230113.GV2047089@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_112816_366119_D8CF3774 
X-CRM114-Status: GOOD (  18.87  )
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

On Tue, Apr 27, 2021 at 08:01:13PM -0300, Jason Gunthorpe wrote:
> At a high level I'm OK with it. dma_map_sg_attrs() is the extra
> extended version of dma_map_sg(), it already has a different
> signature, a different return code is not out of the question.
> 
> dma_map_sg() is just the simple easy to use interface that can't do
> advanced stuff.
> 
> > I'm not that opposed to this. But it will make this series a fair bit
> > longer to change the 8 map_sg_attrs() usages.
> 
> Yes, but the result seems much nicer to not grow the DMA API further.

We already have a mapping function that can return errors:
dma_map_sgtable.

I think it might make more sense to piggy back on that, as the sg_table
abstraction is pretty useful basically everywhere that we deal with
scatterlists anyway.

In the hopefully no too long run I plan to get rid of scatterlists in
at least NVMe and other high performance devices anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
