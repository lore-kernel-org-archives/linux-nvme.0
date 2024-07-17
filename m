Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EC2C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDhvxRFL01TmuGP+e6JpxksRTlNoy28JVl8Jxjm1K94=; b=UiSQqIt1sIopveIPlLK3ISQy40
	6P8pdwQA/DJ4SOYMcmxXWv6KQg+tFmFm1slwZ1COmO58wfzoLEIAQIfiuDKWMAPNhY/Xxs9sUseyn
	gddjbWHPhpmr3iDZgrUfaG34ez+7Fm1Md58DRTZ5K0FSRZDmMDcKqd+TKGaamLgZdmz7GzGp1AIRc
	nLBfeKWO+UKKkiTL1/XAao8Mv4sQLGbGYgG/k1nqZBXuskScndhwG3hFvjRnFN2faY8mRALsPBuoA
	VVM4pGA5C11pGJ+kpAaqFm/EdmWISgNPt5KPlduJDaCiZ9LTe64Rlb6NflBtzgzOicfWwQ/j3g6jK
	fmNN4VSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBmK-0000000EuaT-4AcO;
	Wed, 17 Jul 2024 21:01:36 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBmH-0000000EuZk-46FA
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:01:35 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427beea4ebaso96945e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250092; x=1721854892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDhvxRFL01TmuGP+e6JpxksRTlNoy28JVl8Jxjm1K94=;
        b=qr2Krsi7RmcgoCV3n1Y8r0/fZ/s92ixAFrLugBrL1qbn3hXPvv5ccOi8/9rUfGY8cd
         rOIvPUTJ/obfq2ztPfSi6mBuBU1cDJRr6Fu4wLYdm7J7VsBk+YoIaiULFmD3j1lOXnjk
         XS+6wERG5jL/GwpAyb6RcXK8dvAQYGYRKevk5BI+wNXwdJH4xB18YfrtLZMZ2e7b3z+0
         s633IFTfAChYg9DmCK7xkzp+qP7QcpsXHLCgeb7eQxX21gxOamExJMf1XZp56Fw6dw4B
         UuFKPITx11ybF0g3i7HboVCJr01fylP6XIty2WcWR0eBIwmufOm8zH8D8xL58pW0WUse
         SHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMHOa58EsqMmg6Ob7HH6ND0XiV7z1igOnb6HxVbljZQuLl0W7KFO8HVjnGeuf73+YSDXzpfcepsWcuMF8TxtFQ2vyVTNUZof7etDrv9FM=
X-Gm-Message-State: AOJu0YyYvT3BYmUqHNEUUtNQKlPCEr7rrbWn31xYtZ9XVSW3DHvLI4d0
	QgMX6oOiMuMO6vJIEwAs9gizT8bDxA76HymClYnKeddqhWq/H4IcQ35Ybw==
X-Google-Smtp-Source: AGHT+IFHsrbVTjyYnKym3gSw3FA5U+E6WUIjA4DuihW2G3qNfC1N1lqgl9jmemHXmblb4MUPi1crkw==
X-Received: by 2002:adf:e5d1:0:b0:368:4e52:5877 with SMTP id ffacd0b85a97d-3684e525bcfmr63643f8f.9.1721250092238;
        Wed, 17 Jul 2024 14:01:32 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77a8078sm10674955e9.18.2024.07.17.14.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:01:31 -0700 (PDT)
Message-ID: <3c7aafde-f08b-4ea2-b017-ceceb842238a@grimberg.me>
Date: Thu, 18 Jul 2024 00:01:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/8] nvme-tcp: improve scalability
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_140134_049558_FEF26E14 
X-CRM114-Status: GOOD (  16.87  )
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



On 16/07/2024 10:36, Hannes Reinecke wrote:
> Hi all,
>
> for workloads with a lot of controllers we run into workqueue contention,
> where the single workqueue is not able to service requests fast enough,
> leading to spurious I/O errors and connect resets during high load.
> One culprit here was a lock contention on the callbacks, where we
> acquired the 'sk_callback_lock()' on every callback. As we are dealing
> with parallel rx and tx flows this induces quite a lot of contention.
> I have also added instrumentation to analyse I/O flows, by adding
> a I/O stall debug messages and added debugfs entries to display
> detailed statistics for each queue.

Hannes, I'm getting really confused with this...

Once again you submit a set that is a different direction almost
entirely from v1 and v2... Again without quantifying what each
change is giving us, and it makes it very hard to review and understand.

I suggest we split the changes that have consensus to a separate series
(still state what each change gets us), and understand better the rest...

