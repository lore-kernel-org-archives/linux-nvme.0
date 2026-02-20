Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D7E9A05B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 01:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ivmmj3rmqHiPEXxOwvvtMYJmo8FpOUGoOJc5c2N5Y4=; b=3sKZGDE1Qv+BWJXZx+W+K32B8E
	Qz5UqO8vU5aPm7Y16V/KpzGRTS/2ZCflz2TqoaXCkrzHbN0fET9jyAQF0u34TdJUXoUo1XXQN2Nam
	2rVDh6ZwNnmr+hE8A9nijZAFuzved5OvghmXYMtf5mTqbEwFdsSqPcitH4s2Ytjp5vnR9LSZyNt9o
	gPnIJ46f6mubyTdootbxWqJpmrOYpfkpAX/5ERhPEU8MQyk2FUCa1WOWgcNylwDdDlaN/kLUjO09j
	9MJuV9GrxGP67utNkk1T+R41GKij+MII0b6S441Us4bjb96ljZQkC3l9GKgvG16lEjf3voyH8y/MM
	A9i7NwXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtFE9-0000000Cujo-2yII;
	Fri, 20 Feb 2026 01:22:41 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtFE6-0000000Cuig-2YkD
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 01:22:39 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8947e6ffd20so16892306d6.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771550556; x=1772155356; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ivmmj3rmqHiPEXxOwvvtMYJmo8FpOUGoOJc5c2N5Y4=;
        b=cd01n7PNDFyNQL+DNQ0xlRJam9TaKzfSbM/D56r6RFlKpjGOhmy4UWJiq5usOIKW3U
         cwzFOcwFgglUyWzu/kw73Kyt8FJuHbGgnZB/8q+ytXF++WJ4EfHODgg2ac+ztLq1bh59
         8qhSFNoMd1G7o2fuHXY9PzettMCtDv8vKvx/xxQ+eevqr57OOzxyy1c4Yija5igYe1Zh
         CwdMIq/rbVWe5vGo2e+vlyla4f2GZleeXCQOnBCJbcJmE500CekHatBsQylUoZ47GxBn
         xA2IOGiP5GuAZjn0YD4bG4psKAiO9oMTe3kfceh3GL8mT9TmKlwk5aAncQWqYJKPnLPQ
         oRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771550556; x=1772155356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ivmmj3rmqHiPEXxOwvvtMYJmo8FpOUGoOJc5c2N5Y4=;
        b=V6z+mDeuX38gXiN9uDbUebtsbRfS+DYuCUl7rTTEeobZKPSNh3xNd8ALlXFUF3+f0Y
         8SPYe8YzemDFTLto6HYbBxQGjSnhMfbK0X3AZPgxdP/sP+22QTZZ8l9R+JgzXmL44FFV
         o1UydcUbOXP892637+lv2xZNScDElon+TpvZzW13fl6geJFjGtPUHuBhZCCcjYaBHznx
         dnl1nAaBpzp/OqoSyYA5pbDL6DVJjDbJWxjXmbN7qTLJnknE1nUvt6LFrBKuk0ezEzYI
         Lq6/x6MvjBx9vRBDtVno74/2ovGe3AS2QLDB899cKKuBzoCvBjTk5Bb0Jm5Zq5hfGWnU
         IFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuoVbXgHZk0XvKHodfF4Cl+yakGLc8eNnEzt6An/rmSncBCkCi7dJGXfcsLo1NXXSjcqOcsM3JOybW@lists.infradead.org
X-Gm-Message-State: AOJu0Yz69icmzaTzX8ZD4S/+Ov+QLXNT3Jl9trWD0vNG7eVGmuy7mnI3
	aci8veHXap/EEry4WNEwYWTleVubmrQEtV8GZVNF3Puw+stAia5YXoSF
X-Gm-Gg: AZuq6aJpmt6JDXpaUxSyhPOljQGX7L33TuIl+I2PBayfDtjZOU1wNVUXtnH8nwRiSCD
	MxY1mKOTV6fNk3KvITbZGNGEiZpTAtXSLkVr03vKdYlNb9n/7c19AcFeOhXPjRPOPKtDrz30TEU
	4GJOBWtKXtwr54A48k1MHB3t1xClDix4bG6sXLKcivoFxlPMDfcT1wzSyx9AC48FKZZTZP5DiA2
	0mCfjwu1Fva4mqsy5TB9m66jEmpfez9U+Tv70cAFr5yrgHB2ctRqGCjZdbb9lYR2ofaBtlTRFHB
	wv4u2C/V278RWSxhjVq7xhXI0z29Al3mu5eU6ZH3Zb0NnSUjqYzWDgZBywRULpMeNAbcAlErAfq
	gIqAANSzSddmxz/SmnB+EEF14zK3pfOP+ObPvINDUoF7gCL80yIHoEANWNlrB3571VAC3A2u92q
	8EecaN4dQz9v4OWErfcGuU72Yj38ItiYxepe7hrMd6HyjY
