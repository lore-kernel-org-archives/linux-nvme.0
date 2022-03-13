Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A91C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fRROaWYTPQvKSuQCvL7vOErtiAEXjCIWdThTKAj6gPM=; b=I4P7QmaotLTWoHzft4aV0as2vX
	S75sZECLe/fJ36Elq7GIQJbZz0TEQwnUurS7zKJso/82FUG8GdrRmQy6wLdcKQEM0jixVU1bcDEII
	nHOq9Aidc55lACIBrAkJlrcTBi9ucQ0S/OKGVvXRDuHfJgd2HdnqZkH7G7+l8mSKcallhGF4NCy27
	kz7nk91XgzO56QjjjoWYOZbfg4GYcNxk/RFXXZ8508p14URvNDbSvVpP0w4XS25xWQefFTdZtaJlh
	NIqGPGc7hhXWRBv8Zw6lhyINi9CE7Y6fu8PmJxb3rnqN2vq7kQlSwi2Kvbc0LRpkc5qKzsa+X+vsY
	CaH1VOCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTOK3-002q6v-EY; Sun, 13 Mar 2022 13:31:47 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTOK1-002q6Y-5x
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 13:31:46 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 q7-20020a7bce87000000b00382255f4ca9so10354637wmj.2
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 06:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fRROaWYTPQvKSuQCvL7vOErtiAEXjCIWdThTKAj6gPM=;
 b=g/6xpGH+SkdR6m9OCvIQqwaaW8IfCnGbRRrTR87BVDEIFHyFnsXyJcaOxRxO+b7Pnq
 lQrDyOkYw1ODLjOjOzthwsXEhKtscBCpvn/NnlQfcvGYYKCy4dh5+4KGHGx5G0R63/kQ
 deg3oyulTsg1Pvrk+7QJ4yrV6ePFuy6R79+1v4ywln32fwm9scD05c2rINsInshAUqJp
 0Sezqk2L/206gQXrhnvAdaKpCVwVmBPluziGOlpwFzcTrpCbnijEwFqZm/fxPU95sIBG
 YoEi6dSdi5z/PMkrmHtKn2jyF4Ubj7UBmTbaYNkctpFuYeHiH5NtCeJXmFoseTA8kOSD
 hQ8Q==
X-Gm-Message-State: AOAM533scusMvTC1s93RKwBX4I36NSTUhNn2iXBLFrjPgwz03/cvftzH
 KRheO2asNcDXJmWewlwB9Q8=
X-Google-Smtp-Source: ABdhPJxmnv7vxRzN9uPb8cWuAbg5wApip8WwWhQ9Vj8h7VY8SsVhWksXXcJtUuGmDQMeq204U/Q44g==
X-Received: by 2002:a05:600c:1d29:b0:389:81d6:f499 with SMTP id
 l41-20020a05600c1d2900b0038981d6f499mr13748306wms.137.1647178303628; 
 Sun, 13 Mar 2022 06:31:43 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 f7-20020a5d4dc7000000b001f1d99e9441sm11470797wru.106.2022.03.13.06.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 06:31:43 -0700 (PDT)
Message-ID: <e40f3aea-ba33-f49f-7859-49b47a64cf04@grimberg.me>
Date: Sun, 13 Mar 2022 15:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <20220310125130.16786-1-dossche.niels@gmail.com>
 <df1063c4-eff1-6a4e-0dbb-600ce8ed9721@grimberg.me>
 <9529e5ef-1362-2bba-a5d9-ac5a926f4506@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9529e5ef-1362-2bba-a5d9-ac5a926f4506@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_063145_288344_65E77728 
X-CRM114-Status: GOOD (  22.72  )
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



