Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0599C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F3F611ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F3F611ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Uc0vt5TK+j8uD3b3MoXzoY7+Qog1o88ETkNRk9zcX4M=; b=ixg5YvFrQvNzs3BCtrQOJrSW0
	SzMeGhnAjbg9WpThyqsHA1b+NEC8CnLYKB9TQo6YnzCluGMdc3/Rr2PxsBaY6ChibwF337MdzjW8H
	mz90vEiXAx8h1t3U+WnagU56Aoe3qUgBhiSRaBkSE8MrNldC+Muh42NsNg83SoRo5Ik9fBOXpbIOI
	bWB55LrcdXYICZVFE31BtkA546lU3Dc7J956nn+83N5BMAWowYCID7EuRY6z1pCpNQ+yuhkI9ocqW
	IaOdHMTF0jy5Ia0miqsQLmRiPpy8rjCIVLoR0csKtVmS6rOWxDhvQmwtf3LdY0R9dA0f6gNCi2KfU
	szQti38cA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWcz-002NUY-6S; Tue, 27 Apr 2021 22:56:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWcx-002NUJ-8V
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 22:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=wchQRjaAM+wKsrfBxsOPGilEcofAMBFmBR5ncEuDJho=; b=p/iMkBQjrL0a6o6jR+gByombVv
 3LAs2+TkDsnS8kJ7kvLhZhUpmCrqP2p5q1LjsHKSW+dRJmyov0YujbqXXeaMi3Re9j9lK+tnRcRFE
 wkcY+CSjnAoQ6wuxjrfhBbXySvjcdlv7m2Fs8siQdxWLzmPJXDwuwHho+1ppYXL8s/ApYiT3l+9/e
 qqNiuWT5zwEUEy93TYx8zAce+yOwwWi1vcK3h3+Q2n6XZz+dArCqySsEQFgNrefpE2exHFPHtkh/6
 yEBJrbJ4k/gsiZyQQgPwM4/gbwgNPbIXTesc6kHX6ah8dZKp/JT8pC9VnHMy1U4BwaF2VtP5YMwc8
 58nfLfCg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWcu-00H4Qo-RJ
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 22:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=wchQRjaAM+wKsrfBxsOPGilEcofAMBFmBR5ncEuDJho=; b=EZ9ht7CInMnHYcsaW5R8aYmMj8
 09YKECmF6J1dtTcoVOL5n2vPnyFNuRfpmprAgXcM6moL4NCgJapVcFrAT1GmK88ZLOtBdgfU20kW0
 RY5WUjwcQBwsrdUL/HEpU3IS5o0FdSpggofru2z8+77w/Q3RnCRgS0wmH1jea1qn6LdToqi4OZ/4X
 rrypsgRTfhC4D/uJIb+BWvm1Uqf3s8+RISCE2/zVjkKMttAX0hK4dVgX2qSTi/K1a5II8R6cm3X27
 wVPZcln5l7w31LXIB1N6D4Cr8zR08kHA3166WgpMkT/o5LCOPvawHT2vKIJITGvqFOCPEE8VRwxVk
 JkwiHqmg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWcl-0002mT-O1; Tue, 27 Apr 2021 16:56:12 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
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
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <20210427193351.GR2047089@ziepe.ca> <20210427194013.GS2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9835b877-25ba-83f8-ed39-999cfc1ad415@deltatee.com>
Date: Tue, 27 Apr 2021 16:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194013.GS2047089@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_155620_894985_DB4081B1 
X-CRM114-Status: GOOD (  19.20  )
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



On 2021-04-27 1:40 p.m., Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 04:33:51PM -0300, Jason Gunthorpe wrote:
>> On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
>>> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
>>> PCI P2PDMA pages directly without a hack in the callers. This allows
>>> for heterogeneous SGLs that contain both P2PDMA and regular pages.
>>>
>>> SGL segments that contain PCI bus addresses are marked with
>>> sg_mark_pci_p2pdma() and are ignored when unmapped.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 002268262c9a..108dfb4ecbd5 100644
>>> +++ b/kernel/dma/direct.c
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/vmalloc.h>
>>>  #include <linux/set_memory.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/pci-p2pdma.h>
>>>  #include "direct.h"
>>>  
>>>  /*
>>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>>  	struct scatterlist *sg;
>>>  	int i;
>>>  
>>> -	for_each_sg(sgl, sg, nents, i)
>>> +	for_each_sg(sgl, sg, nents, i) {
>>> +		if (sg_is_pci_p2pdma(sg)) {
>>> +			sg_unmark_pci_p2pdma(sg);
>>
>> This doesn't seem nice, the DMA layer should only alter the DMA
>> portion of the SG, not the other portions. Is it necessary?
> 
> Oh, I got it completely wrong what this is for.
> 
> This should be named sg_dma_mark_pci_p2p() and similar for other
> functions to make it clear it is part of the DMA side of the SG
> interface (eg it is like sg_dma_address, sg_dma_len, etc)

Fair point. Yes, I'll rename this for the next version.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
