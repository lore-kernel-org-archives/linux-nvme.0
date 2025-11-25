Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C536FD0E6E9
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=; b=VrYkrAHUJ88ym++VCoIigzYAsW
	rFFkC23TwNK8oJxQP/3P0x1AejlEbsCPztm03Sq7bp69kkDhgULTtS8+hUL+b+3+hMpD0QXiLAUpV
	W1pmTYoBdgWeHtp5pWJ/p6jxIjJzPnu4RFnXdv9ckodYfquvoambhDlB8E7bqCq0GAsb0Hf+GYC8E
	pYcsmqfgRclfaGj4Q6CNqjsx/vJQAg/CmJm4C6RoZj5D0L7HsB6K3bkvxFaoznOdDYNkeO2zfshNF
	bv1mt9oiyaval0JDFxQhwmuDUALjlI0sVBTlyFO7ygIHKKRE4S1CgwjjqVQHHLqxYeVCAYQJ5DvfO
	9TIBq5OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNtT1-0000000DNQF-34h3;
	Tue, 25 Nov 2025 13:52:27 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNtSx-0000000DNPt-1n7k
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 13:52:26 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so4524035f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764078741; x=1764683541; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=;
        b=dFbYJsyVRzX347uJHcA9oq30+HPB9+gklJ7bQbGvuf65hwcpyBv7sGtxvTlL/t0UhN
         Vi61di5yIXyGVeI1PYi/YtHQWX3zC05+YghWSKIfnZdC+2FXBIz3P6OF0Gl0UECRmENw
         Vgqc8bNaCGtGsRiNC20kjA3P/bL9b7NhXdeKsWiDhbKqiGDiFDJuIxo2mJesYwvV/9+X
         3DKnfmRkQyjAGiu2Njko6uBvCKXjgDhTorRxKJ0KmhkBpYWs49aLfkm8H10z5UTcxGEL
         TinztcH0Sjl4+PUWOrHrUPAY2xmhGXw5oJdHmqMKX4srqT3Og4nSMz/Qq6fm1ndjdOKJ
         duTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078741; x=1764683541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=;
        b=eZNiUVQAu+3pPZM1FadGj6pncE3ATRKVFBx8eqUq2+3YtTHyctN3O2SD3+sv8Fb2+3
         vfdDchAlKOK3u6919duxFJI1wRdtw63r/GL0cblY0pS+m28wF9SK0+K3hOsbt6451Vyv
         rdBXzWBrs/WPh7eRGXmydeU4OAGhXT/KobGEmPk1Ufc0zAJFDrptJfNFXNwZetP4DBCW
         6VMaGdiuREwfwCrt0Ld4St9L78800cARR91qEGavEDcgB0DRyOR+yJalEGFAl7emqhBl
         IiYvuBIng2yzO5cVYM3phjW9Qj3F1lgJ6MhxIN3bMj97eBIVfqoDDyUIm+0uUD8Ak6ja
         z+4w==
X-Forwarded-Encrypted: i=1; AJvYcCXr+V6VhfHZAtutjPkYDpDi8nj3zNCey5fQIZIp+eUxbQfck3maB3XtIp5e105OUq6oFTcbn66MUCIc@lists.infradead.org
X-Gm-Message-State: AOJu0YwRGJpEA1HkFmD6FddIX+9ohd0tUTIsWHo0nsupYpXgRA+I/ZNH
	Y2f5gVUVDXyBRUgdM25Wv6cTt+KVktB4qhLGAKBtpI8jSEK+9f0/dmlY
X-Gm-Gg: ASbGnctCughnOfCimzLdr4TRFYN9ArAEDlNLOEmHdWMPfomkOGrzYHcMnkZkOEefnFZ
	ZORZ1GUEIlOu5K/4RaUMi52JncSDiT+skQvH9OIv8Yxy8r2+gGMb47f0KGu7K/Na2g+U7HZ/hHO
	vcEFcZJ8aqlahtD4rRox1s9sVWUIhm44WolcGTBEFSq88ykuNp26jPqEO+JfONS2o0v+Ve1AjKl
	9IRR/M7Sp3BVJSZhOUYhoyRqoZv4UOZWDAxKXhJaYuWx3BCjTnbU5/zskZ4wRiZjBvmrjLEZwUG
	xQtgWigiBoNfHf1e752s3MUg5zmAoU6mbdqlVZOq6pdG/Dp9XBrvqvOsdlRgnreIVE3agFcl60O
	MQTsleKrS3kHTDv3m0jCPFPTnLLGaWpxKvk+toOIGhGLjQYw4OcIyqLE7SQYhNYjMMQJ9IuYjBX
	octcH29otouYaBiPub0u4EbkPv9OmQ54VYE4CrY1XmZc41o2ZJdLOp15q27FVFpxuldnsR2Ag3