On 3/13/22 15:14, Niels Dossche wrote:
> On 3/13/22 14:03, Sagi Grimberg wrote:
>>
>>
>> On 3/10/22 14:51, Niels Dossche wrote:
>>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>>> held. The only caller of nvmet_ns_changed which does not acquire that
>>> lock is nvmet_ns_revalidate. nvmet_ns_revalidate has 3 callers, of which
>>> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and
>>> nvmet_execute_identify_ns. The other caller
>>> nvmet_ns_revalidate_size_store does acquire the lock. Add a parameter to
>>> nvmet_ns_revalidate to indicate whether the lock was already taken or
>>> not, and thus whether the function still needs to take a lock when
>>> calling nvmet_ns_changed.
>>>
>>> The alternative solution is to let nvmet_ns_revalidate return a bool
>>> which indicates whether nvmet_ns_changed needs to be called and let the
>>> callers handle the locking responsibility. This however places the
>>> responsibility with its callers and causes more duplicate code and
>>> potential to forget to check the return value.
>>>
>>> Both of those identify functions are called from a common function
>>> nvmet_execute_identify, which itself is called indirectly via the
>>> req->execute function pointer.
>>>
>>> This issue was found using a static type-based analyser and manually
>>> verified.
>>>
>>> Signed-off-by: Niels Dossche <dossche.niels at gmail.com>
>>> ---
>>>
>>> Changes in v3:
>>>    - improve commit description
>>>    - do the locking locally
>>>
>>> Changes in v2:
>>>    - added sentence about how the issue was found.
>>>    - added missing &
>>>
>>>    drivers/nvme/target/admin-cmd.c | 2 +-
>>>    drivers/nvme/target/configfs.c  | 2 +-
>>>    drivers/nvme/target/core.c      | 9 +++++++--
>>>    drivers/nvme/target/nvmet.h     | 2 +-
>>>    drivers/nvme/target/zns.c       | 3 ++-
>>>    5 files changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>>> index 6fb24746de06..efa462374783 100644
>>> --- a/drivers/nvme/target/admin-cmd.c
>>> +++ b/drivers/nvme/target/admin-cmd.c
>>> @@ -511,7 +511,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>>>    		goto done;
>>>    	}
>>>    
>>> -	nvmet_ns_revalidate(req->ns);
>>> +	nvmet_ns_revalidate(req->ns, true);
>>>    
>>>    	/*
>>>    	 * nuse = ncap = nsze isn't always true, but we have no way to find
>>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>>> index 091a0ca16361..a803cd66dc4b 100644
>>> --- a/drivers/nvme/target/configfs.c
>>> +++ b/drivers/nvme/target/configfs.c
>>> @@ -586,7 +586,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>>>    		mutex_unlock(&ns->subsys->lock);
>>>    		return -EINVAL;
>>>    	}
>>> -	nvmet_ns_revalidate(ns);
>>> +	nvmet_ns_revalidate(ns, false);
>>>    	mutex_unlock(&ns->subsys->lock);
>>>    	return count;
>>>    }
>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>> index 5119c687de68..0ceef97e4093 100644
>>> --- a/drivers/nvme/target/core.c
>>> +++ b/drivers/nvme/target/core.c
>>> @@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>>>    		ns->nsid);
>>>    }
>>>    
>>> -void nvmet_ns_revalidate(struct nvmet_ns *ns)
>>> +void nvmet_ns_revalidate(struct nvmet_ns *ns, bool should_acquire_lock)
>>>    {
>>>    	loff_t oldsize = ns->size;
>>>    
>>> @@ -540,8 +540,13 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
>>>    	else
>>>    		nvmet_file_ns_revalidate(ns);
>>>    
>>> -	if (oldsize != ns->size)
>>> +	if (oldsize != ns->size) {
>>> +		if (should_acquire_lock)
>>> +			mutex_lock(&ns->subsys->lock);
>>>    		nvmet_ns_changed(ns->subsys, ns->nsid);
>>> +		if (should_acquire_lock)
>>> +			mutex_unlock(&ns->subsys->lock);
>>> +	}
>>
>> What is the harm locking it always and avoid the conditional?
> 
> In my patch v2 submission I wrote the following text in my commit message:
>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>> held. The only caller of nvmet_ns_changed which does not acquire that
>> lock is nvmet_ns_revalidate.
> on which Christoph Hellwig replied:
>> So acquire it in nvmet_ns_revalidate only when we actually call
>> nvmet_ns_changed.  Otherwise we take a subsystem-wide lock for every
>> Identify Namespace all.

Yea, only wrap nvmet_ns_changed, but always.

> 
> Therefore, I changed it to a conditional lock in this patch submission.
> 
> My commit message in v2 did not clearly state that nvmet_ns_revalidate has 3 callers, of which
> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns. The other caller
> nvmet_ns_revalidate_size_store does acquire the lock. Maybe I caused some confusion because of the unclear wording.

It is simpler to just move that call-site outside of the lock imo.

