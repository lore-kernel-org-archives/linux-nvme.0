Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A05BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:01:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D6C61504
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35D6C61504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rHLZ0NLlBGLKcJQoWu3Ma811aaf6tcir9sjMvEq+mvY=; b=c+n7PDFvqLQimV
	2+2lwZYD81E7GBJti2XsXIC1OUL4vNyzfDFhj/146UNhn+7Ts+nC95KnJhue4mxVhffAb2d0Ou/2r
	VEOII0t/C/Yki28S6fle0ye0LlVM8nV42XhXB5LyL9HXPrCwA53snr4EiXpbi/u1Cf0fWwQn7PyPr
	KTHzdnkAcuGXasVYh/1pxx+fqvuScxfYeGo71wHpDtOWPdl5gFKDh2FcbTBgJ26SLow9o/w3Y2O4m
	cLOgDarNaU69lA6px0jzSn7twUUGNbGFYdGNAMymLo5NCT4OjFuAsEKvB3XhrtlGcKkAqC7L+B8qU
	1qlSvZ7dJtLLqCHsFHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mViZP-00CYyV-B1; Wed, 29 Sep 2021 23:00:59 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mViZM-00CYxd-B5
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:00:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Px58k/yNGvaEATkxAQjKyG3Zpeo9iJVoUPzZvebpH+s=; b=CBRPzpf/uyhi04VMy2l9L8WMNh
 TgzA3jF5tP3k7RIYMTsKQ+kaQuWqK+fsqMIeNHQV0H7x3YkzdYGrSqJptc4KuEy4cKPP92gGjT1QC
 MhGeYzPuOy/x5jJvOgdL/FQhThwVb7fOG/JD9g3GdcgQgd0CmorrBCMdBGHOz5INZa7hrPQmozKSx
 rXnVyACjxxSq1C34L7pJg0qw1RZZJkqbjDQBiWSqep8px/eapbxM6kywVM1Cr+nPk8HYxEojwAonO
 ANp/tKEvGxxHbTYm0x8c8OvD5ce8rk+zDidcCuKPVgEcFAqftgIKvYj4u2fND0UE/JeeoO7Xu6oAL
 veDztxbQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mViZA-0007dT-Rp; Wed, 29 Sep 2021 17:00:45 -0600
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928220502.GA1738588@nvidia.com>
 <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
 <20210929224653.GZ964074@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fb678f5e-b477-0bd0-334b-a57e771eedc9@deltatee.com>
Date: Wed, 29 Sep 2021 17:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929224653.GZ964074@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_160056_394445_3A44D844 
X-CRM114-Status: GOOD (  27.04  )
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




On 2021-09-29 4:46 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 03:30:42PM -0600, Logan Gunthorpe wrote:
>> On 2021-09-28 4:05 p.m., Jason Gunthorpe wrote:
>> No, that's not a correct reading of the code. Every time there is a new
>> pagemap, this code calculates the mapping type and bus offset. If a page
>> comes along with a different page map,f it recalculates. This just
>> reduces the overhead so that the calculation is done only every time a
>> page with a different pgmap comes along and not doing it for every
>> single page.
> 
> Each 'struct scatterlist *sg' refers to a range of contiguous pfns
> starting at page_to_pfn(sg_page()) and going for approx sg->length/PAGE_SIZE
> pfns long.
> 

Ugh, right. A bit contrived for consecutive pages to have different
pgmaps and still be next to each other in a DMA transaction. But I guess
it is technically possible and should be protected against.

> sg_page() returns the first page, but nothing says that sg_page()+1
> has the same pgmap.
> 
> The code in this patch does check the first page of each sg in a
> larger sgl.
> 
>>> At least sg_alloc_append_table_from_pages() and probably something in
>>> the block world should be updated to not combine struct pages with
>>> different pgmaps, and this should be documented in scatterlist.*
>>> someplace.
>>
>> There's no sane place to do this check. The code is designed to support
>> mappings with different pgmaps.
> 
> All places that generate compound sg's by aggregating multiple pages
> need to include this check along side the check for physical
> contiguity. There are not that many places but
> sg_alloc_append_table_from_pages() is one of them:

Yes. The block layer also does this. I believe a check in
page_is_mergable() will be sufficient there.

> @@ -470,7 +470,8 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>  
>                 /* Merge contiguous pages into the last SG */
>                 prv_len = sgt_append->prv->length;
> -               while (n_pages && page_to_pfn(pages[0]) == paddr) {
> +               while (n_pages && page_to_pfn(pages[0]) == paddr &&
> +                      sg_page(sgt_append->prv)->pgmap == pages[0]->pgmap) {

I don't think it's correct to use pgmap without first checking if it is
a zone device page. But your point is taken. I'll try to address this.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
