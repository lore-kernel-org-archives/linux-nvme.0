Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEEAD41D61
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Dec 2025 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XER0gi0P9Eu2O/l3YIJe5+k6MYwx2x081H2m6084ITg=; b=y7KBYw6f1C2IY6FBFEAs1X/7cX
	Z2RsXuh/uXpRPHYpnL2Fz5aY9OUv9fQIfi9mxEezAn/rw4ZK5xR60tRqgfAya9Ml6Syxq6wJd2C92
	qJZkXbTtX0pdb6nK2oS0NPbBdkDqcWUGQaF5vy2/GBVsdNuJkrsNOt80HBpSRovG9rIcE57chQ8sv
	V297DmkTGHGXtMNig6E2dB0c9rHVCgHbYhbbRVPp4qQJXRUnsanan2Umn0fSeLyAmARm230e/QRLA
	JqFFOOgqDaUj/hj//R1bnFdt7qOxFHCJYrtYpSa4Ikypz+fNWXkHrsmkr3DRcNWk0KlSs5tEZMuhn
	T1sHYFdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTin3-0000000GmqT-46Nv;
	Thu, 11 Dec 2025 15:41:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTin1-0000000Gmq7-2R1D
	for linux-nvme@lists.infradead.org;
	Thu, 11 Dec 2025 15:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765467670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XER0gi0P9Eu2O/l3YIJe5+k6MYwx2x081H2m6084ITg=;
	b=LfZe5vsyJA+2obgsRULWU9dEAqQdilUFP3qR0dodObQJWSfQ3ZY0p2idvgiHHeirWgSfVF
	ZKrePuvrnTkyKY8OCMs+g+dwLN34x0WK9Vd/Xlq5nNOPHi/ML2Bb+qA4ReNxxXhQkAxUyC
	NEghOjcW96tnYDiLU/PcNVnPRhz8l0I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-0ayh97mGO9C7T1NKVHoYZg-1; Thu, 11 Dec 2025 10:41:09 -0500
X-MC-Unique: 0ayh97mGO9C7T1NKVHoYZg-1
X-Mimecast-MFC-AGG-ID: 0ayh97mGO9C7T1NKVHoYZg_1765467667
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37bab6de7f8so962001fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Dec 2025 07:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765467666; x=1766072466;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XER0gi0P9Eu2O/l3YIJe5+k6MYwx2x081H2m6084ITg=;
        b=M4KwDOFDw2nTTdxM+EVAUNq3ef3vJjddK2uBohgm8BuF0mWToBciuY8QjCQ9Uqz7G2
         WYCUoAJ7SI6q2iK2Y/RRW0sSRu0hufByDQ9LInng/YgwivfT1Pi/eB1n1FIGK1KjyfEy
         nhwb3sRgDojHr1RdJ+J/JKglqYEtc9krc6pC9Z3sLXTgVNvcL7McoSEbEI7XiFRLjZ/Q
         4zpqLBDlynen7BwqUEArScACciKOpdbqqjLyjM/EaJvCgrSdpLkSq5klhI406N3g0+GV
         hFkqWq/b6fQjtYRzOXxIRY9kbGe5Qfn5ieFXejJUvpF7mNUvjMU9wJvbxy22n34avLjf
         07OA==
X-Forwarded-Encrypted: i=1; AJvYcCXmN02LvYenU2y0PiblWGcYWQT2ozlTBi64mgTa3VDQdMTwq63PhbDQ+xKEnYZ9NCkoC/Iu1UFiUlfz@lists.infradead.org
X-Gm-Message-State: AOJu0YxGoBDNAdEIDkLK/jJMRkgHUIWUatyOtdyZu7JcYq0tBs6qTG0I
	uYHdyVYPiHWayOnFtyLkBvOVHl9crP7k1N3hTZN5IL8Uz7WYqn3XbdZl5aafy7GbzMzpVWDE3bo
	lrq11MRvY8mfWfE0Gqy3oHsWW9NqJ7HVUMcO8b9PeXPZ8+jYVlrJhlqt8cxupRxn3sIZPvbhlR/
	zGQbx5r4z94ayNR0exN9VwuWrffl6ywrTXFoukzLjJ1lLaKXS4AitKnxgj
X-Gm-Gg: AY/fxX4nua/kbm4qmdK/gg7CM2jIbC8obxV7iUrZMiGuqwOVD1VONqozD/6UQkLsWhE
	kCVaE5EpnN2fXpLOLn08gb5b2WftMz5ywG7hARnYEmxLJL3qQtr0MPIPlcRdolzsud+/O4OEn8N
	pH+aoihvBIUZIph1QLUQAprv1g2QYg5NGZfMU1tXn/IlwcveG0kvToYWLx7IZ/di+L+CE=
