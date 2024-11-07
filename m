Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7D8D5D672
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FOmBpO65NUUZbynSIJljWcZSxtJSzr/BEmXGDAexTM=; b=XNEv8klbeffxlY4oIL5HciaFLS
	v4kcXCaPtjOQtKa41Sjr7lpk5/4doSw1MAW04VZS2UFFFQxxHUz5Wyaq66mXebiRC2NSwE7TKH1wg
	QMizyvofPiy2W71Am31dYH36hsqh2vC1/Ex4g0JcdsK6bwpSltsXVHyn7O3go1TGyw1brvn8QyWsV
	QQpDNnIx3m6tALWVFekzvW3yk1B25gd0j6H8MVQoWOHECvl+bo+nidZ9v+Jl9JnwcIS5Bz1pyvaqv
	TotRkCwzcpxYEGdjXFFjF02Sck3fK4+k5ki7f7wovtSAxETdfdlXyFEVHU/5dnYw/bao+/P1eqEJw
	LKvF2/pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t96F1-00000007o5D-0N1B;
	Thu, 07 Nov 2024 17:24:19 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t96EI-00000007nvM-1kqK
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 17:23:35 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a9e44654ae3so164912466b.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000212; x=1731605012; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FOmBpO65NUUZbynSIJljWcZSxtJSzr/BEmXGDAexTM=;
        b=AeCsw2K7C6A1clKUgmMtDLLpgMJjJzS+8JfrN1sSpMgaoF1lz6Z/B6uKWZKwHl0O96
         W5GG7O+ArK6c0+nx1GwHIve7HFuzwbIOVyF5uGeWorCuITphNLb26AOrsLEdQky7661l
         i7Yyw3+S98zwaOSz/qcpC8Sq8Yr1xJWaQtJ7TawkCJt/fplVvcG2cnt2AlERjCVutDF2
         3wln7yr6tuMF0j/T03tKq8Qr8qCGI23EukmjpWtPbY962yxBBQLcczidjt6cbFJJk3A6
         cnJAgODbksdXUue+Y/pVrU82Twl4nTexvujPsQ1WN4fxY7ETvDwdJ/SAyGaIch5w/9Ja
         wuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000212; x=1731605012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FOmBpO65NUUZbynSIJljWcZSxtJSzr/BEmXGDAexTM=;
        b=tiwHyUwpoDfLyTahr6nClTJ1+48cjDZ/yt+1/Aijo+eAbZBBMb0EqUKG8qBTEq7bQO
         SsQIjK2TVIxqR3hSzBxJPfO3OvEiiv3KNzlkpIdG0P6FPOwT1ofH/Rnrh3mig9hdMsoX
         L+j5UDBpcRl8aVFtQL2I0kIChW97jtA4ZM5E9Kk+oADgWEOdwRSdsWvVbcY67bfRSZDU
         3P0jsA8nXUt7QAWB12ZRTcsO1e3dQfNo80/1z65pLJ0ntin7iOsEceY8AVaigcLJYV7h
         mBj9hsKgQoLwYn2TTdJyVzzlDTspa9mwUmjeo/3BHVV3DthOdV1osR9yZGW0mCQol5wV
         CInQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJFi0boPPLNCUF7bk/o2g+hPqMDvddzz7cwC6QvPa5aAcjJKz8YlC5f6wPipWBAbSPudKzPL2ysrkq@lists.infradead.org
X-Gm-Message-State: AOJu0Yxpz7R3R5YWq85+Dm9F1ElNVOEhB6FLjj2BpeIEC5nFLShVixGi
	3FVYJalNiiiBqFcI02Mt6ybAe32aaG5N7zs5Sax36/nlA6C8QefP8mySIA==
X-Google-Smtp-Source: AGHT+IGjmKySyNTN/8QcAW8bxivaq94CNWApyrUQEWFwxsq+VaX7hSp+J5pWWeh6pYc6mWGzASLRLw==
X-Received: by 2002:a17:907:6ea4:b0:a9a:dc3:c86e with SMTP id a640c23a62f3a-a9eeb36c852mr77812166b.11.1731000211235;
        Thu, 07 Nov 2024 09:23:31 -0800 (PST)
