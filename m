Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4861ED743F9
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zzioji6t5EJYtuRjVDNljcfalXHvMtqqSYFYu6hs34=; b=iGVppTtQBOsZXpSlzulcGwVKWo
	g/eSa+aJ84uc+LCXAhEBErPD8IFq11M5+rGt6KOEISPEiO1Y7bXLaOPRLq/FTdA2YCfMf31EWKniw
	OSgAoP/9gyFPIr9CVITm7J1yJjnsO9R7eiNe7YGlwbvBPG6+xVxYKZK8cHZldD2ewsOMcZqq7rP9A
	3HWUlVliCLrsOG/yG4AwU3YX4+t+xlCC+h9fnqrko/Uxi+HDdyyy0Bvs6miP36O1p4DIltJ600oMN
	QgfIJehfzGKMp4N2nAh+sDpmlA+Waab3a6n9/1nMrGg20wgShK86iOkOxl01votjpvYRMQRZ5wwlA
	LCgB8S4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDvrm-0000000GWlb-0xI8;
	Thu, 21 Nov 2024 01:20:18 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDvrj-0000000GWlG-3Z86
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 01:20:17 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2ea1e605193so370144a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Nov 2024 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732152015; x=1732756815; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zzioji6t5EJYtuRjVDNljcfalXHvMtqqSYFYu6hs34=;
        b=ElFUCgaPG+K1kuRvHPqjV9qb8qfZOGF/v3nzXKtYUK2WPsyCLuGX9iYvT0Gr/CeVOj
         oZCmry0J/BjeS9e7giAatam9hKBznTsKiVkBvTfGGG9YqYhpXVTxU1oY4yYheU1RHzIF
         arD/stt660Nsxnc5Q2AI9/+SljewqDm+Ap7eLVuHgmTgcPMgrjjjgUm2raAtOvbcjiAC
         /e/pixCcT4aHBZNdLVjCzJBnLN4dGJcAcSBGZ01oOxGw6K7qewDjNQ+QGPisywqe8z0O
         QZVtbCWI3ipjzCNpB/61qmM3rvDlHJa3wJePHRhsCUmKvFtlptdMg1aFBlc0a1NXt6mx
         91GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732152015; x=1732756815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zzioji6t5EJYtuRjVDNljcfalXHvMtqqSYFYu6hs34=;
        b=DKaj5VE+mnYkAJBq8tol0YLVBwSc6m1pPKi2KTmPg12y2UKisIiylBplE1y+oXhtOF
         uxHjQzjHfIM6CRyvai3hciv+Qss/8tgSI0wjjqivkKlLEsIBGTPBBXbRX4QjEpSEUr5D
         G0utcFN4pL3NhikbLrSkKd43oTUt5Y7VzDOI7XaJ84pzQJ1FdKvREuV42oeCB8W8X3NH
         xzt3StGACxb2wfZCk70Z+t+1FeNucLrWAWHvaBQq+aotyVce4F6fRrldIb5bxwzaEbet
         Sn2AO4g5w51Xth8R/tfMvjMoyf/I0/FsR7m8iziQP4fFy1VnYG6GgSHVwU1L1oR/XYt8
         PwjA==
X-Forwarded-Encrypted: i=1; AJvYcCUvSZf497oDX/SKmzrzYcW55WcenJ2yICCSzZnaeVJeMUgpd5qtsRnLQ9UVE/gg+dqqzf9PTXx2xPPF@lists.infradead.org
X-Gm-Message-State: AOJu0YzxDwB80Np/9V1a3th0n2tUC5hOIZCZ/er4yvtv0iip0k/xfagx
	mw7s+Zd+FzzXwSs265PCvDnmCDsmZ0rsvME1K/7R7aJsle6Ebl6vhXriHdxfVwA=
X-Gm-Gg: ASbGncvYxuW9yHBy7Qqfxs8UgXUmr8hYwsO2JeDTSogZwnWzRVKdz8z+Th9ZnXjJ4Wy
	lI8vkgx1CYQarR8GjArxMvMrO4V5IFypK4QmwBAdsCyqWfux6aK/fXEcHgzLcd5tCaE5K4vXVCF
	4iWv3mGT4PTCRUsD34YMr0rm3i1aDdeN8gOo5CCzl4V8/zI8+pFUzV6ZpP1KO/2buQQ5l61tbYb
	QCg7JSfjkVX7MKqH6YszYFtOm5OdzdufX2qEL9U6TDhtwY=
X-Google-Smtp-Source: AGHT+IEPMWVWiZ4xgW98q/E3liAMRD6U3r199xc/qsSzLuoWoDnGWtMOom3v8Ddt9yv6CjLmcWTJsQ==
X-Received: by 2002:a17:90b:1bc3:b0:2ea:5ff8:f325 with SMTP id 98e67ed59e1d1-2eaca6b3c34mr6230031a91.8.1732152014776;
        Wed, 20 Nov 2024 17:20:14 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21287ee19c6sm1895245ad.123.2024.11.20.17.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 17:20:14 -0800 (PST)
Message-ID: <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
Date: Wed, 20 Nov 2024 18:20:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_172015_897213_2FCADB0B 
X-CRM114-Status: GOOD (  21.50  )
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

On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
> On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
>> Hi,
>>
>> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
>>
>> Bisect root cause commit
>> ===================
>> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
>>
>>
>> Test details
>> =========
>> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>> - Test is on ext4 filesystem
>> - System has 4 NVMe disks
>>
> 
> Thanks a lot for the report, to narrow down this problem can you
> please :-
> 
> 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>     have used for this benchmark ?
> 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
> 
> This way we will know if there is an issue only with the ext4 or
> with other file systems are suffering from this problem too or
> it is below the file system layer such as block layer and nvme pci driver ?
> 
> It will also help if you can repeat these numbers for io_uring fio io_engine
> to narrow down this problem to know if the issue is ioengine specific.
> 
> Looking at the commit [1], it only sets the max value to write zeroes 
> sectors
> if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
> write zeroes value.

There's no way that commit is involved, the test as quoted doesn't even
touch write zeroes. Hence if there really is a regression here, then
it's either not easily bisectable, some error was injected while
bisecting, or the test itself is bimodal.

-- 
Jens Axboe

