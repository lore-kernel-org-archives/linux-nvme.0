Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DDC4742C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4FE20825
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FFgvv3qw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OGkZy1Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4FE20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UVw5/XnEbHduev1cB2ebTj5LnmC2tAVE0FBXgBwRZYo=; b=FFgvv3qwCA8tAlVWGo1z6Z5OW
	eBE9/dCnvWCx8Tmqh83i0d1AdkRfHZA4wLTVN/MKuQwc3dDRvRhmmY1Po6gSzgJM6SVo1oTfWvuYR
	vks6Yjy/MBRoD+dtvvTGL7qVV5+UDCeRiDQ9jlM8e9+A3tQwajwUqfQJUklw4078dL4U2VcUfg+B7
	IQiMOqNbf2V6CQRuE975iTu9TVsjpm+9Nz0cUl+HKenJ0LTu0+ehqfdsC6UHY7fWRa5wqaVWjlpT+
	QUCPQwQFoyikkui9txRiLP252XVIPBkJZH0Iw0/qORDbji2uOdm+Nk2maQvxFDqNDRHfWwhKgu1Sg
	HTJrcD7xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcdHR-00026R-Pq; Tue, 10 Nov 2020 23:42:29 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcdHN-00025o-Kv
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 23:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dq7zEId0NdZdINMNT6Dmw/UdigbwtVpJA5sVRfmfofg=; b=OGkZy1Uyl96LErvRAxZGS3VLh2
 UFPnmL68iQiGa7WAKcronB92llBdP3YlqIU+7eGuFKbqGjkT01WWufQfvYhwJQWb5f4Chtvv5u50S
 ehGDDouQf07lLymZnuvKlNikGX0MG5kw18tbF+W0I0l1dYdqjxKHukHshhL/MTMWuMcU1rwtN+iYD
 MX/dMQFi6k6B6yzwa4oKcYK28+bCU9oc5m4af9qikpCqZDiTpCgHOzow/uqJ6YsHG16ieCLyHb+Qi
 Uefg2Nrk14j0VCvqrjysb0S8rgDpYRYKseTyjfXOJtFFb2JZ0gOPhivVU3VIxjdTMfibx68jS04pG
 vJLX6QZg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kcdH8-0000kz-29; Tue, 10 Nov 2020 16:42:11 -0700
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20201110232513.GA705726@bjorn-Precision-5520>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b3918b58-1c46-4f9c-fcae-37fd47b6bfde@deltatee.com>
Date: Tue, 10 Nov 2020 16:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110232513.GA705726@bjorn-Precision-5520>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 03/15] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_184225_711641_4B8B86AF 
X-CRM114-Status: GOOD (  26.40  )
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
Cc: Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-11-10 4:25 p.m., Bjorn Helgaas wrote:
> On Fri, Nov 06, 2020 at 10:00:24AM -0700, Logan Gunthorpe wrote:
>> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
>> dma map functions to determine how to map a given p2pdma page.
> 
> s/dma/DMA/ for consistency (also below in function comment)
> 
>> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
>> offset if they need to map the bus address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c       | 46 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h | 11 +++++++++
>>  2 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index ea8472278b11..9961e779f430 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -930,6 +930,52 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>  
>> +/**
>> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
>> + * @page: page to get the offset for
>> + *
>> + * Must be passed a pci p2pdma page.
> 
> s/pci/PCI/
> 
>> + */
>> +u64 pci_p2pdma_bus_offset(struct page *page)
>> +{
>> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
>> +
>> +	WARN_ON(!is_pci_p2pdma_page(page));
>> +
>> +	return p2p_pgmap->bus_offset;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
>> +
>> +/**
>> + * pci_p2pdma_should_map_bus - determine if a dma mapping should use the
>> + *	bus address
>> + * @dev: device doing the DMA request
>> + * @pgmap: dev_pagemap structure for the mapping
>> + *
>> + * Returns 1 if the page should be mapped with a bus address, 0 otherwise
>> + * and -1 the device should not be mapping P2PDMA pages.
> 
> I think this is missing a word.
> 
> I'm not really sure how to interpret the "should" in
> pci_p2pdma_should_map_bus().  If this returns -1, does that mean the
> patches *cannot* be mapped?  They *could* be mapped, but you really
> *shouldn't*?  Something else?
> 
> 1 means page should be mapped with bus address.  0 means ... what,
> exactly?  It should be mapped with some different address?

1 means it must be mapped with a bus address
0 means it may be mapped normally (through the IOMMU or just with a
direct physical address)
-1 means it cannot be mapped and should fail (ie. if it must go through
the IOMMU, but the IOMMU is not in the whitelist).

> Sorry these are naive questions because I don't know how all this
> works.

Thanks for the review. Definitely points out some questionable language
that I used. I'll reword this if/when it goes further.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
