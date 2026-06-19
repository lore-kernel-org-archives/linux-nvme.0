Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AEECD98F2
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=sDSV7GPu8UH7sbQJKhtjWCvmc6DNEc78/iQ/s01ojgw=; b=LmT7jEzTlhCvZO
	dJaKM5181AirxMzCnykJTx9sL/J+KIoLk4t6phsWez7MzFxX/7e3AcHiVGcac8vGfTnYU2dJ0NsoQ
	PUwCCsasUUUMgA1Qt3ytmin0xoc62mENhtFTIq7SFx8/8+AcD/Di5uWcXDJg1hTW1j8FCuDugsFNa
	JK+5z8KZcpbh99QrheAaQpED9jEDdXj8Ev4wEqWvxbX0SFUaQZr5CuKwMfveZrMUNnTzdrynD4g6O
	NF1SgsOcJnm7YqB/55YLBgHBs9vh72BtbvypgEZlhzMmDUCYiwSwJHGB6iWWt9UG/uymCekgBNZzR
	I7kRrk3f63FQiKq8NTLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waZDf-00000002Teu-3VNk;
	Fri, 19 Jun 2026 13:25:15 +0000
Received: from mail-oi1-f200.google.com ([209.85.167.200])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waZDc-00000002Tcm-2IVi
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 13:25:13 +0000
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-489b8b79d94so1249925b6e.3
        for <linux-nvme@lists.infradead.org>; Fri, 19 Jun 2026 06:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875511; x=1782480311;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDSV7GPu8UH7sbQJKhtjWCvmc6DNEc78/iQ/s01ojgw=;
        b=fP16i0FSXo1SYMtbBdElZwB8qMCgMgF5r/DMhLSDEniCb/m8N6bxUC0j8Kd8TIojQw
         P/nJ6iRJeqbO4GNqgBnSnmNSGfR7fInLuJhp5fElw4RQXaZd2lilCnx9TU5fwWtGuzWM
         fEfBipBpiT1bCt4fhi8IkxLgcLsZPV7rVK0j/PvAJYkjEEJz7u5cvaS5lS7N5NaJHYiU
         SwtL7Yh36Dxh/P/8SbUjkqmcnVHJzbYBHYWkLSyvIU+iyd2iqVVxNvFimoOiMG877TJj
         xtxvraUfY2hK79rFsywyQ1wrKNMUHgROycr8HxpMAyGzMOvfRcTmLulJ4ve8VVPyyuA/
         E4JQ==
X-Forwarded-Encrypted: i=1; AFNElJ/So3Bm/eLfhkXNWG57S3TkWOQzF48U/MnPy/dEYSD0ugz+NUeiLrFCKwIS+B0iRhH0MwaQcrlC1tmM@lists.infradead.org
X-Gm-Message-State: AOJu0YzNtcy3vbwECM6xgZvMHtdw8l2ctnDmA7OclPIEitJ1O4jbwEpV
	icSfDDI8cLtLSOigqkkyXu8WmtPgQLp7x/kTUBBymumw4Q198JZXt5RGqxY3E8Jju8XQrKUzZQ7
	UEfW7PY7Be6IjaWqhTxCyi+Rc9p0D+xUXnWmr4uBs1wdoR+gVM/UWHHfeNuw=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1183:b0:486:560d:aa91 with SMTP id
 5614622812f47-489af3d5d23mr1836626b6e.19.1781875510906; Fri, 19 Jun 2026
 06:25:10 -0700 (PDT)
Date: Fri, 19 Jun 2026 06:25:10 -0700
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a354336.6d5abbec.a50f.0030.GAE@google.com>
Subject: [syzbot ci] Re: namespace-aware configfs
From: syzbot ci <syzbot+ci507e14334c1039c1@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, brauner@kernel.org, hare@kernel.org, hare@suse.de, 
	hch@lst.de, jack@suse.cz, kch@nvidia.com, leitao@debian.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_062512_599213_BD790ED4 
X-CRM114-Status: UNSURE (   8.94  )
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

syzbot ci has tested the following series

[v2] namespace-aware configfs
https://lore.kernel.org/all/20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org
* [PATCH RFC v2 01/12] fs/configfs: rework configfs_is_root()
* [PATCH RFC v2 02/12] fs/configfs: dynamically allocate super_info
* [PATCH RFC v2 03/12] fs/configfs: separate out configfs_{link,unlink}_root()
* [PATCH RFC v2 04/12] fs/configfs: add superblock as attribute to configfs_pin_fs()
* [PATCH RFC v2 05/12] fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
* [PATCH RFC v2 06/12] fs/configfs: add superblock as attribute to configfs_pin_fs()
* [PATCH RFC v2 07/12] fs/namespace: implement mnt_clone_direct()
* [PATCH RFC v2 08/12] fs/configfs: switch to get_tree_keyed()
* [PATCH RFC v2 09/12] fs/configfs: open-code simple_pin_fs()
* [PATCH RFC v2 10/12] nvmet: make discovery subsystem dynamic
* [PATCH RFC v2 11/12] nvmet: per net-namespace port list
* [PATCH RFC v2 12/12] nvmet: make configfs setup namespace aware

