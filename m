Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44103C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFlcLlIh+EbA0METHTv2hF0/wJWmpDxutHxgXL5+so0=; b=iqwuRLPI58LK9OtMXEghCMbWNP
	aUhTTZM6lPm1/RXpakdhwih7IO2v+ZIJYmrcciDl8So03zgzKl/Du5z6I4Jxg47TWSIwEFm7ZgSdm
	n4tYvSKSjtYMfDA4sV20M5582xFypX583Br12/hQv7TQmebEBolm3fz3zkN5vmMQN5kK9miwnhCxB
	/vFtEvh5xM26MCW9azj7dPWokLbSDrBnNgkFux0pgmmjfZLDX5ZqLCgZzVfIed9pUhg9GHSPMmE4I
	ADGxjVyEgYQsaJ+8Ef/B+v2YzJ5ymB6MqrnJNvYONqhy7OUF+qNEB+jC0akomaJAx93798bt/EPo2
	prambhsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petWL-00F7J7-23;
	Wed, 22 Mar 2023 08:08:33 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petWJ-00F7Hu-1B
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:08:32 +0000
Received: by mail-wm1-f54.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so69632wms.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472506; x=1682064506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFlcLlIh+EbA0METHTv2hF0/wJWmpDxutHxgXL5+so0=;
        b=eBcmwlTSfmXG+K0rEJHzmtpfPwN0GBTqtBSlEGi36FMjQ7mBkJv7TRAcaKOcs0cOYd
         7phmLORpcg61+B7WSiMwPFLl4bN4r+6KeadhMKa3u5Xeefy9AIifoKaf5zlGSUR1dd03
         fIjBwwBPexQnt7xXHgwJ6rOdVGVV3qYmjUkyodp17QMTTYJN5USMuNnOfT5K6q6PYL0h
         eBLOEsCemhxHPJsqDAgXTJdw1M+D/3TxNBx/9/v8xsjB82H8L86hqvC7AGHwLB2E4LiA
         YgDvTX+ah6UIGU93Ct7Z3UwAQ87HbZX8yl2r9XXLawxEKTYz94+aJIbQ6bGOJhsn2F6h
         Yt+g==
X-Gm-Message-State: AO0yUKXFg9Sbt13cQ3Qg3W8UE/BPsGjqMZJ+jhkcSb2XfbnqEoTx6R5H
	e04BFMhR6GY1wImpaM3MVLU=
X-Google-Smtp-Source: AK7set/4b5izfnYGpBdkyBegIFsyBTn9pXl18Dzbv/N/z+Li2SKQ/6YJivmqEe9Xk8QFgnFOolR1hA==
X-Received: by 2002:a05:600c:3b90:b0:3ee:52fb:6dd9 with SMTP id n16-20020a05600c3b9000b003ee52fb6dd9mr1827327wms.4.1679472506383;
        Wed, 22 Mar 2023 01:08:26 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003ee6a91b596sm465633wms.29.2023.03.22.01.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:08:26 -0700 (PDT)
Message-ID: <60d3a645-719a-40aa-959d-f461b0c3eed9@grimberg.me>
Date: Wed, 22 Mar 2023 10:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
 <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
 <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_010831_407949_B58B78CC 
X-CRM114-Status: GOOD (  29.29  )
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



On 3/21/23 16:09, Hannes Reinecke wrote:
> On 3/21/23 14:44, Sagi Grimberg wrote:
>>
>>> Call the original data_ready() callback in nvme_tcp_data_ready()
>>> to avoid a receive stall.
>>
>> Can you please improve the description to include what is the stall?
>> For example, does the stall exist today? If it is, I would like to
>> separate such patches from this set and include them asap.
>>
> That is actually particular to the TLS implementation, as it uses the 
> 'data_ready' callback to produce the data which can be read by eg 
> recvmsg().
> 
> Without this call there's no data to peruse for recvmsg().
> 
> But I'm not _that_ deep into networking details to know whether this is 
> TLS specific or an issue with any data_ready callback.
> I assume the latter, but then again, who knows.

Seems that this is only relevant when nvme_tcp runs on top of a ulp,
so a code comment would probably make sense here.

> 
> Hence the slightly vague description.
> 
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/tcp.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 0e14b1b90855..0512eb289dcf 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -936,12 +936,14 @@ static void nvme_tcp_data_ready(struct sock *sk)
>>>       trace_sk_data_ready(sk);
>>> -    read_lock_bh(&sk->sk_callback_lock);
>>> -    queue = sk->sk_user_data;
>>> +    rcu_read_lock_bh();
>>
>> Now I understand your comment from a previous patch.
>> Can you explain why is this convention needed?
>>
>> I would prefer to have it as a separate patch with an
>> explanation to why it is needed.
>>
> This is the slightly odd socket callback handling.
> Any driver is free to set the socket callbacks, but it has to be aware 
> that it might not be the only one in the stack doing so.
> So one has to be prepared that the callbacks are set already, so we 
> should be calling them prior to our callback.

I meant the change from read_lock_bh to rcu_read_lock_bh and the
same for rcu_dereference_sk_user_data. It needs to be in a
separate patch with explanation to why it is needed.

> 
>>> +    queue = rcu_dereference_sk_user_data(sk);
>>> +    if (queue->data_ready)
>>> +        queue->data_ready(sk);
>>
>> Is the tls data_ready call sync or async? just for general knowledge?
>>
>>
> Sync, I guess. Otherwise we wouldn't be needing the lock ...

OK.

