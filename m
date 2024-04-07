Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745BBCD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzOqCdNS/7KjSOCIXb9Qh7O9B2xLz1vt61F2iFBcJA0=; b=a9umIL0hPdO+FGt2SrMsXZln+7
	BrT4mpjR5jLDdjpRv5mXvVmW/+bVc4kP0echjZWtiAnLg1lqy1tJZ91N6aQgz5QNdi2keG8iDlpx/
	3p3p3BAhxzzLIPFPZM+3C8zYZ3jrnMBtb7kAHpbmQLFGq8NL2wSx/uYLi1fUJsngtU8Tx2ebPklTh
	MJ9ferYitWBe1CZCauwk9vRTVNOEcqjvsg9M8aUW6/zfY/ZPAoX4gu02gBk48G+Rn9c1sgeoawAKs
	qOaBR1x4AWJwhIXv8W3PebXYNqtRKxHz5VOInnJubs6Nroe+cZbYB06AmVab34Cx8mLIKQ3cwl2A/
	Gx3c+e9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYcL-0000000DPK1-0T58;
	Sun, 07 Apr 2024 19:55:53 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYcG-0000000DPIw-3NJv
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 19:55:50 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34560201517so179039f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 12:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712519746; x=1713124546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzOqCdNS/7KjSOCIXb9Qh7O9B2xLz1vt61F2iFBcJA0=;
        b=XmHmIfgvF/T56FqYUi1XiwNUcthG2su+tFm7bwptqVJOyojpPhl/6j0xp7oPPg1H+U
         /wntk0Zfv+h1yj7ivFolsbjURQB9m/7er5Wx+CmR+6BsauJ3LYC5ZFsAwWqAiK4Rte9H
         opuqBtJC31Fax91mQ2nS0nSP/3S35vhhC+wbtnwBVJTloIaDgpycVeEYk1ATwQwJFB5X
         TtxnEKwMd10wNovFh2t7A+iWwLV69jlexJ88QE/ofnl2zUsgq7dn2A07sSnbvkOLEY9K
         UvG9jAND9XfWEb8mGL3e0MddoZCoFAYDPx8Q7FfQnMgRXY13xWKYWcC82yEJQ5e1zvYX
         pOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlrgOHXzle4phgy8rE3P6oeA82WOkehQZ/Xwis9y+2DbnIonbpFYZE+jblsZcTEZiYK13x50OkelIk6hJbjMZe17DkoNgx+miECZFM6Mo=
X-Gm-Message-State: AOJu0YzW/KKxG+I/lBB6t5oiaiwepLjXw77BCq/K9HCs91u2xrrqqiVD
	QnC8QLKt/m9XhPDv24hdPYBjCo30709pjgXaxDeYvgkIaf1TU+3LKo6sXw8Y
X-Google-Smtp-Source: AGHT+IFOw9RiCx4Vo7GZIMIZMEC0xFUC5n2BzsBdtK4VVBTn9A3eomE9lcqeQoEj/MmkJ74F3c9rJw==
X-Received: by 2002:a05:600c:3b8d:b0:416:6b86:861 with SMTP id n13-20020a05600c3b8d00b004166b860861mr865026wms.0.1712519745527;
        Sun, 07 Apr 2024 12:55:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id je6-20020a05600c1f8600b0041496734318sm14359460wmb.24.2024.04.07.12.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 12:55:45 -0700 (PDT)
Message-ID: <cd732ee4-4a53-46bd-a9f8-92237a3afbaf@grimberg.me>
Date: Sun, 7 Apr 2024 22:55:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240403141756.88233-1-hare@kernel.org>
 <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
 <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
 <ZhAS0YKfV07qlUes@kbusch-mbp.dhcp.thefacebook.com>
 <46e26322-a677-4c27-bc22-e2c65ed9d03c@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <46e26322-a677-4c27-bc22-e2c65ed9d03c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_125548_872434_3B696B34 
X-CRM114-Status: GOOD (  20.81  )
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



On 05/04/2024 18:36, Hannes Reinecke wrote:
> On 4/5/24 17:03, Keith Busch wrote:
>> On Fri, Apr 05, 2024 at 08:21:14AM +0200, Hannes Reinecke wrote:
>>> On 4/4/24 23:14, Keith Busch wrote:
>>>> On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
>>>>> Hi all,
>>>>>
>>>>> there had been several attempts to implement a latency-based I/O
>>>>> scheduler for native nvme multipath, all of which had its issues.
>>>>>
>>>>> So time to start afresh, this time using the QoS framework
>>>>> already present in the block layer.
>>>>> It consists of two parts:
>>>>> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>>>>>     latency tracker
>>>>> - a 'latency' nvme I/O policy
>>>> Whatever happened with the io-depth based path selector? That should
>>>> naturally align with the lower latency path, and that metric is 
>>>> cheaper
>>>> to track.
>>>
>>> Turns out that tracking queue depth (on the NVMe level) always requires
>>> an atomic, and with that a performance impact.
>>> The qos/blk-stat framework is already present, and as the numbers show
>>> actually leads to a performance improvement.
>>>
>>> So I'm not quite sure what the argument 'cheaper to track' buys us 
>>> here...
>>
>> I was considering the blk_stat framework compared to those atomic
>> operations. I usually don't enable stats because all the extra
>> ktime_get_ns() and indirect calls are relatively costly. If you're
>> enabling stats anyway though, then yeah, I guess I don't really have a
>> point and your idea here seems pretty reasonable.
>
> Pretty much. Of course you need stats to be enabled.
> And problem with the queue depth is that it's actually quite costly
> to compute; the while sbitmap thingie is precisely there to _avoid_
> having to track the queue depth.
> I can't really see how one could track the queue depth efficiently;
> the beauty of the blk_stat framework is that it's running async, and
> only calculated after I/O is completed.
> We could do a 'mock' queue depth by calculating the difference between
> submitted and completed I/O, but even then you'd have to inject a call
> in the hot path to track the number of submissions.
>
> In the end, the latency tracker did what I wanted to achieve (namely
> balance out uneven paths), _and_ got faster than round-robin, so I 
> didn't care about queue depth tracking.

Hey Hannes,

I think its a fair claim that a latency tracker is a valid proxy for 
io-depth tracker.

I think that we need Ewan to validate if this solves the original issue 
he was trying
to solve with his io-depth mpath selector. If so, I don't see any major 
issues with this
proposal.

