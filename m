Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE4CC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=niqcxvxx9mjN5W6h/lURJAP03sAdP9CJ4GgRbGY87SM=; b=orUEJ0cPwBrcCr5yXY8qDYtG7O
	plpDM6akON+7QGWNMFt4R9L9HNrvbuFlhp1LixfEi9bj5DG43XcVhHucoO6OfawEpMg1BA57Wi4PP
	2NWarCJkNZSzDAYVyu2zj4gPpGQHSUZGG55wGloZ6cwfEc/oQL68zvCGkPhV8E2fR/IaXowAAqUWC
	sB6Y08TCm8BJ3c6khd2OTiQjXaMQ3abIIQrMwjthXqvTJ0E5yE/3KHzQsOIC/N+DeUPqnlRRKFMQw
	BA9uwvWwG4e6kDC7GaxDuFZIrmdeuRmCEGQHypsPcGd/YN+5rGx0Mt5i4HG0ozqu4uX56Mxq8WE5w
	KtO7oQNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whki3-00000001iGN-2I6W;
	Thu, 09 Jul 2026 09:06:19 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whki0-00000001iG0-2KAL
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 09:06:18 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1280721a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783587975; x=1784192775; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=niqcxvxx9mjN5W6h/lURJAP03sAdP9CJ4GgRbGY87SM=;
        b=XqbASA/yScpRFboxi588rMFVnvYmxOtTMuEcHHkfQ1KuOOdCOTnJCzRMStyvSg4Wdi
         qdXOhDrsDomimCkL+orSUBqYzHqLCTHu1llClGK4M0YNLqboJjlG59OKWGrtUqTNujVJ
         C6dqeo2u4Z2BD9Hm2ileEy5rrGJJ+NekdyTyHZ9owjb/NF2RHGRgjll9T5eHaKTwjjZo
         WI9GmfIK6UqCI3gNbA8lncrnrQfEdI/wdAmtHUNWgS/2+NeQkvH7JJ1m161imAdsqCh/
         cVp0DRK9bNOi3Ygvtj2i4CEik4jb9xj9GKuSy9/8wQKfHANW2MBVjKs4w6P+O3PSxMCR
         Dtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587975; x=1784192775;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niqcxvxx9mjN5W6h/lURJAP03sAdP9CJ4GgRbGY87SM=;
        b=VKGR+9crwBmFdqAtlBiMJRs/SVqFI7zI9mi/euyn3yKfV0uio718HGNAUT3u6cZXyx
         L4yLJ+sPES3pGCAdl8HoFBKHsa4igOvqGTwOqJrnxK5XKOWGvCY+fRKK7nfusnHxDZQW
         XjWkAa6Iq2PkwxEKFfP72v3/NFUqmSgDb561CcC8pqfEjNJx+zJZ+8JhJGP5x/3KZf2G
         dn0PEXV5Gvtx5qWK24GMet9XNqjwDKtEY6Jzmh9W2ryRzM2t/ULvKo9BsEUWZnj9s94B
         lLTwAfwUzT9QM0eUaPUSTjhgMzNYBGcjfVNZU3pRHnZonjzkmnfgwXm2rhOjkY3WwZdd
         LEvg==
X-Forwarded-Encrypted: i=1; AHgh+Ro3wtoYh0/t8NfOC8k0da5QyA4F/JJtCGaS2+RI5rEQU4mIEvELGm5aLb4gVHK6afVYx+biVvklfqAt@lists.infradead.org
X-Gm-Message-State: AOJu0Ywv/iq++YXcBcZrkhGxFsy6o8g3BqVKURFgEyJL7V7Sl8mYL8RT
	EykVyeUGBj3y5omRXpH7Fhygw7ul/BMxhorZaxKyft1QkCUa/1uYHuOS
