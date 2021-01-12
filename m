Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 09:22:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED2822DFB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 09:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED2822DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pr9WRUS4vUGKQBX0KNj8/g+b2wISlExd9uJHa4pwDiE=; b=Zfi5YCSGit01yGG7LnEPoJlDo
	Yk6R4DL7lA4WADhPWtolDCFd9kgNtkIY8N/EmC6BeQwqUTrzkXDWKMMZ6wxqk5W66amv9TNYszecO
	i3FRcwAA6dsF8M7MO5G8+kr4+BWfS8H7zRQqG9JILNCvD6RPCcnUTmuMRwWsM9/VebwEgepkm2Vgb
	EwPxsJgOfg8Aia0Lqx9SKtkvLeZ3cyUDHegEXniAvGTxzRPczn96oF7umVjXytvKRZhPjPR/jDvXJ
	GuVPq2q6vHGXMOBpwsBOfl2cYo4uh1SLSsHcfGYLYu82AfbTeJ7EVhz0A1GBL9ssRN7C2u0GmTA3t
	4rXc8nqqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzFsU-0005CF-Cg; Tue, 12 Jan 2021 09:22:14 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzFsR-0005BD-TB
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 09:22:12 +0000
Received: by mail-pj1-x102c.google.com with SMTP id iq13so1224959pjb.3
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VebTyXxUx1aA8dMYN70HrF1ZTcfdGnRg21M2nbc+SqY=;
 b=XeeqBHroWmg0WHc9ePr8LgxyiDOVRspq23QH5WWNlHEdrBPcfXE+NXvePXQL86uzbB
 oob8eju284X4VQI7UbVQuk2TB/synix67MZY5KSiEYZwWUF/I6ms23XaoWnfqfZxAP5k
 42v04clFEtE+F9/rl814T8siAXLQGt/T1nZ0FltMrU7hg/sLNgLX19Q2rijt39D+riyd
 bj/UPD1YXqJhaSyHlVDIiNtHybQb9+KqrsjeY+MFB5UwDxHeGg5OPEaPXX+5MkTEwT9t
 E2txo42cHtEPnW8oyuNTHQwvML3D9SAfpNfd6wt2PU5ZO8qaMro2hTosjkNiQ33/bZDt
 Y/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VebTyXxUx1aA8dMYN70HrF1ZTcfdGnRg21M2nbc+SqY=;
 b=lnI/6Wied4oDbYwb9xaK57jaR641u8/eN32mLg8SlMq0cmjZyY/r+BJIwjFpaK8mVi
 hsPAVN1x+KAC0zskSaJ+p8UUrDUmaD70UEIeR0wXBG/Ao1TKWbRcD/CxHjWKcjyuSdSj
 3iV0NtAlCGILBnshdmeW67cWt36zqsyMiF3IDR79UYY+5Azkm2GPwHRXx1tT3VFYlpYl
 aux4mFoLqIrqCW735I/RSDu4XsMsY/zfAcsr2DPyYZ49pMtfBbfeG+BOMUmNMkT0tSsa
 XP8JfwunnNfUZ6FxqPy+H4SF20nKJGBVo+/DRD+aQLRJCOfHAzWHaxyGsa/Tg5zT/c3A
 YeOA==
X-Gm-Message-State: AOAM531Iib/PYk/NV2/DI2yqyIAvy8PPKxHYOedTOHrHbY1LTo/QC+VG
 Y6H8RiyHL8+j7p4Yx8o4EEI=
X-Google-Smtp-Source: ABdhPJzfLDe0FU6u83usjW+/EFiSJ+gXbgqE6Bfzxy2jqiJJ/cTE4L7QjZiplrEWCSvHchCtw+RoFw==
X-Received: by 2002:a17:902:a710:b029:dc:3817:e7c2 with SMTP id
 w16-20020a170902a710b02900dc3817e7c2mr4337864plq.0.1610443330082; 
 Tue, 12 Jan 2021 01:22:10 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d203sm2464165pfd.148.2021.01.12.01.22.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 01:22:09 -0800 (PST)
Date: Tue, 12 Jan 2021 18:22:07 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112092207.GA4888@localhost.localdomain>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_042212_050286_572FEB53 
X-CRM114-Status: GOOD (  11.28  )
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

Hello Javier,

I tested this patch based on nvme-5.11:

[    1.219747] BUG: unable to handle page fault for address: 0000000100000041
[    1.220518] #PF: supervisor read access in kernel mode
[    1.220582] #PF: error_code(0x0000) - not-present page
[    1.220582] PGD 0 P4D 0
[    1.220582] Oops: 0000 [#1] SMP PTI
[    1.220582] CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.11.0-rc1+ #46
[    1.220582] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    1.220582] Workqueue: nvme-wq nvme_scan_work
[    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
[    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
[    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
[    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
[    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
[    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
[    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
[    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
[    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
[    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.220582] Call Trace:
[    1.220582]  internal_create_group+0xde/0x390
[    1.220582]  internal_create_groups.part.4+0x3e/0xa0
[    1.220582]  device_add+0x3cf/0x830
[    1.220582]  ? cdev_get+0x20/0x20
[    1.220582]  ? cdev_purge+0x60/0x60
[    1.220582]  cdev_device_add+0x44/0x70
[    1.220582]  ? cdev_init+0x50/0x60
[    1.220582]  nvme_alloc_chardev_ns+0x187/0x1eb
[    1.220582]  nvme_alloc_ns+0x367/0x460
[    1.220582]  nvme_validate_or_alloc_ns+0xe2/0x139
[    1.220582]  nvme_scan_ns_list+0x113/0x17a
[    1.220582]  nvme_scan_work+0xa5/0x106
[    1.220582]  process_one_work+0x1dd/0x3e0
[    1.220582]  worker_thread+0x2d/0x3b0
[    1.220582]  ? cancel_delayed_work+0x90/0x90
[    1.220582]  kthread+0x117/0x130
[    1.220582]  ? kthread_park+0x90/0x90
[    1.220582]  ret_from_fork+0x22/0x30
[    1.220582] Modules linked in:
[    1.220582] CR2: 0000000100000041
[    1.220582] ---[ end trace b1f509a1bbfbc113 ]---
[    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
[    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
[    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
[    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
[    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
[    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
[    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
[    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
[    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
[    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

And this happens when CONFIG_NVME_MULTIPATH=y configured.  Please refere
attached log up there :)

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