X-Received: by 2002:a05:6214:d43:b0:894:64c1:6643 with SMTP id 6a1803df08f44-89971996be8mr965616d6.19.1771550556131;
        Thu, 19 Feb 2026 17:22:36 -0800 (PST)
Received: from [10.69.55.177] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc95aa7sm276265386d6.17.2026.02.19.17.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 17:22:35 -0800 (PST)
Message-ID: <96ea8e82-ead3-498f-bb87-5b2809089950@gmail.com>
Date: Thu, 19 Feb 2026 17:22:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, jsmart833426@gmail.com
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com>
 <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <20260217153530.GI2392949-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_172238_669120_4807E19C 
X-CRM114-Status: GOOD (  30.02  )
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

On 2/17/2026 7:35 AM, Mohamed Khalfella wrote:
> On Tue 2026-02-17 08:09:33 +0100, Hannes Reinecke wrote:
>> On 2/16/26 19:45, Mohamed Khalfella wrote:
>>> On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
>>>> On 2/14/26 05:25, Mohamed Khalfella wrote:
>>>>> TP8028 Rapid Path Failure Recovery does not define how much time the
>>>>> host should wait for CCR operation to complete. It is reasonable to
>>>>> assume that CCR operation can take up to ctrl->cqt. Update wait time for
>>>>> CCR operation to be max(ctrl->cqt, ctrl->kato).
>>>>>
>>>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>>>> ---
>>>>>     drivers/nvme/host/core.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index 0680d05900c1..ff479c0263ab 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
>>>>>     	if (result & 0x01) /* Immediate Reset Successful */
>>>>>     		goto out;
>>>>>     
>>>>> -	tmo = secs_to_jiffies(ictrl->kato);
>>>>> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
>>>>>     	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
>>>>>     		ret = -ETIMEDOUT;
>>>>>     		goto out;
>>>>
>>>> That is not my understanding. I was under the impression that CQT is the
>>>> _additional_ time a controller requires to clear out outstanding
>>>> commands once it detected a loss of communication (ie _after_ KATO).
>>>> Which would mean we have to wait for up to
>>>> (ctrl->kato * 1000) + ctrl->cqt.
>>>
>>> At this point the source controller knows about communication loss. We
>>> do not need kato wait. In theory we should just wait for CQT.
>>> max(cqt, kato) is a conservative guess I made.
>>>
>> Not quite. The source controller (on the host!) knows about the
>> communication loss. But the target might not, as the keep-alive
>> command might have arrived at the target _just_ before KATO
>> triggered on the host. So the target is still good, and will
>> be waiting for _another_ KATO interval before declaring
>> a loss of communication.
>> And only then will the CQT period start at the target.
>>
>> Randy, please correct me if I'm wrong ...
>>
> 
> wait_for_completion_timeout(&ccr.complete, tmo)) waits for CCR operation
> to complete. The wait starts after CCR command completed successfully.
> IOW, it starts after the host received a CQE from source controller on
> the target telling us all is good. If the source controller on the target
> already know about loss of communication then there is no need to wait
> for KATO. We just need to wait for CCR operation to finish because we
> know it has been started successfully.
> 
> The specs does not tell us how much time to wait for CCR operation to
> complete. max(cqt, kato) is an estimate I think reasonable to make.

So, we've sent CCR, received a CQE for the CCR within KATO (timeout in 
nvme_issue_wait_ccr()), then are waiting another max(KATO, CQT) for the 
io to die.

As CQT is the time to wait once the ctrl is killing the io, and as the 
response indicated it certainly passed that point, a minimum of CQT 
should be all that is needed. Why are we bringing KATO into the picture?

-- this takes me over to patch 8 and the timeout on CCR response being KATO:
Why is KATO being used ? nothing about getting the response says it is 
related to the keep alive. Keepalive can move along happily while CCR 
hangs out and really has nothing to do with KATO.

If using the rationale of a keepalive cmd processing - has roundtrip 
time and minimal and prioritized processing, as CCR needs to do more and 
as the spec allows holding on to always return 1, it should be 
KATO+<something>, where <something> is no more than CQT.

But given that KATO can be really long as its trying to catch 
communication failures, and as our ccr controller should not have comm 
issues, it should be fairly quick. So rather than a 2min KATO, why not 
10-15s ? This gets a little crazy as it takes me down paths of why not 
fire off multiple CCRs (via different ctlrs) to the subsystem at short 
intervals (the timeout) to finally find one that completes quickly and 
then start CQT. And if nothing completes quickly bound the whole thing 
to fencing start+KATO+CQT ?

-- james


