Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E9C25B74
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jun 2024 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HWM/J4zSwgMlyBXIB+KRnl1sEORQ0zoP0qKW4SRLdg=; b=gE5xe5YDUz09mtMsHaKp/ykS6y
	c7U6mt0VxkHb2Iub3UKvbvc0C5WfjhGHXihVm1Zz2oyIHb3yBErXHps3xbHjUMnmIdzDRHm/ypBWQ
	jlI+E6aoZrESd9xgz2Et1jrJYY24VQ7CHekwXI8ZvtG/rX3DdtG1z6HEX3WMWGL6Kow2vH/DaZqdt
	d+30KjgL5Ru0/YUtfzri72x7iVjuO6bFIp+hpBsLXJhTer+0981pydfhSTQM+p+HM2t/IXfBfM8VG
	a0kHUeipmMe2PQRRQQhXUFlF3XvqE3uLvBtnCaMK85tFwPvXMKre7BJfuNFt14kfNvnU6DkG1ydEE
	U4vtIfXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDkwo-0000000EHHh-20mj;
	Sun, 02 Jun 2024 13:08:30 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDkwk-0000000EHG2-3BJ0
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jun 2024 13:08:28 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b8aae138fso345397e87.2
        for <linux-nvme@lists.infradead.org>; Sun, 02 Jun 2024 06:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717333696; x=1717938496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HWM/J4zSwgMlyBXIB+KRnl1sEORQ0zoP0qKW4SRLdg=;
        b=IB0YkJLFX9edYydU0hxku2lXS8jruKBuzya0qSPTv6wyzX87paeNZ8Ejkpewb9f+GA
         Qkj8z72GFP9/Nx4BpQttlK51D9dj/SmpvFiPGunXKuL/sPGriK4FHXMWZLd5NrpgY2jp
         +RGP0FK1tw4aWNvIAz9C9t2sG1yjuBaCflI8oVgFmOFRUGC+LPHbnrQ+7sw8U2gteZgL
         c9fUd4HfmGEzsiHQkHoJu9SEmqeiVD9QZGLww8F1lVi9xV+4H/nAw4jx39oLfrjCrz9d
         wJKVdJCoFkYoP7MYwyQqyOwqOXiN0x4HyoYSRwNljoNuozaV2iQi563Uau86URxpyI/3
         /Arg==
X-Forwarded-Encrypted: i=1; AJvYcCXJomkqa96kozBZbOZxgUNM4nYlWI4mCyQeesGvZ6J5tdSXa52izfcq9RtvYG4/qRzU/Bt9a44v/gFGnAc8NqDvUmPNAEIq86Gy73wpaaQ=
X-Gm-Message-State: AOJu0Yzdu84iYqnxNNIDib7xprNODvdif8AsL5FWcF7f3011QXvEAUYA
	pB5iVSG8YJNe4BpGaCnCc1Il91omcwtCUYHISjlYootomDUAbhAnb2naitrP
X-Google-Smtp-Source: AGHT+IHeFhHwqOcYvEnCY+gVt6VW18DFxkI3iwU/p3OHmqiNvrHY8ytQHJk61ikS3JJtoKgvwbTTOg==
X-Received: by 2002:ac2:4313:0:b0:516:c241:a912 with SMTP id 2adb3069b0e04-52b895545a7mr3568935e87.1.1717333695470;
        Sun, 02 Jun 2024 06:08:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42128edaaf0sm104723185e9.15.2024.06.02.06.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 06:08:15 -0700 (PDT)
Message-ID: <f1f52597-c159-4c87-993d-51221c974dfe@grimberg.me>
Date: Sun, 2 Jun 2024 16:08:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Israel Rukshin <israelr@nvidia.com>,
 Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
 <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
 <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_060826_821949_475F863A 
X-CRM114-Status: GOOD (  25.61  )
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



On 02/06/2024 14:43, Max Gurtovoy wrote:
> Hi Sagi,
>
> On 02/06/2024 11:53, Sagi Grimberg wrote:
>>
>>
>> On 02/06/2024 11:19, Leon Romanovsky wrote:
>>> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>>>> ib_drain_qp does not do drain a shared recv queue (because it is
>>>> shared). However in the absence of any guarantees that the recv
>>>> completions were consumed, the ulp can reference these completions
>>>> after draining the qp and freeing its associated resources, which
>>>> is a uaf [1].
>>>>
>>>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>>>> once the qp moved to error state, we reap the recv_cq once in
>>>> order to prevent consumption of recv completions after the drain.
>>>>
>>>> [1]:
>>>> -- 
>>>> [199856.569999] Unable to handle kernel paging request at virtual 
>>>> address 002248778adfd6d0
>>>> <....>
>>>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>>>> <....>
>>>> [199856.827281] Call trace:
>>>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>>>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>>>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>>>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>>>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>>>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>>>> [199856.860587]  process_one_work+0x1ec/0x4a0
>>>> [199856.864694]  worker_thread+0x48/0x490
>>>> [199856.868453]  kthread+0x158/0x160
>>>> [199856.871779]  ret_from_fork+0x10/0x18
>>>> -- 
>>>>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>> Note this patch is not yet tested, but sending it for visibility and
>>>> early feedback. While nothing prevents ib_drain_cq to process a cq
>>>> directly (even if it has another context) I am not convinced if all
>>>> the upper layers don't have any assumptions about a single context
>>>> consuming the cq, even if it is while it is drained. It is also
>>>> possible to to add ib_reap_cq that fences the cq poll context before
>>>> reaping the cq, but this may have other side-effects.
>>> Did you have a chance to test this patch?
>>> I looked at the code and it seems to be correct change, but I also 
>>> don't
>>> know about all ULP assumptions.
>>
>> Not yet...
>>
>> One thing that is problematic with this patch though is that there is no
>> stopping condition to the direct poll. So if the CQ is shared among a 
>> number of
>> qps (and srq's), nothing prevents the polling from consume 
>> completions forever...
>>
>> So we probably need it to be:
>> -- 
>> diff --git a/drivers/infiniband/core/verbs.c 
>> b/drivers/infiniband/core/verbs.c
>> index 580e9019e96a..f411fef35938 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
>>                  * guarantees that the ulp will free resources and 
>> only then
>>                  * consume the recv completion.
>>                  */
>> -               ib_process_cq_direct(qp->recv_cq, -1);
>> +               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);
>
> I tried to fix the problem few years ago in [1] but eventually the 
> patchset was not accepted.
>
> We should probably try to improve the original series (using cq->cqe 
> instead of -1 for example) and upstream it.
>
> [1] 
> https://lore.kernel.org/all/1516197178-26493-1-git-send-email-maxg@mellanox.com/

Yes. I'd like to know if the qp event is needed though, given that the 
qp is already in error state (from the sq drain)
and then we run a single pass over the recv_cq, is it possible to miss 
any completions.

Would like to resolve the drain without involving the ulp drivers.

If so, then perhaps we can intercept the qp event at the core, before 
sending it to the ulp and there we can complete
the srq completion.

