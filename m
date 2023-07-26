Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97873C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rArkLhnWUlIK4304QM/qMQbcdjqKn5ft/zJeEhBuNj0=; b=lft+13m/UmSTZGXbdJFCOyjzwC
	iPHDpzc/KnEFgny9aBlwCgS8sauS7Wkq853bca0TC97zN8ZIusWmm16UWNw6yFsqcJwVCB/6/B+Do
	ammbDGILqGuEnHukVR/KUwXVGRqpwS+kXy6/wRnniM6MvOda28TCQb/o112t/+sKTUBHA916DCf5j
	nkiFgemZB7ZBdjSV63IXh9S9BcEN+SbAahC2GPEmbwKCmOrNJXntUgNiiDil5tzVBduSUqG2b+pSG
	zNR/fl9a7ND0FrcOjdGRJtLKeX9PO7leACYfMVe82trVlyhdVebT8YCK6YHTakHyyK7/ZCWLHvyFh
	sGG/jjIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOZPz-009WcL-0z;
	Wed, 26 Jul 2023 07:58:47 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOZPt-009Wak-29
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 07:58:43 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-521a69c8da5so1815353a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jul 2023 00:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358318; x=1690963118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rArkLhnWUlIK4304QM/qMQbcdjqKn5ft/zJeEhBuNj0=;
        b=cDtiC1+pXJv1OcyiNCFqtOMSAYP5FYSpzElMeCB15qom7wibU6BVGJlFxqKkEDqm8z
         vmkvc5jVF54MoagBaWLBujg9Hfaq8KEVhkJ+eDlh8G9LxZYspNLuzjwKZYzrFzBJVOwE
         ZAt09lnxWxYk1aWM7xKic1RKQreG7pAc8oihUeTBU345svrPQVqhZ5/Q1Ss6Y4MUZWB8
         skcQpyCqFVcp9JISLLXXAO5fmmL2QbCOBzP9BudlCYsWK/utLxsmc9SFI/mktklej82b
         4IcXDgUiBPuE7ekxNxoWEz+weXvv5aOi9XwbG+PXNA+0yCusF4bwTlb+5lxvsUP79QdQ
         P1fg==
X-Gm-Message-State: ABy/qLbasqGypZz8sQRVSoOMGwCNrFL3uFn3ENsgQjSJ9eQj7dVg2C5U
	sOhVqtDr6BdGvMnMLnJHaC4=
X-Google-Smtp-Source: APBJJlE75PBRDWnYZDfkulwH3fm6QqsNZRSZ1N7P13z+sDsfk/xykOgPxCQQusachBN1RjIoVLR6rw==
X-Received: by 2002:a05:6402:278f:b0:522:3f32:52f1 with SMTP id b15-20020a056402278f00b005223f3252f1mr1109591ede.3.1690358318560;
        Wed, 26 Jul 2023 00:58:38 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7d9da000000b005226f281bc5sm517939eds.25.2023.07.26.00.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:58:37 -0700 (PDT)
Message-ID: <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
Date: Wed, 26 Jul 2023 10:58:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Pratyush Yadav <ptyadav@amazon.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_005841_708609_BBBF7112 
X-CRM114-Status: GOOD (  17.69  )
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


>> If a device has no NUMA node information associated with it, the driver
>> puts the device in node first_memory_node (say node 0). As a side
>> effect, this gives an indication to userspace IRQ balancing programs
>> that the device is in node 0 so they prefer CPUs in node 0 to handle the
>> IRQs associated with the queues. For example, irqbalance will only let
>> CPUs in node 0 handle the interrupts. This reduces random access
>> performance on CPUs in node 1 since the interrupt for command completion
>> will fire on node 0.
>>
>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>> information for the NVMe devices. This means all NVMe devices have
>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>> both nodes get similar performance (around 315k IOPS).
> 
> irqbalance doesn't work with this driver though: the interrupts are
> managed by the kernel. Is there some other reason to explain the perf
> difference?

Maybe its because the numa_node goes to the tagset which allocates
stuff based on that numa-node ?

