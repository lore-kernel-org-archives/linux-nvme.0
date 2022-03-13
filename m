Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00172C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eM1Qp7D7z2caN1w7AihI0OdAFA4AnarkE293z6DlPNA=; b=NuMVmhZ0VLc2IKlrP+mbjW2fZX
	qiUYy5EBy+6kvQf6hn7jVhcABiu2IQtScBDbOR4IYsis0iP1A1AK65j0IUEt5ik2H6aivq1RtRujs
	APN9L1JOutanBcF1nRuhlrylFWCjV8MGspRJ4DDpV96PFzhD9qoF3UWa5IYK/kBawtTxKWeFh1hTO
	khIBS/TTBpYzg8JxO9YDYgWsnSITVBCXe1a0P82P2bNdVVrZc2M3TSu4Yf8wlSIaUG9XypZOOnR8U
	YCf7dQpPaeax8k1B8TvEZAERGvm50rir/Fwj7kehudPw56AwDGJQZzadccy5xfvzeC7Pq1PVwrbtZ
	Oue5N7tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTOcB-002qz8-68; Sun, 13 Mar 2022 13:50:31 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTOc6-002qye-2y
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 13:50:29 +0000
Received: by mail-ed1-x535.google.com with SMTP id h13so16427218ede.5
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=eM1Qp7D7z2caN1w7AihI0OdAFA4AnarkE293z6DlPNA=;
 b=C430JCgzclWvkTfrMkiUZSIVhavxdJHyeYClLx3M2ZhLt319A5V8SKMc3pfC5+0AQj
 7RJm1u1H8RXZXSvVkjpzeXkgZleIp0zSDN+cF6pCUFqvF6kPBED5PdIlsy1Tpcg+9NEO
 MNDjc+xsQ4ioGAyUkXKt2TGQUp7gQMVToniisQbkHXphJevUnU7mK6tKxkbQvTwz9gAj
 MTNtxzypWy7N4nndEl5/wCaRpmfHJ+942T7We3/7T6QXqNJdpP9XT8y3mIK7LngUtb7y
 574Guebj9I7ZnoDE8m91CeaBXdgwfANDWnmwhyjhszBnDVRTFPHzrkAiZ7gKhccYOThj
 Aqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eM1Qp7D7z2caN1w7AihI0OdAFA4AnarkE293z6DlPNA=;
 b=f3eoZRXb3Y1yJmWhNlCnL8YXeyii0aFPj4bQeUcgz8Uz6YVUhW3RMWsg0mMlufGFnI
 XFJUtBiL2x0GtiG1kFo9fQbxh8uJwKoDQuv1GbdUHV5KfDGbU5HrbeYFY0oTe88JBKGe
 Auh2ObT5Pc/t8Vo0jLSP9bAZm9bawVY5Gu/Eyfv7ePh5m8tkZasw1qNjVrPeMalGjxB0
 /jAFC0ptCnzTXf5J0OmCoWZm4IaPTc9I/aMKSxCt/P1Pc0ue/HXqnYXUC3YOXjXTUNap
 SfeS0vxxYaeeM2+WaEBOyh2X06sC9wDuO39leoz5PgvdaCWCTTpAIJTdN97DZv+G2Yn8
 aARA==
X-Gm-Message-State: AOAM530Iux0hCTkne+qvco9RmAxED4Nt16wnYqw++gSr7/hISw3I/6y9
 if/8wVHH4CTWGNcQR/5JEMw=
X-Google-Smtp-Source: ABdhPJxMKczwiaGdCGeO/Xv2SSu5N/plvvGj5GCLmXPx7EsO1wFpADM/gld4PzPqPHGTHNKBVZcUUA==
X-Received: by 2002:a05:6402:2692:b0:416:c49a:2a2c with SMTP id
 w18-20020a056402269200b00416c49a2a2cmr13257517edd.72.1647179424606; 
 Sun, 13 Mar 2022 06:50:24 -0700 (PDT)
Received: from [192.168.0.59] (178-117-137-225.access.telenet.be.
 [178.117.137.225]) by smtp.gmail.com with ESMTPSA id
 bo14-20020a170906d04e00b006ce98d9c3e3sm5598066ejb.194.2022.03.13.06.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 06:50:24 -0700 (PDT)
Message-ID: <278c7d10-b361-6d44-ed27-9d3d0ce25b82@gmail.com>
Date: Sun, 13 Mar 2022 14:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <20220310125130.16786-1-dossche.niels@gmail.com>
 <df1063c4-eff1-6a4e-0dbb-600ce8ed9721@grimberg.me>
 <9529e5ef-1362-2bba-a5d9-ac5a926f4506@gmail.com>
 <e40f3aea-ba33-f49f-7859-49b47a64cf04@grimberg.me>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <e40f3aea-ba33-f49f-7859-49b47a64cf04@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_065026_164621_CC2B8751 
X-CRM114-Status: GOOD (  25.65  )
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