X-Received: by 2002:a05:651c:1508:b0:37a:455e:f2fc with SMTP id 38308e7fff4ca-37fb2152acamr18379511fa.43.1765467666286;
        Thu, 11 Dec 2025 07:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV+wr655qzsjqLP7T1IVlB6YclIVXoe1Iz43J9qZE7N/ayL5NczpGkFZpArOkCiHpM7gRdcQUFwDYgUfFcJOA=
X-Received: by 2002:a05:651c:1508:b0:37a:455e:f2fc with SMTP id
 38308e7fff4ca-37fb2152acamr18379411fa.43.1765467665839; Thu, 11 Dec 2025
 07:41:05 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 11 Dec 2025 23:40:52 +0800
X-Gm-Features: AQt7F2pT_YFn9Ij3s8QGwKq_vywEOzVerk7FehyBknEkeqIpDyo0RNj-5CNMzs8
Message-ID: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
Subject: [bug report] kmemleak observed during blktests nvme/fc
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zATxuYM6mC5zf9AWhm79y3S2JQsaHaFBypv-53LMFbA_1765467667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_074111_712189_AE27C115 
X-CRM114-Status: UNSURE (   4.98  )
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

Hi
The following kmemleak was observed during blktests nvme/fc, please
help check it and let me know if you need any info/test for it,
thanks.

commit d678712ead7318d5650158aa00113f63ccd4e210
Merge: 95ed689e9f30 a0750fae73c5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Dec 10 13:41:17 2025 -0700

    Merge branch 'block-6.19' into for-next

    * block-6.19:
      blk-mq-dma: always initialize dma state

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88826cab51c0 (size 2488):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    60 1a be c1 ff ff ff ff c0 2b 05 73 77 60 00 00  `........+.sw`..
  backtrace (crc 155ec6c5):
    kmem_cache_alloc_node_noprof+0x5e4/0x830
    blk_alloc_queue+0x30/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8883428ec400 (size 96):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 c4 8e 42 83 88 ff ff 00 c4 8e 42 83 88 ff ff  ...B.......B....
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
  backtrace (crc 1deeea82):
    __kmalloc_cache_noprof+0x5de/0x820
    blk_alloc_queue_stats+0x3f/0x100
    blk_alloc_queue+0xc0/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object (percpu) 0x60777301a898 (size 8):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 8 bytes on cpu 9):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    pcpu_alloc_noprof+0x5e0/0xf10
    percpu_ref_init+0x2c/0x330
    blk_alloc_queue+0x533/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881a20fbf80 (size 64):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 9e db 8f ff ff ff ff  ................
    00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00  ................
  backtrace (crc 8cfdd87d):
    __kmalloc_cache_noprof+0x5de/0x820
    percpu_ref_init+0xbf/0x330
    blk_alloc_queue+0x533/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8883428ec600 (size 96):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 c6 8e 42 83 88 ff ff  ...........B....
    08 c6 8e 42 83 88 ff ff 00 00 00 00 00 00 00 00  ...B............
  backtrace (crc af4dc711):
    __kmalloc_cache_noprof+0x5de/0x820
    blk_mq_init_allocated_queue+0xce/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object (percpu) 0x607773052bc0 (size 256):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes on cpu 9):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 60 3c 17 97 ff ff ff ff  ........`<......
  backtrace (crc ce57ad5e):
    pcpu_alloc_noprof+0x5e0/0xf10
    blk_mq_init_allocated_queue+0xf0/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881459079e0 (size 8):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 8 bytes):
    00 a0 9e 43 82 88 ff ff                          ...C....
  backtrace (crc 69c4a0b3):
    __kmalloc_node_noprof+0x6ab/0x970
    __blk_mq_realloc_hw_ctxs+0x361/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8882439ea000 (size 1024):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff e0 3c 17 97 ff ff ff ff  .........<......
  backtrace (crc 66835ea5):
    __kmalloc_cache_node_noprof+0x5f9/0x840
    blk_mq_alloc_hctx+0x52/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881459072a0 (size 8):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 8 bytes):
    ff ff 00 00 00 00 00 00                          ........
  backtrace (crc b47d4cd6):
    __kmalloc_node_noprof+0x6ab/0x970
    alloc_cpumask_var_node+0x56/0xb0
    blk_mq_alloc_hctx+0x74/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88814b47b400 (size 128):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    c0 6b f1 fb ff e8 ff ff c0 6b 31 fc ff e8 ff ff  .k.......k1.....
    c0 6b 71 fc ff e8 ff ff c0 6b b1 fc ff e8 ff ff  .kq......k......
  backtrace (crc d04b4dbc):
    __kmalloc_node_noprof+0x6ab/0x970
    blk_mq_alloc_hctx+0x43a/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888256326c00 (size 512):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a9e88d35):
    __kvmalloc_node_noprof+0x814/0xb30
    sbitmap_init_node+0x184/0x730
    blk_mq_alloc_hctx+0x4b3/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e



-- 
Best Regards,
  Yi Zhang


