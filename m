Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA5C36005
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P4HDI5VjdjIs2jVHnIwb1VkXitmTpZuNV3Y614FNy5Y=; b=JlPb0XZN+YnqKIxqSeRNcbIcIo
	EV5BXBo2jCqST9vUwQmmYn5EAmmgbZKcL0fFB7Lza0Ght2A3YGRVbPuKI49hwsDvEGhyBOPaRwdBw
	U11mAHalq/uFooocnwnIC17pUT3wUADpiwL+6bjon9LY59QrvVmUZ2WsGXq7UC0dDGGaj/rXa6Um5
	eIRovbXkhfWIUjTDWH2UnWCRJ3UM3LscH89E2Zql7hABAqntbWoUT5SX/kB5nq+hn5d5Et1AWL7Z3
	CzVm3PZk7EEn2aVqAWrNVz/p8sa3cikgOuj3+WRug0yDX83hqbE9EmONcU1V7ksICaar0XV08h9Ix
	b6EUl6Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvxnS-0000000HO58-2K6j;
	Sat, 22 Mar 2025 12:17:50 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvxnQ-0000000HO4m-1rHw
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 12:17:49 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-ac289147833so274659466b.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Mar 2025 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742645867; x=1743250667; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4HDI5VjdjIs2jVHnIwb1VkXitmTpZuNV3Y614FNy5Y=;
        b=G9y8lzF4yIHkDQZWTVwdGSOM/gB5aT8YmxpKQTOYWUvLI0K3N4S7xC63U2UuJf3Tvj
         natyfWrDOvPvI4aBitUXhsF0ssxzZf5ElKhKPzhxa8N9dEjbgwkp5pz7FTPfffDxaXqe
         jyYAbteVYtYtzfE8KwuKB1dm1QE++lvtDcbaOvM940qNeUVJNLGNzFjkva7OsKSTB8UD
         CbLPsjAf4/kmR0d1MciROzmE46Al6RIS9yUho0sWDZ3lR29x0BBA0Iwc7xc4GWbfq+Im
         bNl5oj9ImzzEROVM2KPXfwsAoN7iQEB1AfcDREHhKz0FTHxqd15CQNvWzSV/ZGVrg01J
         2knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742645867; x=1743250667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4HDI5VjdjIs2jVHnIwb1VkXitmTpZuNV3Y614FNy5Y=;
        b=n2D2SNpNZkYqFMSxxo9uMfe6ZEzhJmj3/NMSOoItGxSbNohnSIg4/pJdHbwiSra0qY
         OULVt1FUehIkAqlPEs/Nk7/Cf5P1WLkWJSXEUOptFZdRGpMC1GzJF6S65I1NOr1gwaIA
         36knAVaOGnGJGb5Eu1E84pnL0sNdTwB//vAlP3OmBCFMVpNqJ6ItMJPd6MOwer7qB4fz
         2Q/NrsbzbkGI2lnMNjiv0a+0RtShdblX5hMQHnXgVQD4T0AxWItohgUnOcEK9nytyKfz
         2Kv603ZSPW75scYMV5OSAyu8FTbxhAvAsMXc58bgZemvLqvq2DvCWi6SXffR1DtQIl+N
         hJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCW7bfKBy6ajEQc/sXQK58ZlAIbwDzFMtXvihDYOvL5C2K6EONzInCGfzoCAT0p/saLPXGPmWkOJXvYf@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1COa8mZq5Zw53ENDp+Q7hfI8xMM51nwmqHHyIPyEqRmgQjr20
	VYo12QWTATFgDOySACULJsWFwzVbf7guXT4xyvvzUQhWlq1IocWvSZyGqA==
