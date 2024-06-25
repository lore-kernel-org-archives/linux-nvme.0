Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DC1C30653
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S503bXwUZwsbLHG3rT3ocKN+gymdm8bTViNCtB1nafQ=; b=xtyywi4rxyiacgthZlsexOGzTd
	zOMVFTkYU1QYk+wr3K0upcyWGYWBCVJ1mtvfMILoVe4OgwSexFZtaeDz+FwCoXrvaJKE6HZ6mlgh2
	aRWZWtpuvXwm8sAhkkJbFwYBMmKkxw/z/OUU5x0+GMwJ1/bCx2rpb/D/vLRcRjVnHLk0NxNevYiKS
	vugH6IvX+YmFdIc1pURZ+qXZaugeTpX5tdyrRf/EWaLxNzVTFwKRqPETB8L8ois3yO+VFolE4pdFZ
	5nXhZuIAmEfYaPLPW2AyAY3zj1fHmtsFVQ0i7l4gxeXSLxSY2zbQQ4PMXLYeyOOZdpaFCCQEbuFzd
	5E/gejTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM025-00000001qSM-1hDo;
	Tue, 25 Jun 2024 06:52:01 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM022-00000001qRu-2e7s
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 06:51:59 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42111cf2706so6452595e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 23:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298317; x=1719903117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S503bXwUZwsbLHG3rT3ocKN+gymdm8bTViNCtB1nafQ=;
        b=YtKvMfsSR6ng+sUv3WKlS7rhfzSZxnlsueTFzvNhqtQMj+tI+MdRPe8RHZBKhifTKQ
         yOMHAslqB2b7KpUOSv4wF3NuXvqJlJX4LFPrIL47+XR2Js/swekwfWJXfON+VQ6SaDYq
         Ps1OmaDI+qN9gVEDspS8uQgI3lBWY/WCRB726izIRd1ffhYgKtHs4INPlUcb7RBkU3f3
         lCmdJnjQniAjxSthr3O2mNWti2RnEWeEFebU4ficw9dhEeIYTliNv1q91nlnjZSEaVxX
         5gQJoG56iPahzz7sCX21KnqSPk/Jy0i453gMLZiVO1oQlXX63DIBWLQmWkKZ3iJPLb6w
         8EaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbNxa9DL7yS63bQxSf5buQXJef1qy3sWO3+aJ7Gk8TdOk8K/gcDLajsSuVRM/3WBy+JxC4yKSjakjquGT/B2fOV7QgaYxlGsVdTSRPwY8=
X-Gm-Message-State: AOJu0Yy9UWxhIsC7/bLISxtoShv59+fLG3Ft6EVcCxkl/uHWftcaFeru
	O0pxlx48CFJkxCW0j/8FH2QnV3TfyTASbBrpLJxS4NKPiRDGNQUCJdgFlQ==
X-Google-Smtp-Source: AGHT+IFQgSdzaKbWpOVjQ7fNmr+O48i4Bqkr6TnGjw1b3d0KZfOnW9Vht/tGyHpJi+7lWFB3SpYdDw==
X-Received: by 2002:a05:600c:3b8d:b0:421:de31:76 with SMTP id 5b1f17b1804b1-424891aa2a7mr57214285e9.3.1719298316594;
        Mon, 24 Jun 2024 23:51:56 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b5554sm164124015e9.26.2024.06.24.23.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 23:51:56 -0700 (PDT)
Message-ID: <08cb20fb-f5dc-430c-957b-0c9f57e21ff7@grimberg.me>
Date: Tue, 25 Jun 2024 09:51:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
 <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
 <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
 <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
 <bf241d6c-3123-4047-b393-32eb46f692fe@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bf241d6c-3123-4047-b393-32eb46f692fe@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_235158_705499_AAFF7390 
X-CRM114-Status: GOOD (  15.13  )
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



On 25/06/2024 9:05, Hannes Reinecke wrote:
> On 6/24/24 12:02, Sagi Grimberg wrote:
>>
>>
>> On 19/06/2024 18:58, Sagi Grimberg wrote:
>>>
>>>
>>>>> I see how you address multiple controllers falling into the same 
>>>>> mappings case in your patch.
>>>>> You could have selected a different mq_map entry for each 
>>>>> controller (out of the entries that map to the qid).
>>>>>
>>>> Looked at it, but hadn't any idea how to figure out the load.
>>>> The load is actually per-cpu, but we only have per controller 
>>>> structures.
>>>> So we would need to introduce a per-cpu counter, detailing out the
>>>> number of queues scheduled on that CPU.
>>>> But that won't help with the CPU oversubscription issue; we still 
>>>> might have substantially higher number of overall queues than we 
>>>> have CPUs...
>>>
>>> I think that it would still be better than what you have right now:
>>>
>>> IIUC Right now you will have for all controllers (based on your 
>>> example):
>>> queue 1: using cpu 6
>>> queue 2: using cpu 9
>>> queue 3: using cpu 18
>>>
>>> But selecting a different mq_map entry can give:
>>> ctrl1:
>>> queue 1: using cpu 6
>>> queue 2: using cpu 9
>>> queue 3: using cpu 18
>>>
>>> ctrl2:
>>> queue 1: using cpu 7
>>> queue 2: using cpu 10
>>> queue 3: using cpu 19
>>>
>>> ctrl3:
>>> queue 1: using cpu 8
>>> queue 2: using cpu 11
>>> queue 3: using cpu 20
>>>
>>> ctrl4:
>>> queue 1: using cpu 54
>>> queue 2: using cpu 57
>>> queue 3: using cpu 66
>>>
>>> and so on...
>>
>> Hey Hannes,
>>
>> Did you make progress with this one?
>
> Yeah, just trying to get some performance numbers.

Nice.

I understand that you took my comment above about spreading the
queue->io_cpu assignments to different cpus from the mq_map for
different controllers?

Plus, it would be good to understand the performance implications without
the softirq_rx patch, to see the performance implications of this patch 
alone.

Aside from that, I'll be also interested to see the performance 
implications of
the softirq_rx change.

>
> Cheers,
>
> Hannes


