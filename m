Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2178FC433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Dec 2021 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUEdPGf2mgvEdnG+UktAqE22u9m43XekCDiBWsdJQWE=; b=iUQ1LZSduoxdcHNT6OlwvG/uPV
	0zhoBSNCaeBi3fhShEsihtF8PMfjWNiF3glOlDr0USsTJ7OQ1XHW+d53MsX71ot+Rkd38+fhN/5p1
	bqYRVG7XxvyUTvyqR/fqMgWVcI26Nz3+OpPszVUXrx+DWuc+1clfYGB05Alg8CxiofeYws7VMXTul
	/EFWX5ONjRYXT5NcmxDM5KBKtuBpsiqubgly6gpwRtKMVXWzT7vFPSxmQ5cpS7N3ldBvcG1l/1pHK
	foj2n+ClfYU0Lih9laszz+t422sFSqRWMWNM4vSdng5rCS8zsS0Y6kkfisFeOuH3f/23N+bN2zs+X
	0baPWO4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtrGz-001Sg8-5h; Sun, 05 Dec 2021 13:09:45 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtrGv-001SfA-6a
 for linux-nvme@lists.infradead.org; Sun, 05 Dec 2021 13:09:43 +0000
Received: by mail-io1-xd33.google.com with SMTP id q72so5122511iod.12
 for <linux-nvme@lists.infradead.org>; Sun, 05 Dec 2021 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=XUEdPGf2mgvEdnG+UktAqE22u9m43XekCDiBWsdJQWE=;
 b=MOB9LhVWpz+v1n6wvIdQvia9aC6cHJ5K77NB2b21S2jX25BatyDMHjFiLpYQXvjkIJ
 adbF4R/QciWgcbPHWlUSDvAXKz19/XVb4ALtuYtN7A7g7/p2b2DIVxr45znzlSAJTnxK
 3ZiDTS4wueYpcyDBfSGVcyG7fvA3chJHl10Xg+Ze05PsxxZt6vz09sP3jHfqmiwFrrJv
 6uUiWNXvoLmrZqS3nxGSeZdHwoXqcvjeq0AyqxqtLCcv480wEcn8MfuiuBTBZ6t7Ql3u
 n6XE9obb4RgzyziXi4oVghJEL3dGJX8EpLoI5kzCU66yYn702mp2zUuCaVtQWypKZjHE
 KMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XUEdPGf2mgvEdnG+UktAqE22u9m43XekCDiBWsdJQWE=;
 b=gvBs/mnqxdij1L/TpRu22sQcScPTkJue0gn2PJ4Q975VnuQLCWNx+Qv6naw6qaY3W5
 Gb/gG/yzoh3dXCHRmz5hX0P1elEolk1f1rH+AK0VrZ/DCKTqZYb1N5uXVL0OVv4fsHqe
 LJSzsbzEECLqy7L6o9+rJG8KmoVP3m+AgkLg/7r+fgpXBjfbcKj1Pm/szZMCYbTGUIDU
 rTHU2DyeoQUDnSQXBKXfKRnJJvCc2jcagjyuPoeTBmQoDTbaUPLlH6H2yvSr6KP+Bpcs
 ijPUFS67GM5BJGuDIPU801ywE0bAS8TMyuG9HXvGV9o4zkTZ0hxELl5I9+Ew+5ZHXdcI
 Yikw==
X-Gm-Message-State: AOAM530P8XRLzzuWxgI82M0C6FNasRCYLw5frJze3G3hoTogNbwf9gab
 z58vDW+hTa5n0ACcuhbC0h++Et/zTLJ7UKYz
X-Google-Smtp-Source: ABdhPJwUMY9iFQ+FHodGAUyHB9h2MynD7EjFdDBgc8GemavIUyUmzEqQh1S/apnJjrJzo2mAqSVDvA==
X-Received: by 2002:a05:6602:2d8c:: with SMTP id
 k12mr28329208iow.49.1638709778937; 
 Sun, 05 Dec 2021 05:09:38 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id y4sm5316956ilv.21.2021.12.05.05.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Dec 2021 05:09:38 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-2-axboe@kernel.dk>
 <2a3fb650-4b6e-9eb1-aa6b-318236717ccf@suse.de>
 <ad621fff-2338-fad8-48cb-dfdbd5ccc72a@kernel.dk>
 <39b861aa-fb2d-55fd-8581-28ce8e0f0c90@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <52e4e61e-ba7a-68cd-d29f-c68a5d6956cb@kernel.dk>
Date: Sun, 5 Dec 2021 06:09:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <39b861aa-fb2d-55fd-8581-28ce8e0f0c90@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211205_050941_287150_A94701A0 
X-CRM114-Status: GOOD (  23.71  )
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

On 12/5/21 2:07 AM, Hannes Reinecke wrote:
> On 12/4/21 9:13 PM, Jens Axboe wrote:
>> On 12/4/21 3:43 AM, Hannes Reinecke wrote:
>>> On 12/3/21 10:45 PM, Jens Axboe wrote:
>>>> If we have a list of requests in our plug list, send it to the driver in
>>>> one go, if possible. The driver must set mq_ops->queue_rqs() to support
>>>> this, if not the usual one-by-one path is used.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>    block/blk-mq.c         | 24 +++++++++++++++++++++---
>>>>    include/linux/blk-mq.h |  8 ++++++++
>>>>    2 files changed, 29 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 22ec21aa0c22..9ac9174a2ba4 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>>>    {
>>>>    	struct blk_mq_hw_ctx *this_hctx;
>>>>    	struct blk_mq_ctx *this_ctx;
>>>> +	struct request *rq;
>>>>    	unsigned int depth;
>>>>    	LIST_HEAD(list);
>>>>    
>>>> @@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>>>    	plug->rq_count = 0;
>>>>    
>>>>    	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
>>>> -		blk_mq_run_dispatch_ops(plug->mq_list->q,
>>>> +		struct request_queue *q;
>>>> +
>>>> +		rq = plug->mq_list;
>>>> +		q = rq->q;
>>>> +
>>>> +		/*
>>>> +		 * Peek first request and see if we have a ->queue_rqs() hook.
>>>> +		 * If we do, we can dispatch the whole plug list in one go. We
>>>> +		 * already know at this point that all requests belong to the
>>>> +		 * same queue, caller must ensure that's the case.
>>>> +		 */
>>>> +		if (q->mq_ops->queue_rqs &&
>>>> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
>>>
>>> What is the dependency on shared tags here?
>>>   From what I've seen it's just about submitting requests; the only
>>> difference to shared tags is the way the tags are allocated.
>>> Care to explain?
>>
>> For shared tags, we need to actively increment the use count per
>> request. This path doesn't do that, so it's disabled for now. It could
>> be done, but then it'd have to be in the caller, so I'd rather leave it
>> for a future optimization if anyone cares enough about this for shared
>> tags.
>>
>> I can add a comment about it if that helps.
>>
> Please do.
> It'll act as a reminder what needs to be done if and when one of the 
> drivers requiring shared tags is looking at implementing queue_rqs.

I added to the comment yesterday:

https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=f9f526700607bf804fa8541c824ea54253f4241a

-- 
Jens Axboe


