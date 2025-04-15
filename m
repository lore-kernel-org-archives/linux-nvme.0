Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0792BC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mJGaOlQm2C1mZhFYIn2dFQyjhIvxnFU5z8dsdzJhnCs=; b=fsBwo6s4igby4nRyn61xipiZIk
	PNtMTE6F8okt8e2kRKzo+L7/oeQ0kMpBHwrgltitHuvmgR8MVoFvGTUN+7P7Ys2sXazy6uSKqYAfQ
	C6YExHuBt/8P9SZoIFF53sCRV3MmSBZgZ0ZOSYpIp1JkVAjZk6tIACKdbAtB7kqzzuUNiFrtw1NB1
	sEYTXeclxqmu1ZJvE0QdyHT/f5afn500LWn1ttnKJ16J3RyH2Vwh9LOq1KAsQz5vnyt5XjLiBHxq8
	31xpkR/V4dSDpG9+Y4Z9U5NygLhvXgjZCZ+X09ApWSgyoJE0nJf84rJo3INKU0N3ar7cVbVs8Fxdg
	O3duihVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nwD-00000007Cor-3CIq;
	Tue, 15 Apr 2025 21:35:25 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nwB-00000007CoE-3FSc
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:35:24 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac9aea656so6133168f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 14:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744752921; x=1745357721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJGaOlQm2C1mZhFYIn2dFQyjhIvxnFU5z8dsdzJhnCs=;
        b=BPo2ez2Fwm5OAcKAbZywcssXpwOdo/GTPvKiXbdGiAk3JDDSYLJDvLYZ3t0BzuwXuz
         Yh4n8L5NeUyNnCCNcwYDGDRUG3Zlz0nH0Yoci7enGCxmFGpYy0uKslcWfqXkXEIxcU/Y
         XoyBB52ebs00LKvWFQhI7LfMg68W9eFEO/5Y50jftEfW9Ds6R2ZxsYWmUtjUjJp7Wzzc
         SifXHfwAiCbVU8v5g5pCcGc8b7JE5/y6BFYQIXL+z+iZFi51rtkP3pQ21OUoT5o/14FG
         PXFw5WKQLhQZoqEHzNkx7cJVby7bwRMnqKRuu9BbFcV81jGNVgkVe+Mwmtsu+7P/RGOP
         9bwg==
X-Forwarded-Encrypted: i=1; AJvYcCVij/5gDxKKjbZz4atd7lxq15Cx57Cjvir5Ha4XO6hwnYZMeV8DHU58rynYJMGPdo3gcx2GPo/FiFpQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yymip+UAkkwgDpL//8yakKrRs1ksTk5p1byc+Iewsdx+9WGu7Ac
	Jlss/CDv7v81gf/ExiTq6qqiIVO1pAVDxLKYOaUFea2BtyxowNy5
X-Gm-Gg: ASbGnctUHpvr1rxJuLprZf0KijQX1fs64JpVREjiXkBMcnVXVeSgVePF7ziPLlZWcJH
	uDCgSi/uUc0y7zABznHUwAqk2A7ebqF0+jjpjWDDKOlpEULJ0B8L5HQ9Vc05Tf7SHutiMXTW2EU
	M542nXL0TfmWL2poALbzx+qQErEPziKJh9i6vVMdlQxpUr48ju23/dszNa+sqCcalT8a9unyhqz
	UxtirQPhpKDSovEywd9nZl5b8K0H6fhOaZK3B6E/z0dN/732cb9VWRNkHrig4R/mxLCZekTYBTd
	bk+vSUgdZbGNZOej5GnI40sC8i+s7yzhiLSUF6AtGEI0gmGsDHnSps1B0d5He59OZGAoYvmr
X-Google-Smtp-Source: AGHT+IHhrDNHFZ1LyEefMAISm8r+upqVkTydNNTnmrKRRqPOqtsnTiWONpFHq2eTHq506+RRvTqBIg==
X-Received: by 2002:a05:6000:1acd:b0:39c:266c:12a5 with SMTP id ffacd0b85a97d-39ee27522f0mr759421f8f.13.1744752921384;
        Tue, 15 Apr 2025 14:35:21 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae978018sm15160073f8f.49.2025.04.15.14.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 14:35:20 -0700 (PDT)
Message-ID: <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
Date: Wed, 16 Apr 2025 00:35:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_143523_815930_AA8B2F60 
X-CRM114-Status: GOOD (  23.83  )
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



On 15/04/2025 10:07, Hannes Reinecke wrote:
> On 4/3/25 08:55, Hannes Reinecke wrote:
>> When the socket is busy processing nvme_tcp_try_recv() might
>> return -EAGAIN, but this doesn't automatically imply that
>> the sending side is blocked, too.
>> So check if there are pending requests once nvme_tcp_try_recv()
>> returns -EAGAIN and continue with the sending loop to avoid
>> I/O stalls.
>>
>> Acked-by: Chris Leech <cleech@redhat.com>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 1a319cb86453..87f1d7a4ea06 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct 
>> work_struct *w)
>>           result = nvme_tcp_try_recv(queue);
>>           if (result > 0)
>>               pending = true;
>> -        else if (unlikely(result < 0))
>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>               return;
>>   +        if (nvme_tcp_queue_has_pending(queue))
>> +            pending = true;
>> +
>>           if (!pending || !queue->rd_enabled)
>>               return;
>
> The various 'try_send' function will return -EAGAIN for a partial send.
> But it doesn't indicate a blocked Tx, rather we should retry directly.
> Hence this check.
>
> Unless you tell me differently and even a partial send will cause
> ->write_space() to be invoked, then we wouldn't _need_ it.

Umm, that is my understanding. If you tried to send X and were able to
send Y where Y < X, you shouldn't have to keep trying in a busy loop, 
the stack should
tell you when you can send again.

> It would
> still be an optimisation as we're saving the round-trip via socket
> callbacks.

But you are doing a busy loop on a socket that cannot accept new data, 
there are other
sockets that the kthread can be working on.

>
> We could aim for a different error here, to differentiate between a
> 'real' EAGAIN and a partial send.
> Whatever you prefer.

I still don't understand why a partial send warrants a busy loop call to 
sock_sendmsg...

My assumption is that the call right after the partial send, will see 
EAGAIN error. But I may
be missing something here... I just never expected that a partial write 
means that we must busy loop
sending to the socket.

What does a blocking sendmsg do under the hood? does it also follow this 
practice?