On 3/13/22 14:31, Sagi Grimberg wrote:
> 
> 
> On 3/13/22 15:14, Niels Dossche wrote:
>> On 3/13/22 14:03, Sagi Grimberg wrote:
>>>
>>>
>>> On 3/10/22 14:51, Niels Dossche wrote:
>>>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>>>> held. The only caller of nvmet_ns_changed which does not acquire that
>>>> lock is nvmet_ns_revalidate. nvmet_ns_revalidate has 3 callers, of which
>>>> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and
>>>> nvmet_execute_identify_ns. The other caller
>>>> nvmet_ns_revalidate_size_store does acquire the lock. Add a parameter to
>>>> nvmet_ns_revalidate to indicate whether the lock was already taken or
>>>> not, and thus whether the function still needs to take a lock when
>>>> calling nvmet_ns_changed.
>>>> 
>>>> The alternative solution is to let nvmet_ns_revalidate return a bool
>>>> which indicates whether nvmet_ns_changed needs to be called and let the
>>>> callers handle the locking responsibility. This however places the
>>>> responsibility with its callers and causes more duplicate code and
>>>> potential to forget to check the return value.
>>>> 
>>>> Both of those identify functions are called from a common function
>>>> nvmet_execute_identify, which itself is called indirectly via the
>>>> req->execute function pointer.
>>>> 
>>>> This issue was found using a static type-based analyser and manually
>>>> verified.
>>>> 
>>>> Signed-off-by: Niels Dossche <dossche.niels at gmail.com>
>>>> ---
>>>> 
>>>> Changes in v3:
>>>>   - improve commit description
>>>>   - do the locking locally
>>>> 
>>>> Changes in v2:
>>>>   - added sentence about how the issue was found.
>>>>   - added missing &
>>>> 
>>>>   drivers/nvme/target/admin-cmd.c | 2 +-
>>>>   drivers/nvme/target/configfs.c  | 2 +-
>>>>   drivers/nvme/target/core.c      | 9 +++++++--
>>>>   drivers/nvme/target/nvmet.h     | 2 +-
>>>>   drivers/nvme/target/zns.c       | 3 ++-
>>>>   5 files changed, 12 insertions(+), 6 deletions(-)
>>>> 
>>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>>>> index 6fb24746de06..efa462374783 100644
>>>> --- a/drivers/nvme/target/admin-cmd.c
>>>> +++ b/drivers/nvme/target/admin-cmd.c
>>>> @@ -511,7 +511,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>>>>   		goto done;
>>>>   	}
>>>>   
>>>> -	nvmet_ns_revalidate(req->ns);
>>>> +	nvmet_ns_revalidate(req->ns, true);
>>>>   
>>>>   	/*
>>>>   	 * nuse = ncap = nsze isn't always true, but we have no way to find
>>>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>>>> index 091a0ca16361..a803cd66dc4b 100644
>>>> --- a/drivers/nvme/target/configfs.c
>>>> +++ b/drivers/nvme/target/configfs.c
>>>> @@ -586,7 +586,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>>>>   		mutex_unlock(&ns->subsys->lock);
>>>>   		return -EINVAL;
>>>>   	}
>>>> -	nvmet_ns_revalidate(ns);
>>>> +	nvmet_ns_revalidate(ns, false);
>>>>   	mutex_unlock(&ns->subsys->lock);
>>>>   	return count;
>>>>   }
>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>>> index 5119c687de68..0ceef97e4093 100644
>>>> --- a/drivers/nvme/target/core.c
>>>> +++ b/drivers/nvme/target/core.c
>>>> @@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>>>>   		ns->nsid);
>>>>   }
>>>>   
>>>> -void nvmet_ns_revalidate(struct nvmet_ns *ns)
>>>> +void nvmet_ns_revalidate(struct nvmet_ns *ns, bool should_acquire_lock)
>>>>   {
>>>>   	loff_t oldsize = ns->size;
>>>>   
>>>> @@ -540,8 +540,13 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
>>>>   	else
>>>>   		nvmet_file_ns_revalidate(ns);
>>>>   
>>>> -	if (oldsize != ns->size)
>>>> +	if (oldsize != ns->size) {
>>>> +		if (should_acquire_lock)
>>>> +			mutex_lock(&ns->subsys->lock);
>>>>   		nvmet_ns_changed(ns->subsys, ns->nsid);
>>>> +		if (should_acquire_lock)
>>>> +			mutex_unlock(&ns->subsys->lock);
>>>> +	}
>>>
>>> What is the harm locking it always and avoid the conditional?
>>
>> In my patch v2 submission I wrote the following text in my commit message:
>>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>>> held. The only caller of nvmet_ns_changed which does not acquire that
>>> lock is nvmet_ns_revalidate.
>> on which Christoph Hellwig replied:
>>> So acquire it in nvmet_ns_revalidate only when we actually call
>>> nvmet_ns_changed.  Otherwise we take a subsystem-wide lock for every
>>> Identify Namespace all.
> 
> Yea, only wrap nvmet_ns_changed, but always.
> 

Alright, I can send in a patch that does it like that.

>>
>> Therefore, I changed it to a conditional lock in this patch submission.
>>
>> My commit message in v2 did not clearly state that nvmet_ns_revalidate has 3 callers, of which
>> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns. The other caller
>> nvmet_ns_revalidate_size_store does acquire the lock. Maybe I caused some confusion because of the unclear wording.
> 
> It is simpler to just move that call-site outside of the lock imo.

The callsite that has the lock is nvmet_ns_revalidate_size_store. It checks for the enabled flag under that lock.
If nvmet_ns_revalidate_size_store calls nvmet_ns_revalidate without that lock taken, but with the lock acquired inside the nvmet_ns_revalidate_size_store function itself, is it not possible that the ns->enabled flag changes in between the ns->enabled check and the call to nvmet_ns_revalidate_size_store? I thought the locking in that function was to also make sure that the enabled flag does not change during the execution of nvmet_ns_revalidate?

