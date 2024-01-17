Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488C2C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smBRC0fGIjV7NVWRRSnbObc9QKfnzsw9Zntd5C5Qdwo=; b=oDL+hLcY6+MaX3i6CLf/i/ELX6
	MHVaf9qdEHRw0ms6eGgoZCARRB6tzYHhPxcHeT+UIHXrQBQyHo1PP7ozukRzrYMDc2n6ayckTooJc
	/VVQZJk1CEd+4tafRjVUPC5EFQgx7D3FnLJLoLzQJnc1UxVzouYTLgSqZXSLjGKsHfOyx/k7d/QiB
	m4J1LsnhVc9GN3QwkacLWSJYENGmzcEG/tYSr4t8RiMh6vSE7Nmmj1tfTvfn8dckmSedci6teM0hd
	e/D5bHND6Xo/dFfx9Dc1XMMS18nnC3SFGMj3KuISa1JmiJnL+WkfXUExtM9/lcknFgifXH0GQQQYS
	77tl2vew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDej-000pGG-2y;
	Wed, 17 Jan 2024 21:41:05 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDeg-000pE1-0P
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 21:41:04 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so58647139f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705527657; x=1706132457; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smBRC0fGIjV7NVWRRSnbObc9QKfnzsw9Zntd5C5Qdwo=;
        b=yEuEyyd0EmXPsg8Nc56Axc4Yyohw3hrtSOSea3rbhq5X4EIX9E8yzLyjHn1Bd6vtMD
         EkHvWErQGypNECW5m4PwrTJUPvPj2+tRsxa7siXr3pcwTZNbQH4A/dlompxRI++Mc0zn
         ig28wRumVrgPyCxA1+b3KrAYtfSqY+z/rsDQIuq9TsZV3v8KxWwjgHPXO5wM03uCAs25
         WkoBuMaWlpdDyTibnzi5Hp83xVVBE0jHEczzyxQbWsHHsf47xqYqcDHxbcchNmfcGBBC
         CDq5iy+eCuZ1pQ1etzNnbbemb1r3kLWjKMif4AgjR/iJIfPG4wesMKFdadkaqPscrKst
         HMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705527657; x=1706132457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smBRC0fGIjV7NVWRRSnbObc9QKfnzsw9Zntd5C5Qdwo=;
        b=KV081SBiD977+nIBR8HmknecxidWqqxelAZ+h1t47o3cVPpo5z2DAgjMvSPVvwdhmJ
         2QfivrENPvi5i8aCovYPS0xJ7sMX4JeV+al8DutFzwt/xaFyElSKegCQYt5Y5fm6OIn5
         U6FDe8/Wm4EGUNuKKpzWhnnTOU1a/tNjYAsyjXkGgxtXFwvnS3ECo1uhEjN6IeYGWhgj
         EtAdj/cx8qRj7vaMwwMB90TqTyiCje1BNq1lAIHOwhn7vrx3N+Gf9Sw4hkDaxtyjvP6C
         KDUa2bSoEBFTYEQIxDZlDeO3Spzn84WdrP79NzxFsttyhYPNN7qIW6aFiitsP86iXI16
         8RcA==
X-Gm-Message-State: AOJu0YzZIB8Lfvt6qUwxqKa736Wg2UGFieSoNv02bRVC6/DohCTRPXrZ
	wRKW+1pxeCnKi/Faw/tP4tRz0CF09BLL4cf/7cZHZHn5Narv5Q==
X-Google-Smtp-Source: AGHT+IEFCB+mlkil6mSwJtj1E/FwGBlpCCSuAEtTZsOEEjRvUWlgz2WoebfbWy1i24fq79CojzvXCw==
X-Received: by 2002:a6b:5803:0:b0:7bf:4758:2a12 with SMTP id m3-20020a6b5803000000b007bf47582a12mr9490867iob.0.1705527656920;
        Wed, 17 Jan 2024 13:40:56 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a05663811c100b0046b451e7b57sm614364jas.45.2024.01.17.13.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:40:56 -0800 (PST)
Message-ID: <90de77e4-ed8a-47be-b5df-2178913ec115@kernel.dk>
Date: Wed, 17 Jan 2024 14:40:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
 <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
 <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
 <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
 <e8c32676-114b-4aaf-8753-5a6d7b04fc4b@kernel.dk>
 <86a1f9e6-d3ae-4051-8528-13a952cf74a1@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86a1f9e6-d3ae-4051-8528-13a952cf74a1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_134102_166328_8F857966 
X-CRM114-Status: GOOD (  16.83  )
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

On 1/17/24 2:33 PM, Bart Van Assche wrote:
> On 1/17/24 13:14, Jens Axboe wrote:
>>   /* Maps an I/O priority class to a deadline scheduler priority. */
>> @@ -600,6 +604,10 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>       struct request *rq;
>>       enum dd_prio prio;
>>   +    if (test_bit(0, &dd->dispatch_state) ||
>> +        test_and_set_bit(0, &dd->dispatch_state))
>> +        return NULL;
>> +
>>       spin_lock(&dd->lock);
>>       rq = dd_dispatch_prio_aged_requests(dd, now);
>>       if (rq)
>> @@ -616,6 +624,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>       }
>>     unlock:
>> +    clear_bit(0, &dd->dispatch_state);
>>       spin_unlock(&dd->lock);
> 
> Can the above code be simplified by using spin_trylock() instead of
> test_bit() and test_and_set_bit()?

It can't, because you can't assume that just because dd->lock is already
being held that dispatch is running.

> Please note that whether or not spin_trylock() is used, there is a
> race condition in this approach: if dd_dispatch_request() is called
> just before another CPU calls spin_unlock() from inside
> dd_dispatch_request() then some requests won't be dispatched until the
> next time dd_dispatch_request() is called.

Sure, that's not surprising. What I cared most about here is that we
should not have a race such that we'd stall. Since we haven't returned
this request just yet if we race, we know at least one will be issued
and we'll re-run at completion. So yeah, we may very well skip an issue,
that's well known within that change, which will be postponed to the
next queue run.

The patch is more to demonstrate that it would not take much to fix this
case, at least, it's a proof-of-concept.

-- 
Jens Axboe


