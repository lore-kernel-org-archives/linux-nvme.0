Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF0CC5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=637Opzxfawalyy/FgtNaXvcDWsyCO8CdShVJdQcxNsc=; b=GRriOGyxfyXkeMXH1RsheKkWUG
	x9TGg/vrJNlt4v/p0gnEBMwNPqNeQLQ0hpyI6v1cYR8u/XiCOMuE499FEyV23z4Tdq/Cto9WWrvet
	2KqPZ8Z3te964jG6e+NrvHIP99yWzUCb/m03NGeRtNsTH1+S2mSKKiD3LOr73TqU8T8B0OfG2n/sF
	zW0ij4J9mBP9qlzzF3kaWoyl2pR9TKxAFSpaP05+nISX9gtuXFXBydXOfI3NjvqFj4XaTbkvmOC5l
	ktaiOHwDQE0vHcVQBhmaGsmUtWA1IY67a1Dsx5CkxpC6VBglyfhVHu9iuF+DEFI7/25AmWigPz2Zm
	IhRrMHcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCDf-0000000Gd1v-1UMu;
	Wed, 12 Aug 2026 16:54:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCDe-0000000Gd1i-17KD
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 16:54:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6A0360A7D;
	Wed, 12 Aug 2026 16:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487011F000E9;
	Wed, 12 Aug 2026 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553661;
	bh=637Opzxfawalyy/FgtNaXvcDWsyCO8CdShVJdQcxNsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zm7Uc+pISG1kRUxYmK4Uc9+ippcWNJY1YkzuG5/8j7Fb4kQv5UfysFJ4TEKJSMxF9
	 ImVdtWB9B4rjedkWprpDdG35XeLq7qvscFPpVAEDYGh40hOhKVVkIG5p0lODlfEPdM
	 xib6kpWySil4HebbGiYRjAr4YDcQW1ZjN1B/d9tH+YYuSZYru7LwxBk9RfIFk7/5lj
	 qwKU+owlbtrqcG2Q4Wa0tGBWJbYyyMhA6P/zm7xO6l9g6K93PEKyYeVVHvcoTc+in0
	 quj3jLzamXD/f6Fyn42et3l/VglQR7HwfeeTNyWt3RJzLaeu2KHh+FxnzQWlrdHrEa
	 pYmfhFls+NWLg==
Date: Wed, 12 Aug 2026 18:54:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: syzbot <syzbot+18b6b27f58e98c240814@syzkaller.appspotmail.com>
Cc: hch@lst.de, justin.tee@broadcom.com, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nvme?] WARNING in nvmet_fc_register_targetport
Message-ID: <anylOBYF5fPNzZjj@ryzen>
References: <6a7bbaa4.a2bb2777.31c27d.000b.GAE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7bbaa4.a2bb2777.31c27d.000b.GAE@google.com>
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

On Tue, Aug 11, 2026 at 05:13:24PM -0700, syzbot wrote:
> ------------[ cut here ]------------
> !PageLargeKmalloc(page)
> WARNING: mm/slub.c:6602 at free_large_kmalloc+0xbf/0x100 mm/slub.c:6602, CPU#0: syz.2.261/6867
> Modules linked in:
> CPU: 0 UID: 0 PID: 6867 Comm: syz.2.261 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:free_large_kmalloc+0xbf/0x100 mm/slub.c:6602
> Code: 28 90 0f 0b 90 80 3d e8 ab 9c 0e 00 0f 84 c7 6e b7 fe 48 8b 74 24 28 48 89 ef e8 7c 3a 0c 00 b8 00 f0 ff ff 45 31 ed eb 9d 90 <0f> 0b 90 48 83 c4 08 48 89 df 48 c7 c6 24 df 18 8e 5b 5d 41 5c 41
> RSP: 0018:ffffc9000735fa10 EFLAGS: 00010202
> RAX: 00000000000000ff RBX: ffffea00017e83c0 RCX: 000000000000002e
> RDX: 0000000000000000 RSI: ffff88805fa0ff20 RDI: ffffea00017e83c0
> RBP: ffff88805fa0ff20 R08: ffff888023ddfc00 R09: 00000000ffffffff
> R10: ffffffffffffffff R11: 0000000000000000 R12: 00000000ffffffff
> R13: 1ffff92000e6bf5b R14: dead000000000122 R15: ffff888023ddfc90
> FS:  0000000000000000(0000) GS:ffff888096bf4000(0063) knlGS:00000000f5456b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000025d36000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  nvmet_fc_alloc_ls_iodlist drivers/nvme/target/fc.c:569 [inline]
>  nvmet_fc_register_targetport+0x114c/0x1c30 drivers/nvme/target/fc.c:1411
>  fcloop_create_target_port+0x156/0x5a0 drivers/nvme/target/fcloop.c:1558
>  dev_attr_store+0x58/0x80 drivers/base/core.c:2505
>  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>  kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x6ac/0x1050 fs/read_write.c:687
>  ksys_write+0x12a/0x250 fs/read_write.c:739
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>  __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
>  do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7f96fec
> Code: Unable to access opcode bytes at 0xf7f96fc2.
> RSP: 002b:00000000f545650c EFLAGS: 00000292 ORIG_RAX: 0000000000000004
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080000200
> RDX: 000000000000002f RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

Fixed by:
https://git.infradead.org/?p=nvme.git;a=commit;h=ba98d6796d12258e837ece065d2ecb59d76ce4ff

queued for nvme-7.3.

#syz fix: nvmet-fc: fix invalid free in LS IOD error path


Kind regards,
Niklas

