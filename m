Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071E8D49218
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIHQ6zw2SwAGAZpX8HboX0m6HmdtC+TFe3sA6WTGEfg=; b=wy9Z+ghmjH8X/pX/oZzojJrQkh
	m/49fKJluBlUTPgmo9hnpmX1Q0tsQOsNIz11y8m+yGzg7cHmPijl4ISlIc9I8PFnLksWqCyWcdweB
	nwigohAn0YtMxeGZDjYMZlE7c9e11VCR2VEQPBYy/BiUato/X6XCfu8/fkcHVP6xUWqaYxwAm5uUo
	Afxdv4YlIzpz/SlzcWG1/9C8dS0JAvXFlHtkezQELna9H5u+JJRaMigHpRcWsm776hT/hxJyiDEK3
	t6fSifY6AFbzk3Z1xB08qwOHTLKa2Uufw7doTowQqkJXrCyeHonwWL54eMoaD/5UvMLMNdthdrDdz
	vJCVhmWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU1wl-00000000VMv-2Zcr;
	Fri, 12 Dec 2025 12:08:31 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU1wj-00000000VMX-48OI
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 12:08:31 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so9746755e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 04:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765541308; x=1766146108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIHQ6zw2SwAGAZpX8HboX0m6HmdtC+TFe3sA6WTGEfg=;
        b=XQGh9PSaiHKBy7ooTQMdmYEFHFJ+c045Wi4Mczck8a+EZwPJ4zgMFEEdnOgrmrqe+G
         zyMoYJ8APJImw7diXen6a8TAUJJxE0XHMu+WlW+7t5JHQxwz8PHkY/qpQ+lyttIVTGpr
         an7oRQiJMh1QDv1SHhtdn6CNEjohlweuvmCBSxC+Q60UU4lJ5blm+rBvyJQADHVFAeHF
         jAbC3ssYxQ7QJwCyMu0FvSibfdOZOM84NKVvrUgRqsjgwl/0m6xtnaB5kFoS9jRmNdw6
         0hKn1lo7rd0YP40LkBpiRWk5KvG/aP+hwSpDI556GxItq9VMJVw7jDgXdx6ZhNKYxiKK
         8kIg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Azk6kwFm956BoAutRY6gXMbmdPGrgt6yDEPgqlCISKAfayBJ/Viz7yPGNqTyKSuHxZOfCsQ3ENmJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yxo9TdtavvOBH3cek4tgV6HNXtcU5Qxlwdetcs98ncDVQtMBp0p
	0hD02CdxRBbn7fsZaNixP47xZTkRxNwE8nQH7o6rzA5QNr+s3XnggZCg
X-Gm-Gg: AY/fxX6LoRG4TqMLZCvVlO9Lc5JTfLmhWq9oX2wmCNZpr9prssD0ejZoaCsJ2lGbGil
	zhcRZgSXDPMBbTY1RmVf2d764cvKieQBwa+5WpR1ACiDaWgEo9dh5I+p1V4ypZNsr/jtVqUlq74
	eQmLcx3xo2aejd0OanZcIOHMCrgZVlb+NuMXg4dSojDFAVcx/wHBh8pGw0ZAhnklBD7opX4JZdE
	6+p5SK5CgQct9KcZwQw3asJZJWJZngPGX/VbqoYT6FTBtp2+IgFiO0J/iL24L/nCcgt8oxDMB/Z
	rN4izgg+ysg7o+5hnIOieIa4nLFIiNbmLS+GNPYmtSi8+FNpskbbOuJJ1boZ63V/ZjPo9w93X/9
	X5xG0H2fkhgXl67ColkKUSBzxVILcl1NJ3QVf94BKXNKOOpbwR6vRfgswFeh03t+6kdJWolD5nJ
	33f3BipyYHgz5Wr2eug8TM2GkCvtY2QY9DQjJq/lT0vgYRYQ==
X-Google-Smtp-Source: AGHT+IEd4xQYNFOEz0hDDyYM/pq12513ZZcMOuiSBAUYTyOLjaSudDr8cDHiev8z8c6HBDj4hA2B4A==
X-Received: by 2002:a05:600c:3d96:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-47a8f907a60mr19419715e9.19.1765541307839;
        Fri, 12 Dec 2025 04:08:27 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f775012sm27845595e9.7.2025.12.12.04.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 04:08:27 -0800 (PST)
Message-ID: <052ee37c-675f-4611-afa4-62788d220f1b@grimberg.me>
Date: Fri, 12 Dec 2025 14:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/7] nvme-multipath: introduce adaptive I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, dwagner@suse.de,
 axboe@kernel.dk, kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_040830_038823_2E4F35D5 
X-CRM114-Status: GOOD (  13.14  )
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



On 05/11/2025 12:33, Nilay Shroff wrote:
> Hi,
>
> This series introduces a new adaptive I/O policy for NVMe native
> multipath. Existing policies such as numa, round-robin, and queue-depth
> are static and do not adapt to real-time transport performance.

It can be argued that queue-depth is a proxy of latency.

>   The numa
> selects the path closest to the NUMA node of the current CPU, optimizing
> memory and path locality, but ignores actual path performance. The
> round-robin distributes I/O evenly across all paths, providing fairness
> but not performance awareness. The queue-depth reacts to instantaneous
> queue occupancy, avoiding heavily loaded paths, but does not account for
> actual latency, throughput, or link speed.
>
> The new adaptive policy addresses these gaps selecting paths dynamically
> based on measured I/O latency for both PCIe and fabrics.

Adaptive is not a good name. Maybe weighted-latency of wplat (weighted 
path latency)
or something like that.

>   Latency is
> derived by passively sampling I/O completions. Each path is assigned a
> weight proportional to its latency score, and I/Os are then forwarded
> accordingly. As condition changes (e.g. latency spikes, bandwidth
> differences), path weights are updated, automatically steering traffic
> toward better-performing paths.
>
> Early results show reduced tail latency under mixed workloads and
> improved throughput by exploiting higher-speed links more effectively.
> For example, with NVMf/TCP using two paths (one throttled with ~30 ms
> delay), fio results with random read/write/rw workloads (direct I/O)
> showed:
>
>          numa         round-robin   queue-depth  adaptive
>          -----------  -----------   -----------  ---------
> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s

Seems like a nice gain.
Can you please test for the normal symmetric paths case? Would like
to see the trade-off...

