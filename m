Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5BC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:31:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378682311B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378682311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JGAewTdbVxyTLdeMIdjvdwgY6shQcmxC7+FvEebfN9U=; b=UNgeFBaWiqyfusZ+1JG8VqWYd
	j722BcaJZ9rZ7xNCACphkJXPRNFzPCkWQfN1EwCiCpmD9lIk0kUuwG4pPjaXHzVvFtThSHjmZkeSM
	pt4K8xbE+fb4mox7VMglIwQRLlQHeQl0aluFOsmew2GWjpF57FAPhmDfA3uRm1FUKhl6H2UwVlCxU
	X01IXNFLVKNzFxPdrLR1AXOrOhyuakrTTEJ0LgMJ1KtQVJw4lRvEBBe4fp/dPjeWcTuZOoU/mwGty
	Nbk3uVIuQS6dH/yKFiELcCEo0BX9UlITinv2fDKik/iIp8s05cPDO+F61F7Ywrcng6qEkFjWmTUx3
	drfKBbEoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzORZ-00015X-Sh; Tue, 12 Jan 2021 18:31:01 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzORW-00013t-Rf
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 18:31:00 +0000
Received: by mail-ed1-x531.google.com with SMTP id i24so3430061edj.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bwmSGugiNPePeC1VV/onmxCTxlTIPfSnThRVgQfBnec=;
 b=zInwQgaF8rYfei18JNRH7dnHsEHtVD8wVTrrsKFKJgThKqlcMgvkUZ6RKbzmvaML6T
 Jb/FvPT5tdpSUKNUjhwk9/179j+x6pYxvzLoY7pqg97wlV/PZoBI45uLK6ii7yD0pDMs
 JbkFAhPyaKr7bvyrCF+S1zdkkJ2zYiiSIilCzmbNReURB14hubJH4+pmnf2QKXH2RdRs
 1OOokUqCpylmIrEdJFqzuJ1DV+WioZ9KBLp5UiCYtvv/+nx3n9e9HnVIcOudQopdeL6Y
 MaKhPgxGnzcF+wKrXwWj9L5VhHbqfjwXEy6ntsU667wE5aQrOmgFHI64KFmoUpgTE12G
 PA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bwmSGugiNPePeC1VV/onmxCTxlTIPfSnThRVgQfBnec=;
 b=KWm9KT6xKxWKq/baH18/ndVUoh9zTlRxz/SikCC5L1vcdFMKNK7V1IvnqI/971FrbJ
 vf3vJPBuR3+Y72EW6CBfM+7vo0Dg5e0QcJq+SaIpGTVVDTLfkTY6o4LLWDI2T6+n4QdM
 0TPEfvzSdrthXIK/RkeD0N+uW7ZBytAkJrFdLVqm3kVeTZDR3F7WRhNU/t0Lo4EL5Ffd
 isV3R1ZLQ4NdZhKwtLHOSIu+4/oY05HF34PbZ58DT4pKUCyKv53DEMSCwfvNkwGev8GM
 dVETAZnBczrtyo9qPqUb8HhGe+Jwbco8M/+fXrPb8xlS5fyfGcW1IgEWqxiCTr/jocdK
 K8yg==
X-Gm-Message-State: AOAM530vl4inij9mURo3BqhTsxjKWG+LlHr4uORoYj0Vq05xbSF6RERL
 sEIyA1e06u4PvefwDFERv77j2Q==
X-Google-Smtp-Source: ABdhPJxILRPBUzUL8xTAYrCMNhlD2yH/o0a+2/qap35MLBzSxmW+KOLuITPoOtX7LiVhtBXiykywHA==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr375788edr.204.1610476257361; 
 Tue, 12 Jan 2021 10:30:57 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id m5sm1514084eja.11.2021.01.12.10.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 10:30:56 -0800 (PST)
Date: Tue, 12 Jan 2021 19:30:55 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112183055.u3y34tfxh4d5aeue@unifi>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
 <20210112092207.GA4888@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112092207.GA4888@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_133059_074375_DB4B3EEC 
X-CRM114-Status: GOOD (  14.28  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12.01.2021 18:22, Minwoo Im wrote:
>Hello Javier,
>
>I tested this patch based on nvme-5.11:
>
>[    1.219747] BUG: unable to handle page fault for address: 0000000100000041
>[    1.220518] #PF: supervisor read access in kernel mode
>[    1.220582] #PF: error_code(0x0000) - not-present page
>[    1.220582] PGD 0 P4D 0
>[    1.220582] Oops: 0000 [#1] SMP PTI
>[    1.220582] CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.11.0-rc1+ #46
>[    1.220582] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>[    1.220582] Workqueue: nvme-wq nvme_scan_work
>[    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
>[    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
>[    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
>[    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
>[    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
>[    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
>[    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
>[    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
>[    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
>[    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
>[    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>[    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>[    1.220582] Call Trace:
>[    1.220582]  internal_create_group+0xde/0x390
>[    1.220582]  internal_create_groups.part.4+0x3e/0xa0
>[    1.220582]  device_add+0x3cf/0x830
>[    1.220582]  ? cdev_get+0x20/0x20
>[    1.220582]  ? cdev_purge+0x60/0x60
>[    1.220582]  cdev_device_add+0x44/0x70
>[    1.220582]  ? cdev_init+0x50/0x60
>[    1.220582]  nvme_alloc_chardev_ns+0x187/0x1eb
>[    1.220582]  nvme_alloc_ns+0x367/0x460
>[    1.220582]  nvme_validate_or_alloc_ns+0xe2/0x139
>[    1.220582]  nvme_scan_ns_list+0x113/0x17a
>[    1.220582]  nvme_scan_work+0xa5/0x106
>[    1.220582]  process_one_work+0x1dd/0x3e0
>[    1.220582]  worker_thread+0x2d/0x3b0
>[    1.220582]  ? cancel_delayed_work+0x90/0x90
>[    1.220582]  kthread+0x117/0x130
>[    1.220582]  ? kthread_park+0x90/0x90
>[    1.220582]  ret_from_fork+0x22/0x30
>[    1.220582] Modules linked in:
>[    1.220582] CR2: 0000000100000041
>[    1.220582] ---[ end trace b1f509a1bbfbc113 ]---
>[    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
>[    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
>[    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
>[    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
>[    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
>[    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
>[    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
>[    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
>[    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
>[    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
>[    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>[    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>And this happens when CONFIG_NVME_MULTIPATH=y configured.  Please refere
>attached log up there :)
>
>Thanks!

I have not implemented multipath support, but it should definitely not
crash like this. I'll rebase to 5.11 and test.

Christoph: Is it OK to send this without multipath or should I just send
all together?

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
