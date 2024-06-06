Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD56C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6SIhJMYHbPbMKCy9bx8+/YiqMK6RQnhv3MdFiptfabY=; b=DNozOvsiYm8v270OYZdH1YUVCc
	yUwHLgm4suhlXuYxmyI9SX5m1ReF4KYtXGamIRjb4Zt8toH1DavKl0IIEOAlp5QO68GU3DXOnRD69
	wo8jO/u8pUbDSji9AeEWSCbcVna51PniaSR4d7vDbA6ZjK4bi8ajREcRm50zXqAFYeAqos0PbbDLJ
	piuuxpKagESmJMt7ybPVIUWsfepwGhIIqQrrCODUm6j8xpH9NSfRQJaJTbeI+HZ3vWGWa8zUHUojZ
	Y9Sn131j5OtucSLkN6CqzNTBq10aDH/ZRukonKaTy8p5y3Azal1+rwmkEP32/hW0uN8u4Q55kYKrY
	bOzlOnZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFA7m-00000009LhS-0FCT;
	Thu, 06 Jun 2024 10:13:38 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFA7h-00000009LeJ-1Zuk
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 10:13:35 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42158f53b76so896225e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Jun 2024 03:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668809; x=1718273609;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SIhJMYHbPbMKCy9bx8+/YiqMK6RQnhv3MdFiptfabY=;
        b=EUUokRxWT8RlvsS0shaTkfRaOHOB9kTBciIA0vYmfyl0taLP/7yg2jQa2+i2LaBeZR
         Ul8Eocemr4ZGa+OMR3DDWGm3Oirjj1IU4CvQeZSQy5cy+BsCoMHRdmzNHRiqTI/+mYK1
         dEpXDBncIba7etTDSekgs6BkbTQ+aGEOwEVJEKs5l7T5WTAGis1RObZPKRfDNoky/nok
         13+43INGwks/XinHvNznoN/KrDtTGymvGgZmnciGYgEoaEJu7DtLX1r0WRICnofl1NzD
         VrC3xfiMT5zzzgwklQReX51g2O2ku+KXqq7HpBxdDHkElPmE+ctIsHyz1BglTBb7Ltod
         86hA==
X-Forwarded-Encrypted: i=1; AJvYcCXtxr+oHRg6w0TcReeqBcD1ZdvyVYju4dk7+M7oZY/IWVozkOUIJDfvKVMA3XBlI5zuIOy/4X2BcKXNEInYWED19MNJItrzMn6w7p8GMKU=
X-Gm-Message-State: AOJu0YwXXN8od75uGJ5bwdVoOBtjwkdkyLdx+aCgT02g9LkAIr1wP5ZL
	byhRS0NdxdzwjvvQl8yIulyHQA9ram5jTWja8VrHWWiegjYD4fsz
X-Google-Smtp-Source: AGHT+IFNpBx99+2g9M2z5LcQi1Yl42h7tyGXy5+JvX/MNHffumoCzwJiMsXESIBggzIQFWANl8JJGw==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr3649222f8f.0.1717668808901;
        Thu, 06 Jun 2024 03:13:28 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4bcd6sm1144649f8f.45.2024.06.06.03.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:13:28 -0700 (PDT)
Message-ID: <deb873a4-5c59-4292-a86e-3f0b8c460096@grimberg.me>
Date: Thu, 6 Jun 2024 13:13:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
From: Sagi Grimberg <sagi@grimberg.me>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Israel Rukshin <israelr@nvidia.com>,
 Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
 <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
 <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
 <f1f52597-c159-4c87-993d-51221c974dfe@grimberg.me>
Content-Language: en-US
In-Reply-To: <f1f52597-c159-4c87-993d-51221c974dfe@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_031333_436731_E05F99A2 
X-CRM114-Status: GOOD (  25.96  )
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



On 02/06/2024 16:08, Sagi Grimberg wrote:
>
>
> On 02/06/2024 14:43, Max Gurtovoy wrote:
>> Hi Sagi,
>>
>> On 02/06/2024 11:53, Sagi Grimberg wrote:
>>>
>>>
>>> On 02/06/2024 11:19, Leon Romanovsky wrote:
>>>> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>>>>> ib_drain_qp does not do drain a shared recv queue (because it is
>>>>> shared). However in the absence of any guarantees that the recv
>>>>> completions were consumed, the ulp can reference these completions
>>>>> after draining the qp and freeing its associated resources, which
>>>>> is a uaf [1].
>>>>>
>>>>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>>>>> once the qp moved to error state, we reap the recv_cq once in
>>>>> order to prevent consumption of recv completions after the drain.
>>>>>
>>>>> [1]:
>>>>> -- 
>>>>> [199856.569999] Unable to handle kernel paging request at virtual 
>>>>> address 002248778adfd6d0
>>>>> <....>
>>>>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>>>>> <....>
>>>>> [199856.827281] Call trace:
>>>>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>>>>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>>>>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>>>>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>>>>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>>>>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>>>>> [199856.860587]  process_one_work+0x1ec/0x4a0
>>>>> [199856.864694]  worker_thread+0x48/0x490
>>>>> [199856.868453]  kthread+0x158/0x160
>>>>> [199856.871779]  ret_from_fork+0x10/0x18
>>>>> -- 
>>>>>
>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>> ---
>>>>> Note this patch is not yet tested, but sending it for visibility and
>>>>> early feedback. While nothing prevents ib_drain_cq to process a cq
>>>>> directly (even if it has another context) I am not convinced if all
>>>>> the upper layers don't have any assumptions about a single context
>>>>> consuming the cq, even if it is while it is drained. It is also
>>>>> possible to to add ib_reap_cq that fences the cq poll context before
>>>>> reaping the cq, but this may have other side-effects.
>>>> Did you have a chance to test this patch?
>>>> I looked at the code and it seems to be correct change, but I also 
>>>> don't
>>>> know about all ULP assumptions.
>>>
>>> Not yet...
>>>
>>> One thing that is problematic with this patch though is that there 
>>> is no
>>> stopping condition to the direct poll. So if the CQ is shared among 
>>> a number of
>>> qps (and srq's), nothing prevents the polling from consume 
>>> completions forever...
>>>
>>> So we probably need it to be:
>>> -- 
>>> diff --git a/drivers/infiniband/core/verbs.c 
>>> b/drivers/infiniband/core/verbs.c
>>> index 580e9019e96a..f411fef35938 100644
>>> --- a/drivers/infiniband/core/verbs.c
>>> +++ b/drivers/infiniband/core/verbs.c
>>> @@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
>>>                  * guarantees that the ulp will free resources and 
>>> only then
>>>                  * consume the recv completion.
>>>                  */
>>> -               ib_process_cq_direct(qp->recv_cq, -1);
>>> +               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);
>>
>> I tried to fix the problem few years ago in [1] but eventually the 
>> patchset was not accepted.
>>
>> We should probably try to improve the original series (using cq->cqe 
>> instead of -1 for example) and upstream it.
>>
>> [1] 
>> https://lore.kernel.org/all/1516197178-26493-1-git-send-email-maxg@mellanox.com/
>
> Yes. I'd like to know if the qp event is needed though, given that the 
> qp is already in error state (from the sq drain)
> and then we run a single pass over the recv_cq, is it possible to miss 
> any completions.
>
> Would like to resolve the drain without involving the ulp drivers.
>
> If so, then perhaps we can intercept the qp event at the core, before 
> sending it to the ulp and there we can complete
> the srq completion.

Ping?

