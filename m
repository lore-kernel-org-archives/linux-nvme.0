Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126BCF55105
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2026 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3Md33FNyJxS30YQPfvnWGJU9tpFdULTq8VhN/gO/QI=; b=aAjJObRGGK604f0Ti+uRHENzzC
	hX6CXRnHVhlglEL3dRlSfIbvvxR8eE4VnODR1hE80LlkD1OUUxp/6sNibXautCuBuXXFjl4TlV+6P
	R85OY++E0m/vqRefgv58IrfvcSgPqjAxB9lSTgdU73vbSO3JZfR7h1KmKfQqbjsPM7B/6gXSJzXEG
	gW2ONCTIll9baRqFpfLEyi7IfI+WeN0B1v8xyVLNDmzSRbTBSgEVjqiS+K1s1mKjMpScTcZHL9Yc4
	Ez0OEJ0zADswVgmm+bdmmLXBEWutP4mgk6uWLiX7v/78aEzjyGS4JBJlSCNsgvzBlmblqkTnThOKo
	hpzTR84Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyy3v-00000005U8M-323x;
	Sat, 07 Mar 2026 20:15:47 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyy3s-00000005U82-1C3u
	for linux-nvme@lists.infradead.org;
	Sat, 07 Mar 2026 20:15:46 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b96e1ae843dso25334066b.2
        for <linux-nvme@lists.infradead.org>; Sat, 07 Mar 2026 12:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772914542; x=1773519342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Md33FNyJxS30YQPfvnWGJU9tpFdULTq8VhN/gO/QI=;
        b=etaWjfWeGO3uuUbPO6B9P646qFQVXU6ioSeXMP300YvWMqVlDxr1n8UcWFeerM3F7I
         yKVaLDobAeRxArqn5P7H+KK0mB/rDkwGXYXAGSCoDDhRAUfws8H4Ixt0yalQeHufcIEs
         DbFnIln4SISSkRPGo6Gewrc5q7QyPp6ldfs2MyVrZ9jDv2CV3ZYafWKnHgZ42M2lK1vH
         kiwExjOPTSWwCpNM0FgSsTh/ILkI8cFFX67VDbtqQKSUqyu8QE3SRNVSUha6aRdS2dlc
         KN7HxiiL4UVvX3+6T/4SVw7DhRHbwXrHF1k7pAp1Dkh+YiWHyM+oHj87+iZP4bLWfWk/
         0gWw==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ7jQ4cRzJWNwaK507bH9BoppCnIawrR6a/R6mpYNDvFPN3Y/jBJa8dKCVpWJWkt6V+BErJKX8dm5@lists.infradead.org
X-Gm-Message-State: AOJu0YwbqYETitIdPRgufk1AU42b5mUdXa2itNHMm9X99lgURWVkGEwq
	PhfqgLzgq/5Dsv0bZek0/Z/MkcpshsD+rMo5Eimd4NQw187vU5d0rOJX9BqqfWl9+Ls=
X-Gm-Gg: ATEYQzwB3ZM2oRVMalCLLxM0SpZF7jCmryp/s96ptNBfnrbhFHG3i2rbD1i+aYcVkci
	+8TxDlmr7+2Me7gieIpnseuRbb79Wu9XL7R0XKmUVAcNBw2bhoLeAvJAhQr3kTENNUUGBqteKyD
	XmLOTMsCRPwwMwKTidn4EF7g+5QuYxW+b35vu+StuYjEGilCrjDa3IhOHyLWvVTBqiP5hPzQkTJ
	3DBvNRrxB+eFHFle7Q6EajhKpMey/uiPRkDhIw/Z2M2PVCtEUT2sJdtfsB/y5/J7/Ol+x9nJjmu
	PZf95qdBCIU/ZZ3ndzuGrN0BFiGS3lr98v2INMdDVUWv7CvlxiGfCTwQqLKv1cVb1V9WWQMiw6a
	fEBYeIp8ipNUkz60z/b1DYdTuczlWd21dkngt9sIwoTm6BRssVSlhAEuXSdTjoHF44w1fTzUSce
	hZFSVvK5k7+7xsn1dR60UCsYqLdWbhKcjfMmr5T3LQgyyRvKAWJ7PQ5Yk=
