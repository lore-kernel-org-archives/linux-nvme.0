Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E35C77B60
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Apr 2023 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VP8GUfZAP8K+9SRs7eH1Cyi0t6YeBe3zXCPUWGNKPA=; b=Nb1KLIm1/jUMIIAm9FxcavB1sn
	BuKTMPg/Jouf/WgReyGOYGTg0y86kPeCtO5A2dsMLPMG7vtQ1kAXVk1l3iWiyy9CmngrUiL4oEHvV
	4twcoO9mHUQziNVSncuC4wo6dPhVjaMD/UVsv+vl5HA+f7IuwfCYD05ZL3n/oxxWBYlHXbZBULtoa
	F4ZNfx8aY41iZuHONJsMQ5bd4B3UFFUB+RT3HU6H+7zpf+1A5gTnIVbWWg1PbTIsoFrt+98pemJ7K
	rDMz+D54qUirx7MEKJUapvOsuu7f1lG/hIc+1OCGEe4Fzt2kUcs21eAfG4Lj7yZEc6sxzpPHIDnBm
	wzohhg5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqaV6-00EOtN-19;
	Sun, 23 Apr 2023 14:15:36 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqaV2-00EOr7-0t
	for linux-nvme@lists.infradead.org;
	Sun, 23 Apr 2023 14:15:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f1745b7132so7712585e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Apr 2023 07:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259329; x=1684851329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VP8GUfZAP8K+9SRs7eH1Cyi0t6YeBe3zXCPUWGNKPA=;
        b=jIkfqcU68eb/DhM3n7y+OJ+QRH+ElLg4Ff+xHXm5P8b3YX8AziJLJmrLk9jKueav4c
         wjqDsRRVMJ3QoHzylITxioZHleViSw6DDJuDkGrwqe34V2sIo6+5v9zGnHQGx1AnPhKP
         HZdpUA0Q7bcZfwnLsl8FMAq0SPjEG2fa4e5wb7tk+9dcO/+L/GhWDTgmCDiUs7lG4Cer
         CDXB5IeABZl5fwHsCMvKjk1MJT0Io+EMbS3dagTOQhHMXD2s4VZ3/jZxOl8eT5repeuO
         gnMDHEB/+2i8RxDLs+FBEz2X3pxmR51vJ3kgtOwu96G75vgj0YICrPiQcFIwnMDl6BpQ
         w3rQ==
X-Gm-Message-State: AAQBX9eXmU2WnS7V/BWh9iivwqYmJEEkri436TFdwEvRCE+aq9/K8DbC
	acHl9Cs8VznzLwDQ6vNmC7A=
X-Google-Smtp-Source: AKy350b2tVddSJus/vOh0P/IZ4YDEhVzZ2offbsjjmAhv7Eptn9tPDPPuEIcIYfFH25yIGJokYT6Gg==
X-Received: by 2002:a05:600c:3581:b0:3f1:6f37:e48 with SMTP id p1-20020a05600c358100b003f16f370e48mr7889490wmq.1.1682259328590;
        Sun, 23 Apr 2023 07:15:28 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm9754443wmj.12.2023.04.23.07.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 07:15:28 -0700 (PDT)
Message-ID: <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
Date: Sun, 23 Apr 2023 17:15:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Hannes Reinecke <hare@suse.de>
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_071532_314648_20EA4BBE 
X-CRM114-Status: UNSURE (   7.68  )
X-CRM114-Notice: Please train this message.
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


> Hello
> 
> Below kmemleak observed after blktests nvme-tcp, pls help check it, thanks.
> 
> commit: linux-block/for-next
> aaf9cff31abe (origin/for-next) Merge branch 'for-6.4/io_uring' into for-next

Hey Yi,

Is this a regression?
And can you correlate to specific tests that trigger this?

