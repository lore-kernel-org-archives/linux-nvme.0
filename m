Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F10C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDtho8Qg5tUXMdbdaSokB13XskC1ao9tVGk4/on+IUU=; b=WNfOQkKsWaqtF2vB/NmlaK/0ms
	1bfdhEXRSKieuRmCeAFL2H/shturz8PEygoLr+kH60U2xbbMnqyOrni+too29ZoRdg0NWhR7DAN12
	KikFn6KNr4XW0iUkZBTvswRFQ8XuMj9p43dYoFL7DA5EEDCzuOl6Jm6UCBU0hmA/9CoqcJtSMkjUm
	+fu2zjc32FTLbe3hxSA+IiGvy7rvwREog0xStntryA3rqoE/BNlEeqfj/XHJ0peP49CR4h5yBmfDz
	dG3XLmK2gKzYHUsNC8ITs4Vl4Zn0PjXbFaMj56pmgv8oN20Xr0ImcNRcaK4cXIaQ7lGjg/3y9zYph
	57h7McMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twkwg-00000003hSx-3A1l;
	Mon, 24 Mar 2025 16:46:38 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twkqp-00000003gS6-0T6n
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 16:40:36 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so650461766b.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742834433; x=1743439233; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDtho8Qg5tUXMdbdaSokB13XskC1ao9tVGk4/on+IUU=;
        b=KQvPmfdt9Upam4ZG0Dq1jX7a0w7iR6OaPLDiRsLkJ7qC7S1PGSQXB7vadMgARINkPM
         8ldQs/EW/YRfMejkxNTLG4V3fY/b7zaSImySAs5F3/q7MOuISmvhu3gKNodWyMhVITZO
         2eKy28mxs8i8h42P7WYDr6CbWRe+isOEwHeraG0Y+4JSBBtnh/zAHkLETT9GABGwyplr
         W+UVM8tkUqC+aSXMZ0+n8rdCeDZXx0Z/M4myWKclVuQ/97M0/PUjsKBEEbcDtA3enxJi
         O6/X/UZp+2kMJD/mcYWy7x7sDYHTGPsr1ocb/Xg9kND1uyjkzkjSpJr2jOwVWDshEwT/
         AXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834433; x=1743439233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDtho8Qg5tUXMdbdaSokB13XskC1ao9tVGk4/on+IUU=;
        b=Mh/Xww28YrYwoNFv3wSEcanRZ/YbBfAsJzGkfSY/Py6h30b6MTHJX9U+Ne3LA3M287
         qPiW1I4+RUydETI576aIcb8jrx+5dVDIZlP3LFdptU92AGOzLEmMHOxxd9BKLH2oe920
         04Qmj2dK8IB81XSMvXxIP/hDD+8WcTn678u643hmDXoAVSFWT89+x9LVICRl5tELqvkg
         rncqJkbbsyoIsCEWN3T/7izuikPtk726lXJ04fT7NuucW1s3xU7Bd90C4eBPvrLpOZol
         bBFlJW7PbIdfw7vrl1NACmhYSe8ivOYQdrh/i3GhHYWfayKLQSVCBZPe53t+XPqjvOPb
         oEYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmEh6vACN9j9rdlHk2KOO5hIKk8mvNig2O5QhBjXVpdB2iTFridhUtOvZUpqneZCMr0VqTtFvVupQL@lists.infradead.org
X-Gm-Message-State: AOJu0YxyoJhHD/GfRkpsN7I7jCKn4b4rR/4OALNYRYmiAJICmNPqfCuX
	+pMHf13EH7A5UjBgmA2kIswpCrhft0NMdj8JAI6TCeLHxshYnnZw
X-Gm-Gg: ASbGncs0Ycu5zPEK6NY3bASBkUPE8uyAOoD6lXacutQIIlpponH0Jz8LhqvCNPuG7WA
	BmAH16uKLQNzvBlH2ie/O94i82xWghIsEOBrCr5hlnGb/iCiRvfg+DRfeYsXWf+2881IWIIJBtp
	IgpOfXvWfDNEXb/33cEjfSp/mERjbSwI1ptU6wP5e+orqEl5v6BbnFeUiY8UZvoFludMlmMougW
	VW376521pZTZ3NniMmVqeV0CHAPeH4bciglPF80L9GaECdMNX8tbCMw2UXlpMs5C8irtK4Vs5zY
	Y/SQYn6CNch/rrFgTcpg19qhSk8xhnye+nPAmGK7HyTtg1q3UZSvaDohzAw1qXomaIHl
