Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D407C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N6UA84ftd4sgVUyBJEtQoIMCZZdOizw9zRC7TOsJMr4=; b=uuBWAk+8FJlNPU22EU9KGd82SA
	GCNEP/K8Kq40w/7PlWreMcARjZvNnB23pngtU1fihqiptjcltmTFVudY3T21F/jrHqumdm7gtl0J/
	lOHMS72rnNBgkc5APTwg9L9qQzdk9eXBkXYetpsiPKfag0tQqHZf2av8lWqNG+9uUhn+3otWJ9ZQs
	b9VHk1cqIGPhYMTm9k6gXURjwjdJHxasBOOriveCZtqAWJ3Qc8obetVT3RS0NtmFVuGGcm13Sn4qI
	2ZY+c9YchzP8adziG698OB3D74oVCKkOgTUUE5U5eFGFOtdusMUkFYaqvXp16FE+IVnMuXdNWVbip
	hV5G2xSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtFr-006TGw-Tg; Thu, 16 Dec 2021 16:05:15 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtFq-006TFj-23
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:05:15 +0000
Received: by mail-il1-x12f.google.com with SMTP id r2so22422772ilb.10
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N6UA84ftd4sgVUyBJEtQoIMCZZdOizw9zRC7TOsJMr4=;
 b=wxuG+E0mLOOJSWSjoDUpjwsovXHL/4Br3NfpP110XTS+uAuaVFaml/WrOZjVokKgzh
 bOKwD8iLX7NvHeSwziVpwUFoQ4de99RvPksmdGwqfrUYDjSwqYrIJeOKlvOPkT2fr1CC
 0ASujzwPZ7gOWYb212VFRVNJcZ2kBGlwWG3QZ/87gIedvBPNnD5PSQE9X0bVBY7RWfdr
 +z6sXvpU3roMcaKyg0lWCQ6zcV1DocQ2QaYiOkqH1SqoPWX4iRZJ91hfbGKDrBgCcwuP
 dymwGPQJRh63qfsQ1ZAOEb8RrUTAaSZrJy3e7A6PDzSBJ9dpWos8Pkib3LvFO2gfVh0Z
 0acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N6UA84ftd4sgVUyBJEtQoIMCZZdOizw9zRC7TOsJMr4=;
 b=XK8/7XJGSzo/RSsTLdNRbr5goYpSGlwM/ElmdJupxcD9PrBOSsu89erymzjb8vZxDD
 5Rdd8Zozms/V/pqeJO/6aXudflE0ix68clhPrvRjnIUehhkP2P0LZANvJs6G2gT3MosZ
 5xXGXUM+/zyrEbbgP40azWRSCssnyc+CnMk43nT2ClVsQzydLiXof/kNvNK9fZ8M6jsv
 buBaQnJ8SuAIG+XAo/ukEjoGLU9kWJRotqqeWc14FTgLggwTrGuTmHco06pPRde1qMox
 idWyfeg5KemQMjp6ExLB1QzQHhFRbGh7GE4O+cpebjOG8GqvGnFfP0S84twzwsAaDHJc
 7wkg==
X-Gm-Message-State: AOAM531n1LaaKcJIbCmQpzdrhemEVfp46s8EuR8/bwXZv80I6Fl/ImNt
 gOc8xxBFlJPmlLijewukbVPBtQ==
X-Google-Smtp-Source: ABdhPJwqF9eDs3713Z00opgYLwwgfH2xbAIythGLGLVihXl3/zor5fKLqunW6WGSqo2Q3ls5bpQM4w==
X-Received: by 2002:a05:6e02:1a07:: with SMTP id
 s7mr10289591ild.50.1639670713196; 
 Thu, 16 Dec 2021 08:05:13 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id j15sm2955439ile.68.2021.12.16.08.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 08:05:12 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk> <YbsB/W/1Uwok4i0u@infradead.org>
 <2adafc43-3860-d9f0-9cb5-ca3bf9a27109@nvidia.com>
 <06ab52e6-47b7-6010-524c-45bb73fbfabc@kernel.dk>
 <9b4202b4-192a-6611-922e-0b837e2b97c3@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5f249c03-5cb2-9978-cd2c-669c0594d1c0@kernel.dk>
Date: Thu, 16 Dec 2021 09:05:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9b4202b4-192a-6611-922e-0b837e2b97c3@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080514_131894_EB8FAB13 
X-CRM114-Status: GOOD (  27.23  )
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

On 12/16/21 9:00 AM, Max Gurtovoy wrote:
> 
> On 12/16/2021 5:48 PM, Jens Axboe wrote:
>> On 12/16/21 6:06 AM, Max Gurtovoy wrote:
>>> On 12/16/2021 11:08 AM, Christoph Hellwig wrote:
>>>> On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
>>>>> +	spin_lock(&nvmeq->sq_lock);
>>>>> +	while (!rq_list_empty(*rqlist)) {
>>>>> +		struct request *req = rq_list_pop(rqlist);
>>>>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>>>> +
>>>>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>>>>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>>>>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>>>>> +			nvmeq->sq_tail = 0;
>>>> So this doesn't even use the new helper added in patch 2?  I think this
>>>> should call nvme_sq_copy_cmd().
>>> I also noticed that.
>>>
>>> So need to decide if to open code it or use the helper function.
>>>
>>> Inline helper sounds reasonable if you have 3 places that will use it.
>> Yes agree, that's been my stance too :-)
>>
>>>> The rest looks identical to the incremental patch I posted, so I guess
>>>> the performance degration measured on the first try was a measurement
>>>> error?
>>> giving 1 dbr for a batch of N commands sounds good idea. Also for RDMA host.
>>>
>>> But how do you moderate it ? what is the batch_sz <--> time_to_wait
>>> algorithm ?
>> The batching is naturally limited at BLK_MAX_REQUEST_COUNT, which is 32
>> in total. I do agree that if we ever made it much larger, then we might
>> want to cap it differently. But 32 seems like a pretty reasonable number
>> to get enough gain from the batching done in various areas, while still
>> not making it so large that we have a potential latency issue. That
>> batch count is already used consistently for other items too (like tag
>> allocation), so it's not specific to just this one case.
> 
> I'm saying that the you can wait to the batch_max_count too long and it 
> won't be efficient from latency POV.
> 
> So it's better to limit the block layar to wait for the first to come: x 
> usecs or batch_max_count before issue queue_rqs.

There's no waiting specifically for this, it's just based on the plug.
We just won't do more than 32 in that plug. This is really just an
artifact of the plugging, and if that should be limited based on "max of
32 or xx time", then that should be done there.

But in general I think it's saner and enough to just limit the total
size. If we spend more than xx usec building up the plug list, we're
doing something horribly wrong. That really should not happen with 32
requests, and we'll never eg wait on requests if we're out of tags. That
will result in a plug flush to begin with.

> Also, This batch is per HW queue or SW queue or the entire request queue ?

It's per submitter, so whatever the submitter ends up queueing IO
against. In general it'll be per-queue.

-- 
Jens Axboe


