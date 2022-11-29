Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F05C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/jN8CDNxrDZag/wbLCJVmkiAlc7PInMojWyMS5FvR0=; b=h4Gzc57YP6WVuT2D/uMPNtEn7p
	ysh3Aq8vsaaYA6awLIEfLTy/JYUdgX22MvYhJsL+H9IDFRNqGTDLiTMG4GiUgOKqXrXJJZnktj9ZE
	1QqMRaj8dKmRytKSHKJ77bTg+z9hmaVDfCZ60ohofAe8z52VeBMOff5rQVB9xwol7gnY9Epau4hF6
	sEzaxa687gHw/VAfqGlIQrYkeK7Y9BoWM4fqGLUO+/RlpHhNeft5XCVIbWFtvkBgWdhFYNBgeY7rc
	z4p+9ct98oUD2f1umpYC/4R50sO2LdvdPoHwOcIenRbfthV+PezMrAaIPumAjlpHu/PmiO1l3wdvr
	BVkvmYCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01fl-009HpK-5i; Tue, 29 Nov 2022 14:33:21 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01fi-009Hmn-Pf
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:33:20 +0000
Received: by mail-pg1-x532.google.com with SMTP id h193so13158635pgc.10
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/jN8CDNxrDZag/wbLCJVmkiAlc7PInMojWyMS5FvR0=;
        b=rG+mjOKGZIuhcRRFhzc7kHJmTKJjWNlvt7Nt28EVz0Kxsk9y61xwE/KEbNqx+V/42i
         airBHJapeb49fJ0pSNFqO5BhkAv/aUPJaqsg9KOcKCbTJUX1CEucmPQ5nYIfifb4F5uA
         WX2SJOx8neXgabEli9IZyy+73GBbBStkog9NsKYn+o42JjxY5wJSAqSKt4/eOLb1YQM4
         PHpH+iKL5ejjDl2zl3WDMhewbfDY2m0HxyL/pk/LraH0vcvmN4DQt61aqx0RvRgTFG/2
         dwuy2LUy+JGTsuvA8kHbUPpPhp3ikthbKKrOZfYRE05J48UDQZZxlk4Lf4FaVD43L/Zj
         5kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/jN8CDNxrDZag/wbLCJVmkiAlc7PInMojWyMS5FvR0=;
        b=uejef+uLK+yWtz8Otyif7TiiNOZbHWQCjqDP3tfus5NJ3+7wJL1cOS67ARjvp1flVt
         XJio6cS1eRYva8MFr/j5GW8RKLAMOmYVPeLCTvrD0rVWK6fZ1zpqWmCUVY0oBQ6uED5+
         jCMIXft1geHrvVeRnFUTLTtwL8Ykbkp5k5SMYDsoArEhPd0EdnzTszV9EBp/Q1wWd8Ag
         PZSZJZOE0jkq7YxRxMvBZlr30P/nqeUPXobsKvGFb0g0qBuJ3rZFQlaOmcbIsQteIZf4
         6RBnFaNZKkuNv/zbOWDSIPQrPReYrj0Fr8INL1zjMbFgNhgppzzo2MMoahnEV406fiMF
         KU+A==
X-Gm-Message-State: ANoB5pmDh8Lotc0R4mW+fMTOgZtqCTZp2MCqIg1X+c1uGf5VKdHK2/v/
	U/cpDCfvDcEcxNN1ettLGwsguQ==
X-Google-Smtp-Source: AA0mqf4NCD+CMqaRNtBqT0OTyODhHhUsIusitSWW7R/Q/B4WQ7RqxGE2SqQGEO5BH4L0xJBLMVHbng==
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id s20-20020a632154000000b00477b650494bmr29063622pgm.434.1669732396674;
        Tue, 29 Nov 2022 06:33:16 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090abf8a00b00212e5068e17sm1431643pjs.40.2022.11.29.06.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:33:16 -0800 (PST)
Message-ID: <ac488153-9a3c-1758-e596-e6c7928e984e@kernel.dk>
Date: Tue, 29 Nov 2022 07:33:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
 <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
 <0733f642-8b97-b6ce-8a0e-14c3bb8e2a9a@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0733f642-8b97-b6ce-8a0e-14c3bb8e2a9a@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_063318_905487_F2C1EA4A 
X-CRM114-Status: GOOD (  19.53  )
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

On 10/4/22 2:19 AM, Sagi Grimberg wrote:
> 
> 
> On 10/4/22 09:11, Hannes Reinecke wrote:
>> On 10/3/22 11:43, Sagi Grimberg wrote:
>>> Our mpath stack device is just a shim that selects a bottom namespace
>>> and submits the bio to it without any fancy splitting. This also means
>>> that we don't clone the bio or have any context to the bio beyond
>>> submission. However it really sucks that we don't see the mpath device
>>> io stats.
>>>
>>> Given that the mpath device can't do that without adding some context
>>> to it, we let the bottom device do it on its behalf (somewhat similar
>>> to the approach taken in nvme_trace_bio_complete).
>>>
>>> When the IO starts, we account the request for multipath IO stats using
>>> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
>>> in the middle of the request.
>>>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   drivers/nvme/host/core.c      |  4 ++++
>>>   drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
>>>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>>>   3 files changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 64fd772de817..d5a54ddf73f2 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -384,6 +384,8 @@ static inline void nvme_end_req(struct request *req)
>>>           nvme_log_error(req);
>>>       nvme_end_req_zoned(req);
>>>       nvme_trace_bio_complete(req);
>>> +    if (req->cmd_flags & REQ_NVME_MPATH)
>>> +        nvme_mpath_end_request(req);
>>>       blk_mq_end_request(req, status);
>>>   }
>>> @@ -421,6 +423,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>>   void nvme_start_request(struct request *rq)
>>>   {
>>> +    if (rq->cmd_flags & REQ_NVME_MPATH)
>>> +        nvme_mpath_start_request(rq);
>>>       blk_mq_start_request(rq);
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_start_request);
>>
>> Why don't you move the check for REQ_NVME_MPATH into nvme_mpath_{start,end}_request?
> 
> I'm less fond of calling a function that may or may not
> do anything...
> 
> But it is a pattern that exists in the code, if people prefer
> it I can change it.

I prefer it the way that you have it, avoids a function call for
the hot path of not being multipath.

-- 
Jens Axboe