> 
> unreferenced object 0xffff88821f0cc880 (size 32):
>    comm "kworker/1:2H", pid 3067, jiffies 4295825061 (age 12918.254s)
>    hex dump (first 32 bytes):
>      82 0c 38 08 00 ea ff ff 00 00 00 00 00 10 00 00  ..8.............
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
>      [<ffffffff8776d0bf>] sgl_alloc_order+0x7f/0x360
>      [<ffffffffc0ba9875>] 0xffffffffc0ba9875
>      [<ffffffffc0bb068f>] 0xffffffffc0bb068f
>      [<ffffffffc0bb2038>] 0xffffffffc0bb2038
>      [<ffffffffc0bb257c>] 0xffffffffc0bb257c
>      [<ffffffffc0bb2de3>] 0xffffffffc0bb2de3
>      [<ffffffff86897f49>] process_one_work+0x8b9/0x1550
>      [<ffffffff8689919c>] worker_thread+0x5ac/0xed0
>      [<ffffffff868b2222>] kthread+0x2a2/0x340
>      [<ffffffff866063ac>] ret_from_fork+0x2c/0x50
> unreferenced object 0xffff88823abb7c00 (size 512):
>    comm "nvme", pid 6312, jiffies 4295856007 (age 12887.309s)
>    hex dump (first 32 bytes):
>      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>      ff ff ff ff ff ff ff ff a0 53 5f 8e ff ff ff ff  .........S_.....
>    backtrace:
>      [<ffffffff86f63da7>] kmalloc_trace+0x27/0xe0
>      [<ffffffff87d61205>] device_add+0x645/0x12f0
>      [<ffffffff871c2a73>] cdev_device_add+0xf3/0x230
>      [<ffffffffc09ed7c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
>      [<ffffffffc0b54e0c>] 0xffffffffc0b54e0c
>      [<ffffffffc086b177>] 0xffffffffc086b177
>      [<ffffffffc086b613>] 0xffffffffc086b613
>      [<ffffffff871b41e6>] vfs_write+0x216/0xc60
>      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
>      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
>      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff88810ccc9b80 (size 96):
>    comm "nvme", pid 6312, jiffies 4295856008 (age 12887.308s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff86f63da7>] kmalloc_trace+0x27/0xe0
>      [<ffffffff87d918e0>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x200
>      [<ffffffffc09ed83c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
>      [<ffffffffc0b54e0c>] 0xffffffffc0b54e0c
>      [<ffffffffc086b177>] 0xffffffffc086b177
>      [<ffffffffc086b613>] 0xffffffffc086b613
>      [<ffffffff871b41e6>] vfs_write+0x216/0xc60
>      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
>      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
>      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff8881d1fdb780 (size 64):
>    comm "check", pid 6358, jiffies 4295859851 (age 12883.466s)
>    hex dump (first 32 bytes):
>      44 48 48 43 2d 31 3a 30 30 3a 4e 46 76 44 6d 75  DHHC-1:00:NFvDmu
>      52 58 77 79 54 79 62 57 78 70 43 4a 45 4a 68 36  RXwyTybWxpCJEJh6
>    backtrace:
>      [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
>      [<ffffffffc09fb710>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_core]
>      [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
>      [<ffffffff871b47d2>] vfs_write+0x802/0xc60
>      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
>      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
>      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff8881d1fdb600 (size 64):
>    comm "check", pid 6358, jiffies 4295859908 (age 12883.409s)
>    hex dump (first 32 bytes):
>      44 48 48 43 2d 31 3a 30 30 3a 4e 46 76 44 6d 75  DHHC-1:00:NFvDmu
>      52 58 77 79 54 79 62 57 78 70 43 4a 45 4a 68 36  RXwyTybWxpCJEJh6
>    backtrace:
>      [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
>      [<ffffffffc09fb710>] nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_core]
>      [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
>      [<ffffffff871b47d2>] vfs_write+0x802/0xc60
>      [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
>      [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
>      [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> --
> Best Regards,
>    Yi Zhang
> 

