Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C04C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jun 2022 07:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MmcE7duW7Kv9hljlDQrUwDV3dtaPk2KpHKeurBsiEjc=; b=gk/n/aZKlVbmUva4HvkGqr+J95
	kMr0NGIoKOrbk3mUlu8V9l7pCg5Xl0nZlAMOZTPqlm0aFy0csms2V/kGFUoJ43WahQW7MIaeJMWgW
	vnVBO1eEZtDmxknSVRv3mBawZbbF5iAYFQ0kr9cx2hKymsDo0uY7xHEhAGlnab9TD+CT/iPPxIkTA
	5mHTOOLELgRhvEK4CYeL+MznwOUs8vli1eZGRzJGEwluDaWRi3G5cHcLAjScVVWvrd1OE9UuJpYm7
	vR8r6cZrPtuZ3b1ZPiAO4a4VaSzBfU9KvXO9rk2fRpc6f8o0SJEjQmhg88itgV2kvpb0e+JXaDd+3
	1WZFf1hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0Hx5-00FqZH-Q4; Sun, 12 Jun 2022 07:24:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0Hx2-00FqXg-L1
	for linux-nvme@lists.infradead.org; Sun, 12 Jun 2022 07:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655018631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MmcE7duW7Kv9hljlDQrUwDV3dtaPk2KpHKeurBsiEjc=;
	b=AY9D8rHB8fd0yURCwNn4QHfGCTZFCvU7l3IqCPSRCStncaphO9g0+lBrQA7eEGIbz2KXqz
	lLOC9AbcQfFs/alrzR7Iozoee3rHWIQLjWLPq3k/0VYVqIuCI+F9hd3DVBmMb/XaAjBZF8
	ORKKD3cljw2kDQKqSX8bKpX7hrIlTgo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-mOixb5TEO1qlr33ouumqDg-1; Sun, 12 Jun 2022 03:23:49 -0400
X-MC-Unique: mOixb5TEO1qlr33ouumqDg-1
Received: by mail-pj1-f70.google.com with SMTP id m5-20020a17090a4d8500b001e0cfe135c7so1449457pjh.3
        for <linux-nvme@lists.infradead.org>; Sun, 12 Jun 2022 00:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MmcE7duW7Kv9hljlDQrUwDV3dtaPk2KpHKeurBsiEjc=;
        b=Z09vBhwa2IIywXn+2OoH7TSW+hz3OCjwToq3J+BvUR9/z+I95m6EBssiMv9qGwBW3c
         x/AaHM8URNm3p5bmuy47myHB3klKBIbf/1yYsA5of+NmUD/EHdfNjT1uyA21EzHnUymL
         LVJyT1isIkxSxJqSP+9xWsux8mNP8U1tKIKzt1qt1Px+i7wOIWICcgmaqt6iP2QpL3wv
         6FIfM2m5IDccVRsljL/nIMCXn9L1euEWv1VzIAXgfQnrUXlHgxKRlvnq26Yv0Zy94jWb
         2YPnDehxQwZcB2dkXmMEuXgNjTqqxbN5huqY34oM/VyrALfIcKWMYNWSEKd/iZBmXQQa
         c4wg==
X-Gm-Message-State: AOAM533inLpYxR6hUtxdwivQ4duU7CuFS2qeiEB2B28Gi3SOL6c3+RxD
	33I+tN/UhKWFr1XjK0Rf/+GerhdUWwdBGkI85KBpohcW2HAwo3jA2pAj5OKH/nXBUGboKDA3Oby
	Vdxv6DwaqU4b5IZpsI/hJuZkbAERX4RbLR64DZE5t3V8=
X-Received: by 2002:a17:90a:5ae1:b0:1db:d0a4:30a4 with SMTP id n88-20020a17090a5ae100b001dbd0a430a4mr8915764pji.128.1655018627915;
        Sun, 12 Jun 2022 00:23:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnnnlMbkwBLneNa3SCjjbXuuQ+10i1Ooyz31Fy+abA98lUIu7tjgrSe87DdDY2EMnvhvTZu4DIw2XfpExVjEY=
X-Received: by 2002:a17:90a:5ae1:b0:1db:d0a4:30a4 with SMTP id
 n88-20020a17090a5ae100b001dbd0a430a4mr8915739pji.128.1655018627578; Sun, 12
 Jun 2022 00:23:47 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 12 Jun 2022 15:23:36 +0800
Message-ID: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
Subject: [bug report] kmemleak observed from blktests on latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220612_002400_932570_B459610D 
X-CRM114-Status: UNSURE (   4.32  )
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

Hello
I found below kmemleak with the latest linux-block/for-next[1], pls
help check it, thanks.

