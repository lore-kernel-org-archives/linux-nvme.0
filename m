Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A76E87829
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Go9eQ9VjpjtYLnPn84LjPSh+9PLJEghIT0dh62MZDrQ=; b=x0pdS1pXqpihDElYIBjg5W157A
	Q0m7CAYFQ+Gv74rSuS+M1gRLlukrnb2c/an48kAQcFZn2D30eHQkUvO6ui3YB4JUWez7sBo4fC1JK
	HYclURN6c6FhZZdvZuLT/Z665g8Vj9WFljvC+Kj2HRoV0portd7ryr8xJz9rg/ReB0pYuVsfCzsyq
	XKodbhHDQuTnm7XsL3xhoFR1e+Qud+cTLi1l8xq0J8ekNC3DBgECt0KQJ2yJwkIk6XDWoJnyBx8r5
	7d0iyGfmS59ipRNM5L0es5CzG+uyxDYrUjrlmx/5QzZZn0z9kvPyBbtPIlIPp2hVdLJcpB+2cBoeg
	dK6JGkQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnGnP-00000006i6l-0uQT;
	Tue, 03 Feb 2026 13:50:23 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnGnL-00000006i6O-03JA
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 13:50:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33860339;
	Tue,  3 Feb 2026 05:50:10 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E1E63F632;
	Tue,  3 Feb 2026 05:50:14 -0800 (PST)
Message-ID: <4e375e54-e141-473c-ae71-fc013268d057@arm.com>
Date: Tue, 3 Feb 2026 13:50:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>, axboe@kernel.dk,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203094247.GP34749@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260203094247.GP34749@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_055019_136685_D58EB030 
X-CRM114-Status: GOOD (  21.34  )
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

On 2026-02-03 9:42 am, Leon Romanovsky wrote:
> On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
>> On Mon, Feb 02, 2026 at 06:36:24PM +0100, Christoph Hellwig wrote:
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 2a52cf46d960..f944b747e1bd 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
>>>   		nvme_free_descriptors(req);
>>>   }
>>>   
>>> +static bool nvme_pci_alloc_dma_vecs(struct request *req,
>>> +		struct blk_dma_iter *iter)
>>> +{
>>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>>> +
>>> +	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
>>> +			GFP_ATOMIC);
>>> +	if (!iod->dma_vecs)
>>> +		return false;
>>> +	iod->dma_vecs[0].addr = iter->addr;
>>> +	iod->dma_vecs[0].len = iter->len;
>>> +	iod->nr_dma_vecs = 1;
>>> +	return true;
>>> +}
>>> +
>>>   static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>>   		struct blk_dma_iter *iter)
>>>   {
>>> @@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>>   	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>>>   		return false;
>>>   	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>>> +		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
>>> +			return false;
>>
>> In the case where this iteration caused dma_need_unmap() to toggle to
>> true, this is the iteration that allocates the dma_vecs, and it
>> initializes the first entry to this iter. But the next lines proceed to
>> the save this iter in the next index, so it's doubly accounted for and
>> will get unmapped twice in the completion.
>>
>> Also, if the allocation fails, we should set iter->status to
>> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
>> Otherwise, the caller will think the request is badly formed if you
>> return false from here without setting iter->status.
>>
>> Here's my quick take. Boot tested with swiotlb enabled, but haven't
>> tried to test the changing dma_need_unmap() scenario.
>> ---
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 9fc4a60280a07..233378faab9bd 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -816,6 +816,28 @@ static void nvme_unmap_data(struct request *req)
>>   		nvme_free_descriptors(req);
>>   }
>>   
>> +static bool nvme_pci_prp_save_mapping(struct blk_dma_iter *iter,
>> +				      struct request *req)
>> +{
>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +
>> +	if (!iod->dma_vecs) {
>> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>> +
>> +		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
>> +				GFP_ATOMIC);
>> +		if (!iod->dma_vecs) {
>> +			iter->status = BLK_STS_RESOURCE;
>> +			return false;
>> +		}
>> +	}
>> +
>> +	iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
>> +	iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
>> +	iod->nr_dma_vecs++;
>> +	return true;
>> +}
>> +
>>   static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>   		struct blk_dma_iter *iter)
>>   {
>> @@ -825,11 +847,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>   		return true;
>>   	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>>   		return false;
>> -	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>> -		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
>> -		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
>> -		iod->nr_dma_vecs++;
>> -	}
>> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
> 
> Can dev->dma_skip_sync be modified in parallel with this check?
> If so, dma_need_unmap() may return different results depending on the
> time at which it is invoked.

It can if another thread is making mappings in parallel, however as 
things currently stand that would only lead to the current thread 
thinking it must save the unmap state for the mappings it's already made 
even if it technically didn't need to.

In principle it could also change back the other way if another thread 
reset the device's DMA mask, but doing that with active mappings would 
fundamentally break things in regard to the dma_skip_sync mechanism anyway.

Thanks,
Robin.

> 
>> +		return nvme_pci_prp_save_mapping(iter, req);
> 
> Thanks


