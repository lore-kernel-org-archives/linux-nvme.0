Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376F3C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43rfvUAosYxf8R7CToOPjamcVKiNt92R/6+esnJxC6c=; b=aJCH/emSfbElhQRA8vT+htNyJp
	l0nTRuXWKgXYc3o2d9Ss5K4oCYwpLHFQf2tNL3A4X6520Ke/pz5NsbR7hKLZeYIf1zrZqMY4bikFo
	8t/oBs9//yns+z+hyZzwKAfzNXjKPIoiGxwPFUkv8ol5e4YAYDkQxfjDYYjGem8oxUR9WImd9Hta9
	yx3STPYHkcg5+ArfkbsKMqs+TW9SD0a1f8+ZJhKRnDJuT7rEXbw8Nuc2fs1cYfMkugkBO8Qb8ESwD
	Mt8YRggI865ZvcmA15mXIs1rT/IIpQ6wdTASjcgJIuCjksQl5ai42mCok9XlcbxhBGeYkgqMhxoaM
	jf16PDHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwjD-0000000ExRL-46l6;
	Sun, 23 Aug 2026 01:10:27 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwj7-0000000ExQY-2tfV
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 01:10:24 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso6078007a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 18:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447420; x=1788052220;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43rfvUAosYxf8R7CToOPjamcVKiNt92R/6+esnJxC6c=;
        b=TsXYGpSCyFCHGGZoA+3iiJjPbjdBqmTksdfjESOWZiCM5G8fiCXG+dK4L7O5lEw4YF
         E0brC7lKZvYFHWEkvdhhFqYbzK6ekRK/42H4zmmcFK2B8lq9WfwFE7di2HecMPLF+g3F
         4cPLvLLd5zwxSt8Z5zhkeNKaI8hnSxkFe01o7phPjwEO+0tbg1vUFcVitBKAjxjUesPJ
         7+ppn2snhYrjB7wzpWbc7YJ9lX70R3tKhDPQGlInD05uiryM87j2FXqUmjPzGJPIdZ9g
         S/FxOCIyFGxCF8gzCqpAPNh756Q1TB7jDD6H2U7g2TlDVqXd7Z+6O/3aJMKr8s7j7qfa
         Gdwg==
X-Gm-Message-State: AFuF++n4o7PrZ8t+sxZ0tH2Sm4ynyzCK71l5t6bTxL5LX8sR/FhohV91
	lQ5ib17dKA8j7LB4jdUgejk4kmUqK3eyjTd4K5RQ6IJ/jlfIiLdba8bD
X-Gm-Gg: AR+sD13jA4OEjvDJ0JHYuNOmypWBY3T74qUnc3CNus1aa1E+sontwjOva4SMzdd1Pv3
	leEaa9Hi9oyy6rONncPndHn/lU4oW1vEg6SVSjQkeBPt6rYn+W1i7xgCQanvM8fZzObEnoV1QLM
	MywB0ugVGXSeiLfpPJy39MNwkVRk9Y0WGzq5zKBcLUDanrBfnfi3HhuAQAc8cn6gw13sPB20IEP
	loHfKcapeo3xqKl97t27+Tt/uQd/G5YeoJT5qDq5uCQUIOK9AvDKECdUno2BQLsWxbG1sxEZcSi
	r0qtbv7HbBCZn60br+t8kJgKBEhIiRMqTMRk8eRzliiAPVALfuTuPn52BGoPCw8XWXYDoV+TU0O
	D5GHWmBaZjwDfOYZWzlhPMlmDuAYj42fAX3iWdTTOmffVMZ3SJ/WEqDzzeZpHf2erk0B6G/ku4y
	XtA6/LYhMeELgO4AQXDJDV7Bv+DQb2K/usGpzZQNdwba1IteHs0uvvvzKDqMcNXUMEjj/6sBbtw
	r5fadJuOurE5Q422p812bQ=
X-Received: by 2002:a05:6402:2491:b0:6a1:284f:7891 with SMTP id 4fb4d7f45d1cf-6a42f1c0568mr20123254a12.7.1787447419714;
        Sat, 22 Aug 2026 18:10:19 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1abfa0sm530190a12.20.2026.08.22.18.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 18:10:19 -0700 (PDT)
Message-ID: <55310833-fd75-4d0f-b910-0a19090c2e9c@grimberg.me>
Date: Sun, 23 Aug 2026 04:10:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] nvme-rdma: parallelize I/O queue setup
To: Surabhi Gogte <sgogte@purestorage.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
References: <20260627041551.1981256-1-sgogte@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260627041551.1981256-1-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_181023_826503_26BCD228 
X-CRM114-Status: GOOD (  12.75  )
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



On 27/06/2026 7:15, Surabhi Gogte wrote:
> This patch series parallelizes nvme-rdma connection and reconnection by
> setting up I/O queues in parallel instead of sequentially. Allocation and
> startup of each queue are combined into a single per-queue async work
> item, so per-queue connection latency overlaps across all queues. This
> matters most on high-core-count hosts with many I/O queues, where serial
> setup dominates connect time.
>
> Patch 1 is a preparatory refactor: nvme_rdma_alloc_queue() takes a queue
> pointer so allocation and startup can be folded into a single async
> worker.
>
> Patch 2 contains the implementation for async setup of I/O queues.
>
> Testing on a 64-core host with 64 I/O queues shows nvme-rdma connection
> time reduced from ~1.4s to 416ms.
>
> Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>

Would it be possible to do the same for nvme-tcp?

