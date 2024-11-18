Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15B1D591AA
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVO8qk3DSHDvk4oNuHMVMR5RvZCXGNXgG4n2Q5ZEl4o=; b=YdASlAYlsf7Z03uqiVoF0D/NGS
	YBLLZ26CQi80iWjxMT/lYwxnX0X+kjDCHzXEfnzVhELvMGjpwCwvhWFNa4q8Mpz9DMRzI8zTiLQXF
	SISnGnVbDGDXyGJStxbSUiIC/OIHOto730DiLTvBGeeMcIjtk7/hNU/ei7ldEiszLvFJ3fAgqBzOU
	Hnd+bkUYnWbZJ5lWwK+w0CA0KjNIr1A90MSv5ePUnTibUbbLXlYwybTDiKbuv/2deEIYngJPmeFS9
	0CLQjqj1PQ11o6F98PpH5ncr9gD/GzwxNl3l8oN9N04yvs9wO2nm9gUJ+dJ/NaOnWAXtmtnUlMnz2
	GZV7VNsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD5nO-0000000AF98-3Kl9;
	Mon, 18 Nov 2024 17:44:18 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD5nM-0000000AF8O-1DqL
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 17:44:17 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3000958e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731951854; x=1732556654; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVO8qk3DSHDvk4oNuHMVMR5RvZCXGNXgG4n2Q5ZEl4o=;
        b=nhryfoHb1tebeYpur2p+gGojF7MoQ3FB922eP2nmHkHZ7bzkSzMfDm8FJ+aHK/tSZx
         Tz6L6XiaqT7KB5GJBPrkXouNGLydl1qf8gn+DNUgRoC5OoF2Fry265D17Xoo7S4n/LA6
         lt74CAxjELGKPnJ35EP3oMw6WLwaHdB9uvU7ya/NR2UjGPgpkAcWLPltEx4SFXEEMc7G
         qz8Jr/4vqOpUjpJjF/KBFwGJjjNmd8d6t4CJ7mxGzHDD9KlqtUvqFJEmcjQb7k2VPgm+
         1SPOpkk10fr+Aw+YmXrOTf8WAqycZFoY+bdgsomGvyNrjTFntpQGGvU00h+tCDPqWWIQ
         FOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731951854; x=1732556654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVO8qk3DSHDvk4oNuHMVMR5RvZCXGNXgG4n2Q5ZEl4o=;
        b=WV7AAfU7ejtX2GIi1TTLpt5d94wQwXZBkDKQTPQeS4pcg8wYNCcw1PaOqEr5qoGo7s
         iuRtmGbMrerzS9/cy3gaQnSRjyy02Q6iH7iUWEKSpoJo3cf6KN3MegdoXzHtgEdp+DE3
         tYvmLOprnIMkjpmxUwOXYMzFkB0g3FEv3j+gWyu177+RZa/uL9YRKxmtqXBnC3xXxhnN
         HI3gpbB1tUz5euNo8OCsvGXSxC7KNIHxTW0LnDC8AqEjDeWUzzFLvQixRCEOrnVdR0Mp
         27Ukhy+9zR6aAYXqspMBiOGwhrM4KM64zbNvyb7f6wo88naNAnG9urMaPsJxaVCUlbAW
         U3aA==
X-Forwarded-Encrypted: i=1; AJvYcCXDvJ9GsGTS6mFucEK7TNwl3O35Ii2lZwZJiY7lmTB4TWUISse/A7HpkWoXXiAD8JntZT00PGDyRvdf@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9oUgEMlR38GVTVvefUp/q4KzHvxdwBs7f7uiWgpwffxkcvuJ2
	hmyZvR5DrPZGh88mtopqHzYSvpUgvKIaRmLs2bfA+6ZW9LLu/aM9
X-Google-Smtp-Source: AGHT+IE8deZQbEFmLxsNjvaQHppwSiVlfb/JcEO8eBT8Er4XhuZQWQlwrAn+B4VtBktpYvCn9ldPGA==
X-Received: by 2002:a2e:b896:0:b0:2ff:566e:b597 with SMTP id 38308e7fff4ca-2ff606fb54fmr81123891fa.38.1731951854002;
        Mon, 18 Nov 2024 09:44:14 -0800 (PST)
Received: from [192.168.42.187] (82-132-219-237.dab.02.net. [82.132.219.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e045270sm561214266b.146.2024.11.18.09.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:44:13 -0800 (PST)
Message-ID: <4f5ef808-aef0-40dd-b3c8-c34977de58d2@gmail.com>
Date: Mon, 18 Nov 2024 17:45:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 martin.petersen@oracle.com, anuj1072538@gmail.com, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
 <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com>
 <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com>
 <20241118125029.GB27505@lst.de>
 <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com>
 <20241118170329.GA14956@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241118170329.GA14956@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_094416_334401_D574B328 
X-CRM114-Status: GOOD (  21.40  )
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

On 11/18/24 17:03, Christoph Hellwig wrote:
> On Mon, Nov 18, 2024 at 04:59:22PM +0000, Pavel Begunkov wrote:
>>>
>>> Can we please stop overdesigning the f**k out of this?  Really,
>>
>> Please stop it, it doesn't add weight to your argument. The design
>> requirement has never changed, at least not during this patchset
>> iterations.
> 
> That's what you think because you are overdesigning the hell out of
> it.  And at least for me that rings every single alarm bell about
> horrible interface design.

Well, and that's what you think, terribly incorrectly as far as
I can say.

>>> either we're fine using the space in the extended SQE, or
>>> we're fine using a separate opcode, or if we really have to just
>>> make it uring_cmd.  But stop making thing being extensible for
>>> the sake of being extensible.
>>
>> It's asked to be extendible because there is a good chance it'll need to
>> be extended, and no, I'm not suggesting anyone to implement the entire
>> thing, only PI bits is fine.
> 
> Extensibility as in having reserved fields that can be checked for
> is one thing.  "Extensibility" by adding indirections over indirections

I don't know where you found indirections over indirections.

> without a concrete use case is another thing.  And we're deep into the
> latter phase now.
> 
>> And no, it doesn't have to be "this or that" while there are other
>> options suggested for consideration. And the problem with the SQE128
>> option is not even about SQE128 but how it's placed inside, i.e.
>> at a fixed spot.
>>
>> Do we have technical arguments against the direction in the last
>> suggestion?
> 
> Yes.  It adds completely pointless indirections and variable offsets.

One indirection, and there are no variable offsets while PI remains
the only user around.

> How do you expect people to actually use that sanely without
> introducing bugs left right and center?

I've just given you an example how the user space can look like, I
have absolutely no idea what you're talking about.

> I really don't get why you want to make an I/O fast path as complicated
> as possible.

Exactly, _fast path_. PI-only handling is very simple, I don't buy
that "complicated". If we'd need to add more without an API expecting
that, that'll mean a yet another forest of never ending checks in the
fast path effecting all users.

-- 
Pavel Begunkov

