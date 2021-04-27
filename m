Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F17C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:50:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772A860FF1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 22:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772A860FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DabWhbd0Cz8AilpTDHc03o1W+ktr6nbulvzAX6dqU28=; b=I4qU1pCDysmBz7Z9z1kFbMxmP
	5UCC3R1ujtvlTh6QcOqMkzzHTrwAgIjs6/QCrKX5rYouWHUpMbN9D8yIMoPhEweFRaUs45rF9ifl2
	vzY0iXY2LjjKCfqzTHyr0vlarNfahpcuDAFkjC8U3KLH/HWIjUriNVeGEgVgYhPpIUjPe1U8bhCxy
	H0JIhQTdwCWUXT/MQ7/phOm881EBhI5LNObwrvX24MFei9Aapt5rTUJd95WcNBWMiAYsE6P2oVmBv
	sclIxUmNxWoB3h7xffFoNRQW6tdKDZ9XYE8sQg9YydFukdYDdR/XKHt2KLAEUJ3KnsCw70nm3RS6X
	+YUULqMhQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbWXJ-002Mgk-IH; Tue, 27 Apr 2021 22:50:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWXG-002Mge-TL
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 22:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=PBZp6uxAp8nlNU5Rm16hkR47Rwe8xrGWtpeD+dKWkk4=; b=uMhGY6bQKkAu8+YWpQflkRnCrV
 OmCdfyVJStwzdejsovLdRpmpAE/J8QF+cdlJX5jHZKfTgdFfxc3o25ZARI9X4APZeQ9KNj/1QiHsC
 HoaKk6d7fPVypKZ36BubGezZIU0esXZx6IXD0L0Mdo2Nm/+qbo/Fym+icRn8TYq2X7d2HccuHs13M
 pQ0lu+H9ODJYaIIhQaGpT2Plh9h9iSIh1xAXgg66uGzRAkI05Pz9l92ctntaWk9KIRWnF2yEOWNAZ
 3P49I9PzRMCkoVgb6+RvT/oDq/+BMJ+6FlVf/ssGnATVbMlxoDHB4mZdFbPafFARXYiqGTUttu+cZ
 xf4jBTCg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbWXC-00H3tz-5O
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 22:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=PBZp6uxAp8nlNU5Rm16hkR47Rwe8xrGWtpeD+dKWkk4=; b=c2SnI7NAl3/gr4SFEOqWfEjO9J
 1JGnC7Zf5KDX7iHl6Y4Xf/2xqN/Sf5EK4N3LedlbB9Fd00L3W9uy4hRpaf9AzRR6bhJRwlUH+3jQV
 JGHEoIAnzvnTbXFFloa9dmt/bebMlHu8p0eMd7ujtwQMFSXPtCaCZfLSEapIfvrwoLvjkcmHaak0S
 os4Ry++J+BA4Zjy4rlpJGfScH23wq+QuJ1EnvUrl/i2hoEb1GA+PElTtZrctT7avrcp051HeAQJHt
 MommdMIRXxQ8f7+NTw6YINNchc1V2k8mSpMibhQPjTbiWcdM3d674C2MzQOyDshqLUX3ERNg5eNxi
 Yzo0Jtug==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWWo-0002hR-Kh; Tue, 27 Apr 2021 16:50:04 -0600
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
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427192232.GO2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <74473159-b4d7-89c8-9dae-7e983b22ef2b@deltatee.com>
Date: Tue, 27 Apr 2021 16:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427192232.GO2047089@ziepe.ca>
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
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_155026_269981_9EDB19AA 
X-CRM114-Status: GOOD (  22.02  )
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



On 2021-04-27 1:22 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() either returns a positive number indicating the number
>> of entries mapped or zero indicating that resources were not available
>> to create the mapping. When zero is returned, it is always safe to retry
>> the mapping later once resources have been freed.
>>
>> Once P2PDMA pages are mixed into the SGL there may be pages that may
>> never be successfully mapped with a given device because that device may
>> not actually be able to access those pages. Thus, multiple error
>> conditions will need to be distinguished to determine weather a retry
>> is safe.
>>
>> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
>> convention from dma_map_sg(). The function will return a positive
>> integer on success or a negative errno on failure.
>>
>> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
>> indicate that a P2PDMA page is not mappable.
>>
>> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
>> level implementations that P2PDMA pages are allowed and to warn if a
>> caller introduces them into the regular dma_map_sg() interface.
> 
> So this new API is all about being able to return an error code
> because auditing the old API is basically terrifying?
> 
> OK, but why name everything new P2PDMA? It seems nicer to give this
> some generic name and have some general program to gradually deprecate
> normal non-error-capable dma_map_sg() ?
> 
> I think that will raise less questions when subsystem people see the
> changes, as I was wondering why RW was being moved to use what looked
> like a p2pdma only API.
> 
> dma_map_sg_or_err() would have been clearer
> 
> The flag is also clearer as to the purpose if it is named
> __DMA_ATTR_ERROR_ALLOWED

I'm not opposed to these names. I can use them for v2 if there are no
other opinions.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
