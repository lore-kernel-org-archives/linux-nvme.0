Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1C2C56205
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oliBzuP6J83For3trSwQ/QDdChWGW2mUE93fKekyBf8=; b=naA8/B309Xs4wGFiqNOa8iazxD
	nyP/Nt8zOEtmcP9firL0NIZk9Mj9LAGwvX8M36FmsHmTyBJFkXOjsNFqIiALFwMdY6ZqzFamPjK86
	MEVY1us90o6A12+c+a5AlXpd7KvL2CSFrbj79cP0VNx3lAYbQWSMUitCJv6gwPgc9WHnngUDEV8oE
	W8jbtbNgOfKC6hEzq6ty7Xa0lvcOzFRDwBPNiflsWzJ2ckm5fdCmOcFkKWm6aIwywPxYWICX0UiC8
	dTqWNGoTh+M1GmSNxRYV95Ld4S+RsacjzYSELA72K76rzYPK43EkC5VPk8asS//M+G/RS+xIp7vSv
	vG0zO6vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrzza-000000064rv-2bet;
	Thu, 06 Aug 2026 15:26:46 +0000
Received: from mail-oa1-f78.google.com ([209.85.160.78])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrzzU-000000064rA-3BG4
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 15:26:42 +0000
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-44d0960fb5bso2338098fac.2
        for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2026 08:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029999; x=1786634799;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oliBzuP6J83For3trSwQ/QDdChWGW2mUE93fKekyBf8=;
        b=k2hHlFJbcGqGlmOg270z6dvlP2rI4M33vKCS3rGra42MG49kZy5dF92PVnZUR+1/+2
         dw67m4ggkuY4EEOz9gyONrgTPDJ6zGhJTsfooubJ7kHRBYvFKePMCNxQ8IPsspHwrAb+
         sEuxzeRIdI+eAJWBmCvO80bA4TbG///e7Gtm0BNVnzydBVKvnO/0Dd4z7PCpt+/ZeRo5
         oOI831UtHgY3+hG6xld1uud9ay8xZ/pA74j7D36fpDsFFGK7e/mMjYnTEpHWFmZjFR0E
         6LBZuFzmOrdgfXlCO90+aFp06GgeCa4CE0UWYi7CyyXa6vOtvUFfJKkc5o6eIrmJgm7g
         cAKg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0i8qm5Res7GGFyfb2ZHECtkemQ/+pa7QkcGrM5h7x5r13dGGmRhJf2omKb9eFZ31yWA9VAtp+Y15f@lists.infradead.org
X-Gm-Message-State: AOJu0YyDx25O/dWZki8emYgd2JWt2EElGlju9B23jat9PSbqOuh6ZrzE
	hjqlnFRiR29tioCX5exK9VzK/B+B3o907nBv0Ay5mRU0PzEn2GEco3yQ9o2UIZqfz6gfe9DDSdv
	3LGuMD+YUJr8Xw1uwkWrq/cS6knjGEDSgk5NHbCa4InaaiyZ4s5R/VOzaEZQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f03:b0:6ae:3815:ff7d with SMTP id
 006d021491bc7-6ae96d129b9mr7603776eaf.14.1786029999325; Thu, 06 Aug 2026
 08:26:39 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:26:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74a7af.01d0871a.3a0d52.0021.GAE@google.com>
Subject: [syzbot] [nvme?] possible deadlock in nvmf_dev_show
From: syzbot <syzbot+0e8964254f19d55e5679@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_082640_811187_08CE7C5A 
X-CRM114-Status: UNSURE (   8.72  )
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

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148a3c99580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0e8964254f19d55e5679
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ecb6d42b95f/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53481594a62a/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11ad64300b74/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e8964254f19d55e5679@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.3.1694/12704 is trying to acquire lock:
ffffffff8fd25f60 (nvmf_dev_mutex){+.+.}-{4:4}, at: nvmf_dev_show+0x26/0x210 drivers/nvme/host/fabrics.c:1444