Received: from [192.168.42.11] (82-132-217-53.dab.02.net. [82.132.217.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def54asm122435866b.157.2024.11.07.09.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 09:23:30 -0800 (PST)
Message-ID: <b11cc81d-08b7-437d-85b4-083b84389ff1@gmail.com>
Date: Thu, 7 Nov 2024 17:23:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] io_uring/rw: add support to send metadata along
 with read/write
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20241030180112.4635-1-joshi.k@samsung.com>
 <CGME20241030181013epcas5p2762403c83e29c81ec34b2a7755154245@epcas5p2.samsung.com>
 <20241030180112.4635-7-joshi.k@samsung.com>
 <ZyKghoCwbOjAxXMz@kbusch-mbp.dhcp.thefacebook.com>
 <914cd186-8d15-4989-ad4e-f7e268cd3266@gmail.com>
 <ceb58d97-b2e3-4d36-898d-753ba69476be@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ceb58d97-b2e3-4d36-898d-753ba69476be@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_092334_490622_643C1EB2 
X-CRM114-Status: GOOD (  45.55  )
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

On 11/1/24 17:54, Kanchan Joshi wrote:
> On 10/31/2024 8:09 PM, Pavel Begunkov wrote:
>> On 10/30/24 21:09, Keith Busch wrote:
>>> On Wed, Oct 30, 2024 at 11:31:08PM +0530, Kanchan Joshi wrote:
>>>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/
>>>> io_uring.h
>>>> index 024745283783..48dcca125db3 100644
>>>> --- a/include/uapi/linux/io_uring.h
>>>> +++ b/include/uapi/linux/io_uring.h
>>>> @@ -105,6 +105,22 @@ struct io_uring_sqe {
>>>>             */
>>>>            __u8    cmd[0];
>>>>        };
>>>> +    /*
>>>> +     * If the ring is initialized with IORING_SETUP_SQE128, then
>>>> +     * this field is starting offset for 64 bytes of data. For meta io
>>>> +     * this contains 'struct io_uring_meta_pi'
>>>> +     */
>>>> +    __u8    big_sqe[0];
>>>> +};
>>
>> I don't think zero sized arrays are good as a uapi regardless of
>> cmd[0] above, let's just do
>>
>> sqe = get_sqe();
>> big_sqe = (void *)(sqe + 1)
>>
>> with an appropriate helper.
> 
> In one of the internal version I did just that (i.e., sqe + 1), and
> that's fine for kernel.
> But afterwards added big_sqe so that userspace can directly access
> access second-half of SQE_128. We have the similar big_cqe[] within
> io_uring_cqe too.
> 
> Is this still an eyesore?

Yes, let's kill it as well please, and I don't think the feature
really cares about it, so should be easy to do if not already in
later revisions.

>>>> +
>>>> +/* this is placed in SQE128 */
>>>> +struct io_uring_meta_pi {
>>>> +    __u16        pi_flags;
>>>> +    __u16        app_tag;
>>>> +    __u32        len;
>>>> +    __u64        addr;
>>>> +    __u64        seed;
>>>> +    __u64        rsvd[2];
>>>>    };
>>>
>>> On the previous version, I was more questioning if it aligns with what
>>
>> I missed that discussion, let me know if I need to look it up
> 
> Yes, please take a look at previous iteration (v5):
> https://lore.kernel.org/io-uring/e7aae741-c139-48d1-bb22-dbcd69aa2f73@samsung.com/

"But in general, this is about seeing metadata as a generic term to
encode extra information into io_uring SQE."

Yep, that's the idea, and it also sounds to me that stream hints
is one potential user as well. To summarise, the end goal is to be
able to add more meta types/attributes in the future, which can be
file specific, e.g. pipes don't care about integrity data, and to
be able to pass an arbitrary number of such attributes to a single
request.

