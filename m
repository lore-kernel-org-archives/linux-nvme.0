Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D2C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 11:26:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F13423104
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 11:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13423104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rXKv32fzzhSJ4Xy8qg8M5GTBfBvLdr+A9BxnfYZFfHA=; b=QiPfw4676x6qp6wIyMcB6dPWo
	AsxLkECZikNTP4q9zi9YFd53dEzf0RIEfE+lcGpx/Iso2HZ8nbElhDEqzlv8j3EwNH3CHHobDeJnz
	hfj7NGXYxWay4i2mDKTJFpNnVer6gWb0NaT6Yc7u7iEil9q9GZIZh3wmNVz0nopYi2u1drFpE9krL
	j9zWTsiO8lXA/mRX0APuWAuKpYZSStxvJ3LnDQpY2JYYYxiLlwB4rp969HID94LkajEy6UBgZSyVp
	mGbRL3NMFeo8prpcMwDpRRYl5zdE9bcZkSXpyOI59HQwLVgDtxvNLbcxxDggm6UOp/g4SIX2GNmjh
	DM1a8Jn+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzHog-0006dN-4D; Tue, 12 Jan 2021 11:26:27 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzHod-0006bi-G3
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 11:26:24 +0000
Received: by mail-pf1-x433.google.com with SMTP id 11so1219547pfu.4
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=69lJu+5uJVh3g3QBR1OSlKVM9BJBfcSQPSXxMNaTocE=;
 b=hP8Azw9xBW9eu1pXHPKelXVV0ijD0O+s5OIogg7yckgPeU38vnSrtZgnYvg85Sym1+
 oj6ffRT0bLKN7Y8jzuCEaBQbeFZQXszFk7fEV2CKxW1WGZoDMYB5j//j6NdCru8KCNf9
 h02FV2mBdXhqv6KBbVt9WhdHVs5uGLuapcG9yxcfrF8ELvH47cz5ihzDJE1sysAf5Ez5
 pq9eZ+3vArevzUlXjx+Cd4jXeGlWdbGQvGdTasudvAcqWKWh4kFhgj+N4cGw2R0E4ryH
 KYoU2XUuCGZ3DjM/smZIN9GQReN+wu4bNvcRehgaPEbFqLOH7IIN3VEJy9DvT/1aL57c
 lFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=69lJu+5uJVh3g3QBR1OSlKVM9BJBfcSQPSXxMNaTocE=;
 b=Rik6NuUwKxkp9Qu/b8hI3RkFo+ke+UDWeTo1PsMP/HuFAXJGLwB82mB6VxsHenJPfK
 1sTdePey7bdeXY6swnfKQ7ICRmhnzwOXnVHz8K0pzr597FAZbXzmN5cjd3+1c+OIZzBq
 XM5Nbt4/3WGvkAzLYdTieVeoe0frRZaHS8CFIOYF255qzyj8JFNdASYQSXD/Dj/32deH
 YKdAv2agPKQNjvQYFvkjzn6KCFj8yca/oOov/u6HRS9QdcWVe8YzkO1SaD6TIq6l5pPt
 Xvmpx428agI43EYTFwAp1WJy+kV3Lj0Zy46DXs9m8JPf7fHUhMSsh6j+CTOriWIuqICj
 npbA==
X-Gm-Message-State: AOAM530XuEdTq4MBVwXk1zZ+pULCWt/kDNkEWGrxYuLVYwsKl1POYY7m
 Q4YZQTJkmOBlaMmAzPpePDR7hTkjlk+ARg==
X-Google-Smtp-Source: ABdhPJyDEo3T7deZnXcLUwDLF+oKf6/a/m6Oz8qNzK34lIw8PUt3ShbwB1fcGo5oBkChSlJh0mltCA==
X-Received: by 2002:a63:3246:: with SMTP id y67mr4285814pgy.438.1610450781118; 
 Tue, 12 Jan 2021 03:26:21 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id u24sm2878418pjx.56.2021.01.12.03.26.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 03:26:20 -0800 (PST)
Date: Tue, 12 Jan 2021 20:26:18 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112112618.GA25093@localhost.localdomain>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
 <20210112092207.GA4888@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112092207.GA4888@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_062623_594988_9F18DAC8 
X-CRM114-Status: GOOD (  14.96  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-01-12 18:22:07, Minwoo Im wrote:
> Hello Javier,
> 
> I tested this patch based on nvme-5.11:
> 
> [    1.219747] BUG: unable to handle page fault for address: 0000000100000041
> [    1.220518] #PF: supervisor read access in kernel mode
> [    1.220582] #PF: error_code(0x0000) - not-present page
> [    1.220582] PGD 0 P4D 0
> [    1.220582] Oops: 0000 [#1] SMP PTI
> [    1.220582] CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.11.0-rc1+ #46
> [    1.220582] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    1.220582] Workqueue: nvme-wq nvme_scan_work
> [    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
> [    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
> [    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
> [    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
> [    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
> [    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
> [    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
> [    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
> [    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
> [    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
> [    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.220582] Call Trace:
> [    1.220582]  internal_create_group+0xde/0x390
> [    1.220582]  internal_create_groups.part.4+0x3e/0xa0
> [    1.220582]  device_add+0x3cf/0x830
> [    1.220582]  ? cdev_get+0x20/0x20
> [    1.220582]  ? cdev_purge+0x60/0x60
> [    1.220582]  cdev_device_add+0x44/0x70
> [    1.220582]  ? cdev_init+0x50/0x60
> [    1.220582]  nvme_alloc_chardev_ns+0x187/0x1eb
> [    1.220582]  nvme_alloc_ns+0x367/0x460
> [    1.220582]  nvme_validate_or_alloc_ns+0xe2/0x139
> [    1.220582]  nvme_scan_ns_list+0x113/0x17a
> [    1.220582]  nvme_scan_work+0xa5/0x106
> [    1.220582]  process_one_work+0x1dd/0x3e0
> [    1.220582]  worker_thread+0x2d/0x3b0
> [    1.220582]  ? cancel_delayed_work+0x90/0x90
> [    1.220582]  kthread+0x117/0x130
> [    1.220582]  ? kthread_park+0x90/0x90
> [    1.220582]  ret_from_fork+0x22/0x30
> [    1.220582] Modules linked in:
> [    1.220582] CR2: 0000000100000041
> [    1.220582] ---[ end trace b1f509a1bbfbc113 ]---
> [    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
> [    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
> [    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
> [    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
> [    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
> [    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
> [    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
> [    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
> [    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
> [    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
> [    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> And this happens when CONFIG_NVME_MULTIPATH=y configured.  Please refere
> attached log up there :)
> 
> Thanks!

If this chardev has to have ns_id_attr_group, we need to consider
nvme_ns_id_attrs_are_visible() to take care of dev_to_disk(dev) in case
non-block device.

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
