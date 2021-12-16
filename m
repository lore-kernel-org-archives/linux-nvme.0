Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53788C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uszjjuvB8q/WqjBC306kvcFMpjQKQSQCD8unuBBJd2I=; b=SHlXcCuowXjxUDHmF3lz5usc0n
	SMBjHzKy2H7BwkZ7MQXmJcBgXzz9a3i7eU0AMsrhRWKuXKjhVJCwMH1OrzLn76cFKe/Eh9z7cv28E
	ADuvA1vxbQrRJ07aFzPCGmm3apnu3PvBwdoAtcDSDUupGaAQVdTUQSYaFDsYNiu0CxeMhkW9DEjmC
	ePmbS/GN3QLHI9UuySv+1bfdX+oUpS5T7cw8Kmlt52cp2HPreTxU5PSYNjsrBTHyTPg2b5mqhkFDA
	gmcIaVCF/x6rU6Geg8IipDIo5qQ7V4PJdVcCFtFdeojMUc63vQVuLNgG6GWYjvFUITzRBIUgROEeT
	UrTkrSQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtPV-006XY8-Q3; Thu, 16 Dec 2021 16:15:13 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtKF-006V87-Mr
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:09:49 +0000
Received: by mail-il1-x135.google.com with SMTP id l5so22440107ilv.7
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uszjjuvB8q/WqjBC306kvcFMpjQKQSQCD8unuBBJd2I=;
 b=zff00H1VSpzjXRKe4ky3E61eX+iRO+N1bYhC9GTQ6cZT8goTOrcjIRl/0S4Uu/982C
 UE915IltjE3bZy+1rVeAHycIhztarz0R4GHgaebdei3SyjS49FUfaBOUXcxEHLDYfXG1
 +cpaZt+F0CssF0L9M27loZAA7gmnTpjpQwGVgFXUhEBWgYGahPtuaAgA6ogO8bztJY8y
 n84u8VFFBsl4rQairsSvU9ONVpBDaNA+cnSh6qbrT1q/TP5YZUyJu/iIc480O8He882h
 OlDSnqzOph1qkq8YuXu/tVAGC6faB4yb7Q7jW6F95QhBMLd6c8mey/xQK3kxaV7BNspd
 TDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uszjjuvB8q/WqjBC306kvcFMpjQKQSQCD8unuBBJd2I=;
 b=1KD97HrdUkggogDdvng1YCL7zv+HBjwsc/tHAY/spBYBJLV2sm0Z8bBAAET+7ij3F6
 7VEgWiq4+OFxQe6dnaqFMTBUKjajQTG8NjVRiev5FRAndYf/Cx87bhAS73kxQHMNKtGy
 M8uNnhZ6JNhNv5bV+pYHru+HOvxcdlB7mFGwQPE5qDjPG0DEkL3/2OZHTJgEOA3nW40s
 z+sfACcMNyWw2k2/K6VLTXE0xyjZIz7+ANBudr6JqQLUUUI81FiFChI8lL5xhCgcL0SW
 8dBdknBjR3Z5QDPAvliA3hD412v8bfhL82Tgbew4y+zDV7EioxxlGdwUKwyOTDmcGsug
 cxeg==
X-Gm-Message-State: AOAM533aC+MX57HtPNwCwtwxm5gxYT2kdFHoFUgGb+YXZo02DhdQTB68
 Uf2B2cl5R1osaQacN333hcZkEQ==
X-Google-Smtp-Source: ABdhPJyjGdaka6LhiuzcMqtGNkKAq2IwMSoXkLD9JJRF3MW+pqLXp5Si0ThklvYjFBvC1zCpLI897Q==
X-Received: by 2002:a05:6e02:12e6:: with SMTP id
 l6mr9830035iln.275.1639670986672; 
 Thu, 16 Dec 2021 08:09:46 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id x15sm2824542iob.8.2021.12.16.08.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 08:09:46 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Max Gurtovoy <mgurtovoy@nvidia.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
 <0c131172-54cf-29f9-8fc6-53582ad50402@nvidia.com>
 <e2828b33-65c8-e881-e802-b5431aabc6ac@kernel.dk>
 <adc77577-5c94-fb06-a4e4-afbddd2a7b57@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c9f5bcde-e9f3-644e-f167-44f041195cc0@kernel.dk>
