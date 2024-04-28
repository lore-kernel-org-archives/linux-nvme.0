Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE248C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSsj5LAoQ32PBl1G57MXIm3HfE7QVXhj2MFLYvYJyaM=; b=mUoXpO7AV88qqEINF/rtczQ5K9
	Rx3+C02A0FD2ABEJE2MyDq8SLEEGqAv65Mo5iwWgIqMmEGcw9Kc9NQwFPXo48WDe03UEfJiZMTgk9
	ehlS+YYNmGNfXb8aq6ptl/Cdt6pjbOVZ9TCAd67qYFG9uH+7j0Ni/5KDXvOpGmNjdfjVyKR0F4gcV
	1y6XshgQ/IdghyWuTjdRf928In9jmW3FzXJyLnvmBcIVFT4fIMsivhC5A44HxW09r9+4hX9RTQjLT
	MobkIB7AxB7WoFlDlj66/AZgbpoqlm9/qla3sslQ9zaAasaBuLb8jaabPupJ/UCELY5tAAeVYbHNt
	yPOtRVHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0zcc-0000000H7u8-3J8g;
	Sun, 28 Apr 2024 08:10:54 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0zcW-0000000H7sA-2rrP
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 08:10:50 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34a42d6e216so726314f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714291846; x=1714896646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSsj5LAoQ32PBl1G57MXIm3HfE7QVXhj2MFLYvYJyaM=;
        b=H2TZuHzO1eYnYN/355602F24oS4uvXL3Ql0ra7RR8e6u8FOwIKtXTH7iyjPsD2Qvi8
         v3ZMqlRfkTEa93fKkpnrZ2kjwZaxKNkGGccogB2TrFrdu6so6g9n+LFFaJyYQGUUQAtd
         UoodpT9aHecukk1Agmszc6l6uKM9zbUM7zE+Uu8G37Pms6SsMFRgf1bUMtjY/FtnMI6B
         ANBZDx1xMRyl4uVq2np25RgaBx6Q28ZsTuqtjiMBv5tOoT+/65vkCF/xLIFAlhoOzL08
         7ioDNfJGu7zRgtaapkhO7OeH82f6FCVUT/PwM75M0AN3bBPIjIhNn/4FedORsj9TNQk0
         6QYw==
X-Forwarded-Encrypted: i=1; AJvYcCUVQhdSJdZuM9IaPmtJCjHq74tRB56Hvy8epth33AfCF1Zf6RTXpEJqySEDNkLyItC4U4XImyRyu+iN7ehzV14PyCVE13JtNIMQJXERm0c=
X-Gm-Message-State: AOJu0YzqgUyV4MxyPmcWyB980sylGfPmaPD4PAR5Mn39ldIPVP5knwBG
	B74aecTeX6g3oCBYwm17QuCo8PJg8AdYdZ6N9l5xbIhK4CS4umEl
X-Google-Smtp-Source: AGHT+IGP4m8pWKjjEduL1pHCrqGLJrYhz2+AVqhsRQtW4q+UW/nhK9upYyNDD7iRIJaedhqYRalo8g==
X-Received: by 2002:adf:a412:0:b0:346:500f:9297 with SMTP id d18-20020adfa412000000b00346500f9297mr4939177wra.2.1714291845438;
        Sun, 28 Apr 2024 01:10:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003456c693fa4sm26429616wrz.93.2024.04.28.01.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:10:45 -0700 (PDT)
Message-ID: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
Date: Sun, 28 Apr 2024 11:10:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
To: kwb <wangbing.kuang@shopee.com>, james.smart@broadcom.com,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: chunguang.xu@shopee.com
References: <20240428063147.88058-1-wangbing.kuang@shopee.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240428063147.88058-1-wangbing.kuang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_011048_783740_7F9A717F 
X-CRM114-Status: GOOD (  10.98  )
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



On 28/04/2024 9:31, kwb wrote:
> Hi,
> We found nvme connect will dealock when it cannot alloc tag in admin queue. So we reproduce it and find a way to work around. The solution is to utilize reserve tag for connecting.
> Here is the deadlock environment:
> 1. the process [kworker/u129:1+nvme-wq] want to connect wait for geting tag, but tag is used up:
> [<0>] blk_mq_get_tag+0x11d/0x2d0
> [<0>] __blk_mq_alloc_request+0x92/0x180
> [<0>] blk_mq_alloc_request+0x7c/0xc0
> [<0>] nvme_alloc_request+0x28/0x100 [nvme_core]
> [<0>] __nvme_submit_sync_cmd+0x1ea/0x230 [nvme_core]
> [<0>] nvmf_reg_read64+0x62/0xa0 [nvme_fabrics]
> [<0>] nvme_enable_ctrl+0x25/0xb0 [nvme_core]
> [<0>] nvme_tcp_setup_ctrl+0x257/0x340 [nvme_tcp]
> [<0>] nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
> [<0>] process_one_work+0x228/0x3d0
> [<0>] worker_thread+0x4d/0x3f0
> [<0>] kthread+0x127/0x150
> [<0>] ret_from_fork+0x1f/0x30
> 2. many processes (here is nvme list) is waiting for connecting:
> [<0>] blk_execute_rq+0x8d/0x110
> [<0>] nvme_execute_passthru_rq+0x60/0x1f0 [nvme_core]
> [<0>] nvme_submit_user_cmd+0x23e/0x400 [nvme_core]
> [<0>] nvme_user_cmd+0x163/0x1d0 [nvme_core]
> [<0>] nvme_ctrl_ioctl+0x2e/0x40 [nvme_core]
> [<0>] __nvme_ioctl+0x78/0xc0 [nvme_core]
> [<0>] nvme_ioctl+0x1e/0x20 [nvme_core]
> [<0>] blkdev_ioctl+0x126/0x260
> [<0>] block_ioctl+0x4a/0x60
> [<0>] __x64_sys_ioctl+0x91/0xc0
> [<0>] do_syscall_64+0x59/0xc0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reproduce method is very eazy:
> 1. call many nvme list
> 2. make nvme io timeout to recover connection
> 3. trick is to make reconnect-delay much time, eg:30s
>
> The solution is the appending patch. it is tested and also consider keepalive and reset/showdown tag reserve.

The error_recovery work should unquiesce the admin_q, which should fail 
fast all pending admin commands,
so it is unclear to me how the connect process gets stuck.

What is step (2) - make nvme io timeout to recover the connection?

Is this reproducing with upstream nvme? or is this some distro kernel 
where this happens?
Do you have the below patch applied?
de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")