X-Google-Smtp-Source: AGHT+IFKl0FSWbmMlOH9ZWfAZWRSmX8BD6ohJLnDHz1PIktPZZElxLDCt4b4SkoYMkjbJJn+KqrIYg==
X-Received: by 2002:a5d:5d81:0:b0:42b:3ded:298d with SMTP id ffacd0b85a97d-42cc1d2d5ebmr16251211f8f.32.1764078741365;
        Tue, 25 Nov 2025 05:52:21 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm35280457f8f.26.2025.11.25.05.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:52:20 -0800 (PST)
Message-ID: <a80a1e7d-e387-448f-8095-0aa22a07af17@gmail.com>
Date: Tue, 25 Nov 2025 13:52:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
 <905ff009-0e02-4a5b-aa8d-236bfc1a404e@gmail.com>
 <53be1078-4d67-470f-b1af-1d9ac985fbe2@amd.com>
Content-Language: en-US
In-Reply-To: <53be1078-4d67-470f-b1af-1d9ac985fbe2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_055223_491491_5AC66B0F 
X-CRM114-Status: GOOD (  27.40  )
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

On 11/24/25 14:17, Christian König wrote:
> On 11/24/25 12:30, Pavel Begunkov wrote:
>> On 11/24/25 10:33, Christian König wrote:
>>> On 11/23/25 23:51, Pavel Begunkov wrote:
>>>> Picking up the work on supporting dmabuf in the read/write path.
>>>
>>> IIRC that work was completely stopped because it violated core dma_fence and DMA-buf rules and after some private discussion was considered not doable in general.
>>>
>>> Or am I mixing something up here?
>>
>> The time gap is purely due to me being busy. I wasn't CC'ed to those private
>> discussions you mentioned, but the v1 feedback was to use dynamic attachments
>> and avoid passing dma address arrays directly.
>>
>> https://lore.kernel.org/all/cover.1751035820.git.asml.silence@gmail.com/
>>
>> I'm lost on what part is not doable. Can you elaborate on the core
>> dma-fence dma-buf rules?
> 
> I most likely mixed that up, in other words that was a different discussion.
> 
> When you use dma_fences to indicate async completion of events you need to be super duper careful that you only do this for in flight events, have the fence creation in the right order etc...

I'm curious, what can happen if there is new IO using a
move_notify()ed mapping, but let's say it's guaranteed to complete
strictly before dma_buf_unmap_attachment() and the fence is signaled?
Is there some loss of data or corruption that can happen?

sg_table = map_attach()         |
move_notify()                   |
   -> add_fence(fence)           |
                                 | issue_IO(sg_table)
                                 | // IO completed
unmap_attachment(sg_table)      |
signal_fence(fence)             |

> For example once the fence is created you can't make any memory allocations any more, that's why we have this dance of reserving fence slots, creating the fence and then adding it.

Looks I have some terminology gap here. By "memory allocations" you
don't mean kmalloc, right? I assume it's about new users of the
mapping.

>>> Since I don't see any dma_fence implementation at all that might actually be the case.
>>
>> See Patch 5, struct blk_mq_dma_fence. It's used in the move_notify
>> callback and is signaled when all inflight IO using the current
>> mapping are complete. All new IO requests will try to recreate the
>> mapping, and hence potentially wait with dma_resv_wait_timeout().
> 
> Without looking at the code that approach sounds more or less correct to me.
> 
>>> On the other hand we have direct I/O from DMA-buf working for quite a while, just not upstream and without io_uring support.
>>
>> Have any reference?
> 
> There is a WIP feature in AMDs GPU driver package for ROCm.
> 
> But that can't be used as general purpose DMA-buf approach, because it makes use of internal knowledge about how the GPU driver is using the backing store.

Got it

> BTW when you use DMA addresses from DMA-buf always keep in mind that this memory can be written by others at the same time, e.g. you can't do things like compute a CRC first, then write to backing store and finally compare CRC.

Right. The direct IO path also works with user pages, so the
constraints are similar in this regard.

-- 
Pavel Begunkov


