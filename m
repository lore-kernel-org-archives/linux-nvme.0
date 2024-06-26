Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E495C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihBpMTTiNrKvmk9diRPzmMFpksKDsJ37Y+fvSUt2P4o=; b=SNiYGMuqp2QSV8hMLH65/2ytGn
	T1L5MpnKamxwyiD+0cw+jRL6WW/v2ZDRuovRnksI1jGdFSiGVwlrQeu/paQkIAPgXQsysnS5nARkA
	Q8s+tvN4guqt0eN2V7+CtSxEeyU+n9Fphxo1+P0qnTq3xxGtl+sHXqNqIgmh5+h4O7Hhf70bgMbLx
	pGSCcw4Zo69JYqLdVE6F1KPa4AuF/6wTXK1tkH9Q5RdvuOcykCQs1GhiR/dECuWdqlMSzG+eHj/MB
	ResUpvU+FAM6d9Ec3LGy5AiiUY0Jm92k8UMpYg67ZlwxRdkOE0xMhuyxkIGOM8CZX02Gb6DZOhTbv
	1qX6dvAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSqH-00000006zy1-11zW;
	Wed, 26 Jun 2024 13:37:45 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSqD-00000006zwA-3Zaq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 13:37:43 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424a5d998eeso1909745e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 06:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409060; x=1720013860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihBpMTTiNrKvmk9diRPzmMFpksKDsJ37Y+fvSUt2P4o=;
        b=TOrHl2XShBTN0ik2/G6xCmh5Ok8zvkJUTEr6PS+ocNaLgMEm4vteczDxogRxq6EINp
         2dPgB3qLsbn7RV/Vt2zgkeVjp1qhce6QZo4yaH+PXFsbLE2rKYuuzkeGhU1CuZCYxpnr
         cDKpq/HalT8CoyaTAWPS3vJcV+b7vH4kD6PiZafUoUn+obNJQI4hadBBfx4aUJtCbt6n
         SBdZ5frmFZ1msPlwlGJCzxThyAKXZzkPc/teTaF5xhM4ra7S0VdiuL+/2P9TyOzGPXFR
         OxcQTPBcusE6/FaZoYg9Fh24g4mLvMwT+3bvEk2vNJ19nSJLmMlyWcV5p+hmLxxe1usC
         CQXA==
X-Forwarded-Encrypted: i=1; AJvYcCXpB27Q0CSr2ebeWzGXFnHdNfpAzEVwuioJkHlVAWvwnNXYJ162yV2Ri3gi8nfBvkK/PctWZYfJf+gzfEIU1iMBgvVw/erdpaZnfJOQaqI=
X-Gm-Message-State: AOJu0YzBUpQUQ1kN8tPk2w5v9eyRx6Qm1VTYbMV2AFc0Szln/Bdp3Ph4
	LsH16drtPd94s4jVBkPzRZSoPCr6wih6BaFc8aluHtw/MIOnbnunZ64/mw==
X-Google-Smtp-Source: AGHT+IHKE63Fbq9icSFxiZAidbQaLrEUFY04fGPLWoXaHY7GQBp9t969oTz0ETYzI1tnamlXXss/FQ==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d3 with SMTP id 5b1f17b1804b1-424a74b3420mr28815705e9.0.1719409059593;
        Wed, 26 Jun 2024 06:37:39 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8266a37sm26189935e9.19.2024.06.26.06.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:37:39 -0700 (PDT)
Message-ID: <d14c86cc-b6cf-4b86-840f-fd514ad8a8c0@grimberg.me>
Date: Wed, 26 Jun 2024 16:37:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-tcp scalability improvements
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240626121347.1116-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_063741_941124_56FB4EBB 
X-CRM114-Status: GOOD (  19.56  )
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



On 26/06/2024 15:13, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Hi all,
>
> we have had reports from partners that nvme-tcp suffers from scalability
> problems with the number of controllers; they even managed to run into
> a request timeout by just connecting enough controllers to the host.
>
> Looking into it I have found several issues with the nvme-tcp implementation:
> - the 'io_cpu' assignment is static, leading to the same calculation
>    for each controller. Thus each queue with the same number is
>    assigned the same CPU, leading to CPU starvation.
> - The blk-mq cpu mapping is not taken into account when calculating
>    the 'io_cpu' number, leading to excessive thread bouncing during I/O
> - The socket state is not evaluating, so we're piling more and more
>    requests onto the socket even when it's already full.
>
> This patchset addresses these issues, leading to a better I/O
> distribution for several controllers.

Hannes, Please quantify what every change gives us please. Each
change on its own should present merit, otherwise we should consider
weather it is actually needed.

>
> Performance for read increases from:
> 4k seq read: bw=368MiB/s (386MB/s), 11.5MiB/s-12.7MiB/s
>    (12.1MB/s-13.3MB/s), io=16.0GiB (17.2GB), run=40444-44468msec
> 4k rand read: bw=360MiB/s (378MB/s), 11.3MiB/s-12.1MiB/s
>    (11.8MB/s-12.7MB/s), io=16.0GiB (17.2GB), run=42310-45502msec
> to:
> 4k seq read: bw=520MiB/s (545MB/s), 16.3MiB/s-21.1MiB/s
>    (17.0MB/s-22.2MB/s), io=16.0GiB (17.2GB), run=24208-31505msec
> 4k rand read: bw=533MiB/s (559MB/s), 16.7MiB/s-22.2MiB/s
>    (17.5MB/s-23.3MB/s), io=16.0GiB (17.2GB), run=23014-30731msec
>
> However, peak write performance degrades from:
> 4k seq write: bw=657MiB/s (689MB/s), 20.5MiB/s-20.7MiB/s
>    (21.5MB/s-21.8MB/s), io=16.0GiB (17.2GB), run=24678-24950msec
> 4k rand write: bw=687MiB/s (720MB/s), 21.5MiB/s-21.7MiB/s
>    (22.5MB/s-22.8MB/s), io=16.0GiB (17.2GB), run=23559-23859msec
> to:
> 4k seq write: bw=535MiB/s (561MB/s), 16.7MiB/s-19.9MiB/s
>    (17.5MB/s-20.9MB/s), io=16.0GiB (17.2GB), run=25707-30624msec
> 4k rand write: bw=560MiB/s (587MB/s), 17.5MiB/s-22.3MiB/s
>    (18.4MB/s-23.4MB/s), io=16.0GiB (17.2GB), run=22977-29248msec
>
> which is not surprising, seeing that the original implementation would
> be pushing as many writes as possible to the workqueue, with complete
> disregard of the utilisation of the queue (which was precisely the
> issue we're addressing here).

Well, I do not expect performance to degrade here. Its a noticeable drop 
I'd say.

>
> Hannes Reinecke (5):
>    nvme-tcp: align I/O cpu with blk-mq mapping
>    nvme-tcp: distribute queue affinity
>    nvmet-tcp: add wq_unbound module parameter
>    nvme-tcp: SOCK_NOSPACE handling
>    nvme-tcp: make softirq_rx the default
>
> Sagi Grimberg (2):
>    net: micro-optimize skb_datagram_iter
>    nvme-tcp: receive data in softirq
>
>   drivers/nvme/host/tcp.c   | 126 ++++++++++++++++++++++++++++----------
>   drivers/nvme/target/tcp.c |  34 +++++++---
>   net/core/datagram.c       |   4 +-
>   3 files changed, 122 insertions(+), 42 deletions(-)
>


