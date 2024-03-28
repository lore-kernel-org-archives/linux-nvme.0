Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01424C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dr5CVYVHQhlbInTEfSxMv7vhYKWCp3Kaeaw3PIRXnBw=; b=T2uwj6CvQlM+qrG4S6cTN1GPcY
	lzCjMElFlbr3gxFpcjUGWD+x6KioDz2ohsvboX6Vjr8lMw29tC1IZ/QsE8Cloc6nzAGGmtqjFLbHi
	jw/S+EU/+rEgk/WfdLssOs+VSAnFlFGYuHplILCWPFR49aipLv/P+o7f47TNtMXuzeziIquvWfwAL
	qqArpoCCgBTA6EEhjO78maR5bHylyeJ5NEIoUn2MhGyO7y3xbk14moxs19ZQ1L6h7bWFvV0Fpanqz
	pfE9AdtsZu3Q30HA9OTX2TED2DNl2EOp2TjpirjmCNcPZwvxZHvOsssjUzhJjMb9+GBN1Lzsoh8XK
	lG3Yr7dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpn9l-0000000Dbbs-3eO5;
	Thu, 28 Mar 2024 10:38:49 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpn9j-0000000DbbB-0NHE
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 10:38:48 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so220292f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 28 Mar 2024 03:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711622321; x=1712227121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr5CVYVHQhlbInTEfSxMv7vhYKWCp3Kaeaw3PIRXnBw=;
        b=iBTISsjSAy6p4wya/3Oe3Oy17Qnwu5MRLad0MQgM9o/992vl0jwEUQsFq6SZb1caTx
         lq2QQu31l8mCdeXPkZa89zGpEoJDI0pVBvhWvnZ7RGCFq4i2yjPN8bgLyQ96CvT43OnR
         hmvOr0Yr6ltYlVXWkP5usLMAl3QZ7lM4Oxv86Y0eJGMi3uvXbWz99WRq7wp3dLFsgMMs
         WkFJl2isZaCWOOeOuh9u1sEEd6INocE/R6u2w5NCdpDB7NawR0Uupza3vkBcszgEHN0j
         EdYdA6Fxv7jfbeXWVcQlcU52kjr/iaMdnQgrKrwLxh/uNQG6bPDnQ8uF6JYC722KkSKA
         wD7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4iw4OemDOtNg4LXKT3hvWIy26GmY17XNJkUV97VbunjUdD4Y+wv9cYwrz02qxQh6HSKaVaAFAOvfpIwX5A4t+vN008pP9wpmyV1NQFB0=
X-Gm-Message-State: AOJu0Ywxz1x5I/V1qxtlyiorN1h2AivpuvvGq+ZRMGhLnRsHwohh262f
	kOMqaAcX/qJnEvj9STLOj4eidnlal/QGpalboyg7qJ2xVktZItDmEbBCkZ5n
X-Google-Smtp-Source: AGHT+IFou6tOPC7Ao+bhIwpk7Xu50MBOaItZV60Nzslc1N6So9zsFjJxO7Dq0ongdDNfQM+cUzaazA==
X-Received: by 2002:adf:e487:0:b0:341:e368:2c0a with SMTP id i7-20020adfe487000000b00341e3682c0amr1740329wrm.5.1711622320709;
        Thu, 28 Mar 2024 03:38:40 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l2-20020adff482000000b0033ec312cd8asm1395501wro.33.2024.03.28.03.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 03:38:40 -0700 (PDT)
Message-ID: <5cade4b4-f19f-422d-ab93-bc853b1563d1@grimberg.me>
Date: Thu, 28 Mar 2024 12:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] block,nvme: latency-based I/O scheduler
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20240326153529.75989-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240326153529.75989-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_033847_167440_348C52AC 
X-CRM114-Status: GOOD (  17.35  )
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



On 26/03/2024 17:35, Hannes Reinecke wrote:
> Hi all,
>
> there had been several attempts to implement a latency-based I/O
> scheduler for native nvme multipath, all of which had its issues.
>
> So time to start afresh, this time using the QoS framework
> already present in the block layer.
> It consists of two parts:
> - a new 'blk-nodelat' QoS module, which is just a simple per-node
>    latency tracker
> - a 'latency' nvme I/O policy
>
> Using the 'tiobench' fio script I'm getting:
>    WRITE: bw=531MiB/s (556MB/s), 33.2MiB/s-52.4MiB/s
>    (34.8MB/s-54.9MB/s), io=4096MiB (4295MB), run=4888-7718msec
>      WRITE: bw=539MiB/s (566MB/s), 33.7MiB/s-50.9MiB/s
>    (35.3MB/s-53.3MB/s), io=4096MiB (4295MB), run=5033-7594msec
>       READ: bw=898MiB/s (942MB/s), 56.1MiB/s-75.4MiB/s
>    (58.9MB/s-79.0MB/s), io=4096MiB (4295MB), run=3397-4560msec
>       READ: bw=1023MiB/s (1072MB/s), 63.9MiB/s-75.1MiB/s
>    (67.0MB/s-78.8MB/s), io=4096MiB (4295MB), run=3408-4005msec
>
> for 'round-robin' and
>
>    WRITE: bw=574MiB/s (601MB/s), 35.8MiB/s-45.5MiB/s
>    (37.6MB/s-47.7MB/s), io=4096MiB (4295MB), run=5629-7142msec
>      WRITE: bw=639MiB/s (670MB/s), 39.9MiB/s-47.5MiB/s
>    (41.9MB/s-49.8MB/s), io=4096MiB (4295MB), run=5388-6408msec
>       READ: bw=1024MiB/s (1074MB/s), 64.0MiB/s-73.7MiB/s
>    (67.1MB/s-77.2MB/s), io=4096MiB (4295MB), run=3475-4000msec
>       READ: bw=1013MiB/s (1063MB/s), 63.3MiB/s-72.6MiB/s
>    (66.4MB/s-76.2MB/s), io=4096MiB (4295MB), run=3524-4042msec
>    
> for 'latency' with 'decay' set to 10.
> That's on a 32G FC testbed running against a brd target,
> fio running with 16 thread.

Can you quantify the improvement? Also, the name latency suggest
that latency should be improved no?

>
> As usual, comments and reviews are welcome.
>
> Hannes Reinecke (2):
>    block: track per-node I/O latency
>    nvme: add 'latency' iopolicy
>
>   block/Kconfig                 |   7 +
>   block/Makefile                |   1 +
>   block/blk-mq-debugfs.c        |   2 +
>   block/blk-nodelat.c           | 368 ++++++++++++++++++++++++++++++++++
>   block/blk-rq-qos.h            |   6 +
>   drivers/nvme/host/multipath.c |  46 ++++-
>   drivers/nvme/host/nvme.h      |   2 +
>   include/linux/blk-mq.h        |  11 +
>   8 files changed, 439 insertions(+), 4 deletions(-)
>   create mode 100644 block/blk-nodelat.c
>