X-Gm-Gg: ASbGncsDyF3CdfIkwi7A+vZusMAWRcqVvDwco0829AbJdUB2xzcOLXOaw5O0CkUfAgh
	eLxhOxgrPgULZfBHPIfeKWV3TGiXIs9d7LgBFf72ca4B5OF0edj2m3rE5W3lqxQqlw87OhIli91
	d0pQcEVcNhRgJnmqvue/lc3FMvfeE8zM0DXor5rl4fqe0V6yVvD1ch36FkchsR2laUaYbNf2a+6
	fUQBJJ1uDU2QZ41GRmepyaNnApy6wTZUtysftKnOLDaJIxwe6HInd9dO0j73cWkMejXnn7kTEgB
	LaTM/7UylOdRFEK2CKF8Rr2FIp5TYFwsEqWRyB8dYuGch1EdTOhF
X-Google-Smtp-Source: AGHT+IGTuEpHZ1J0PVeUKZ2VvqMGPeVTC2axbdt19OYrJw3swztReYqCcwl8lgFmgDWsSvmvtEHqpg==
X-Received: by 2002:a17:907:c5cb:b0:ac4:2b1:56cf with SMTP id a640c23a62f3a-ac402b17f6bmr376798766b.30.1742645866479;
        Sat, 22 Mar 2025 05:17:46 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.234.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd569fesm336941466b.173.2025.03.22.05.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 05:17:45 -0700 (PDT)
Message-ID: <68e33a48-8a77-4c49-824f-902187a4aacc@gmail.com>
Date: Sat, 22 Mar 2025 12:18:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: import fixed buffer before going
 async
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Xinyu Zhang <xizhang@purestorage.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-4-csander@purestorage.com>
 <8338ac70-ed0b-4df5-a052-9ab1dfec9e26@gmail.com>
 <CADUfDZoELiri8Fuq3tHSsKf1XhPVaZ1eoCzfXK7g994VY4o9Vg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CADUfDZoELiri8Fuq3tHSsKf1XhPVaZ1eoCzfXK7g994VY4o9Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_051748_483272_84606E00 
X-CRM114-Status: GOOD (  23.08  )
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

On 3/21/25 21:38, Caleb Sander Mateos wrote:
> On Fri, Mar 21, 2025 at 1:34 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 3/21/25 18:48, Caleb Sander Mateos wrote:
>>> For uring_cmd operations with fixed buffers, the fixed buffer lookup
>>> happens in io_uring_cmd_import_fixed(), called from the ->uring_cmd()
>>> implementation. A ->uring_cmd() implementation could return -EAGAIN on
>>> the initial issue for any reason before io_uring_cmd_import_fixed().
>>> For example, nvme_uring_cmd_io() calls nvme_alloc_user_request() first,
>>> which can return -EAGAIN if all tags in the tag set are in use.
>>
>> That's up to command when it resolves the buffer, you can just
>> move the call to io_import_reg_buf() earlier in nvme cmd code
>> and not working it around at the io_uring side.
>>
>> In general, it's a step back, it just got cleaned up from the
>> mess where node resolution and buffer imports were separate
>> steps and duplicate by every single request type that used it.
> 
> Yes, I considered just reordering the steps in nvme_uring_cmd_io().
> But it seems easy for a future change to accidentally introduce
> another point where the issue can go async before it has looked up the
> fixed buffer. And I am imagining there will be more uring_cmd fixed
> buffer users added (e.g. btrfs). This seems like a generic problem
> rather than something specific to NVMe passthru.

That's working around the api for ordering requests, that's the
reason you have an ordering problem.

> My other feeling is that the fixed buffer lookup is an io_uring-layer
> detail, whereas the use of the buffer is more a concern of the
> ->uring_cmd() implementation. If only the opcodes were consistent
> about how a fixed buffer is requested, we could do the lookup in the
> generic io_uring code like fixed files already do.

That's one of things I'd hope was done better, and not only
specifically for registered buffers, but it's late for that.

> But I'm open to implementing a different fix here if Jens would prefer.

It's not a fix, the behaviour is well within the constrained
of io_uring.

-- 
Pavel Begunkov


