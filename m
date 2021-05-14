Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F802C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:18:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01929613F1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01929613F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+PHTh9eUXkYGXr8xa8XL7NLEqKD5q5gXg3gXcyxqR6s=; b=gwvZS2OP0wlsECQ2LSL9yGDn3
	cPPGvhcbwCDPYc6nezy+A6oUqk17KDZhN640qvFFPW6vaZlsm8caRpjd1BxrvQldGFimuT20BlN/N
	i23RtpJpdyw7xGh7DqERHOZnNc5tEBmg4X781JPmsNiqAdjneR4eeIYc8Zst/Yxc/FsBqvuXj8D6j
	Jzj7ZpGMrTBfF17qilk2C2l2QWkHohuEW9hbuCbocVAHE+RfGplnN/8XBIFxe8GAOftV//zm2X3CR
	yRhvu4FpAbGiUYTDz5wbWzxAjz1bBziImkUZni5aC8y+jxmwpkcC6livueREA7SzKl7ZgoM9Zg7bI
	av+q7Uayg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhaVm-008SrO-OP; Fri, 14 May 2021 16:18:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaVj-008SqU-TG
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=UIw7EfWmD3A5GJzYN/3QOUOCIyHuFu16FWOPf7ANc9Y=; b=w9tcVGNoJWDBnoSd8+NqnXwOmG
 TfaFNRTnaFNJF4xu+Z/yQUVJcHgePHh14Y+ygFrtj3RUEq/S0aB1NoM2moxRkDUq3JnSNX2eXKhkQ
 uJj/xAF/ZUQ3bqWBkpB/AEnVd1/L+QH/7pAPUf/f5RBHxZv5WpagTbcIio1tZVJpjQ6joaen58Ufr
 ySsmD5jr+8sdX7TtbgPWcW0v72tDWi9aaQIcqUXLmvDOJq/NUE4KIHNxcL7GBafBq4sKJNri/9P4d
 /z41tDyNNZbzx63Rj/Ccq2cX+/O6pV3ZFQJJ0kjwpfaKxl/G1FuPgN1hN/8BDUWO8RrTRjiqAG74Q
 RNfp3tBQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaVh-00C6jr-Eq
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=UIw7EfWmD3A5GJzYN/3QOUOCIyHuFu16FWOPf7ANc9Y=; b=ifFUHGd+/63UwWC7Lc9/oor7EB
 2xjO0Kj1AlFEpeDAwbOKeW8D81UORdDKkPxs7CF9lZHYha50YtQkAW8SwcBLPjO/SrcXyl30YTRho
 MbfBoG89yDCZm/Gp8aa++DAJcvdvSRYMC7EbFLh8FinG05Ku9EKpgWTM/v4BVl4jTXyWC3/LqjVgu
 bdtOV6sJX1hy0+oEpb6EvH7KJiIfkE8Gl1VaVjCNeplN1uBeqW+034RUscz+xQLCn+ISPdE0nf+rC
 ggxbKXYoIRATTWu1GzOpzi2ZHRBR0QVMYKgJfXEoeRUmTpW6t1lgOr2s3tTG29i7Rquf1zkW1OwXB
 T6ym8TIw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhaVY-000693-Pi; Fri, 14 May 2021 10:17:49 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-16-logang@deltatee.com> <20210514135712.GD4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6615c351-9c28-3a74-8c43-4aeb7993fb98@deltatee.com>
Date: Fri, 14 May 2021 10:17:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135712.GD4715@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 15/22] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_091757_505476_78BA6E21 
X-CRM114-Status: GOOD (  18.79  )
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



On 2021-05-14 7:57 a.m., Christoph Hellwig wrote:
>> +	for_each_sg(sgl, sg, nents, i) {
>> +		if (sg_is_dma_pci_p2pdma(sg)) {
>> +			sg_dma_unmark_pci_p2pdma(sg);
>> +		} else  {
> 
> Double space here.  We also don't really need the curly braces to start
> with.
> 
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>> +	enum pci_p2pdma_map_type map;
>>  	struct scatterlist *sg;
>> +	int i, ret;
>>  
>>  	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
>> +			switch (map) {
> 
> Why not just:
> 
> 			switch (pci_p2pdma_map_segment(&p2pdma_state, dev,
> 					sg)) {
> 
> (even better with a shorter name for p2pdma_state so that it all fits on
> a single line)?
> 
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				continue;
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				/*
>> +				 * Mapping through host bridge should be
>> +				 * mapped normally, thus we do nothing
>> +				 * and continue below.
>> +				 */
> 
> I have a bit of a hard time parsing this comment.
> 
>> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
>> +			ret = -EINVAL;
>>  			goto out_unmap;
>> +		}
>>  		sg_dma_len(sg) = sg->length;
>>  	}
>>  
>> @@ -411,7 +443,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>  
>>  out_unmap:
>>  	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
>> -	return -EINVAL;
>> +	return ret;
> 
> Maybe just initialize ret to -EINVAL at declaration time to simplify this
> a bit?
>

All fair points, will fix in v3.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
