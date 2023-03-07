Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0819BC678D5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 12:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLelsIhbKWpc5yapdbqbzgpAdEx7KGy/2HW3dZElm4A=; b=01lWcLTz5LNKGz4mNhLDm2V/23
	t/hyBokv5MoFYWbRyHBpDJfdmbgaaTLDlYorD00g4VQpv9Q4qcohhlJsdFacQkr6zcuBoPDrHWMl9
	9v0Qy7PlZBhzRaBFpg1ni49+r9H/PcTYO3k382+iUEUkz4+25Rr32YSEpSdJlT9wAWZTQ+FnXfC5F
	w2KjlWkcVfIOCrCiCWOqMlf3YjJN/Jg/aQNg03RTuKZb3XgYIM1Vc4NgCMsz2unxGCKnp6SfSghHz
	cgjM+RQy6Raj82FLGRxpRK/PccGb2miRDET8+HZqnoQBVDvJkKYYClDTxAGrWTgJs7fp/uQKeXmhI
	+eI1W2Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWTx-0006rE-BE; Tue, 07 Mar 2023 12:31:53 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWTv-0006qX-5q
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 12:31:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id c18so7652027wmr.3
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 04:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLelsIhbKWpc5yapdbqbzgpAdEx7KGy/2HW3dZElm4A=;
        b=BlUz1oKzFQYNvYAhLe/lCmXYHjvdYm6N7PeDUmhTW1/nEpr3JmrsmCBXO2FYhezPOV
         P5ME7MWb1ItG+XU0NLjy0/gIFOoenmE749eKQnsjfS84xO9awdevAB0zvISNe9fmccLu
         UfGB3vgAkXahamShoWbUCx3lLS9N+DA8y2cUY9hSq1YkwDu2SgyKfSaTGk/beExWNmWg
         B2W+wfN3APJb+83tbwFjAR8V2ScYLLwKMrryCs1Tc437hMxfqk648btPBf2xYat2uoOS
         gdjaH3Ft3FoSsQUWByoxy6f/jSCYqCftOjo0Mfa9LRuRlQUv5baxoSg5uJQTA+oLoFB1
         Ctjg==
X-Gm-Message-State: AO0yUKVmulqtdaews3V1lmEwisj8cy3zwFqxyyTpWkxZd0mFTJJI6/Kc
	v3JkWib549L44tBvWO7FfcM=
X-Google-Smtp-Source: AK7set8uO67EW1fFLUJ3WLSFMzfQAPt+Do3v9sT5ZOc4T+FkfRRyHSR19PbfeUIDoJ+LDUPeDme5UA==
X-Received: by 2002:a05:600c:1c1f:b0:3e7:f108:6456 with SMTP id j31-20020a05600c1c1f00b003e7f1086456mr11640006wms.0.1678192309494;
        Tue, 07 Mar 2023 04:31:49 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id o33-20020a05600c512100b003e209186c07sm19403727wms.19.2023.03.07.04.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:31:49 -0800 (PST)
Message-ID: <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
Date: Tue, 7 Mar 2023 14:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
 <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
 <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_043151_249622_48D84701 
X-CRM114-Status: GOOD (  19.95  )
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



On 3/7/23 14:14, Ming Lei wrote:
> On Tue, Mar 07, 2023 at 01:39:27PM +0200, Sagi Grimberg wrote:
>>
>>
>> On 3/6/23 23:49, Ming Lei wrote:
>>> On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 3/4/23 01:13, Ming Lei wrote:
>>>>> When investigating one customer report on warning in nvme_setup_discard,
>>>>> we observed the controller(nvme/tcp) actually exposes
>>>>> queue_max_discard_segments(req->q) == 1.
>>>>>
>>>>> Obviously the current code can't handle this situation, since contiguity
>>>>> merge like normal RW request is taken.
>>>>>
>>>>> Fix the issue by building range from request sector/nr_sectors directly.
>>>>>
>>>>> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>     drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>>>>>     1 file changed, 19 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index c2730b116dc6..d4be525f8100 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>>>>>     		range = page_address(ns->ctrl->discard_page);
>>>>>     	}
>>>>> -	__rq_for_each_bio(bio, req) {
>>>>> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>>>> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>>>> -
>>>>> -		if (n < segments) {
>>>>> -			range[n].cattr = cpu_to_le32(0);
>>>>> -			range[n].nlb = cpu_to_le32(nlb);
>>>>> -			range[n].slba = cpu_to_le64(slba);
>>>>> +	if (queue_max_discard_segments(req->q) == 1) {
>>>>> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
>>>>> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
>>>>> +
>>>>> +		range[0].cattr = cpu_to_le32(0);
>>>>> +		range[0].nlb = cpu_to_le32(nlb);
>>>>> +		range[0].slba = cpu_to_le64(slba);
>>>>> +		n = 1;
>>>>> +	} else {
>>>>> +		__rq_for_each_bio(bio, req) {
>>>>> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>>>> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>>>> +
>>>>> +			if (n < segments) {
>>>>> +				range[n].cattr = cpu_to_le32(0);
>>>>> +				range[n].nlb = cpu_to_le32(nlb);
>>>>> +				range[n].slba = cpu_to_le64(slba);
>>>>> +			}
>>>>> +			n++;
>>>>>     		}
>>>>> -		n++;
>>>>>     	}
>>>>>     	if (WARN_ON_ONCE(n != segments)) {
>>>>
>>>>
>>>> Maybe just set segments to min(blk_rq_nr_discard_segments(req),
>>>> queue_max_discard_segments(req->q)) and let the existing code do
>>>> its thing?
>>>
>>> What is the existing code for applying min()?
>>
>> Was referring to this:
>> --
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 3345f866178e..dbc402587431 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -781,6 +781,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
>> *ns, struct request *req,
>>                  range = page_address(ns->ctrl->discard_page);
>>          }
>>
>> +       segments = min(segments, queue_max_discard_segments(req->q));
> 
> That can't work.
> 
> In case of queue_max_discard_segments(req->q) == 1, the request still
> can have more than one bios since the normal merge is taken for discard
> IOs.

Ah, I see, the bios are contiguous though right?
We could add a contiguity check in the loop and conditionally
increment n, but maybe that would probably be more complicated...

