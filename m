Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D129C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxfHcY1pOTCPS1MeaDBnQh2Hmf8LizWSClrR0oEQfT0=; b=lzX9ZMFtFqV2QkDc7n6ylk2eyo
	TmGE72ETKjgZzhePCXjTuCOwuzBI4JR8UdFUl4/7V2/4ICm5j49doLhYnv7wj29OeWCkFC6PyT/ay
	gpiUqpDPy6whefLbnnA1s419ZMtpNX9dani6VsPEr1vBeWW8i7B7kL5f5jzuRiwrqJ7qDWqDja+la
	qpcX4m3Kd6KeMecPhZbLMj/1qXEpxK1pjssMHXAwdIpxG0emyRYCd+JyB4NMjHBtcmNpislPvzIpQ
	LSNDTWNGX9FdZRLRwrKKD4cvzK5ISLzTnVIhlXmQ77sP4sxzNCv7r/rQ9jmQzlYKDTbGe6ddQJ4hS
	tw9Uv0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riX8x-00000008gP8-1Q4r;
	Fri, 08 Mar 2024 10:07:59 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riX8v-00000008gNA-1esR
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 10:07:58 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso629042f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 02:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892474; x=1710497274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxfHcY1pOTCPS1MeaDBnQh2Hmf8LizWSClrR0oEQfT0=;
        b=QlFLuJ6aPy78Mm5Osf5Wjxu53XyF5zh0Wt2PLKiT+EOJuIKhhDIt0JlM5XlUzQJkXQ
         0LpmYSzPP7Ht6XIj8sNCLay14ET3w/RpggCfJc7at+Ru/Fsvb8XNSIDQIIsiIODRCC+M
         fadEB1oFwstVDSiskUkAbYxcZut9qGZFFZcSdZBT8ezlvIcVsgEGn0e2BQ5rQOPQmay8
         q16PxaeTG80+G5/eRBnTEB9vhLtcHZBYMHOY/11F1HQfLgNkDUxNBuucnNgXqx6yoOUx
         LhNLUEJx3Z8LEiAfGwAlxRlASLvKV+c8ZjQdGU1YC7NlGsgAvYgcYPvtQC1bGIGzU9zE
         CDbg==
X-Forwarded-Encrypted: i=1; AJvYcCVldlferht9L0meyT4GilI13klSJwxjkdgKRMRZKQSxibdykIJucsaZ4Ap3oLJOUJ1uaGRjWAeqy4pP+zv5b8i8kOwZscfDEwtfw9ttPlo=
X-Gm-Message-State: AOJu0YxqcafbDdSPBL1pCeopMEXYlYX/vpkIZRsGDqT0WEyDHZhHmXWE
	BzHozk16bmkddq8wuXK3cpkkNSpAGqXK5JrutyCR/RWY1zAHUCmo
X-Google-Smtp-Source: AGHT+IE7fWdp7E/WunqzOXM48JPLVuFBsvpVcscPa1rCjr957g/P3espLhhGA71FVhcKqlIcVpRbNA==
X-Received: by 2002:a5d:6e04:0:b0:33e:6a7d:41b8 with SMTP id h4-20020a5d6e04000000b0033e6a7d41b8mr1069422wrz.5.1709892473918;
        Fri, 08 Mar 2024 02:07:53 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ba27-20020a0560001c1b00b0033e68338fbasm3537593wrb.81.2024.03.08.02.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:07:53 -0800 (PST)
Message-ID: <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
Date: Fri, 8 Mar 2024 12:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_020757_470627_8E5EF3D8 
X-CRM114-Status: GOOD (  22.98  )
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



On 08/03/2024 11:15, Guixin Liu wrote:
>
>> unlike abort, preempt-and-abort needs a semantic guarantee because 
>> the consumer
>> may rely on this for fencing purposes. So it cannot be supported in 
>> "best effort" I think.
>>
>> A possible implementation would be not to abort as there is no such 
>> interface, but
>> nvmet may wait for all pending ns IO to complete and disallowing new 
>> IO to come in
>> (using percpu_ref_kill and percpu_ref_resurrect on ns->ref). This 
>> won't work very efficiently
>> withALL_REGS reservations though.
>
> Hi Sagi,
>
> I found that if we return an error when the call to 
> percpu_ref_tryget_live(&ns->ref) fails,
>
> it might cause hosts that still have permissions to interrupt their 
> IO. Additionally,
>
> preempt_and_abort itself holds an ns->ref, we cannot wait the ref to 
> become to zero.
>
> The solution I can think of is to add a "per-namespace" percpu_ref to 
> the controller for
>
> counting IO issued to a particular namespace by that controller. Then, 
> during the execution
>
> of preempt_and_abort, we wait for the count of those preempted and 
> unregistered controllers
>
> to drop to zero.

Yes, that is what I had in mind as well. Obviously the ns->ref cannot be 
used for this purpose.

>
> The nsid is user-specified, so we can not use array to store the 
> per-namespace percpu_ref,
>
> this will increase lookup overhead if we use xarray.

Yes, that is tricky to get right.

>
> What do you think Sagi? Or may be we can declare that 
> preempt_and_abort is not supported, just
>
> like SPDK does.

It can definitely come incrementally, but at the very least it should be 
incorrectly supported.

Out of curiosity, doesn't your use-case need a fencing protection 
against inflight I/Os reordering during
preemption?

