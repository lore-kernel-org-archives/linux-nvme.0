Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F59C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:19:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89428610A2
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 17:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89428610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kv86caG9mNAy7IHk4HPB8M5ez0gzsRR5fPoplCVo9K0=; b=UAOKfeEhH4at0KnLTrqL6ngry
	zrBz6mgyiwSb6qv6NnS+Tt2dq2TG/8RdNUNOgnxdlLYxyXcBQWY/OhIVpf2z6S+/rAYD68RnjRZNS
	pQ2AWXn2u3aspNkIFy8GablKZIINs/g+5ZwRIvb8YT6KFGpP92MHBo0+ZLT+5HuIXzD5NCn4QERc3
	m+O1CtoI3gnPu8snsydg77ndGC299oBlblNLMW1nPgseFvsuIYUheRxvyDhUgqnCUrWV5T+lrY80L
	QVrkvjVDx6nZ1R7EwEH7C7rDjN6W0qMN76WBBFmdmoMBJ3wJreCjCUoQWIBcsC8+9L6OkF68mBioS
	f+skEi0KQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldcEX-00EV1U-Sy; Mon, 03 May 2021 17:19:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldcES-00EV09-NV
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 17:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Xgskyepw/lHRcKmwXdhV8lu3qVd1TfZZh6M74Jlngas=; b=elZgYd0qt8oZG/mFi1ih1rgLZE
 gxwkngTRGFTJycEqbhqVFhyAy8NGY9oWlz2daOR3a0wuc23CgOOQh3BpjaMn6VwvpVGEWhpaFUzw1
 NLPriHN84e3VHzJ00r4CcVztQu5NDLJu8+bBn70lF8admkR3q0hU+qJy5hZnWR1J/CbCw6TT/2z8U
 sVIbJ46M2W50n73D4AllTKtf69vTiM9FdbU8RgNQc1B1Q52zQd6PbaioLiWtWTKBvY7L4gGwNqEDp
 BLvhd4bxfLDjl6Km/fNhyYET5nb3rJZOAxsjay+sNmV2u3pOpOWvsHdaatb6z4Kxu9mENrZLUcitn
 I+CfooMQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldcEQ-003L6c-3M
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 17:19:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Xgskyepw/lHRcKmwXdhV8lu3qVd1TfZZh6M74Jlngas=; b=QqAwmeJngpzHhZ/sdMQj3UlLTL
 rC/1Y3ph6DV1kkJjARvToJ6QRKEfJDGAt2iQpPoawvtTM+fMCs6n5bVz+292DJzzv2C+T87D91M2V
 4wQ42/crm5YKsUUkp1hzvaTN17qEVQ+9oQ5Geo3ecq6vpk8odJrImqmZK5cpK3vHJJj9E+WmPg9Vq
 PNjtWNXdgJrO7pQU42Bzcn/2z9aPF7saV5+TkwUTbLKY2ssS41V1zdma+gltt/IQ92sPJS4wSu9fA
 qs7uDvdjdZjyuEC+dg4iSsxKIllszekl4Ujify/+NQ8fbP/N5UrU3OAn3vie0yC4GaRvbbT11kmeF
 NOTlVoCw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldcEG-0005Bx-Lz; Mon, 03 May 2021 11:19:33 -0600
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
 <20210408170123.8788-14-logang@deltatee.com>
 <78a165e1-657b-c284-d31a-adc8c9ded55d@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4ad9c1d9-ec2a-1fe1-c5d9-19d2053da912@deltatee.com>
Date: Mon, 3 May 2021 11:19:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <78a165e1-657b-c284-d31a-adc8c9ded55d@nvidia.com>
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
Subject: Re: [PATCH 13/16] nvme-pci: Convert to using dma_map_sg_p2pdma for
 p2pdma pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_101942_156871_934DF845 
X-CRM114-Status: GOOD (  13.12  )
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



On 2021-05-02 7:34 p.m., John Hubbard wrote:
>>   	if (iod->npages == 0)
>>   		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
>>   			      iod->first_dma);
>> @@ -868,14 +857,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>>   	if (!iod->nents)
>>   		goto out_free_sg;
>>   
>> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>> -		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>> -				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>> -	else
>> -		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>> -					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
>> -	if (!nr_mapped)
>> +	nr_mapped = dma_map_sg_p2pdma_attrs(dev->dev, iod->sg, iod->nents,
>> +				     rq_dma_dir(req), DMA_ATTR_NO_WARN);
>> +	if (nr_mapped < 0) {
>> +		if (nr_mapped != -ENOMEM)
>> +			ret = BLK_STS_TARGET;
>>   		goto out_free_sg;
>> +	}
> 
> But now the "nr_mapped == 0" case is no longer doing an early out_free_sg.
> Is that OK?

dma_map_sg_p2pdma_attrs() never returns zero. It will return -ENOMEM in
the same situation and results in the same goto out_free_sg.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
