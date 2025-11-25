Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0568ED0EE18
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+mYioxWgzcz5tqtizOnI1Ne46KDyU7fg8afEAzl4P4=; b=0q9AVVs2ziHd9g1wXToKR8iWvd
	ihIXLEAudlelwAMIZTOyOGm72NfXevD4hkRNlvpSLSCJu4jqg4sfr90O9XEEnnWbXj5l4SCJIpFq+
	2aBLbkJasuRewuHPc7/e0NLT2rWtsRKSWEqvTL/Hpnm1pQtsvOzj9eblkoo1Es3/mZ7vNB8lifhw0
	S6lWF1Q3X8WqocMMBMTmA7k9G6DpmOWQW8eMy7JbewwaG5cy18BofJiyuFBo4NuCSCSK0VkdVB6bV
	ujlsghFJNZZiqS4T3AdxVox8A6BxUnYneEiNLTlOP5alrJdt2N1xrPTtb5DbISfMguKPola98viji
	r0Fq2D/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNytk-0000000DqYV-2ITE;
	Tue, 25 Nov 2025 19:40:24 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNyth-0000000DqY0-06a3
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 19:40:22 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-477aa218f20so36749065e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 11:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764099619; x=1764704419; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+mYioxWgzcz5tqtizOnI1Ne46KDyU7fg8afEAzl4P4=;
        b=hSc6BVFLhxP+yN3ALwIWLC7wJ0RCyHOF50OE8jxuHTFXhDLOA90N+2N8YQa6pf+eec
         8ohEJj1Wpg8FSfz3tn5Yb0rugfL2x2ch5zVzlrJVb1XCZrbSCUkI2XbJl+cZ1ykFOuqG
         OBzU8XlV9S9v9b7d7cfi8760ubduTvr8YwHIqGgkemz8AXK4/dEj3KFcPWcCASG/g76N
         ZEDVmu8xG6mnR+2eMtuH1dyNfGYUsNM5hjkPF+44Vj5vu9Bg9MNbX41clX8VQpS/ZuMV
         MfcriZ7Rolx5To4YxISa+COwVVxkEMNgTaxbFg9ONqMb7jxljaBXgq3vsJbWIPQhplUn
         xCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764099619; x=1764704419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+mYioxWgzcz5tqtizOnI1Ne46KDyU7fg8afEAzl4P4=;
        b=Z7TcYz5KQC7JvOQc8tNADbUUAV+UD698JVU6Af4gKb19JDLnibx/Hap6i2he5Y4RnS
         VMUOnob1J76/eFwdzQna9b3IHTbA5W9s1vqeANDOOmEc8++L8YT6Sn+p1Nf64DFJHan8
         9iOQ58TbH/i8ZUtm//OlYtkqUWKtW15VNVpppDj3aiQUOOaNVnBvN07Jmt+vV/7LH4SS
         2/uUdvICHcqw2HwJfCpcWfzzqEvjTcjkBBwBg9YhL51K1cMJJEdKh5KyqtH+DtdJTvHa
         uyt2SyvEX9KAAHUyV862ERzUtiRIM3/+VrqTn0L2RwSTST1s3x2/ZqJQvlesvRoOv3dI
         IrlA==
X-Forwarded-Encrypted: i=1; AJvYcCVr7HgRrf7sbUuIVxcyYbUOw2gOAcWynuupv1L8Ck2S29rTkyWiPiyO3RECxLOIR6KK305suWsUskGF@lists.infradead.org
X-Gm-Message-State: AOJu0YyYZ6WcjKwSaS1JGMv1o5+NSKLNzFzqFoLk6pWrTEz29KBF3IDx
	kv52Dad6vc9No9JbRYak6J1iKaEyN8K7OzhPukTnWe0GfNVaKvpoTpbW
X-Gm-Gg: ASbGncuaXBC+dGobnzhs+efHJ6RfrKeDBXkDUhomZ0W2C8uwuk2mxpUpsSCwB9Bd47F
	L4lU7/yAA6UbfySg724GP4BRm6Yf3s3Bo+4uUPO2mS8fRXCARuQy54DQX4GQPqq/f6n7LKNlLsH
	fvpd2D+1Yr/xN1Ot9V/wzIebip6I6IbQ/iujcla6K5LskjqnojCnLQfXIYj7D6svDJyOw9o00PI
	qVAZHDEKqyMQTz/57GkqqNwr/ZTYSm9oV2uxGJKVLjAqalzngFxWck7pGxaY+xMn3AanxLuOclI
	OjtdZ5xYf9YfZEElkL8+kPSntzUXY/dp6IeDy7PkLQzIPl57rN9xxMTtz9asGnVsY3AxujFxBtz
	d3Mw079gwNrJux6YTfVDnn8VYJbZZNtHy1HGv24y77FZ9iNHdVH+2kq49h3ZDkcxslT0ycwUx65
	5jpXYsPuMLDdwEf2qo1Jc2RwuLNxr4HnDaS9fWygk/kBO68B+T3MuQUY2kwqb8sQ==