[1]
75d6654eb3ab (origin/for-next) Merge branch 'for-5.19/block' into for-next


unreferenced object 0xffff88831d0fe800 (size 256):
  comm "check", pid 15430, jiffies 4306578361 (age 70450.608s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff 00 80 76 a6 83 88 ff ff  ..........v.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<00000000a875060e>] nbd_config_put+0x6c1/0x7e0 [nbd]
    [<0000000086fab6c1>] nbd_start_device_ioctl+0x454/0x4a0 [nbd]
    [<000000009305a7c9>] configfs_write_iter+0x2b0/0x480
    [<0000000047e9815b>] new_sync_write+0x2ef/0x530
    [<0000000009113f79>] vfs_write+0x626/0x910
    [<00000000ef2d7042>] ksys_write+0xf9/0x1d0
    [<00000000ca06addd>] do_syscall_64+0x5c/0x80
    [<00000000e1ffe4b5>]
entry_SYSCALL_64_after_hwframe+0x46/0xb0unreferenced object
0xffff88818f43fe00 (size 256):
  comm "kworker/u32:13", pid 53617, jiffies 4370965500 (age 6066.292s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff c0 62 c1 0d 81 88 ff ff  .........b......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<0000000031ca7691>] nvme_mpath_alloc_disk+0x28a/0x8a0 [nvme_core]
    [<000000002038acbe>] nvme_alloc_ns_head+0x40c/0x740 [nvme_core]
    [<00000000e54cea22>] nvme_init_ns_head+0x4a3/0xa40 [nvme_core]
    [<000000007694f30a>] nvme_alloc_ns+0x3c7/0x1690 [nvme_core]
    [<0000000085ede1e2>] nvme_validate_or_alloc_ns+0x240/0x400 [nvme_core]
    [<000000001de40492>] nvme_scan_ns_list+0x20b/0x550 [nvme_core]
    [<00000000e799d365>] nvme_scan_work+0x2d2/0x760 [nvme_core]
    [<000000005b788977>] process_one_work+0x8d4/0x14d0
    [<00000000c452e193>] worker_thread+0x5ac/0xec0
    [<000000005065b8e4>] kthread+0x2a7/0x350
    [<00000000fe3dc1db>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888720279c00 (size 256):
  comm "kworker/u32:2", pid 62305, jiffies 4370965926 (age 6065.866s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff 58 8c b0 88 85 88 ff ff  ........X.......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<0000000031ca7691>] nvme_mpath_alloc_disk+0x28a/0x8a0 [nvme_core]
    [<000000002038acbe>] nvme_alloc_ns_head+0x40c/0x740 [nvme_core]
    [<00000000e54cea22>] nvme_init_ns_head+0x4a3/0xa40 [nvme_core]
    [<000000007694f30a>] nvme_alloc_ns+0x3c7/0x1690 [nvme_core]
    [<0000000085ede1e2>] nvme_validate_or_alloc_ns+0x240/0x400 [nvme_core]
    [<000000001de40492>] nvme_scan_ns_list+0x20b/0x550 [nvme_core]
    [<00000000e799d365>] nvme_scan_work+0x2d2/0x760 [nvme_core]
    [<000000005b788977>] process_one_work+0x8d4/0x14d0
    [<00000000c452e193>] worker_thread+0x5ac/0xec0
    [<000000005065b8e4>] kthread+0x2a7/0x350
    [<00000000fe3dc1db>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888163681c00 (size 256):
  comm "kworker/u32:13", pid 53617, jiffies 4370966347 (age 6065.585s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff 60 31 b2 9c 82 88 ff ff  ........`1......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<0000000031ca7691>] nvme_mpath_alloc_disk+0x28a/0x8a0 [nvme_core]
    [<000000002038acbe>] nvme_alloc_ns_head+0x40c/0x740 [nvme_core]
    [<00000000e54cea22>] nvme_init_ns_head+0x4a3/0xa40 [nvme_core]
    [<000000007694f30a>] nvme_alloc_ns+0x3c7/0x1690 [nvme_core]
    [<0000000085ede1e2>] nvme_validate_or_alloc_ns+0x240/0x400 [nvme_core]
    [<000000001de40492>] nvme_scan_ns_list+0x20b/0x550 [nvme_core]
    [<00000000e799d365>] nvme_scan_work+0x2d2/0x760 [nvme_core]
    [<000000005b788977>] process_one_work+0x8d4/0x14d0
    [<00000000c452e193>] worker_thread+0x5ac/0xec0
    [<000000005065b8e4>] kthread+0x2a7/0x350
    [<00000000fe3dc1db>] ret_from_fork+0x22/0x30
-- 
Best Regards,
  Yi Zhang


