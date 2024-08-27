Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C000BC52D6F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qd+xhwXLn7uOqF5khrmXW/ChY13HstN+vN18RqhPTMo=; b=pzbbyJxaCOdipZkiq7Rfx8grzQ
	SHh50kSvVGtqVIlt42hmsuImC+PjTUAOqsF4onuspdB0S6EtrQCp5xiZ6Qt9GHvcs1fDiaIu3t7WB
	cWaJ26V1GAWYMJHk7wU/LvB0CNAJUTzu9in7S7dZaO7ILPVeSU7OOXtXbTYpMh3klHUtRsQ9XeKP1
	30M8cvHG4cnXdg+xxPch3e9vc3jwgQTo282SBQQiARugRK8sIToqw1JlhkxzbEwfCYNIK/uqoaKWG
	PEBM9UwpQIAPXuNrCuWqYmm2itHUH0KbllhfxWFxAFkK7gXk6cj8c5D7bQBTxAp4w2VQrJgtfePeQ
	XOoyynZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqPc-0000000AAHD-0m4m;
	Tue, 27 Aug 2024 07:14:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqPa-0000000AAGi-3HSA
	for linux-nvme@bombadil.infradead.org;
	Tue, 27 Aug 2024 07:14:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qd+xhwXLn7uOqF5khrmXW/ChY13HstN+vN18RqhPTMo=; b=fqokx4I2UbvKoakkuIkXh60Or5
	8mvhun7p2tPP5Fs0I5ZFkf7XEN4s4Ovz7d1Pf434ERWvZopvCDhqGBKWHEcLNOg+aXXruz0jVMCDU
	LqiPOUpLkPXrSPwnBzzMAI0O5ds9pT9oDn3wI1LjoorTdBSrTWuPsRjrOVeyEN7Ofp68yaXCM/usU
	NcF1E2GsfGBaEAmGic00umkAcgEOy4XuFXHzjAc4wqBbgcy70UtxI9Wd+IsSW+8BbzV5m4E8j6IUq
	LIkqZvBNWRboRn+yJgin5WzjI/AFw3IWYnH6YSFQt/NZB4zFl4aZWqKNNy8j51HA53n/CUjTRjp1f
	iBE2g0PA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqPX-0000000AoFK-2cq4
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 07:14:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6526A227AAA; Tue, 27 Aug 2024 09:14:28 +0200 (CEST)
Date: Tue, 27 Aug 2024 09:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240827071428.GA12797@lst.de>
References: <20240822183718.1234-1-mhklinux@outlook.com> <20240824081618.GB8527@lst.de> <SN6PR02MB415753359387FBC8977A9598D48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415753359387FBC8977A9598D48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_081439_797871_CEEC55F1 
X-CRM114-Status: GOOD (  26.84  )
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

On Mon, Aug 26, 2024 at 03:27:30PM +0000, Michael Kelley wrote:
> OK, this makes sense to me. The DMA_ATTR_* symbols are currently
> defined as just values that are not part of an enum or any other higher
> level abstraction, and the "attrs" parameter to the dma_* functions is
> just "unsigned long". Are you thinking that the separate namespace is
> based only on the symbolic name (i.e., DMA_MAP_* vs DMA_ATTR_*),
> with the values being disjoint? That seems straightforward to me.

Yes. Although initially I'd just keep ATTR for the allocation and then
maybe do a scripted run to convert it.

> Changing the "attrs" parameter to an enum is a much bigger change ....

I don't think an enum makes much sense as we have bits defined.  A
__bitwise type would be nice, but not required.

> For a transition period we can have both DMA_ATTR_SKIP_CPU_SYNC
> and DMA_MAP_SKIP_CPU_SYNC, and then work to change all
> occurrences of the former to the latter.
> 
> I'll have to look more closely at WEAK_ORDERING and NO_WARN.
> 
> There are also a couple of places where DMA_ATTR_NO_KERNEL_MAPPING
> is used for dma_map_* calls, but those are clearly bogus since that
> attribute is never tested in the map path.

Yeah, these kinds of bogus things is what I'd like to kill..


> > Note that this also in general involves changes to the block drivers
> > to set that flag, which is a bit annoying, but I guess there is not
> > easy way around it without paying the price for the BLK_MQ_F_BLOCKING
> > overhead everywhere.
> 
> Agreed. I assumed there was some cost to BLK_MQ_F_BLOCKING since
> the default is !BLK_MQ_F_BLOCKING, but I don't really know what
> that is. Do you have a short summary, just for my education?

I think the biggest issue is that synchronize_srcu is pretty damn
expensive, but there's also a whole bunch of places that unconditionally
defer to the workqueue.


