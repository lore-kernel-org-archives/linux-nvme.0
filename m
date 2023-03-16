Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA6AC6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QA2j2PetYPJnYccY7pMvfAi1SVPZp7NWFMhQaNDxkPw=; b=ruPh1CWC3peKiEQb3DHqW/lpxd
	5LWd+CTkmPr1LYDeU2oVYj1f4NrtKYsHkEY3Awb2kzJHxvWlXzHnNZ+QdVNJuzLD7gTM/XwJ6SXxJ
	JpxI5n2BWEGAUuzjPzvCRrIjdHBDFi8jM097jY6fu9O+UmplDL2H82gov7jeEF6BR087yPi5DWZ2Q
	cXIJ3CLDejuUoYrEOV/NBFv2/IlWC80tln4zqaZxtDG4GmEmHwrJHFhmQhAFEeX/4Ltxoao0TTPpD
	/6lPoF3wK2Azz2i/wUoB1S0IGDQ2Qug0Y7VsuWG9UoOnoeXa3w4txNKTTS4vyzojRhVPOnhQibOkq
	3X/D0Vfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcqD0-00GxI9-0T;
	Thu, 16 Mar 2023 16:12:06 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcqCx-00GxHd-1K
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 16:12:04 +0000
Received: by mail-ed1-f48.google.com with SMTP id cy23so9623362edb.12
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 09:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA2j2PetYPJnYccY7pMvfAi1SVPZp7NWFMhQaNDxkPw=;
        b=joZBzUzAXdXLr54RltxpUizljqGkvH4LiF9GZjagtfqzVn7xxkw7R+AqeoDj3vAl+s
         k8VAIjKl+jd580d1jmHdTJ64iFly6qwDykvCk8SWv+mrnefDzKm6+IyMb4FK/dMccP5f
         fYjI3S5Y074+UabwnSiNpF59+U0b7agTWKIllTk4MtD5JvbFTMmoXNeoknge8ySCga1r
         F02m/mWv5fmziOWvuVTHdbT40bbx3P97QrIyJm1+APJHbmggHYF4I5RhXlKAOcdV/M3T
         1A9BBP8vBKJOWehRTxoLe25JRaWbPEU8moXhyyR+ffWd1Zq9xW0B23cHixOlnWpZhTYC
         4oVA==
X-Gm-Message-State: AO0yUKVhMAu6qBFDL0nOOp7D+Y2ZBWtwZPRLPSW9JNggfMSqnyOOR7Fz
	tbv2vP3EiJTm3NqI/9Z61iw=
X-Google-Smtp-Source: AK7set+10rmEDVv7l5trPoZiPmO412ex16TfgeFs19j4GmxfZqpnl6hvnAKN5vQ1XnJKkPYoNeqqQg==
X-Received: by 2002:a17:906:dc:b0:92f:cb36:2259 with SMTP id 28-20020a17090600dc00b0092fcb362259mr3954169eji.3.1678983120159;
        Thu, 16 Mar 2023 09:12:00 -0700 (PDT)
Received: from [10.100.102.14] (46-117-185-164.bb.netvision.net.il. [46.117.185.164])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b008b1b86bf668sm3983132ejo.4.2023.03.16.09.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 09:11:59 -0700 (PDT)
Message-ID: <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
Date: Thu, 16 Mar 2023 18:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_091203_448121_23FD51E2 
X-CRM114-Status: GOOD (  15.26  )
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


>>> Could you try this patch with your tcp polling queues enabled?
>>>
>>> ---
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 9e5e0277a4d95..12f7ab369f7ba 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -844,30 +844,12 @@ void submit_bio(struct bio *bio)
>>>    }
>>>    EXPORT_SYMBOL(submit_bio);
>>> -/**
>>> - * bio_poll - poll for BIO completions
>>> - * @bio: bio to poll for
>>> - * @iob: batches of IO
>>> - * @flags: BLK_POLL_* flags that control the behavior
>>> - *
>>> - * Poll for completions on queue associated with the bio. Returns number of
>>> - * completed entries found.
>>> - *
>>> - * Note: the caller must either be the context that submitted @bio, or
>>> - * be in a RCU critical section to prevent freeing of @bio.
>>> - */
>>> -int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
>>> +static int blk_poll(struct request_queue *q, struct io_comp_batch *iob,
>>> +		    struct bio *bio, unsigned int flags)
>>>    {
>>>    	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
>>
>> You need to pass in the cookie as well.
>> Probably can pass BLK_QC_T_NONE for blk_rq_poll...
> 
> I don't understand. The bio holds the cookie, and the bio is passed through the
> rq. If we send NONE, then polling won't happen. Will the command be completed
> some other way?

You're right, I thought that NONE then the poll will be called at least 
once. That seem to have changed from the past...

> And since we're talking about this, what happens if a command is dispatched to
> a polled queue, but has no data transfer? The nvme driver doesn't attach a bio
> to the request in that case, so no cookie?

IIRC, initially NONE was called once, and the loop in blk_execute_rq 
looped until the completion was met.

I would assume that any other cookie other than NONE would work here, 
because the driver .poll() would be invoked at least once (maybe set
ONESHOT as well).