X-Google-Smtp-Source: AGHT+IFpWZeUDyopyguGNmEbgYIRF/Mo2eq9v5oFLJoUC93zNjBvPZO9k5dPUiOZ58x4X8B/LhlhcQ==
X-Received: by 2002:a05:600c:1c88:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-477c0165badmr197645055e9.7.1764099618711;
        Tue, 25 Nov 2025 11:40:18 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add608bsm5321225e9.5.2025.11.25.11.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 11:40:18 -0800 (PST)
Message-ID: <478ea064-3a2f-4529-81f3-ac2346fe32f0@gmail.com>
Date: Tue, 25 Nov 2025 19:40:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <a80a1e7d-e387-448f-8095-0aa22a07af17@gmail.com>
 <0d0d2a6a-a90c-409c-8d60-b17bad32af94@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <0d0d2a6a-a90c-409c-8d60-b17bad32af94@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_114021_096870_3C6A8B4A 
X-CRM114-Status: GOOD (  24.83  )
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

On 11/25/25 14:21, Christian König wrote:
> On 11/25/25 14:52, Pavel Begunkov wrote:
>> On 11/24/25 14:17, Christian König wrote:
>>> On 11/24/25 12:30, Pavel Begunkov wrote:
>>>> On 11/24/25 10:33, Christian König wrote:
>>>>> On 11/23/25 23:51, Pavel Begunkov wrote:
>>>>>> Picking up the work on supporting dmabuf in the read/write path.
>>>>>
>>>>> IIRC that work was completely stopped because it violated core dma_fence and DMA-buf rules and after some private discussion was considered not doable in general.
>>>>>
>>>>> Or am I mixing something up here?
>>>>
>>>> The time gap is purely due to me being busy. I wasn't CC'ed to those private
>>>> discussions you mentioned, but the v1 feedback was to use dynamic attachments
>>>> and avoid passing dma address arrays directly.
>>>>
>>>> https://lore.kernel.org/all/cover.1751035820.git.asml.silence@gmail.com/
>>>>
>>>> I'm lost on what part is not doable. Can you elaborate on the core
>>>> dma-fence dma-buf rules?
>>>
>>> I most likely mixed that up, in other words that was a different discussion.
>>>
>>> When you use dma_fences to indicate async completion of events you need to be super duper careful that you only do this for in flight events, have the fence creation in the right order etc...
>>
>> I'm curious, what can happen if there is new IO using a
>> move_notify()ed mapping, but let's say it's guaranteed to complete
>> strictly before dma_buf_unmap_attachment() and the fence is signaled?
>> Is there some loss of data or corruption that can happen?
> 
> The problem is that you can't guarantee that because you run into deadlocks.
> 
> As soon as a dma_fence() is created and published by calling add_fence it can be memory management loops back and depends on that fence.

I think I got the idea, thanks

> So you actually can't issue any new IO which might block the unmap operation.
> 
>>
>> sg_table = map_attach()         |
>> move_notify()                   |
>>    -> add_fence(fence)           |
>>                                  | issue_IO(sg_table)
>>                                  | // IO completed
>> unmap_attachment(sg_table)      |
>> signal_fence(fence)             |
>>
>>> For example once the fence is created you can't make any memory allocations any more, that's why we have this dance of reserving fence slots, creating the fence and then adding it.
>>
>> Looks I have some terminology gap here. By "memory allocations" you
>> don't mean kmalloc, right? I assume it's about new users of the
>> mapping.
> 
> kmalloc() as well as get_free_page() is exactly what is meant here.
> 
> You can't make any memory allocation any more after creating/publishing a dma_fence.

I see, thanks

> The usually flow is the following:
> 
> 1. Lock dma_resv object
> 2. Prepare I/O operation, make all memory allocations etc...
> 3. Allocate dma_fence object
> 4. Push I/O operation to the HW, making sure that you don't allocate memory any more.
> 5. Call dma_resv_add_fence(with fence allocate in #3).
> 6. Unlock dma_resv object
> 
> If you stride from that you most likely end up in a deadlock sooner or later.
-- 
Pavel Begunkov