X-Gm-Gg: AfdE7cnexp8tX3oic6ruTztsG5wYZkrD744H/uo7GCpqeJHPG3mn69mbkKuUL5nlMod
	/HbAes3h0pQIy7DPi+Xpxt4qNOxtTdthkaH965GsNPREk52U17Z3y9ZWKiG0junImCmF3F3KoQV
	Roo/mu7y/zE3FCbdIDRHwVsq59E01kCYOl7wLL/hbXuPZ4FG78Z8yzP3ePHePT1RByV1U65yJMs
	61IjeVVCZLCX+tFBtaO6tRpRsuXB7AKAprtP8HyJvKPBjcfn1depUdYJEFvg4Uq4/T5umZVJvEZ
	RDgIfCJ6JnLFHv/0B4KFUtV02mdrschyhhOwbbEWj3AIRDfIDwl3CY07UubWVWJhmy1y/bGPRGX
	P00vtPu3QKIgG8wOPjeenInvEnLU4KC8U9greKtT1OxBYSqOiN8Arjh/T8daw6o1J/efZYKdd3X
	W5jGe81nHQWKC75ThDH0RK6phEISQAEFTLc4wSBntn
X-Received: by 2002:a17:90a:e70d:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-38941fb57e3mr6283355a91.29.1783587975008;
        Thu, 09 Jul 2026 02:06:15 -0700 (PDT)
Received: from [10.0.48.76] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a583a22f8sm825313a91.15.2026.07.09.02.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:06:14 -0700 (PDT)
Message-ID: <7ae65361-f601-4fd9-8eac-5dfb9f6bb7ea@gmail.com>
Date: Thu, 9 Jul 2026 17:06:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make firmware activation poll interval configurable
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guzebing <guzebing@bytedance.com>
References: <20260627010610.47768-1-guzebing1612@gmail.com>
 <20260709064233.GA18381@lst.de>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <20260709064233.GA18381@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_020616_605743_13975D8C 
X-CRM114-Status: GOOD (  17.47  )
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



On 7/9/26 2:42 PM, Christoph Hellwig wrote:
> On Sat, Jun 27, 2026 at 09:06:10AM +0800, guzebing wrote:
>> From: Guzebing <guzebing@bytedance.com>
>>
>> nvme_fw_act_work() polls the controller processing-paused status every
>> 100 ms while firmware activation is pending. Some devices can complete
>> online activation in only a few hundred milliseconds, so the fixed
>> interval can add noticeable latency before the driver observes
>> completion.
>>
>> Add an nvme_core.fw_act_poll_interval_ms module parameter to make the
>> poll interval tunable. Keep the default at 100 ms to preserve existing
>> behavior, and accept values from 10 ms to 100 ms so systems that need
>> faster completion detection can opt in to a shorter interval.
>>
>> Signed-off-by: Guzebing <guzebing@bytedance.com>
>> ---
>> We recently observed this issue while performing online firmware
>> updates for Gen5 NVMe SSDs in a production environment.
>>
>> During firmware activation, the kernel quiesces I/O. Detecting the end
>> of firmware activation earlier lets the driver unquiesce I/O earlier,
>> which is important for the long-tail I/O latency of production
>> workloads.
> 
> What value does this device report in the Maximum Time for Firmware
> Activation (MTFA) field?  It might make sense to scale the polling
> time as a fraction of that instead of requiring a manual override.
> 

The Samsung PM9D3a Gen5 SSD reports MTFA = 10, i.e. 1000 ms.

I also checked another device, an Intel/Solidigm P5520 Gen4 drive.  It
reports MTFA = 100, i.e. 10000 ms, while the observed online activation
time is about 800 ms.

I agree that deriving the polling interval from MTFA would be better
than adding a module parameter.  Given that MTFA is a conservative upper
bound rather than a good estimate of the common activation time, would
using a small fraction of it, for example MTFA / 100 clamped to 10..100
ms, be a reasonable policy for v2?

That would give 10 ms for the PM9D3a device above, while keeping the
current 100 ms interval for the P5520 case and for large-MTFA devices.


