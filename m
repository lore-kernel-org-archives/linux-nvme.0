Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04715E7B611
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x94YbsbSTLVHjbOsIERIQoPyFZlZNAwxCbQQ5f6DtmQ=; b=WLmJpei+URO4+c8pRCytxQF3m+
	y0hdVmmHc5L3fHS3bLZExxqTUFPd+9Bs0bgiz+73MAUJ68EUAeluyqlVT26g867lPSoBffYRFkaRJ
	YhKbqAsFGC2pt5PEhalRtdMMCQH5zxIPNQfyjsjOP0Ju7Hp6WVvDIKER7paLOo4yJsarLyicfZGJ3
	ve+41O7IkdgN9a/7YG+5tWkNPUBxUQF4HyEAiditOzr/2qo5kUHZdpb9urJ1TEk6mPc+EAcLhJnTQ
	Ir3Igk93fjYwY8RD5JT/Oum9FX+jULLpZCROwEBJo94aR3iihlVC9rLf6iQ8VadCYZXakzi+xUDNc
	wRDDJZFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo1sU-0007XA-2v;
	Wed, 04 Oct 2023 13:25:26 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo1sS-0007Vp-00
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 13:25:25 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-406532c49dcso4747205e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 06:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425915; x=1697030715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x94YbsbSTLVHjbOsIERIQoPyFZlZNAwxCbQQ5f6DtmQ=;
        b=JTwZhgtAzByGdYynuzbUD5n89JsxCR7R9l/vKmK9Kep7PwbT9wZl9ULR4JG8zpN3AU
         rtTVmBKSdkUlg5M82lE4bewceS9hSfHB9AIczjWYPd25vkadtgb5Tu3t8ED/bpCtnNf5
         TpV7HQaQL8/uHGV7FWuyPmNHdvDRIzosUjxzWN6uXM+bt88QnyRGuCK5484b2RlD3GnE
         60yHWPxinejo1RuMTblxAMvQE5wCY4d/ppoTeWuWvCMua/+9J6FlT4QZDQyZz9KVJYOS
         w6BNNiJ9kvC6m0GeYvlnPKVHvllIThEMlyDIF0uQN2YCS9VAYFvB5XC+mSPvvBGle6dt
         o9Wg==
X-Gm-Message-State: AOJu0YyTP04VKH6RcsvRs5zeKzaQ+pHyLoOzdMlUP6WG4SVLu/FTySnB
	WnZChyPakzpJd3+Y9C0eizc=
X-Google-Smtp-Source: AGHT+IHFQkJDxGFmCudeiB5949yF1YnKz6QMHwMKy7Qj+AJ3Ffn2NifH2gChfI7c3pJrgqyfqXRp7g==
X-Received: by 2002:adf:f14e:0:b0:320:b1e:7e6c with SMTP id y14-20020adff14e000000b003200b1e7e6cmr2070349wro.3.1696425915101;
        Wed, 04 Oct 2023 06:25:15 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d6a09000000b003232380ffd5sm4009545wru.106.2023.10.04.06.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:25:14 -0700 (PDT)
Message-ID: <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
Date: Wed, 4 Oct 2023 16:25:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sj@kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, zahavi.alon@gmail.com,
 stable@vger.kernel.org
References: <20231003164638.2526-1-sj@kernel.org>
 <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
 <2023100445-twisted-everyone-be72@gregkh>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2023100445-twisted-everyone-be72@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_062524_040732_2F45584D 
X-CRM114-Status: GOOD (  18.94  )
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


>>> Hello,
>>>
>>> On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
>>>
>>>>   From Alon:
>>>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>>>> a malicious user can cause a UAF and a double free, which may lead to
>>>> RCE (may also lead to an LPE in case the attacker already has local
>>>> privileges)."
>>>>
>>>> Hence, when a queue initialization fails after the ahash requests are
>>>> allocated, it is guaranteed that the queue removal async work will be
>>>> called, hence leave the deallocation to the queue removal.
>>>>
>>>> Also, be extra careful not to continue processing the socket, so set
>>>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>>>
>>>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>
>>> Would it be better to add Fixes: and Cc: stable lines?
>>
>> This issue existed since the introduction of the driver, I am not sure
>> it applies cleanly that far back...
>>
>> I figured that the description and Reported-by tag will trigger stable
>> kernel pick up...
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

I could have sworn to have seen patches that did not have stable CCd
nor a Fixes tag and was picked up for stable kernels :)
But I guess those were either hallucinations or someone sending patches
to stable...

I can resend with CC to stable.

Thanks.

