Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E1CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zb0zFvmGrXCV4bXxD7qGBK+l8y0JfGz1f2hK2OsISA=; b=wrXPI9832LPDZ3Vvh10LHLgAl6
	vXY8ugFgqmEzOlRi35jnxy8XQKSmkwryxUJs0aV6EEAUhI3l56RFcr0/cIT9GprYttakNGkUYzNUX
	2j7bnQLW0qOw3GnudrkPztIJOXi9kCFskqirvd1LA+MqtVZRVhdbdu19gDP+6lzmlriLowiuN2kcP
	ltcokxVPdLUBk8xc6FixcwqJUdQ/wyc7x0kdHkJJZlDA/mDrM46m3VYF5cX+G1sWLAJgKfwzGFCPx
	hbnifGVhBiQNzg+zQdNXpfT2MiIcVJOtjfMkAmTsAEfgyTC0w3CELevBYhLwpL8Iu2autnxIRMUqv
	zAhz8p/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDLrt-00EBRN-1e;
	Wed, 13 Dec 2023 09:49:29 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDLrq-00EBQk-2P
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 09:49:28 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50bcf41379bso1852022e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 01:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702460963; x=1703065763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zb0zFvmGrXCV4bXxD7qGBK+l8y0JfGz1f2hK2OsISA=;
        b=hdXkzobOVnMBK1wd0b99RFDlezc+1weANVbezFsm8zTMjWMpp7UACZWEy9Mm7ZT6/t
         43phpyJw90DG7rvacZtW5t16QhmGrBZ1Ts/Qou+3kK+9Ww3l7rPFkSlkMxWWD7NHYtws
         dQfH+uxC83/a8C+66bmITXk2jJnzUobRqwMQqcKjnSKwbWs7ycToFLG0DVs94rXGjaKc
         pp84TVmLEXQz6rA3eK2glaOsLicnVg5emwBhUlHwdZHq8iXGnSAb/DJ86L/oKHWh+qXy
         MlAqArQQFG1/O4h8ERXxcAXUxUq3ZJXhtkEe9+mp3Z4mobYvdWBC8Grs22eo+GD9dzj8
         oU1w==
X-Gm-Message-State: AOJu0YzecAV7rTNCRjVYK3NUG9+3hpiNe422w+CWGVwRFseUdTHeUWtf
	7GqgQWWdZl7Pr79+IuQhADQ=
X-Google-Smtp-Source: AGHT+IHa1G0rfWfvK4SyhYBeXWOWC71Jvh8vX76aVfKZVRomsic9JRnRhzWp1K5OWqTFvRil2oK08A==
X-Received: by 2002:a05:651c:1a20:b0:2c9:acf4:310a with SMTP id by32-20020a05651c1a2000b002c9acf4310amr7349967ljb.3.1702460962972;
        Wed, 13 Dec 2023 01:49:22 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0040c34cb896asm18510532wmq.41.2023.12.13.01.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 01:49:22 -0800 (PST)
Message-ID: <5a166754-390a-46f8-9861-38bc90111c4f@grimberg.me>
Date: Wed, 13 Dec 2023 11:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, brauner@kernel.org
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-6-aaptel@nvidia.com>
 <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
 <253plzsis4h.fsf@nvidia.com>
 <97e6efa4-8d70-98e1-f5af-1d34672c2e2b@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <97e6efa4-8d70-98e1-f5af-1d34672c2e2b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_014926_780979_FBD79481 
X-CRM114-Status: GOOD (  19.33  )
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


> Hi Sagi,
> 
> On 29/11/2023 15:52, Aurelien Aptel wrote:
>> Hi Sagi,
>>
>> Sagi Grimberg <sagi@grimberg.me> writes:
>>>> +     ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
>>>> +                               ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
>>>> +                               ctrl->ctrl.opts->tls);
>>>> +     if (!ok) {
>>>
>>> please use a normal name (ret).
>>
>> Ok, we will rename to ret and make ulp_ddp_query_limits() return int 0
>> on success to be consistent with the name.
>>
>>> Plus, its strange that a query function receives a feature and returns
>>> true/false based on this. The query should return the limits, and the
>>> caller should look at the limits and see if it is appropriately
>>> supported.
>>
>> We are not sure how to proceed as this seems to conflict with what you
>> suggested in v12 [1] about hiding the details of checking supports in
>> the API. Limits just dictate some constants the nvme-layer should use
>> once we know it is supported.
>>
>> We can rename ulp_ddp_query_limits() to ulp_ddp_check_support(). This
>> function checks the support of the specified offload capability and also
>> returns the limitations of it.
>>
>> Alternatively, we can split it in 2 API functions (check_support
>> and query_limits).
>>
>> Let us know what you prefer.
>>
>> Thanks
>>
>> 1: 
>> https://lkml.kernel.org/netdev/bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me/
> 
> We would like to submit another version by the end of this week and 
> hopefully progress with this series.
> To address your comment, I was thinking about something like:
> 
> +    if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
> +        goto err;
> +
> +    ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
> +    if (ret)
> +        goto err;
> +
> +    if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
> +        goto err;
> 
> I would like to remind you that the community didn't want to add ulp_ddp 
> caps and limits context to the netdev structure (as we have for example 
> in the block layer q) and preferred the design of ops/cbs.

Seems fine to me.

