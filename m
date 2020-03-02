Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6753C3F2D1
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 02:04:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498DE2468D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 02:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNkrJIpe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LxEPOiBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498DE2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zNTPpdI1fkXu6UPFi+V6V5wC6sKLNCmnHEunKuDl/84=; b=kNkrJIpev8gDAI
	2jRXWBxk3pcJ3WbNERhz1yrHvwf4ZasJnoBGRTwsaszPIrzA4a2OyLXBVx9qbTATik1BcL/ybD2PE
	L0b6FremE1UQQ4C4uWWdFVVsCiPvCYr9OX54EpKqvh6U7Eqbb7o1vVDVmPTXi4ye4qT8kn/twzZ98
	cC9ICEpoK8ph7SAyGqhJjpdA2RXPnuk2LvSVwGu/p+xIcJBZ5vnxTD1zWh0shbj8OBB897L8rE0U3
	qaN0oPp3thBDQ7flTcaUlNbjcgQ3SC+In84TcDXJzKxRRn+YHnH8Lk/oPA3uS/yoGVmM6aC1Lf4Sf
	ykxSHq1CRCilJGBWt++w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8aRE-0005wD-Nr; Mon, 02 Mar 2020 02:04:08 +0000
Received: from frisell.zx2c4.com ([192.95.5.64])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8aR6-0005nJ-RW
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 02:04:03 +0000
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 391cbd2e;
 Mon, 2 Mar 2020 01:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
 :subject:message-id:mime-version:content-type; s=mail; bh=Zs8XUw
 O5e9G4YKZat1LsU/JcqiA=; b=LxEPOiBptXvA75E3nor8hOdvJrZgFKOLKaBEEJ
 0hWMXi8jGS0s1fasKwox0vE9+BD+HycEpvEyCJ3THzUvp0NLjd34FZxM0i38oMAr
 ztz5Uul8OlS8dcIlCzllZCV29gPg2I1w7bKEnZQqPEplcErqFKZEtHWgBQvJVcZt
 8DrBSIhm2ZQfbvPM1lUpR4WPcjocUpEz3iwADHs1u7Bp7ew6losVo2qclKY8iFuM
 UsgBM5BPZnYfqESsb4o+nYK5oHDSwayTGLY9f5VZTwlCVfQQvyo/wEXiF7syKLEm
 YtXibVmY25KQuHKnYaxK3ehxcXhUjTGiF+gh9B/D8A8Q6rNQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 205fd155
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Mon, 2 Mar 2020 01:59:33 +0000 (UTC)
Date: Mon, 2 Mar 2020 10:03:39 +0800
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-nvme@lists.infradead.org, linux-ext4@vger.kernel.org
Subject: "I/O 8 QID 0 timeout, reset controller" on 5.6-rc2
Message-ID: <20200302020339.GA5532@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_180401_047313_3024D441 
X-CRM114-Status: UNSURE (   6.26  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

My torrent client was doing some I/O when the below happened. I'm
wondering if this is a known thing that's been fixed during the rc
cycle, a regression, or if my (pretty new) NVMe drive is failing.

Thanks,
Jason

Feb 24 20:36:58 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, aborting
Feb 24 20:37:29 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, reset controller
Feb 24 20:37:59 thinkpad kernel: nvme nvme1: I/O 8 QID 0 timeout, reset controller
Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Device not ready; aborting reset
Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Abort status: 0x371
Feb 24 20:39:18 thinkpad kernel: INFO: task jbd2/dm-1-8:730 blocked for more than 122 seconds.
Feb 24 20:39:18 thinkpad kernel:       Tainted: P     U     O      5.6.0-rc2+ #39
Feb 24 20:39:18 thinkpad kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 24 20:39:18 thinkpad kernel: jbd2/dm-1-8     D    0   730      2 0x80004000
Feb 24 20:39:18 thinkpad kernel: Call Trace:
Feb 24 20:39:18 thinkpad kernel:  ? __schedule+0x1ba/0x540
Feb 24 20:39:18 thinkpad kernel:  ? bit_wait_timeout+0x60/0x60
Feb 24 20:39:18 thinkpad kernel:  schedule+0x45/0xb0
Feb 24 20:39:18 thinkpad kernel:  io_schedule+0xd/0x40
Feb 24 20:39:18 thinkpad kernel:  bit_wait_io+0x8/0x50
Feb 24 20:39:18 thinkpad kernel:  __wait_on_bit+0x23/0x80
Feb 24 20:39:18 thinkpad kernel:  out_of_line_wait_on_bit+0x7d/0x90
Feb 24 20:39:18 thinkpad kernel:  ? var_wake_function+0x20/0x20
Feb 24 20:39:18 thinkpad kernel:  jbd2_journal_commit_transaction+0xeb7/0x16c8
Feb 24 20:39:18 thinkpad kernel:  kjournald2+0xa2/0x250
Feb 24 20:39:18 thinkpad kernel:  ? wait_woken+0x80/0x80
Feb 24 20:39:18 thinkpad kernel:  kthread+0xf3/0x130
Feb 24 20:39:18 thinkpad kernel:  ? commit_timeout+0x10/0x10
Feb 24 20:39:18 thinkpad kernel:  ? kthread_park+0x80/0x80
Feb 24 20:39:18 thinkpad kernel:  ret_from_fork+0x1f/0x30
Feb 24 20:39:18 thinkpad kernel: INFO: task qbittorrent:2456 blocked for more than 122 seconds.
Feb 24 20:39:18 thinkpad kernel:       Tainted: P     U     O      5.6.0-rc2+ #39
Feb 24 20:39:18 thinkpad kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 24 20:39:18 thinkpad kernel: qbittorrent     D    0  2456      1 0x00000000
Feb 24 20:39:18 thinkpad kernel: Call Trace:
Feb 24 20:39:18 thinkpad kernel:  ? __schedule+0x1ba/0x540
Feb 24 20:39:18 thinkpad kernel:  schedule+0x45/0xb0
Feb 24 20:39:18 thinkpad kernel:  rwsem_down_write_slowpath+0x1e7/0x440
Feb 24 20:39:18 thinkpad kernel:  ext4_buffered_write_iter+0x2e/0x150
Feb 24 20:39:18 thinkpad kernel:  ext4_file_write_iter+0x48/0x7a0
Feb 24 20:39:18 thinkpad kernel:  do_iter_readv_writev+0x124/0x180
Feb 24 20:39:18 thinkpad kernel:  do_iter_write+0x77/0x190
Feb 24 20:39:18 thinkpad kernel:  vfs_writev+0x7b/0xd0
Feb 24 20:39:18 thinkpad kernel:  ? __fput+0x158/0x240
Feb 24 20:39:18 thinkpad kernel:  ? _cond_resched+0x10/0x20
Feb 24 20:39:18 thinkpad kernel:  do_pwritev+0x86/0xd0
Feb 24 20:39:18 thinkpad kernel:  do_syscall_64+0x3d/0x140
Feb 24 20:39:18 thinkpad kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 24 20:39:18 thinkpad kernel: RIP: 0033:0x7f6f049cafa4
Feb 24 20:39:18 thinkpad kernel: Code: Bad RIP value.
Feb 24 20:39:18 thinkpad kernel: RSP: 002b:00007f6ee3ffc870 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
Feb 24 20:39:18 thinkpad kernel: RAX: ffffffffffffffda RBX: 0000000071e78000 RCX: 00007f6f049cafa4
Feb 24 20:39:18 thinkpad kernel: RDX: 0000000000000001 RSI: 00007f6ee3ffc8c0 RDI: 0000000000000033
Feb 24 20:39:18 thinkpad kernel: RBP: 00007f6ee3ffc940 R08: 0000000000000000 R09: 0000000000000000
Feb 24 20:39:18 thinkpad kernel: R10: 0000000071e78000 R11: 0000000000000246 R12: 0000000000000001
Feb 24 20:39:18 thinkpad kernel: R13: 0000000000000033 R14: 0000000000000001 R15: 00007f6ee3ffc8c0
Feb 24 20:39:18 thinkpad kernel: INFO: task qbittorrent:7733 blocked for more than 122 seconds.
Feb 24 20:39:18 thinkpad kernel:       Tainted: P     U     O      5.6.0-rc2+ #39
Feb 24 20:39:18 thinkpad kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 24 20:39:18 thinkpad kernel: qbittorrent     D    0  7733      1 0x00000000
Feb 24 20:39:18 thinkpad kernel: Call Trace:
Feb 24 20:39:18 thinkpad kernel:  ? __schedule+0x1ba/0x540
Feb 24 20:39:18 thinkpad kernel:  schedule+0x45/0xb0
Feb 24 20:39:18 thinkpad kernel:  rwsem_down_write_slowpath+0x1e7/0x440
Feb 24 20:39:18 thinkpad kernel:  ext4_buffered_write_iter+0x2e/0x150
Feb 24 20:39:18 thinkpad kernel:  ext4_file_write_iter+0x48/0x7a0
Feb 24 20:39:18 thinkpad kernel:  ? wake_up_q+0x56/0x90
Feb 24 20:39:18 thinkpad kernel:  ? _cond_resched+0x10/0x20
Feb 24 20:39:18 thinkpad kernel:  ? __kmalloc+0x15f/0x250
Feb 24 20:39:18 thinkpad kernel:  do_iter_readv_writev+0x124/0x180
Feb 24 20:39:18 thinkpad kernel:  do_iter_write+0x77/0x190
Feb 24 20:39:18 thinkpad kernel:  vfs_writev+0x7b/0xd0
Feb 24 20:39:18 thinkpad kernel:  ? do_epoll_ctl+0x250/0x1020
Feb 24 20:39:18 thinkpad kernel:  ? __x64_sys_futex+0x127/0x140
Feb 24 20:39:18 thinkpad kernel:  do_pwritev+0x86/0xd0
Feb 24 20:39:18 thinkpad kernel:  do_syscall_64+0x3d/0x140
Feb 24 20:39:18 thinkpad kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 24 20:39:18 thinkpad kernel: RIP: 0033:0x7f6f049cafa4
Feb 24 20:39:18 thinkpad kernel: Code: Bad RIP value.
Feb 24 20:39:18 thinkpad kernel: RSP: 002b:00007f6e5fffbf30 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
Feb 24 20:39:18 thinkpad kernel: RAX: ffffffffffffffda RBX: 0000000072b38000 RCX: 00007f6f049cafa4
Feb 24 20:39:18 thinkpad kernel: RDX: 0000000000000032 RSI: 00007f6e5fffbf80 RDI: 0000000000000033
Feb 24 20:39:18 thinkpad kernel: RBP: 00007f6e5fffc310 R08: 0000000000000000 R09: 0000000000000000
Feb 24 20:39:18 thinkpad kernel: R10: 0000000072b38000 R11: 0000000000000246 R12: 0000000000000032
Feb 24 20:39:18 thinkpad kernel: R13: 0000000000000033 R14: 0000000000000032 R15: 00007f6e5fffbf80
Feb 24 20:39:18 thinkpad kernel: INFO: task qbittorrent:11389 blocked for more than 122 seconds.
Feb 24 20:39:18 thinkpad kernel:       Tainted: P     U     O      5.6.0-rc2+ #39
Feb 24 20:39:18 thinkpad kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 24 20:39:18 thinkpad kernel: qbittorrent     D    0 11389      1 0x00000000
Feb 24 20:39:18 thinkpad kernel: Call Trace:
Feb 24 20:39:18 thinkpad kernel:  ? __schedule+0x1ba/0x540
Feb 24 20:39:18 thinkpad kernel:  ? bit_wait_timeout+0x60/0x60
Feb 24 20:39:18 thinkpad kernel:  schedule+0x45/0xb0
Feb 24 20:39:18 thinkpad kernel:  io_schedule+0xd/0x40
Feb 24 20:39:18 thinkpad kernel:  bit_wait_io+0x8/0x50
Feb 24 20:39:18 thinkpad kernel:  __wait_on_bit+0x23/0x80
Feb 24 20:39:18 thinkpad kernel:  out_of_line_wait_on_bit+0x7d/0x90
Feb 24 20:39:18 thinkpad kernel:  ? var_wake_function+0x20/0x20
Feb 24 20:39:18 thinkpad kernel:  do_get_write_access+0x2c1/0x3d0
Feb 24 20:39:18 thinkpad kernel:  jbd2_journal_get_write_access+0x2e/0x50
Feb 24 20:39:18 thinkpad kernel:  __ext4_journal_get_write_access+0x32/0x70
Feb 24 20:39:18 thinkpad kernel:  ? ext4_dirty_inode+0x4e/0x70
Feb 24 20:39:18 thinkpad kernel:  ext4_reserve_inode_write+0x8e/0xc0
Feb 24 20:39:18 thinkpad kernel:  ext4_mark_inode_dirty+0x3c/0x1c0
Feb 24 20:39:18 thinkpad kernel:  ext4_dirty_inode+0x4e/0x70
Feb 24 20:39:18 thinkpad kernel:  __mark_inode_dirty+0x243/0x360
Feb 24 20:39:18 thinkpad kernel:  generic_update_time+0x98/0xc0
Feb 24 20:39:18 thinkpad kernel:  file_update_time+0xa4/0xf0
Feb 24 20:39:18 thinkpad kernel:  ? generic_write_checks+0x59/0xa0
Feb 24 20:39:18 thinkpad kernel:  ext4_buffered_write_iter+0x4d/0x150
Feb 24 20:39:18 thinkpad kernel:  ext4_file_write_iter+0x48/0x7a0
Feb 24 20:39:18 thinkpad kernel:  do_iter_readv_writev+0x124/0x180
Feb 24 20:39:18 thinkpad kernel:  do_iter_write+0x77/0x190
Feb 24 20:39:18 thinkpad kernel:  vfs_writev+0x7b/0xd0
Feb 24 20:39:18 thinkpad kernel:  ? __x64_sys_futex+0x127/0x140
Feb 24 20:39:18 thinkpad kernel:  do_pwritev+0x86/0xd0
Feb 24 20:39:18 thinkpad kernel:  do_syscall_64+0x3d/0x140
Feb 24 20:39:18 thinkpad kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 24 20:39:18 thinkpad kernel: RIP: 0033:0x7f6f049cafa4
Feb 24 20:39:18 thinkpad kernel: Code: Bad RIP value.
Feb 24 20:39:18 thinkpad kernel: RSP: 002b:00007f6e5f7fb850 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
Feb 24 20:39:18 thinkpad kernel: RAX: ffffffffffffffda RBX: 00000000739b0000 RCX: 00007f6f049cafa4
Feb 24 20:39:18 thinkpad kernel: RDX: 0000000000000001 RSI: 00007f6e5f7fb8a0 RDI: 000000000000002d
Feb 24 20:39:18 thinkpad kernel: RBP: 00007f6e5f7fb920 R08: 0000000000000000 R09: 0000000000000000
Feb 24 20:39:18 thinkpad kernel: R10: 00000000739b0000 R11: 0000000000000246 R12: 0000000000000001
Feb 24 20:39:18 thinkpad kernel: R13: 000000000000002d R14: 0000000000000001 R15: 00007f6e5f7fb8a0
Feb 24 20:39:18 thinkpad kernel: INFO: task kworker/u32:11:9953 blocked for more than 122 seconds.
Feb 24 20:39:18 thinkpad kernel:       Tainted: P     U     O      5.6.0-rc2+ #39
Feb 24 20:39:18 thinkpad kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 24 20:39:18 thinkpad kernel: kworker/u32:11  D    0  9953      2 0x80004000
Feb 24 20:39:18 thinkpad kernel: Workqueue: writeback wb_workfn (flush-254:1)
Feb 24 20:39:18 thinkpad kernel: Call Trace:
Feb 24 20:39:18 thinkpad kernel:  ? __schedule+0x1ba/0x540
Feb 24 20:39:18 thinkpad kernel:  ? bit_wait_timeout+0x60/0x60
Feb 24 20:39:18 thinkpad kernel:  schedule+0x45/0xb0
Feb 24 20:39:18 thinkpad kernel:  io_schedule+0xd/0x40
Feb 24 20:39:18 thinkpad kernel:  bit_wait_io+0x8/0x50
Feb 24 20:39:18 thinkpad kernel:  __wait_on_bit+0x23/0x80
Feb 24 20:39:18 thinkpad kernel:  out_of_line_wait_on_bit+0x7d/0x90
Feb 24 20:39:18 thinkpad kernel:  ? var_wake_function+0x20/0x20
Feb 24 20:39:18 thinkpad kernel:  do_get_write_access+0x2c1/0x3d0
Feb 24 20:39:18 thinkpad kernel:  jbd2_journal_get_write_access+0x2e/0x50
Feb 24 20:39:18 thinkpad kernel:  __ext4_journal_get_write_access+0x32/0x70
Feb 24 20:39:18 thinkpad kernel:  ? ext4_dirty_inode+0x4e/0x70
Feb 24 20:39:18 thinkpad kernel:  ext4_reserve_inode_write+0x8e/0xc0
Feb 24 20:39:18 thinkpad kernel:  ext4_mark_inode_dirty+0x3c/0x1c0
Feb 24 20:39:18 thinkpad kernel:  ext4_dirty_inode+0x4e/0x70
Feb 24 20:39:18 thinkpad kernel:  __mark_inode_dirty+0x243/0x360
Feb 24 20:39:18 thinkpad kernel:  ext4_da_update_reserve_space+0x155/0x170
Feb 24 20:39:18 thinkpad kernel:  ext4_ext_map_blocks+0xcde/0x1190
Feb 24 20:39:18 thinkpad kernel:  ext4_map_blocks+0xd7/0x540
Feb 24 20:39:18 thinkpad kernel:  ? _cond_resched+0x10/0x20
Feb 24 20:39:18 thinkpad kernel:  ? kmem_cache_alloc+0x14a/0x200
Feb 24 20:39:18 thinkpad kernel:  ext4_writepages+0x750/0xd30
Feb 24 20:39:18 thinkpad kernel:  ? dma_pte_clear_level+0x158/0x1b0
Feb 24 20:39:18 thinkpad kernel:  ? do_writepages+0x29/0xb0
Feb 24 20:39:18 thinkpad kernel:  do_writepages+0x29/0xb0
Feb 24 20:39:18 thinkpad kernel:  ? __wb_calc_thresh+0x25/0x100
Feb 24 20:39:18 thinkpad kernel:  __writeback_single_inode+0x38/0x320
Feb 24 20:39:18 thinkpad kernel:  writeback_sb_inodes+0x1e7/0x460
Feb 24 20:39:18 thinkpad kernel:  __writeback_inodes_wb+0x47/0xc0
Feb 24 20:39:18 thinkpad kernel:  wb_writeback+0x225/0x2b0
Feb 24 20:39:18 thinkpad kernel:  wb_workfn+0x393/0x4c0
Feb 24 20:39:18 thinkpad kernel:  process_one_work+0x1d1/0x380
Feb 24 20:39:18 thinkpad kernel:  worker_thread+0x45/0x3c0
Feb 24 20:39:18 thinkpad kernel:  kthread+0xf3/0x130
Feb 24 20:39:18 thinkpad kernel:  ? process_one_work+0x380/0x380
Feb 24 20:39:18 thinkpad kernel:  ? kthread_park+0x80/0x80
Feb 24 20:39:18 thinkpad kernel:  ret_from_fork+0x1f/0x30
Feb 24 20:39:31 thinkpad kernel: nvme nvme1: Device not ready; aborting reset
Feb 24 20:39:31 thinkpad kernel: nvme nvme1: Removing after probe failure status: -19
Feb 24 20:40:02 thinkpad kernel: nvme nvme1: Device not ready; aborting reset
Feb 24 20:40:02 thinkpad kernel: blk_update_request: I/O error, dev nvme1n1, sector 2161435200 op 0x1:(WRITE) flags 0x800 phys_seg 2 prio class 0
Feb 24 20:40:02 thinkpad kernel: Aborting journal on device dm-1-8.
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1) in ext4_reserve_inode_write:5618: Journal has aborted
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1) in ext4_do_update_inode:5055: Journal has aborted
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 217612288, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1) in ext4_dirty_inode:5816: Journal has aborted
Feb 24 20:40:02 thinkpad kernel: JBD2: Error -5 detected when updating journal superblock for dm-1-8.
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1) in ext4_dirty_inode:5816: IO failure
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1) in ext4_writepages:2795: IO failure
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): previous I/O error to superblock detected
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: EXT4-fs warning (device dm-1): ext4_end_bio:347: I/O error 10 writing to inode 22851099 starting block 43856256)
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): I/O error while writing superblock
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1): ext4_journal_check_start:84: Detected aborted journal
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): Remounting filesystem read-only
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1): ext4_journal_check_start:84: Detected aborted journal
Feb 24 20:40:02 thinkpad kernel: EXT4-fs (dm-1): Remounting filesystem read-only
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on dev dm-1, logical block 0, lost sync page write
Feb 24 20:40:02 thinkpad kernel: EXT4-fs error (device dm-1): ext4_journal_check_start:84: Detected aborted journal
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on device dm-1, logical block 43856256
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on device dm-1, logical block 43856257
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on device dm-1, logical block 43856258
Feb 24 20:40:02 thinkpad kernel: Buffer I/O error on device dm-1, logical block 43856259
Feb 24 20:40:02 thinkpad kernel: nvme nvme1: failed to set APST feature (-19)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
