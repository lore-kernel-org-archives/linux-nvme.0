Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14DDC197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Du7QBubrlGXfNigw4iC7kl1XS5hi1xvWO3QSD5CM42U=; b=c2+zhkwgbdn3R7RtyZVJ8c8w1S
	qFPeCn1TPHOXwk4pio18nt5y1nkgcfCOYbpRn6ph+5nTDNm3PO1/Addx9XR48h7fgnAnWRD0vec45
	9kn+bs9LZ8rF8rA58mr2itnb0/Bw0l//X6awgnGzItSQr6v7G1svlDIv+j79Rs0rkdWJqhzpqDwaA
	zCELwRR2sUCjAhDPpVc6Me8aoVarUg7LZ0a+Tby+rHOlrt/ZpH66Jq5dMNHg9MBBfqOvl3RyRBtBt
	ceAXpj+5+a41BDadbMyOXr4twGURZ2zQ5izBOb9rHC/B32F+RVt0lVsMJwS3XVR+4YOvseyi3DklM
	RcZshH6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r55DU-00CH5i-1v;
	Mon, 20 Nov 2023 14:25:36 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r55DH-00CH2P-04
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 14:25:29 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-408fd07bb78so4092285e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 06:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490320; x=1701095120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Du7QBubrlGXfNigw4iC7kl1XS5hi1xvWO3QSD5CM42U=;
        b=agTpfMklFlt/zZlQSn+CL+x6s4YQtvztiJUHYYV/jMeghXi4TNXJ5wOlIpQhm5dXQ5
         7Ey1yvmAyJVpXw79sGqplsLlY+WEuErXs3OkhveGgZ0oK6VRaeB8S8sEzZfbdmUo37wj
         hG7aAQe5DWn8TqZ+monVkEE/Kne/UVsKAvsIqYsrQ1ZDV3Tx7vTr1swsakFdJdvqIHHU
         7OmEv26zBNZ0vJRZCZp0q2ZvgZrzqRx9mjrMMU5ZFrN9+QXS5D8U1wLrF2zsk+rTyg1F
         M+l5qNN+AmGbl8hEdmHS9gdbkZIqIutYrVeFMHZ0VX3FI5ZH0VnJJXOJTrWnrb8wIhKG
         vtTg==
X-Gm-Message-State: AOJu0YyMMrzI6vwmcnLBiHIenqdCBHeEA0ybORL2FUjeT/ktypw/mkxY
	wO0268PxHBfSMbAC/9u3bSJxt76ws7o=
X-Google-Smtp-Source: AGHT+IEQ5i59Ba/Y1BJmzjLilKCSIRAiifvZKZehacHaRpfYT0Jy2YIIghiT5e9f9L3UFn7OmKN0Nw==
X-Received: by 2002:a05:600c:1d18:b0:404:72f9:d59a with SMTP id l24-20020a05600c1d1800b0040472f9d59amr6349473wms.0.1700490319588;
        Mon, 20 Nov 2023 06:25:19 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b00405959469afsm14008438wms.3.2023.11.20.06.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:25:18 -0800 (PST)
Message-ID: <828693f2-1aa5-416a-9d9c-e1a1e9edcf2c@grimberg.me>
Date: Mon, 20 Nov 2023 16:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
 <3b2164c7-961e-4cfb-bff9-517e7b77fd61@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3b2164c7-961e-4cfb-bff9-517e7b77fd61@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_062523_061762_5798E2E3 
X-CRM114-Status: GOOD (  22.53  )
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



On 11/20/23 16:19, Hannes Reinecke wrote:
> On 11/20/23 14:39, Sagi Grimberg wrote:
>>
>>> Setting up I/O queues might take quite some time on larger and/or
>>> busy setups, so KATO might expire before all I/O queues could be
>>> set up.
>>> Fix this by start keep alive from the ->init_ctrl_finish() callback,
>>> and stopping it when calling nvme_cancel_admin_tagset().
>>
>> If this is a fix, the title should describe the issue it is fixing, and
>> the body should say how it is fixing it.
>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/core.c | 6 +++---
>>>   drivers/nvme/host/fc.c   | 6 ++++++
>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 62612f87aafa..f48b4f735d2d 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>>>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>>   {
>>> +    nvme_stop_keep_alive(ctrl);
>>>       if (ctrl->admin_tagset) {
>>>           blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>>>                   nvme_cancel_request, ctrl);
>>
>> There is a cross dependency here, now nvme_cancel_admin_tagset needs to
>> have the keep-alive stopped first, which may be waiting on I/O, which
>> needs to be cancelled...
>>
>> Keep in mind that kato can be arbitrarily long, and now this function
>> may be blocked on this kato period.
>>
>> I also think that now the function is doing something that is more
>> than simply cancelling the inflight admin tagset, as it is named.
>>
> Hmm. I could move it out of cancel_admin_tagset(). It means that I'll
> have to touch each transport driver, but as I have to touch at least
> fc anyway I guess it's okay.
> 
>>> @@ -3200,6 +3201,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl 
>>> *ctrl, bool was_suspended)
>>>       clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
>>>       ctrl->identified = true;
>>> +    nvme_start_keep_alive(ctrl);
>>> +
>>
>> I'm fine with moving it here. But instead, maybe just change
>> nvme_start_keep_alive() to use a zero delay and keep it where it
>> is? will that help?
>>
> Not really. We still will fail if setting up I/O queues takes longer
> than the KATO period.

Why? Is this specific for non-tbkas? or very short kato?
because connect is effectively a command that should be counted as
indication that the controller is fine.

If you are not able to connect even a single queue, I'd say something
is wrong and it could be argued that you _want_ to fail.