but task is already holding lock:
ffff88804e4bc998 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x1270 fs/seq_file.c:183

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       seq_read_iter+0xe1/0x1270 fs/seq_file.c:183
       kernfs_fop_read_iter+0x46c/0x610 fs/kernfs/file.c:290
       __kernel_read+0x397/0xad0 fs/read_write.c:532
       integrity_kernel_read+0x7e/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x25e/0x350 security/integrity/ima/ima_crypto.c:222
       ima_calc_file_hash+0x1e3/0x380 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
       process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open_root+0x2f6/0x5a0 fs/namei.c:4916
       file_open_root+0x1c6/0x3f0 fs/open.c:1355
       kernel_read_file_from_path_initns+0x189/0x260 fs/kernel_read_file.c:163
       fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
       _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c:873
       request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
       reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
       __sys_sendmsg+0x160/0x210 net/socket.c:2770
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (cb_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       genl_release+0x7e/0x1d0 net/netlink/genetlink.c:697
       netlink_release+0x1058/0x1ff0 net/netlink/af_netlink.c:735
       __sock_release+0xb3/0x260 net/socket.c:710
       sock_close+0x1c/0x30 net/socket.c:1501
       __fput+0x3ff/0xb50 fs/file_table.c:512
       fput_close_sync+0x118/0x250 fs/file_table.c:617
       __do_sys_close fs/open.c:1511 [inline]
       __se_sys_close fs/open.c:1496 [inline]
       __x64_sys_close+0x8b/0x120 fs/open.c:1496
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       __sock_release+0x86/0x260 net/socket.c:709
       sock_close+0x1c/0x30 net/socket.c:1501
       __fput+0x3ff/0xb50 fs/file_table.c:512
       __fput_sync+0xd4/0x100 fs/file_table.c:604
       nvme_tcp_alloc_queue.isra.0+0xd53/0x1750 drivers/nvme/host/tcp.c:1922
       nvme_tcp_alloc_admin_queue drivers/nvme/host/tcp.c:2107 [inline]
       nvme_tcp_configure_admin_queue+0x26/0x4d0 drivers/nvme/host/tcp.c:2261
       nvme_tcp_setup_ctrl+0xa4/0xa20 drivers/nvme/host/tcp.c:2391
       nvme_tcp_create_ctrl+0x975/0xd20 drivers/nvme/host/tcp.c:3014
       nvmf_create_ctrl drivers/nvme/host/fabrics.c:1359 [inline]
       nvmf_dev_write+0x4ee/0xb60 drivers/nvme/host/fabrics.c:1406
       vfs_write+0x2aa/0x1050 fs/read_write.c:685
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (nvmf_dev_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       nvmf_dev_show+0x26/0x210 drivers/nvme/host/fabrics.c:1444
       seq_read_iter+0x32f/0x1270 fs/seq_file.c:231
       seq_read+0x344/0x4d0 fs/seq_file.c:163
       vfs_read+0x1e4/0xb40 fs/read_write.c:572
       ksys_read+0x12a/0x250 fs/read_write.c:716
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  nvmf_dev_mutex --> &ima_iint_mutex_key[depth] --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(&ima_iint_mutex_key[depth]);
                               lock(&p->lock);
  lock(nvmf_dev_mutex);

 *** DEADLOCK ***

1 lock held by syz.3.1694/12704:
 #0: ffff88804e4bc998 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x1270 fs/seq_file.c:183

stack backtrace:
CPU: 0 UID: 0 PID: 12704 Comm: syz.3.1694 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 nvmf_dev_show+0x26/0x210 drivers/nvme/host/fabrics.c:1444
 seq_read_iter+0x32f/0x1270 fs/seq_file.c:231
 seq_read+0x344/0x4d0 fs/seq_file.c:163
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f750099e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75017a5028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f7500c26180 RCX: 00007f750099e0d9
RDX: 0000000000002020 RSI: 00002000000007c0 RDI: 0000000000000005
RBP: 00007f7500a35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7500c26218 R14: 00007f7500c26180 R15: 00007ffd2a300088
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

