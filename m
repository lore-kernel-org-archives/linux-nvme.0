Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF756C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cJSKxOJIzFWJNB/4kEdPj9SAYSFCsRpghMAEka+ai04=; b=TNH1pdBXS7h+bd
	S4krKdrsUeC84DB7uZx1A5rMd0wLpQBOz47RrQTXoiEV/zHIsj3xUY1rNynBR/KqKnC4AjlO8uibR
	mYZ+dB7Teq5FLo4lsZP0vk6tTpi73k3A3UUd3pT0EbES1VePSGP70ygsMvoGkAw4CPN7hQcCjvq8f
	lYrVPYgGrvJuQases1GClUp1jaAYLYD4IKmR0LHs7ePU2ZA48GfvimdcDBkQ5PIuKb7G9X/3fHrOH
	9lZqWeBmHaJgc44zeeBM7cEPIUUjpai7XgQ69SGzH+1EvIOvDEVd4rHaXQuUidVBfhbkXXwlptjGA
	F6cPg3zKNeLQpmgHOU0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF0Da-00DgzQ-8k; Tue, 01 Feb 2022 20:57:38 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF0DY-00Dgz1-6j
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 20:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=cJSKxOJIzFWJNB/4kEdPj9SAYSFCsRpghMAEka+ai04=; b=inRrrLF05DauLsozmFhswOyT+U
 WPSDQkzNTcNkRZ8czrnUNGLopNg88HLX9pdCK4UlXF1bzYf1BKgtsKpvGypPta7CHlcUOku9K9vge
 +NAO35wcF3CTICM/mBTLmVIVzczzqTvX+VVkIJTevRDS2LfYWgy1a6+2EUp3AAiQR5ChqflV0MWso
 oxckJk6HwJ98oVn/PvRLw3x09cOhCMFDyStF8NnTcjdXZ77YjfG+lzhwmhLo1H71ALY2CJFwigpj+
 UdeGbDqFGDIIDyWwb0VsLflcq8qGQM/ErCZ1YgjT6Xi6D86QbJbPGca8MIAn8BpFKQVINH97Ks3w6
 NHJute4A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nF0D7-009dre-2I; Tue, 01 Feb 2022 13:57:10 -0700
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-9-logang@deltatee.com>
 <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bd83b26d-2f35-cd0a-bb20-a4626d8d48a7@deltatee.com>
Date: Tue, 1 Feb 2022 13:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, ckulkarnilinux@gmail.com,
 martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jonathan.derrick@linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 08/24] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_125736_260464_08F5CE8A 
X-CRM114-Status: GOOD (  28.18  )
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



On 2022-02-01 1:53 p.m., Jonathan Derrick wrote:
> 
> 
> On 1/27/2022 5:25 PM, Logan Gunthorpe wrote:
>> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
>> PCI P2PDMA pages directly without a hack in the callers. This allows
>> for heterogeneous SGLs that contain both P2PDMA and regular pages.
>>
>> A P2PDMA page may have three possible outcomes when being mapped:
>>    1) If the data path between the two devices doesn't go through the
>>       root port, then it should be mapped with a PCI bus address
>>    2) If the data path goes through the host bridge, it should be mapped
>>       normally, as though it were a CPU physical address
>>    3) It is not possible for the two devices to communicate and thus
>>       the mapping operation should fail (and it will return -EREMOTEIO).
>>
>> SGL segments that contain PCI bus addresses are marked with
>> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
>>
>> P2PDMA mappings are also failed if swiotlb needs to be used on the
>> mapping.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
>>   kernel/dma/direct.h |  7 ++++++-
>>   2 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 50f48e9e4598..975df5f3aaf9 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>>   		arch_sync_dma_for_cpu_all();
>>   }
>>   
>> +/*
>> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
>> + * require any further action as they contain a bus address.
>> + */
>>   void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>>   	struct scatterlist *sg;
>>   	int i;
>>   
>> -	for_each_sg(sgl, sg, nents, i)
>> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>> -			     attrs);
>> +	for_each_sg(sgl,  sg, nents, i) {
>> +		if (sg_is_dma_bus_address(sg))
>> +			sg_dma_unmark_bus_address(sg);
>> +		else
>> +			dma_direct_unmap_page(dev, sg->dma_address,
>> +					      sg_dma_len(sg), dir, attrs);
>> +	}
>>   }
>>   #endif
>>   
>>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	int i;
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>> +	enum pci_p2pdma_map_type map;
>>   	struct scatterlist *sg;
>> +	int i, ret;
>>   
>>   	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
>> +			switch (map) {
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				continue;
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				/*
>> +				 * Any P2P mapping that traverses the PCI
>> +				 * host bridge must be mapped with CPU physical
>> +				 * address and not PCI bus addresses. This is
>> +				 * done with dma_direct_map_page() below.
>> +				 */
>> +				break;
>> +			default:
>> +				ret = -EREMOTEIO;
>> +				goto out_unmap;
>> +			}
>> +		}
> I'm a little confused about this code. Would there be a case where the mapping needs
> to be checked for each sg in the list? And if some sg in the sgl can be mapped
> differently, would we want to continue checking the rest of the sg in the sgl instead
> of breaking out of the loop completely?

Yes, the code supports heterogeneous SGLs with P2PDMA and regular
memory; it's also theoretically possible to mix P2PDMA memory for
different devices. So yes, the mapping must be checked for every SG in
the list. It can't just see one SG that points to P2PDMA memory and
assume the rest are all good.

Logan

