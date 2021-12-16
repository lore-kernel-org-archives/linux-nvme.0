Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8136EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b9T7lUgEmRg8+nKkprDGKdCFmqRa0ugSHibCC5wg/d0=; b=FQwyqI9J+b4Qui6O3gapRYkGTO
	XwkHwiH59+M4/WlSKVCZvw8jPmRrmjSxcXiqrtRQlSjESRzH7j5xxCawo7A2xMWU4wKt+KR4L2dWw
	r8fwC0hu8IJwBFYlJXM1EpokMGSyPBh3Uyd2/uJuinvxuPHsCJjrnzpU191vDMiNZwfcgbPWqaD0g
	JPXpadD/zpDp+4fB5/QZI76ZKsar6n3Pf72OsVLwUK1Z9g2hCp6CT2ko+2hOYq5Et9UwZnjEQzLbr
	ktc6/VzwO6jwiYQ7voJxaRdltVg6kxog9kUpLK3dVskAaNsjbN5Fy9vldrmgmdJYc+M93aPem0gzf
	5nWKm13g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtw4-006jO4-14; Thu, 16 Dec 2021 16:48:52 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtkM-006epY-Oo
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:36:48 +0000
Received: by mail-io1-xd2c.google.com with SMTP id q72so35898872iod.12
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b9T7lUgEmRg8+nKkprDGKdCFmqRa0ugSHibCC5wg/d0=;
 b=NuDxJljCQzFklFAt1GApD87HLgvKPVWj2aOL2lZ3r/BhenK5lRaVACDPYHcAuOGI5O
 WpC0Urp7F2Mvm9hYt5t5hzJtElIlYCP3d6sO6Yu4q/6qQ0E/9cPaMfVYwGrydPpgrvXc
 ZzTSa+fMyCTL3pSuk45evrIwyuKN4c/AOpjkC1hPB8Nyw6cqgCxwU2bMyKtxMYthZDOm
 ZqhD8EAB+q+MvIupBSqFMDNM65bVqKJ2dD4bPQ4okkBew/LQGUHwPhv1r7JVYNIudIGV
 2PRJ6YwxxKawYjVZoLUL+eGkPrpTEcEhFMV7U+5EHOalksROyHK7c9AKWtKFL1Q4DRPe
 3hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b9T7lUgEmRg8+nKkprDGKdCFmqRa0ugSHibCC5wg/d0=;
 b=Q4QVal+GB04nEgvLghvyoy8dq0bg+gISK/6cSNQxP/SzzJyIOVNcSGJlMZUz8sNGoi
 CxAFm6lXA20DHkS7ZjGRbaokxPsTYOyVUqGZtnCWIEBrrP8NstyeSdy9QR0HE539l53V
 mf4X2AL7fD3KUjW6RJtR4gsET4HTcLBNdKUA/OAKkmHcXahQWZCPZ9M6KAQ56tm1v+fO
 Fng5iDoXs7js0FvXPmro5J8Ot39LgY4eqKWLBhkG/fMgmJifQd9YMGdoR0nHe8yNx1nC
 DujzrLRdu44F11Hu+0kjoYtNO30TJ9LxFN8uSUbosyuJOiD8B9keXwqHiA/8RlYYnanM
 ESSA==
X-Gm-Message-State: AOAM530uxp2N46VKmmyLcDTpivgIAafPE4X9lLfbmN2CPCeGbnmnebAS
 Lizbop0WLg/QHxcee5aXwOj84R7zcATGKw==
X-Google-Smtp-Source: ABdhPJw+a+kvqQsGgvqylyFyCSbie+OIKk6QS8+SwhW/C2jjCa/pVMJCU96pgMuNnPWcwikjm+77AQ==
X-Received: by 2002:a5d:8999:: with SMTP id m25mr9624676iol.185.1639672605785; 
 Thu, 16 Dec 2021 08:36:45 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id x8sm3443506ill.20.2021.12.16.08.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 08:36:45 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk> <YbsB/W/1Uwok4i0u@infradead.org>
 <2adafc43-3860-d9f0-9cb5-ca3bf9a27109@nvidia.com>
 <06ab52e6-47b7-6010-524c-45bb73fbfabc@kernel.dk>
 <9b4202b4-192a-6611-922e-0b837e2b97c3@nvidia.com>
 <5f249c03-5cb2-9978-cd2c-669c0594d1c0@kernel.dk>
 <d1613b7f-342d-08ad-d655-a6afb89e1847@nvidia.com>
 <a159220b-6e0c-6ee9-f8e2-c6dc9f6dfaed@kernel.dk>
 <3474493a-a04d-528c-7565-f75db5205074@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <87e3a197-e8f7-d8d6-85b6-ce05bf1f35cd@kernel.dk>