X-Google-Smtp-Source: AGHT+IH2sbshgb2g3hA15gaE0qcsgQIFZkzMtI/lI5+qTLW5Thn45LTleHIoJg+SzEbs//cdhPE69g==
X-Received: by 2002:a17:907:3e8c:b0:ac1:ffde:7706 with SMTP id a640c23a62f3a-ac3f2285fb7mr1136848666b.25.1742834432587;
        Mon, 24 Mar 2025 09:40:32 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::25f? ([2620:10d:c092:600::1:5023])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd23c7bsm712400566b.150.2025.03.24.09.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:40:32 -0700 (PDT)
Message-ID: <a548f318-9809-4d9f-bac9-a4b83fd6bdff@gmail.com>
Date: Mon, 24 Mar 2025 16:41:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250321184819.3847386-1-csander@purestorage.com>
 <Z95nyw8LUw0aHKCu@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Z95nyw8LUw0aHKCu@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_094035_155343_EC1FA0AC 
X-CRM114-Status: GOOD (  28.65  )
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

On 3/22/25 07:33, Ming Lei wrote:
> On Fri, Mar 21, 2025 at 12:48:16PM -0600, Caleb Sander Mateos wrote:
>> To use ublk zero copy, an application submits a sequence of io_uring
>> operations:
>> (1) Register a ublk request's buffer into the fixed buffer table
>> (2) Use the fixed buffer in some I/O operation
>> (3) Unregister the buffer from the fixed buffer table
>>
>> The ordering of these operations is critical; if the fixed buffer lookup
>> occurs before the register or after the unregister operation, the I/O
>> will fail with EFAULT or even corrupt a different ublk request's buffer.
>> It is possible to guarantee the correct order by linking the operations,
>> but that adds overhead and doesn't allow multiple I/O operations to
>> execute in parallel using the same ublk request's buffer. Ideally, the
>> application could just submit the register, I/O, and unregister SQEs in
>> the desired order without links and io_uring would ensure the ordering.
> 
> So far there are only two ways to provide the order guarantee in io_uring
> syscall viewpoint:
> 
> 1) IOSQE_IO_LINK
> 
> 2) submit register_buffer operation and wait its completion, then submit IO
> operations
> 
> Otherwise, you may just depend on the implementation, and there isn't such
> order guarantee, and it is hard to write generic io_uring application.
> 
> I posted sqe group patchset for addressing this particular requirement in
> API level.
> 
> https://lore.kernel.org/linux-block/20241107110149.890530-1-ming.lei@redhat.com/
> 
> Now I'd suggest to re-consider this approach for respecting the order
> in API level, so both application and io_uring needn't play trick for
> addressing this real problem.

The group api was one of the major sources of uneasiness for previous
iterations of ublk zc. The kernel side was messy, even though I
understand that the messiness was necessitated from the choice of
the API and the mismatch with existing io_uring bits.

The question is whether it can be made simpler and more streamlined
now, internally and from the point of uapi as well. E.g. can it
extend traditional links paths without leaking into other core io_uring
parts where it shouldn't be? And to be honest, I can't say I like the
idea, just as I'm not excited by links we already have. They're a
pain to keep around, the abstraction is leaking in all unexpected
places, and it's not flexible enough and needs kernel changes for
every new simple case, not to mention something more complicated
like reading a memory and deciding about the next request from that.

I'd rather argue for letting the user to do that in bpf and make
it responsible for all error parsing and argument inference, as
in patches I sent around December, though they need to be extended
to go beyond cqe-sqe manipulation interface.


> With sqe group, just two OPs are needed:
> 
> - provide_buffer OP(group leader)
> 
> - other generic OPs(group members)
> 
> group leader won't be completed until all group member OPs are done.
> 
> The whole group share same IO_LINK/IO_HARDLINK flag.
> 
> That is all the concept, and this approach takes less SQEs, and application
> will become simpler too.

-- 
Pavel Begunkov


