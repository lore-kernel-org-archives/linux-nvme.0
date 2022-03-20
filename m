Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CCEC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Mar 2022 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5sRQAmoTSGTiIsfeqFCXPb93iYlZ+sGnfZi7ymf7ck=; b=s7jRvxBfMfFyg7faCGsnMc1dXs
	nQ7iYzMKLXYa4GPir/DWrJcr9Tl2JZ4uF+GMDL1RiDhlesnTXY3VhKmaCVJy5h6+lfcQEVPPd041C
	o8UPqus5YfoI6ipSLw4Q8Ji3mdqSprepkanH+vKlX+kuv6gdObDhf42RY1iqEHmaLZNggIX1O2g9k
	FfckkeRfFjXaFkz4JHUmY4gR7h/TpOB2Y1ClaoiNtZmNMWI8wcKW90oNNjalkszz88CigG0WnMD+1
	yqRxUy+SuEiM1JVHFkWefwACYb0YF5b99nsWw3MYE9Zden2d3xb6tE3wPzVvqLoYqYD0n+WEWeMV3
	pRQAzSag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nVvAc-005Ggy-8X; Sun, 20 Mar 2022 13:00:30 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nVvAZ-005GgY-Fd
 for linux-nvme@lists.infradead.org; Sun, 20 Mar 2022 13:00:29 +0000
Received: by mail-wr1-f43.google.com with SMTP id j10so4405896wrb.13
 for <linux-nvme@lists.infradead.org>; Sun, 20 Mar 2022 06:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=y5sRQAmoTSGTiIsfeqFCXPb93iYlZ+sGnfZi7ymf7ck=;
 b=bavWslO2qkQGMk8cGa/cnN4dYBiLyZ3IbuXWMtV9BdD+aFcQmib7G6Q75Yv3Q/SRSM
 fUxwbb8IMdZslrkoEoCvXstxc+XItCRwDLFVaoGeIa9FwnzUIbFulT7Ps0eCsYRnHIvO
 Twgn/UhyUX4IqddBv0xwBRz+jXvr5ccd1dWaDr6KXxPY0WynHSdpH3AnYLxhjAKCsJcd
 X+7bhlREeycV6a+FaZuMbP8sC/8tsp9+dlGBzlOzCCo/dyu19hkA0Avv6aryPmaBBDR4
 27B/1ee7ZQGrLouynmyJ2hhZgEUEUYsax+xj4G5EnL2Yd3jDm62J1E2wBCBYmj8OLY7Z
 J1qA==
X-Gm-Message-State: AOAM531tClDlzd3M5BjHhE0Q21AVfU6y+S90jR+izzN9E3hVgF9Pab+l
 hMJg3B1rth14z/P/PyLbu7I=
X-Google-Smtp-Source: ABdhPJza6KxaJvBjbj6xX61/XOa9xgzJrOxnYWpMqEt78TAWMoqN3jdiYy0Si5ydTRJxKyItWreBAg==
X-Received: by 2002:a05:6000:2ab:b0:204:f77:c1a with SMTP id
 l11-20020a05600002ab00b002040f770c1amr1384207wry.173.1647781225836; 
 Sun, 20 Mar 2022 06:00:25 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 v188-20020a1cacc5000000b00384b71a50d5sm11281287wme.24.2022.03.20.06.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Mar 2022 06:00:25 -0700 (PDT)
Message-ID: <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
Date: Sun, 20 Mar 2022 15:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Nitzan Carmi <nitzanc@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
 <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220320_060027_640988_6BD8BCF5 
X-CRM114-Status: GOOD (  15.20  )
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


>>> # nvme connect to target
>>> # nvme reset /dev/nvme0
>>> # nvme disconnect-all
>>> # sleep 10
>>> # echo scan > /sys/kernel/debug/kmemleak
>>> # sleep 60
>>> # cat /sys/kernel/debug/kmemleak
>>>
>> Thanks I was able to repro it with the above commands.
>>
>> Still not clear where is the leak is, but I do see some non-symmetric
>> code in the error flows that we need to fix. Plus the keep-alive timing
>> movement.
>>
>> It will take some time for me to debug this.
>>
>> Can you repro it with tcp transport as well ?
> 
> Yes, nvme/tcp also can reproduce it, here is the log:
> 
> unreferenced object 0xffff8881675f7000 (size 192):
>    comm "nvme", pid 3711, jiffies 4296033311 (age 2272.976s)
>    hex dump (first 32 bytes):
>      20 59 04 92 ff ff ff ff 00 00 da 13 81 88 ff ff   Y..............
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
>      [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
>      [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
>      [<000000002653e58d>] blk_alloc_queue+0x400/0x840
>      [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
>      [<00000000486936b6>] nvme_tcp_setup_ctrl+0x70c/0xbe0 [nvme_tcp]
>      [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
>      [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>      [<0000000056b79a25>] vfs_write+0x17e/0x9a0
>      [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
>      [<00000000c035c128>] do_syscall_64+0x3a/0x80
>      [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8881675f7600 (size 192):
>    comm "nvme", pid 3711, jiffies 4296033320 (age 2272.967s)
>    hex dump (first 32 bytes):
>      20 59 04 92 ff ff ff ff 00 00 22 92 81 88 ff ff   Y........".....
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
>      [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
>      [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
>      [<000000002653e58d>] blk_alloc_queue+0x400/0x840
>      [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
>      [<000000006ca5f9f6>] nvme_tcp_setup_ctrl+0x772/0xbe0 [nvme_tcp]
>      [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
>      [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>      [<0000000056b79a25>] vfs_write+0x17e/0x9a0
>      [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
>      [<00000000c035c128>] do_syscall_64+0x3a/0x80
>      [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8891fb6a3600 (size 192):
>    comm "nvme", pid 3711, jiffies 4296033511 (age 2272.776s)
>    hex dump (first 32 bytes):
>      20 59 04 92 ff ff ff ff 00 00 5c 1d 81 88 ff ff   Y........\.....
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
>      [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
>      [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
>      [<000000002653e58d>] blk_alloc_queue+0x400/0x840
>      [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
>      [<000000004a3bf20e>] nvme_tcp_setup_ctrl.cold.57+0x868/0xa5d [nvme_tcp]
>      [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
>      [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>      [<0000000056b79a25>] vfs_write+0x17e/0x9a0
>      [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
>      [<00000000c035c128>] do_syscall_64+0x3a/0x80
>      [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Looks like there is some asymmetry on blk_iolatency. It is intialized
when allocating a request queue and exited when deleting a genhd. In
nvme we have request queues that will never have genhd that corresponds
to them (like the admin queue).

Does this patch eliminate the issue?
--
diff --git a/block/blk-core.c b/block/blk-core.c
index 94bf37f8e61d..6ccc02a41f25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)

         blk_queue_flag_set(QUEUE_FLAG_DEAD, q);

+       rq_qos_exit(q);
         blk_sync_queue(q);
         if (queue_is_mq(q)) {
                 blk_mq_cancel_work_sync(q);
diff --git a/block/genhd.c b/block/genhd.c
index 54f60ded2ee6..10ff0606c100 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -626,7 +626,6 @@ void del_gendisk(struct gendisk *disk)

         blk_mq_freeze_queue_wait(q);

-       rq_qos_exit(q);
         blk_sync_queue(q);
         blk_flush_integrity();
         /*
--