X-Received: by 2002:a17:907:72d3:b0:b8f:bb98:b8f6 with SMTP id a640c23a62f3a-b942dba8d11mr347436466b.19.1772914541202;
        Sat, 07 Mar 2026 12:15:41 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a559b992sm1487584a12.25.2026.03.07.12.15.38
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 12:15:39 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b611274bso4410226f8f.3
        for <linux-nvme@lists.infradead.org>; Sat, 07 Mar 2026 12:15:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVL9XlV24aTN0imRV0zBIfDPcVlH8Dh57cTLHG79K6TmVN2hCg715MkXoGtUIy+dju9ZwhkZlmjvvAa@lists.infradead.org
X-Received: by 2002:a05:6000:2404:b0:439:abcd:b312 with SMTP id
 ffacd0b85a97d-439da64f787mr11260517f8f.7.1772914538367; Sat, 07 Mar 2026
 12:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20260307194636.2755443-2-iam@sung-woo.kim>
In-Reply-To: <20260307194636.2755443-2-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Sat, 7 Mar 2026 15:15:22 -0500
X-Gmail-Original-Message-ID: <CAJNyHpL8HjfnCwDMcf0Jm8U2iQci73nGMRb6-8csGiQuRPoUgw@mail.gmail.com>
X-Gm-Features: AaiRm52q49pfpue_Gnpm_oa2HoGgXJ-YMgcB3IY6AlHLMVqo-cR78PPByDXe5nM
Message-ID: <CAJNyHpL8HjfnCwDMcf0Jm8U2iQci73nGMRb6-8csGiQuRPoUgw@mail.gmail.com>
Subject: Re: [PATCH] Fix race bug in nvme_poll_irqdisable()
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260307_121545_316315_854F3BBA 
X-CRM114-Status: UNSURE (   7.99  )
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

Also, this can permanently disable the first IRQ, preventing future
NVMe completions delivery.
Thus, bdev_open() and bdev_release() may stuck.

The task hung detector can detect this:

INFO: task syz-executor.2:15754 is blocked on a mutex likely owned by
task systemd-udevd:136.
task:systemd-udevd   state:D stack:0     pid:136   tgid:136   ppid:1
   task_flags:0x400100 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0xc92/0x54e0 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x87/0x300 kernel/sched/core.c:6964
 io_schedule+0xce/0x150 kernel/sched/core.c:7791
 folio_wait_bit_common+0x367/0x8b0 mm/filemap.c:1323
 folio_wait_bit_killable mm/filemap.c:1468 [inline]
 folio_wait_locked_killable include/linux/pagemap.h:1252 [inline]
 folio_wait_locked_killable include/linux/pagemap.h:1248 [inline]
 filemap_read_folio+0x175/0x2a0 mm/filemap.c:2502
 do_read_cache_folio+0x258/0x480 mm/filemap.c:4096
 read_cache_folio+0x5e/0x80 mm/filemap.c:4128
 read_mapping_folio include/linux/pagemap.h:1028 [inline]
 read_part_sector+0xd8/0x320 block/partitions/core.c:722
 read_lba+0x1cb/0x370 block/partitions/efi.c:247
 find_valid_gpt block/partitions/efi.c:602 [inline]
 efi_partition+0x285/0x2b10 block/partitions/efi.c:719
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed block/partitions/core.c:693 [inline]
 bdev_disk_changed+0x8dc/0x1710 block/partitions/core.c:642
 blkdev_get_whole+0x194/0x2a0 block/bdev.c:765
 bdev_open+0x4ba/0xeb0 block/bdev.c:974
 bdev_file_open_by_dev block/bdev.c:1076 [inline]
 bdev_file_open_by_dev+0x1b4/0x250 block/bdev.c:1051
 disk_scan_partitions+0x1f5/0x320 block/genhd.c:387
 blkdev_common_ioctl+0x3fb/0x29b0 block/ioctl.c:707
 blkdev_ioctl+0x299/0x700 block/ioctl.c:786
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x1bf/0x220 fs/ioctl.c:583
 x64_sys_call+0x1280/0x21b0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x71/0x330 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f16e1d2e277
RSP: 002b:00007ffe72978038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe72978150 RCX: 00007f16e1d2e277
RDX: 0000000000000000 RSI: 000000000000125f RDI: 000000000000000e
RBP: 00007ffe729781d0 R08: 000055ed818ee543 R09: 00007f16e1e0bbe0
R10: 0000000000000000 R11: 0000000000000246 R12: 000055ed818f4071
R13: 000055ed818ee89f R14: 00007ffe72978090 R15: 000055edb8a23bd0
 </TASK>