Date: Thu, 16 Dec 2021 09:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3474493a-a04d-528c-7565-f75db5205074@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083646_854887_C4E4472A 
X-CRM114-Status: GOOD (  28.79  )
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

On 12/16/21 9:34 AM, Max Gurtovoy wrote:
> 
> On 12/16/2021 6:25 PM, Jens Axboe wrote:
>> On 12/16/21 9:19 AM, Max Gurtovoy wrote:
>>> On 12/16/2021 6:05 PM, Jens Axboe wrote:
>>>> On 12/16/21 9:00 AM, Max Gurtovoy wrote:
>>>>> On 12/16/2021 5:48 PM, Jens Axboe wrote:
>>>>>> On 12/16/21 6:06 AM, Max Gurtovoy wrote:
>>>>>>> On 12/16/2021 11:08 AM, Christoph Hellwig wrote:
>>>>>>>> On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
>>>>>>>>> +	spin_lock(&nvmeq->sq_lock);
>>>>>>>>> +	while (!rq_list_empty(*rqlist)) {
>>>>>>>>> +		struct request *req = rq_list_pop(rqlist);
>>>>>>>>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>>>>>>>> +
>>>>>>>>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>>>>>>>>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>>>>>>>>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>>>>>>>>> +			nvmeq->sq_tail = 0;
>>>>>>>> So this doesn't even use the new helper added in patch 2?  I think this
>>>>>>>> should call nvme_sq_copy_cmd().
>>>>>>> I also noticed that.
>>>>>>>
>>>>>>> So need to decide if to open code it or use the helper function.
>>>>>>>
>>>>>>> Inline helper sounds reasonable if you have 3 places that will use it.
>>>>>> Yes agree, that's been my stance too :-)
>>>>>>
>>>>>>>> The rest looks identical to the incremental patch I posted, so I guess
>>>>>>>> the performance degration measured on the first try was a measurement
>>>>>>>> error?
>>>>>>> giving 1 dbr for a batch of N commands sounds good idea. Also for RDMA host.
>>>>>>>
>>>>>>> But how do you moderate it ? what is the batch_sz <--> time_to_wait
>>>>>>> algorithm ?
>>>>>> The batching is naturally limited at BLK_MAX_REQUEST_COUNT, which is 32
>>>>>> in total. I do agree that if we ever made it much larger, then we might
>>>>>> want to cap it differently. But 32 seems like a pretty reasonable number
>>>>>> to get enough gain from the batching done in various areas, while still
>>>>>> not making it so large that we have a potential latency issue. That
>>>>>> batch count is already used consistently for other items too (like tag
>>>>>> allocation), so it's not specific to just this one case.
>>>>> I'm saying that the you can wait to the batch_max_count too long and it
>>>>> won't be efficient from latency POV.
>>>>>
>>>>> So it's better to limit the block layar to wait for the first to come: x
>>>>> usecs or batch_max_count before issue queue_rqs.
>>>> There's no waiting specifically for this, it's just based on the plug.
>>>> We just won't do more than 32 in that plug. This is really just an
>>>> artifact of the plugging, and if that should be limited based on "max of
>>>> 32 or xx time", then that should be done there.
>>>>
>>>> But in general I think it's saner and enough to just limit the total
>>>> size. If we spend more than xx usec building up the plug list, we're
>>>> doing something horribly wrong. That really should not happen with 32
>>>> requests, and we'll never eg wait on requests if we're out of tags. That
>>>> will result in a plug flush to begin with.
>>> I'm not aware of the plug. I hope to get to it soon.
>>>
>>> My concern is if the user application submitted only 28 requests and
>>> then you'll wait forever ? or for very long time.
>>>
>>> I guess not, but I'm asking how do you know how to batch and when to
>>> stop in case 32 commands won't arrive anytime soon.
>> The plug is in the stack of the task, so that condition can never
>> happen. If the application originally asks for 32 but then only submits
>> 28, then once that last one is submitted the plug is flushed and
>> requests are issued.
> 
> So if I'm running fio with --iodepth=28 what will plug do ? send batches 
> of 28 ? or 1 by 1 ?

--iodepth just controls the overall depth, the batch submit count
dictates what happens further down. If you run queue depth 28 and submit
one at the time, then you'll get one at the time further down too. Hence
the batching is directly driven by what the application is already
doing.


-- 
Jens Axboe


