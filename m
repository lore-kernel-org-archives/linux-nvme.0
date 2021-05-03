Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C7C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:55:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9724061078
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9724061078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s6qS5uXR7pSe264sLlb9ch6PmFZMT4hxjyzQCYlxdws=; b=PolXxabh0zgiC7C4owIlQmXEq
	/im3P0cUW780Wc+AaiaQvzBmmebMFbYjG3//GFWZwd0te9KWc9qhXzVPzoznSjl7+cR/QrBfO2zwU
	oEuqTXaqMPiQFV81zPs1ShfeRx8CppPs8jJ7od6X+TVkr6eT84qU7aaUKiJXuGZEJpTeWaE7f5/7D
	eRC4GqO77WyuDG8NGsI2LDJXQ60dTc4lJoelUmKNfZPMNO/4V4cB12x3I1I2JtuOavSXm7w5VH9AI
	muyD/IdSDl93kD8ZVF/2jM+bolUdfe428kOt8DFpkXD2nPb+0bxC10F7QvTB5slPjEaxoVC1sKxkH
	q/swelMHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldbqs-00ESf6-5B; Mon, 03 May 2021 16:55:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbqq-00ESew-1U
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 16:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=h9d5zovbtXKtO9TZYvlu4xL+neDJxYxd4FL4V4x+RQk=; b=P4c5t+43fUbgNGsq9o6cgqz2nu
 iqoTEBlDCItYjgS+7zFn7xLgs1Y2wmCbtYMmpbP6/zX1hp4osSRl5UfezdQqnojMcIOQbIvyrQOU3
 DxNyVplyG+4wsFUiNbTEx01zpQ1bqyAV7q3BTV1v/phcXlTua8AgtqGNR9DfoeF/BKc1KGM6zI75/
 uhDMzCzk82HPAv/6MBZUaTUTKJIl17uU8tnrdItRrmn6uCO2d0WKFjJuDItnwvGiI6ovpNpZq59YG
 FwcUAdx/0SSBmvgyxg7s4azZnb61ZerK+cE5azu3zLdBHEnYebOkGodS89GZ7VXx99JZPtilSkKJj
 Hd6SxnGw==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbqm-003Ium-St
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 16:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=h9d5zovbtXKtO9TZYvlu4xL+neDJxYxd4FL4V4x+RQk=; b=XA3VMJFHu22LiuYRgV7sx4Rs8c
 3591aoMHNv/NjUeysIvMIemFNGQvvxhSeVFLCIfBFEcN01AnLU0454DR7x9i5+KbkpS9wQvmvTDlB
 wmDUyJnbQ8AY0II0FjrcE9U2lfVByEIa3k4pk83kSjB2pgdejDq3f35QdxYnU45zXwOvnAdMTmYRD
 sEhVGLAwVXWpBZYAFJ1g4iWMaNWdT8a2zstO8bergFsL7t06RcmqF22XWsu1q8nTiQZBV3QbpBlvX
 aEpoRPohuyyWFgct68cZTIlU40n9PYIaNeseQ9Io2WJOjCS7wWDIUSo6hGwSJE0qOa2JxxSZtGHpi
 RmunKpRw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldbqc-0004SZ-Bi; Mon, 03 May 2021 10:55:07 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa0698ba-abad-8c07-2962-d66b6a7affd9@deltatee.com>
Date: Mon, 3 May 2021 10:55:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_095516_980615_865DBA6D 
X-CRM114-Status: GOOD (  39.84  )
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