We don't need to implement it here, but the uapi needs to be flexible
enough to be able to accommodate that, or we should have an
understanding how it can be extended without dirty hacks.

> Also the corresponding code, since my other answers will use that.
> 
>>> Pavel was trying to do here. I didn't quite get it, so I was more
>>> confused than saying it should be this way now.
>>
>> The point is, SQEs don't have nearly enough space to accommodate all
>> such optional features, especially when it's taking so much space and
>> not applicable to all reads but rather some specific  use cases and
>> files. Consider that there might be more similar extensions and we might
>> even want to use them together.
>>
>> 1. SQE128 makes it big for all requests, intermixing with requests that
>> don't need additional space wastes space. SQE128 is fine to use but at
>> the same time we should be mindful about it and try to avoid enabling it
>> if feasible.
> 
> Right. And initial versions of this series did not use SQE128. But as we
> moved towards passing more comprehensive PI information, first SQE was
> not enough. And we thought to make use of SQE128 rather than taking
> copy_from_user cost.

Do we have any data how expensive it is? I don't think I've ever
tried to profile it. And where the overhead comes from? speculation
prevention?

If it's indeed costly, we can add sth to io_uring like pre-mapping
memory to optimise it, which would be useful in other places as
well.
  
>   > 2. This API hard codes io_uring_meta_pi into the extended part of the
>> SQE. If we want to add another feature it'd need to go after the meta
>> struct. SQE256?
> 
> Not necessarily. It depends on how much extra space it needs for another
> feature. To keep free space in first SQE, I chose to place PI in the
> second one. Anyone requiring 20b (in v6) or 18b (in v5) space, does not
> even have to ask for SQE128.
> For more, they can use leftover space in second SQE (about half of
> second sqe will still be free). In v5, they have entire second SQE if
> they don't want to use PI.
> If contiguity is a concern, we can move all PI bytes (about 32b) to the
> end of second SQE.
> 
> 
>   > And what if the user doesn't need PI but only the second
>> feature?
> 
> Not this version, but v5 exposed meta_type as bit flags.

There has to be a type, I assume it's being added back.

> And with that, user will not pass the PI flag and that enables to use
> all the PI bytes for something else. We will have union of PI with some
> other info that is known not to co-exist.

Let's say we have 3 different attributes META_TYPE{1,2,3}.

How are they placed in an SQE?

meta1 = (void *)get_big_sqe(sqe);
meta2 = meta1 + sizeof(?); // sizeof(struct meta1_struct)
meta3 = meta2 + sizeof(struct meta2_struct);

Structures are likely not fixed size (?). At least the PI looks large
enough to force everyone to be just aliased to it.

And can the user pass first meta2 in the sqe and then meta1?

meta2 = (void *)get_big_sqe(sqe);
meta1 = meta2 + sizeof(?); // sizeof(struct meta2_struct)

If yes, how parsing should look like? Does the kernel need to read each
chunk's type and look up its size to iterate to the next one?

If no, what happens if we want to pass meta2 and meta3, do they start
from the big_sqe?

How do we pass how many of such attributes is there for the request?

It should support arbitrary number of attributes in the long run, which
we can't pass in an SQE, bumping the SQE size is not scalable in
general, so it'd need to support user pointers or sth similar at some
point. Placing them in an SQE can serve as an optimisation, and a first
step, though it might be easier to start with user pointer instead.

Also, when we eventually come to user pointers, we want it to be
performant as well and e.g. get by just one copy_from_user, and the
api/struct layouts would need to be able to support it. And once it's
copied we'll want it to be handled uniformly with the SQE variant, that
requires a common format. For different formats there will be a question
of perfomance, maintainability, duplicating kernel and userspace code.

All that doesn't need to be implemented, but we need a clear direction
for the API. Maybe we can get a simplified user space pseudo code
showing how the end API is supposed to look like?

-- 
Pavel Begunkov

