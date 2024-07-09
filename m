Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91312C2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 07:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUv2+NrWujwe8BVkD9DgfeEYs8ucJpa3kx7QKzhfrgo=; b=PLtnCnpdYfKyffn8gmNAT7L3gY
	nmqJGBEWg2XlL8UBPmP9yTL1nntJgYmcjFIKIBHAhdPk2SRZsus0u4QPCtSCh7EUmP+MTfTiLwpO2
	Wvl0AvmDt70oHyhAapWcl2pq4ph7SysrqMZq3WpEE9Wo9Yy/XALVnuD2L4j2OdjA8QjpYozWxTXXk
	q749acrzL7j8rz8hLOtzI4OiiU6d4cbJg9emkloPNjq3Yp+DlUr8EqmunlwQ73NZvfzNa2xAQ3D+2
	knq8DnHviS7rQ7pAB08o6qeEYmaK4YFph80tBz+vyQxq01TmGslmDoIrTOt4qkUQ3njHE23Q4ihjA
	WgdXXtSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4vc-00000006BSP-1xQ2;
	Tue, 09 Jul 2024 07:06:20 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4vZ-00000006BRZ-2FB3
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 07:06:18 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-426719e2efeso728115e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jul 2024 00:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508776; x=1721113576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUv2+NrWujwe8BVkD9DgfeEYs8ucJpa3kx7QKzhfrgo=;
        b=qOdZISVZhkyHSMfueYNxd+g6y++UweSKhy6Fr3T86/Fv8tThUZ1zPUEL2MU1OCnwzu
         HMKKJEQ7Ea+knTk/D7hOFEu98TqQtGHyO0wbh4sShnzbkuzEh/RFJkGwtwqvuJ0jDLY1
         HJKjCxREDWNM8FK7RzxYoHwsTSAJXIIlqTcM8PuiGu5GiQxOsV4Py1xPm9j/LEsyKUyg
         TwbxjWsppNcILmXtMR2NIjEDjz875ACP7hCyaxaAMB3H8Zzkp8B+/UpBjjVn1HdDn9f8
         ONWZFHJgHhoONVkFFxd5rjWWO6OQjz1+sR1sZvhIXZVYzeHu+6HQX8CRVDGqIyHBrXmg
         KMjA==
X-Forwarded-Encrypted: i=1; AJvYcCXeeJ08I4lxik4VnzNOD4LW2HwEVBQJ8x1flvbuDD0J+yfXLGy6/xBPTX76u2Cvso5P8xpi/6E+YQZkl0NNiDFxNs/09U1t0Ms7QhDKkYg=
X-Gm-Message-State: AOJu0Yz5fAos19s2TM1g97XocSojr48Yfy+tnR3BUrXMnxUj1znXuO0d
	fr0Aa2t4JYY5JZHIL7Ut1Vg0UOeRSkUUFFDhsPdOmaWyMOW7/nDNBhAltUox
X-Google-Smtp-Source: AGHT+IEcM7gqGBpRsxO3e6ufFDqOMHoW89mms9DMpv5GYkn6ulijmq0AMhcSykFkdBKu4ckEb/Nlzw==
X-Received: by 2002:a05:600c:3b16:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-426708ff5c6mr10339965e9.4.1720508775488;
        Tue, 09 Jul 2024 00:06:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f1182sm26022765e9.14.2024.07.09.00.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 00:06:15 -0700 (PDT)
Message-ID: <7fb81dc1-1921-488a-9b8a-f48ba3f59f6b@grimberg.me>
Date: Tue, 9 Jul 2024 10:06:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-2-hare@kernel.org>
 <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
 <a54ac72e-f04f-4bb7-a9de-5a3d3d71d9c6@suse.de>
 <5334b2dd-23ab-4637-a762-e871f884db54@grimberg.me>
 <7d52a56b-2311-4f64-a0f4-383c5521e91c@suse.de>
 <8013f402-4831-46c3-b207-c08821c15760@grimberg.me>
 <7b5006e7-9df3-4ee3-a2e9-0ce091c21434@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7b5006e7-9df3-4ee3-a2e9-0ce091c21434@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_000617_596348_25604666 
X-CRM114-Status: GOOD (  17.07  )
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



On 09/07/2024 9:51, Hannes Reinecke wrote:
> On 7/8/24 21:31, Sagi Grimberg wrote:
>>
>>
>> On 08/07/2024 18:50, Hannes Reinecke wrote:
> [ .. ]
>>>
>>> Weellll ... if 'SOCK_NOSPACE' is for blocking sockets, why do we 
>>> even get the 'write_space()' callback?
>>> It gets triggered quite often, and checking for the SOCK_NOSPACE bit 
>>> before sending drops the number of invocations quite significantly.
>>
>> I need to check, but where have you testing it? in the inline path?
>> Thinking further, I do agree that because the io_work is shared, we may
>> sendmsg immediately as space is becomes available instead of some 
>> minimum space.
>>  > Can you please quantify this with your testing?
>> How many times we get write_space() callback? how many times we get 
>> EAGAIN, and what
>> is the perf... Also interesting if this is more apparent in specific 
>> workloads. I'm assuming its
>> more apparent with large write workloads.
>
> Stats for my testing
> (second row is controller 1, third row controller 2):

Which row? you mean column?

>
> write_space:
> 0: 0 0
> 1: 489 2
> 10: 325 20
> 11: 28 1
> 12: 14 1
> 13: 252 1
> 14: 100 12
> 15: 310 1
> 16: 454 2
> 2: 31 11
> 3: 50 1
> 4: 299 42
> 5: 1 19
> 6: 12 0
> 7: 737 16
> 8: 636 1
> 9: 19 1

These are incrementing counters where ctrl1 and ctrl2 got the 
.write_space() callbacks?
What are 0-16? queues? I thought you had 32 queues...

>
> queue_busy:
> 0: 0 0
> 1: 396 2
> 10: 66 18
> 11: 91 8
> 12: 56 14
> 13: 464 7
> 14: 24 15
> 15: 574 8
> 16: 516 9
> 2: 22 29
> 3: 56 5
> 4: 153 99
> 5: 2 40
> 6: 18 0
> 7: 632 5
> 8: 590 13
> 9: 129 2

What is queue_busy?

>
> The send latency is actually pretty good, and around 150 us on 
> controller 1

150us for what? the average duration of sendmsg call alone?

i.e.
start
sendmsg
end

> (with two notable exceptions of 480 us on queue 5 and 646 us on queue 
> 6) and around 100 us on controller 2 (again with exceptions of 444 us 
> on queue 5 and 643 us on queue 6). Each queue processing around 150k 
> requests.

Are you referring to the above measurements? I'm having trouble 
understanding what you wrote...

>
> Receive latency is far more consistent; each queue has around 150 us 
> on controller 1 and 140 us on controller 2.

Again, latency of what?