On 2021-05-02 5:28 p.m., John Hubbard wrote:
>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> 
> This routine now deserves a little bit of commenting, now that it is
> doing less obvious things. How about something like this:
> 
> /*
>   * Unmaps pages, except for PCI_P2PDMA pages, which were never mapped in the
>   * first place. Instead of unmapping PCI_P2PDMA entries, simply remove the
>   * SG_PCI_P2PDMA mark
>   */
> void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> 		int nents, enum dma_data_direction dir, unsigned long attrs)
> {
> 

Ok.

>>   	struct scatterlist *sg;
>>   	int i;
>>   
>> -	for_each_sg(sgl, sg, nents, i)
>> +	for_each_sg(sgl, sg, nents, i) {
>> +		if (sg_is_pci_p2pdma(sg)) {
>> +			sg_unmark_pci_p2pdma(sg);
>> +			continue;
>> +		}
>> +
>>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>>   			     attrs);
>> +	}
> 
> The same thing can be achieved with fewer lines and a bit more clarity.
> Can we please do it like this instead:
> 
> 	for_each_sg(sgl, sg, nents, i) {
> 		if (sg_is_pci_p2pdma(sg))
> 			sg_unmark_pci_p2pdma(sg);
> 		else
> 			dma_direct_unmap_page(dev, sg->dma_address,
> 					      sg_dma_len(sg), dir, attrs);
> 	}
> 
> 

That's debatable (the way I did it emphasizes the common case). But I'll
consider changing it.

> 
> Also here, a block comment for the function would be nice. How about
> approximately this:
> 
> /*
>   * Maps each SG segment. Returns the number of entries mapped, or 0 upon
>   * failure. If any entry could not be mapped, then no entries are mapped.
>   */
> 
> I'll stop complaining about the pre-existing return code conventions,
> since by now you know what I was thinking of saying. :)

Not really part of this patchset... Seems like if you think there should
be a comment like that here, you should send a patch. But this patch
starts returning a negative value here.

>>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	int i;
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
> 
> Is it worth putting this stuff on the stack--is there a noticeable
> performance improvement from caching the state? Because if it's
> invisible, then simplicity is better. I suspect you're right, and that
> it *is* worth it, but it's good to know for real.
> 
>>   	struct scatterlist *sg;
>> +	int i, ret = 0;
>>   
>>   	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
>> +						     attrs);
>> +			if (ret < 0) {
>> +				goto out_unmap;
>> +			} else if (ret) {
>> +				ret = 0;
>> +				continue;
> 
> Is this a bug? If neither of those "if" branches fires (ret == 0), then
> the code (probably unintentionally) falls through and continues on to
> attempt to call dma_direct_map_page()--despite being a PCI_P2PDMA page!

No, it's not a bug. Per the documentation of pci_p2pdma_map_segment(),
if it returns zero the segment should be mapped normally. P2PDMA pages
must be mapped with physical addresses (or IOVA addresses) if the TLPS
for the transaction will go through the host bridge.

> See below for suggestions:
> 
>> +			}
>> +		}
>> +
>>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>>   				sg->offset, sg->length, dir, attrs);
>>   		if (sg->dma_address == DMA_MAPPING_ERROR)
> 
> This is another case in which "continue" is misleading and not as good
> as "else". Because unless I'm wrong above, you really only want to take
> one path *or* the other.

No, per above, it's not one path or the other. If it's a P2PDMA page it
may still need to be mapped normally.

> Also, the "else if (ret)" can be simplified to just setting ret = 0
> unconditionally.

I don't follow. If ret is set, we need to unset it before the end of the
loop.

> Given all that, here's a suggested alternative, which is both shorter
> and clearer, IMHO:
> 
> 	for_each_sg(sgl, sg, nents, i) {
> 		if (is_pci_p2pdma_page(sg_page(sg))) {
> 			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
> 						     attrs);
> 			if (ret < 0)
> 				goto out_unmap;
> 			else
> 				ret = 0;
> 		} else {
> 			sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
> 					sg->offset, sg->length, dir, attrs);
> 			if (sg->dma_address == DMA_MAPPING_ERROR)
> 				goto out_unmap;
> 			sg_dma_len(sg) = sg->length;
> 		}
> 	}

No, per the comments above, this does not accomplish the same thing and
is not correct.

I'll try to add a comment to the code to make it more clearer. But the
kernel doc on pci_p2pdma_map_segment() does mention what must be done
for different return values explicitly.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
