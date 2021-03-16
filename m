Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F722C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:12:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CCE64FC4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CCE64FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0sI9fZDhGkXlOMJXbkA5KEfDJk4E42C8WHjyLFY95VA=; b=c+9r1mivSAocuAmYR+J1wwSvK
	g6EMFv+9EJjc1qjq5cQu510l+3DheyDKCkFJbnZkl+zVQ1khN3ir0+dMCqPQWr5c6Sn+qRJ4uL9Tc
	HR5PUh8VotiC5bVym1Eo+Y4MsI0GzP9JVuz+jBHU8uv9As/dRcD1V/I+OXqFq1uQnbOd3yCyW0kOV
	u/F/xfl7/fYEigb27cSe3Owwv32ykIiBpniCenuOFr+ozaGqonLIU57vqBatWbr+yHK+93PdQ7PGy
	TvYf2Qxxo+kjDPCjTnOhrJ15hAUyRCw+RCZcRKLMMhb3w4ii5tGG+fRgyQUI6sggiNlpbqD6w39iH
	0GtmU4msA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM4oB-00078x-Lr; Tue, 16 Mar 2021 08:12:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM4o6-00077Z-Nn
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 08:12:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 68EB168C4E; Tue, 16 Mar 2021 09:11:57 +0100 (CET)
Date: Tue, 16 Mar 2021 09:11:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210316081156.GA16595@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-7-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_081203_846098_5EC67381 
X-CRM114-Status: GOOD (  14.73  )
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

On Thu, Mar 11, 2021 at 04:31:36PM -0700, Logan Gunthorpe wrote:
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			if (sg_page(sg)->pgmap != pgmap) {
> +				pgmap = sg_page(sg)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
> +			}
> +
> +			if (map < 0) {
> +				sg->dma_address = DMA_MAPPING_ERROR;
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +
> +			if (map) {
> +				sg->dma_address = sg_phys(sg) + sg->offset -
> +					bus_off;
> +				sg_dma_len(sg) = sg->length;
> +				sg_mark_pci_p2pdma(sg);
> +				continue;
> +			}
> +		}

This code needs to go into a separate noinline helper to reduce the impact
on the fast path.  Also as Robin noted the offset is already
accounted for in sg_phys.  We also don't ever set the dma_address in
the scatterlist to DMA_MAPPING_ERROR, that is just a return value
for the single entry mapping routines.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