Date: Thu, 16 Dec 2021 09:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <adc77577-5c94-fb06-a4e4-afbddd2a7b57@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080947_801599_C9B43C0D 
X-CRM114-Status: GOOD (  23.26  )
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

On 12/16/21 9:06 AM, Max Gurtovoy wrote:
> 
> On 12/16/2021 5:59 PM, Jens Axboe wrote:
>> On 12/16/21 6:02 AM, Max Gurtovoy wrote:
>>> On 12/15/2021 6:24 PM, Jens Axboe wrote:
>>>> This enables the block layer to send us a full plug list of requests
>>>> that need submitting. The block layer guarantees that they all belong
>>>> to the same queue, but we do have to check the hardware queue mapping
>>>> for each request.
>>>>
>>>> If errors are encountered, leave them in the passed in list. Then the
>>>> block layer will handle them individually.
>>>>
>>>> This is good for about a 4% improvement in peak performance, taking us
>>>> from 9.6M to 10M IOPS/core.
>>>>
>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>    drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 61 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index 6be6b1ab4285..197aa45ef7ef 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -981,6 +981,66 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>    	return BLK_STS_OK;
>>>>    }
>>>>    
>>>> +static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
>>>> +{
>>>> +	spin_lock(&nvmeq->sq_lock);
>>>> +	while (!rq_list_empty(*rqlist)) {
>>>> +		struct request *req = rq_list_pop(rqlist);
>>>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>>> +
>>>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>>>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>>>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>>>> +			nvmeq->sq_tail = 0;
>>>> +	}
>>>> +	nvme_write_sq_db(nvmeq, true);
>>>> +	spin_unlock(&nvmeq->sq_lock);
>>>> +}
>>>> +
>>>> +static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
>>>> +{
>>>> +	/*
>>>> +	 * We should not need to do this, but we're still using this to
>>>> +	 * ensure we can drain requests on a dying queue.
>>>> +	 */
>>>> +	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
>>>> +		return false;
>>>> +	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
>>>> +		return false;
>>>> +
>>>> +	req->mq_hctx->tags->rqs[req->tag] = req;
>>>> +	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
>>>> +}
>>>> +
>>>> +static void nvme_queue_rqs(struct request **rqlist)
>>>> +{
>>>> +	struct request *req = rq_list_peek(rqlist), *prev = NULL;
>>>> +	struct request *requeue_list = NULL;
>>>> +
>>>> +	do {
>>>> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>>>> +
>>>> +		if (!nvme_prep_rq_batch(nvmeq, req)) {
>>>> +			/* detach 'req' and add to remainder list */
>>>> +			if (prev)
>>>> +				prev->rq_next = req->rq_next;
>>>> +			rq_list_add(&requeue_list, req);
>>>> +		} else {
>>>> +			prev = req;
>>>> +		}
>>>> +
>>>> +		req = rq_list_next(req);
>>>> +		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
>>>> +			/* detach rest of list, and submit */
>>>> +			prev->rq_next = NULL;
>>> if req == NULL and prev == NULL we'll get a NULL deref here.
>>>
>>> I think this can happen in the first iteration.
>>>
>>> Correct me if I'm wrong..
>> First iteration we know the list isn't empty, so req can't be NULL
>> there.
> 
> but you set "req = rq_list_next(req);"
> 
> So can't req be NULL ? after the above line ?

I guess if we hit the prep failure path for the first request that could
be a concern. Probably best to add an if (prev) before that detach,
thanks.

-- 
Jens Axboe


