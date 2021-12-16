Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2B1C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iy5CBM62f67zWQVTHi20FTmmvRd5vKYiKZGf23/3HD8=; b=oJzvgU4lxQ6pnICi3i6waTUTlF
	TvBeAwxqMBGbvkx6BaZB6C7aMKHeqQoSvMAvfj5fLupum583IbkeqEFH+EvzbqCaTFqRk/xcXPoTM
	TAu5gPScLdsPJcc7Tfv1D+VdG5Wt3Go0LlI4MLrBIbs38jnD4by5r5DfKAcaUW7193npgRisiEY0u
	VWXL2iSPtZaGybVGa+hU1LUlg//VTFmdSsPcyugGXsG5MSQtcTTqgm+0ce/J382fkRxpcKqNIrq97
	ufKPYp4cm4o7xwCj3VnHwjHMa1q+u4eSZ8SpftzFD0rfCq7pIwZA+LWZXUm/zPvj2U88QQRJFW4CA
	IpeMkmIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtAx-006Rko-LZ; Thu, 16 Dec 2021 16:00:11 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtAu-006Rfq-AK
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:00:10 +0000
Received: by mail-io1-xd2f.google.com with SMTP id z26so35692044iod.10
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iy5CBM62f67zWQVTHi20FTmmvRd5vKYiKZGf23/3HD8=;
 b=Javde6l+5AFbbAeAvnFQ7oiv6VYTnTPZzHj5uczxGqOkdVi2GnGlE2+M5Dpj6vHRdS
 xQ+gxU7HN5FAbSlHGERI9do0SwW9UBV/VeG6YZtRtvsijYPkPLXZsGJNoJxhucfHNHUD
 ZdyB4Jbibhy5JqfM1Nfml0SO+5wJ5C2K4rvyZ6Zk5DEEHtXv7x/lz7p3/qADjbhOAcqZ
 dn2kWgVouXKWF3/QtltwwopAa1pIdw8zQnfJ4ZANIELg3U0qYXVc5/7oGNVrVuczax+v
 MRhkOXUZfTmkk7lXi4oycDE361SKUv1PTfXFroJlbTgXOmOc9N2gkz/uV2rEIFmxCInY
 2nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iy5CBM62f67zWQVTHi20FTmmvRd5vKYiKZGf23/3HD8=;
 b=oy1AePqnxfSmn9pcSTqyhNsBbDtvLNAKH2qh1U/hsUydv/Jt8Mp5PWpYut7YWE4D2K
 k9vyYJLDY1nIQG2s5Feq6/TbX23T40i6ocExWfRdxqxq6ELXJcU5/NhnNQIyDzu6Cd+t
 t6opDSlwduCI7KJEyDTY9rY/eY4YYhG0kQQEG7pvzq04FMFPATEbtlu15O/3ol+uczww
 y4zI0JVj/X7yRoTZdNZKRU0e3ZUlI9TUnVe+3LkcykAwhj78ZF/ubaA9BLT1qQCkcsv2
 x5RgPUnvAUlq6c52haLIy78Gpgk2Rs7aTHJVrbxovQKsrjrn0T5e5RmArhfHVB4GKgPW
 OjPw==
X-Gm-Message-State: AOAM533teh6NdzlDCRzCf8N7uBmVu41fqmT2ffUAkhfCywTCr7POHKyL
 sXj6wPim4oJvR9v4RYekFUjz9w==
X-Google-Smtp-Source: ABdhPJyjl8B9f8JmBzGHkNy4jX8PkkCRc8QUdj44GWv9A98u9sNmeUKePWVXMogT75ZeHwoqt9FejA==
X-Received: by 2002:a05:6638:1306:: with SMTP id
 r6mr9627878jad.260.1639670406366; 
 Thu, 16 Dec 2021 08:00:06 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id m2sm3449166ilu.31.2021.12.16.08.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 08:00:05 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Max Gurtovoy <mgurtovoy@nvidia.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
 <0c131172-54cf-29f9-8fc6-53582ad50402@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2828b33-65c8-e881-e802-b5431aabc6ac@kernel.dk>
Date: Thu, 16 Dec 2021 08:59:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0c131172-54cf-29f9-8fc6-53582ad50402@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080008_419118_84942E06 
X-CRM114-Status: GOOD (  25.65  )
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

On 12/16/21 6:02 AM, Max Gurtovoy wrote:
> 
> On 12/15/2021 6:24 PM, Jens Axboe wrote:
>> This enables the block layer to send us a full plug list of requests
>> that need submitting. The block layer guarantees that they all belong
>> to the same queue, but we do have to check the hardware queue mapping
>> for each request.
>>
>> If errors are encountered, leave them in the passed in list. Then the
>> block layer will handle them individually.
>>
>> This is good for about a 4% improvement in peak performance, taking us
>> from 9.6M to 10M IOPS/core.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 6be6b1ab4285..197aa45ef7ef 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -981,6 +981,66 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   	return BLK_STS_OK;
>>   }
>>   
>> +static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
>> +{
>> +	spin_lock(&nvmeq->sq_lock);
>> +	while (!rq_list_empty(*rqlist)) {
>> +		struct request *req = rq_list_pop(rqlist);
>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +
>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>> +			nvmeq->sq_tail = 0;
>> +	}
>> +	nvme_write_sq_db(nvmeq, true);
>> +	spin_unlock(&nvmeq->sq_lock);
>> +}
>> +
>> +static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
>> +{
>> +	/*
>> +	 * We should not need to do this, but we're still using this to
>> +	 * ensure we can drain requests on a dying queue.
>> +	 */
>> +	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
>> +		return false;
>> +	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
>> +		return false;
>> +
>> +	req->mq_hctx->tags->rqs[req->tag] = req;
>> +	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
>> +}
>> +
>> +static void nvme_queue_rqs(struct request **rqlist)
>> +{
>> +	struct request *req = rq_list_peek(rqlist), *prev = NULL;
>> +	struct request *requeue_list = NULL;
>> +
>> +	do {
>> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>> +
>> +		if (!nvme_prep_rq_batch(nvmeq, req)) {
>> +			/* detach 'req' and add to remainder list */
>> +			if (prev)
>> +				prev->rq_next = req->rq_next;
>> +			rq_list_add(&requeue_list, req);
>> +		} else {
>> +			prev = req;
>> +		}
>> +
>> +		req = rq_list_next(req);
>> +		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
>> +			/* detach rest of list, and submit */
>> +			prev->rq_next = NULL;
> 
> if req == NULL and prev == NULL we'll get a NULL deref here.
> 
> I think this can happen in the first iteration.
> 
> Correct me if I'm wrong..

First iteration we know the list isn't empty, so req can't be NULL
there.

-- 
Jens Axboe


