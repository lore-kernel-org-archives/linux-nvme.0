Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B7C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:57:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2426101A
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2426101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W97gLDKOSxiq6NEh5Rf1/FugyDc+B7HN4stk81MIV3Y=; b=OsR0dzLcGnc/x1UrxIkuH2xnY
	RLzEfJGiW1ovaSd0VauHwq1iQKRplI3k66+Xe3SPirNrUk8cIrU5BVRWkhoNaoHtR726wnABAlPr2
	HoEswixVsomWNEfDp8yk24gu1xy7sI1X7M69a0HLGwyZhVYKUTi3Bbs6iYwTwoonVmJKzqxG9vGTW
	Xa8P5S92Q2/scXFpP2zuGf314FDL/hWXJakQTh8xRybP8mL8hrQM1H+TXRE0leQxxhQ6LwT1pH8SA
	6C5i2VIOljjv0AaHH1u6mI8J5E8moN/yxwbra59uIfHKtbStxsFehrWosUnAu7Moe2zXkRPcodWDS
	7Yt6Ldozg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhYJd-008DJF-Te; Fri, 14 May 2021 13:57:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYJb-008DJ3-5e
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 13:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ycf+Ridpmezb3hp6yCOC46HUc2t/NrvYXBs20Gz2ILA=; b=cd9A/glMjz9JIhiKprgEJ/D4pJ
 K3tc+5nJCJ2sMnBAqzhKwxi0pc07ufULPbrz3vEhl6PwX5LUXKqyBvghqeDzQpKev9W6G8E0bBTQv
 hX1T6gBIl0X7cvXEnOUfxmGiXKX7BJBEU5ImKNdfAgXsIn7I4YZpABxlO8j1cNDaVuOBuN5fyWBLK
 gPTon+c7/+K15vq0FtqCRRa2F1lFqra4v2Vo/SmadzRxK5ayijKE5E3QiP/mvjhemNCf5qLEzFcsk
 jXuEMtWMSi6Ht5V931p/tRjlgyfPCSJjrWqd1aOxnaLU3pcDckaF6H9wtIlezcawOy74TLn5WIAoI
 DinbfBLA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYJY-00C1F4-L7
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 13:57:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 176846736F; Fri, 14 May 2021 15:57:13 +0200 (CEST)
Date: Fri, 14 May 2021 15:57:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v2 15/22] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210514135712.GD4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-16-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_065716_852775_97A933C4 
X-CRM114-Status: GOOD (  16.94  )
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

> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_dma_pci_p2pdma(sg)) {
> +			sg_dma_unmark_pci_p2pdma(sg);
> +		} else  {

Double space here.  We also don't really need the curly braces to start
with.

> +	struct pci_p2pdma_map_state p2pdma_state = {};
> +	enum pci_p2pdma_map_type map;
>  	struct scatterlist *sg;
> +	int i, ret;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {

Why not just:

			switch (pci_p2pdma_map_segment(&p2pdma_state, dev,
					sg)) {

(even better with a shorter name for p2pdma_state so that it all fits on
a single line)?

> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped normally, thus we do nothing
> +				 * and continue below.
> +				 */

I have a bit of a hard time parsing this comment.

> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
> +			ret = -EINVAL;
>  			goto out_unmap;
> +		}
>  		sg_dma_len(sg) = sg->length;
>  	}
>  
> @@ -411,7 +443,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  
>  out_unmap:
>  	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return -EINVAL;
> +	return ret;

Maybe just initialize ret to -EINVAL at declaration time to simplify this
a bit?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
