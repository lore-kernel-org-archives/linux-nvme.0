Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825F8C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 21:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W3ORrbxbnsaKbtgUtZE17IRhJEx3eT2R+M8sXqR8BR4=; b=izROvop+ZW61QYzt2RchR65VY4
	UrunpeFo9vi4GUCRdcishuClAMuWLVojRHUBsLx6f9dlbwIupagjg8QbSFwIFsufGp6rexh4LtPj1
	GEoD2nIf98wcrgzf7ck3UVnNYv6unB43ffBg8v+cP8KgZrbKiMFQGex8WBUZ1qfJ3kRuf1jXLJxck
	rAylFzMxlauLG+DCr3MYDrX/6Podqgn0l441y09izqkcMtCLuZ6w4Ao3sVvfeHAG/g+IfV1SdrkKh
	vKnoOjmXPbskOB7anvqEA/JwsmI5k9Si5PYtjnlcGnwV8fV5rVrk6gLj+hYy/tYu/TL0MEhZvSwYU
	dEXFQS8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwQW-0000000GsR3-3SV8;
	Mon, 08 Apr 2024 21:21:16 +0000
Received: from mail-ot1-f49.google.com ([209.85.210.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwQT-0000000GsQN-1wFR
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 21:21:15 +0000
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e681fad78cso1220555a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 Apr 2024 14:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712611270; x=1713216070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ORrbxbnsaKbtgUtZE17IRhJEx3eT2R+M8sXqR8BR4=;
        b=YE9TjOCPJJCbKdmeLclr4RviYpwqRC7/GlCvsOurdhSGnQdkkkwQ2Ucl2IcKmgWyP7
         gpehMgcJSjvPCvN5az09cQwfC+BVOhv/MX1EyFQCUlExEtYps/WEAdnSWDXoQmCWlb+K
         3ghfuZnncQ/iVYF9b/cqNNFCuTwkDzLayA8kHdd4wAiaVMrfuBIGM0eLZe13kK7VYMLM
         Kr7TNjTh3ObWaBTfqw8pBBw5cuQBAXt+OoYgTkhanUUI/G1TjzVUUVvhY61pKguboxcg
         IDnX7velbtFZkOnEGcay3RQrkQ9NrwPiub5QeIYVL2yAAW6xegZUS4G7l0Asc1BaVuFD
         dgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvQ1m56t8NOmc9ugfv9c8jRF5NdIw3fTiecM9ebJ/P3fy8f1APr4BuWEOT892ZQMdJ9k8e81byjcLARNEyrEWgLMVk6i0bX7B4puXtJcU=
X-Gm-Message-State: AOJu0YxYdoL4+qFfQzU+GCwdMKBBULuVy7wxtTEyL8WLEG5SjkC7nagD
	2ZG8YMbIZprULGAJpu9ch9/FQyJ42NPW5lj8Ifqhh71IB9Jw6Z+F
X-Google-Smtp-Source: AGHT+IE0z8b/piB2F0PqM2zKX59y7wtTTOzd1gaxBVHQkov7ehhrLFrtiz0ojBBuUk7AGakpvoqoRw==
X-Received: by 2002:a05:6808:603:b0:3c5:f534:e2c7 with SMTP id y3-20020a056808060300b003c5f534e2c7mr3741199oih.1.1712611270404;
        Mon, 08 Apr 2024 14:21:10 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bm9-20020a0568081a8900b003c5f3426753sm520383oib.13.2024.04.08.14.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:21:10 -0700 (PDT)
Message-ID: <ad9eb876-061b-4f85-9c6f-add1719b72c8@grimberg.me>
Date: Tue, 9 Apr 2024 00:21:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] nvme-fabrics: reset connection for secure
 concatenation
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-13-hare@kernel.org>
 <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
 <a1395ee5-fbff-47ef-9400-56b8f3a0d1f5@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a1395ee5-fbff-47ef-9400-56b8f3a0d1f5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_142113_549388_EC01EA03 
X-CRM114-Status: GOOD (  24.54  )
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



On 08/04/2024 9:21, Hannes Reinecke wrote:
> On 4/7/24 23:46, Sagi Grimberg wrote:
>>
>>
>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>> When secure concatenation is requested the connection needs to be
>>> reset to enable TLS encryption on the new cnnection.
>>> That implies that the original connection used for the DH-CHAP
>>> negotiation really shouldn't be used, and we should reset as soon
>>> as the DH-CHAP negotiation has succeeded on the admin queue.
>>> The current implementation does not allow to easily skip
>>> connection attempts on the I/O queues, so we connect I/O
>>> queues, but disable namespace scanning on these queues.
>>> With that no I/O can be issued on these queues, so we
>>> can tear them down quickly without having to wait for
>>> quiescing etc.
>>
>> We shouldn't have to connect io queues here. The scan prevention
>> is just a hack...
>>
> Oh, believe me, I tried. What _should_ be possible is to create a
> controller with just admin queues, and skip the io queue setup part.
> But once you do that it's impossible to create io queues after reset
> (which is what you'd need here).
> I tried to fix this, but that ended up with a massive rewrite/reordering
> of the init path. Which sure has its merits, but I deemed out of scope
> for this patchset.
>
> So I decided for this 'hack', and shelved the init path reorg for a
> later patchset.

Interesting that it requires a full rewrite. Can you share some info
what particularly breaks when you change the nr_io_queues between
resets? nr_io_queues can be changed across resets from the controller side
as well.

>
>>> Once that is done we can reset the controller directly
>>> after the ->create_ctrl() callback.
>>
>> Why not set opts->nr_io_queues = 0 for secure concatenation and
>> setting it to the original value before resetting?
>
> See above. The io tagset is allocated in the init path _only_.

ok. So? What is the issue here? is this because ns scanning is checking
the existence of a ctrl->tagset? I predicted that this check will be 
problematic
to assume the ctrl state in the future.

We can add a controller flag for this.

> And creating of the io tagset is tied with connecting the io queues.

Where exactly?

>
> The reset code requires the tagset to be present; it just reconnects
> the io queues.

it connects io_queues if ctrl->queue_count > 1

> So either you do some trickery here like skipping connecting io queues
> (or, indeed, skipping namespace scanning),
> or you end up with a massive reshuffling of the init code path trying
> to separate tagset creation from io queue connections.

Hmm, I'm not exactly sure what separation exactly is required here.