and found the following issue:
general protection fault in put_net

Full report is available here:
https://ci.syzbot.org/series/dd681b97-ec65-4bbf-9440-cbbf1c103062

***

general protection fault in put_net

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      66affa37cfac0aec061cc4bcf4a065b0c52f7e19
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/a4aeaf5c-a583-4650-97af-058d35909234/config
syz repro: https://ci.syzbot.org/findings/773be3e5-366e-482f-8da3-9a5abb71b7a8/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc000000003b: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001d8-0x00000000000001df]
CPU: 0 UID: 0 PID: 5865 Comm: syz.1.18 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:is_ns_init_id include/linux/ns_common.h:25 [inline]
RIP: 0010:__ns_ref_put include/linux/ns_common.h:72 [inline]
RIP: 0010:put_net+0x33/0x260 include/net/net_namespace.h:297
Code: 53 48 89 fb e8 4e ea 50 ff 48 85 db 0f 84 e8 00 00 00 49 bc 00 00 00 00 00 fc ff df 4c 8d b3 e0 01 00 00 4d 89 f5 49 c1 ed 03 <43> 80 7c 25 00 00 74 08 4c 89 f7 e8 6d 1d be ff 4d 8b 3e 31 ff 4c
RSP: 0018:ffffc9000349fcb8 EFLAGS: 00010203
RAX: ffffffff8275a0b2 RBX: fffffffffffffffd RCX: ffff88810d921dc0
RDX: 0000000000000000 RSI: 0000000000010000 RDI: fffffffffffffffd
RBP: 0000000000010000 R08: ffffffff903203f7 R09: 1ffffffff206407e
R10: dffffc0000000000 R11: ffffffff8275aa40 R12: dffffc0000000000
R13: 000000000000003b R14: 00000000000001dd R15: 0000000000000000
FS:  000055558a1a8500(0000) GS:ffff88818dc4e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33263fff CR3: 0000000116edc000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 put_fs_context+0x123/0xb00 fs/fs_context.c:498
 fscontext_release+0x62/0x80 fs/fsopen.c:79
 __fput+0x44f/0xa60 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1fa/0x710 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb902f9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff92660ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fff92660fb0 RCX: 00007fb902f9ce59
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00000000000107a6 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b32620000 R11: 0000000000000246 R12: 00007fff92660ff0
R13: 00007fb903215fac R14: 00000000000107da R15: 00007fb903215fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:is_ns_init_id include/linux/ns_common.h:25 [inline]
RIP: 0010:__ns_ref_put include/linux/ns_common.h:72 [inline]
RIP: 0010:put_net+0x33/0x260 include/net/net_namespace.h:297
Code: 53 48 89 fb e8 4e ea 50 ff 48 85 db 0f 84 e8 00 00 00 49 bc 00 00 00 00 00 fc ff df 4c 8d b3 e0 01 00 00 4d 89 f5 49 c1 ed 03 <43> 80 7c 25 00 00 74 08 4c 89 f7 e8 6d 1d be ff 4d 8b 3e 31 ff 4c
RSP: 0018:ffffc9000349fcb8 EFLAGS: 00010203
RAX: ffffffff8275a0b2 RBX: fffffffffffffffd RCX: ffff88810d921dc0
RDX: 0000000000000000 RSI: 0000000000010000 RDI: fffffffffffffffd
RBP: 0000000000010000 R08: ffffffff903203f7 R09: 1ffffffff206407e
R10: dffffc0000000000 R11: ffffffff8275aa40 R12: dffffc0000000000
R13: 000000000000003b R14: 00000000000001dd R15: 0000000000000000
FS:  000055558a1a8500(0000) GS:ffff88818dc4e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33263fff CR3: 0000000116edc000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	e8 4e ea 50 ff       	call   0xff50ea57
   9:	48 85 db             	test   %rbx,%rbx
   c:	0f 84 e8 00 00 00    	je     0xfa
  12:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  19:	fc ff df
  1c:	4c 8d b3 e0 01 00 00 	lea    0x1e0(%rbx),%r14
  23:	4d 89 f5             	mov    %r14,%r13
  26:	49 c1 ed 03          	shr    $0x3,%r13
* 2a:	43 80 7c 25 00 00    	cmpb   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 f7             	mov    %r14,%rdi
  35:	e8 6d 1d be ff       	call   0xffbe1da7
  3a:	4d 8b 3e             	mov    (%r14),%r15
  3d:	31 ff                	xor    %edi,%edi
  3f:	4c                   	rex.WR


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