>
> All performance number are derived from the 'tiobench-example.fio'
> sample from the fio sources, running on a 96 core machine with one,
> two, or four subsystem and two paths, each path exposing 32 queues.
> Backend is nvmet using an Intel DC P3700 NVMe SSD.

The patchset in v1 started by stating a performance issue when
controllers have a limited number of queues, does this test case
represent the original issue?

>
> write performance:
> baseline:
> 1 subsys, 4k seq:  bw=523MiB/s (548MB/s), 16.3MiB/s-19.0MiB/s (17.1MB/s-20.0MB/s)
> 1 subsys, 4k rand: bw=502MiB/s (526MB/s), 15.7MiB/s-21.5MiB/s (16.4MB/s-22.5MB/s)
> 2 subsys, 4k seq:  bw=420MiB/s (440MB/s), 2804KiB/s-4790KiB/s (2871kB/s-4905kB/s)
> 2 subsys, 4k rand: bw=416MiB/s (436MB/s), 2814KiB/s-5503KiB/s (2881kB/s-5635kB/s)
> 4 subsys, 4k seq:  bw=409MiB/s (429MB/s), 1990KiB/s-8396KiB/s (2038kB/s-8598kB/s)
> 4 subsys, 4k rand: bw=386MiB/s (405MB/s), 2024KiB/s-6314KiB/s (2072kB/s-6466kB/s)
>
> patched:
> 1 subsys, 4k seq:  bw=440MiB/s (461MB/s), 13.7MiB/s-16.1MiB/s (14.4MB/s-16.8MB/s)
> 1 subsys, 4k rand: bw=427MiB/s (448MB/s), 13.4MiB/s-16.2MiB/s (13.0MB/s-16.0MB/s)

That is a substantial degradation. I also keep asking, how does null_blk 
looks like?

> 2 subsys, 4k seq:  bw=506MiB/s (531MB/s), 3581KiB/s-4493KiB/s (3667kB/s-4601kB/s)
> 2 subsys, 4k rand: bw=494MiB/s (518MB/s), 3630KiB/s-4421KiB/s (3717kB/s-4528kB/s)
> 4 subsys, 4k seq:  bw=457MiB/s (479MB/s), 2564KiB/s-8297KiB/s (2625kB/s-8496kB/s)
> 4 subsys, 4k rand: bw=424MiB/s (444MB/s), 2509KiB/s-9414KiB/s (2570kB/s-9640kB/s)

There is still an observed degradation when moving from 2 to 4 
subsystems, what is the
cause of it?

>
> read performance:
> baseline:
> 1 subsys, 4k seq:  bw=389MiB/s (408MB/s), 12.2MiB/s-18.1MiB/s (12.7MB/s-18.0MB/s)
> 1 subsys, 4k rand: bw=430MiB/s (451MB/s), 13.5MiB/s-19.2MiB/s (14.1MB/s-20.2MB/s)
> 2 subsys, 4k seq:  bw=377MiB/s (395MB/s), 2603KiB/s-3987KiB/s (2666kB/s-4083kB/s)
> 2 subsys, 4k rand: bw=377MiB/s (395MB/s), 2431KiB/s-5403KiB/s (2489kB/s-5533kB/s)
> 4 subsys, 4k seq:  bw=139MiB/s (146MB/s), 197KiB/s-11.1MiB/s (202kB/s-11.6MB/s)
> 4 subsys, 4k rand: bw=352MiB/s (369MB/s), 1360KiB/s-13.9MiB/s (1392kB/s-14.6MB/s)
>
> patched:
> 1 subsys, 4k seq:  bw=405MiB/s (425MB/s), 2.7MiB/s-14.7MiB/s (13.3MB/s-15.4MB/s)
> 1 subsys, 4k rand: bw=427MiB/s (447MB/s), 13.3MiB/s-16.1MiB/s (13.0MB/s-16.9MB/s)
> 2 subsys, 4k seq:  bw=411MiB/s (431MB/s), 2462KiB/s-4523KiB/s (2522kB/s-4632kB/s)
> 2 subsys, 4k rand: bw=392MiB/s (411MB/s), 2258KiB/s-4220KiB/s (2312kB/s-4321kB/s)
> 4 subsys, 4k seq:  bw=378MiB/s (397MB/s), 1859KiB/s-8110KiB/s (1904kB/s-8305kB/s)
> 4 subsys, 4k rand: bw=326MiB/s (342MB/s), 1781KiB/s-4499KiB/s (1823kB/s-4607kB/s)

Same question here, your patches do not seem to eliminate the overall 
loss of efficiency.

