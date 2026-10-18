Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D52CCF2C4
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C++u6t/j/bpdXW85SGtKu8asGtwuQpgg01rY7vIXavw=; b=CHgJLRQo4sY6RSlsPIZ2eaIH6s
	adqaIu8qJTvaVLWtggsL+KYXM1yMa5xySSK4+wmgUZdSPIXPyM08o8R34KKpPwMjLOpcK4N5Ne84i
	3wqSDnUrjg9Epxy5+hkl+jtOAB1lsoY9nUn/U6Ua6ilEe40Y1VQXvWVseVslYJ2IZNfdG4XiUORAq
	KTNoDQK+JVI+xgvSpsPlX+fZ0jtpwEjIbxBCOkc+Y1vgDBcMzTgtk+4cKyLipbvVDYwgCizYi7F7+
	sDRD1jPuwDNpMy4DN6q6uCyHR7YIvOa7s7d0TzbarwGZuIkvqrFnF8OBVVc1by8PPaeD6NQk28TyG
	mwRqiZrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIXts-00000006DuJ-268O;
	Sun, 18 Oct 2026 20:54:36 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIXtq-00000006Dtv-1PIh
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 20:54:35 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-5366463571cso5640771cf.3
        for <linux-nvme@lists.infradead.org>; Sun, 18 Oct 2026 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792356873; x=1792961673; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C++u6t/j/bpdXW85SGtKu8asGtwuQpgg01rY7vIXavw=;
        b=U4K2/A3v+L6MQcxFqA+af7RptJbcc48VYSOMXSIirT16t4BFNxjR86Ysiw+FWS8CfN
         ShHXGkIYApWL1go2ao4rvgOdzxRlCLd5Gl48Odttk876tcseKxnNLhRRT1AQBVRlaG74
         U4tGfb5SEHyyLo32yA+kc9dadDL1Acmv8zsJOfZBHL9gA1knIkXICwcDYHhbI8k24IPv
         9in12lQM7dBnSyKhfxACsqEFPYKwJOcbJ5a1Ry449fP1SKnS68V4GO5rddoocUP6rFg0
         +LQU+AaIAk4jr6HRqKyulb/OE52eslV79SYVaPl+fRmxq5Z0o5hgu47HwcCP6BsuoO+C
         ZDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356873; x=1792961673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C++u6t/j/bpdXW85SGtKu8asGtwuQpgg01rY7vIXavw=;
        b=ygPLbqxIFl2npUIhq6hXkTpmgBamco6W2DIw7w3WoDJE/ZjgqtwT2u+YqvC3c/bbEg
         v66R0kAQgTmvvFmgprSzoCIt0KT3rtWx0JDP93vtBprdGTPXXkrDC+1AAWk4ZE58u7Hu
         s4ybA5DDXn2/oTg4p/ZGI6UcradatJIFlM57bfWwWRg7Hou2rw302yHropC2PzoQQLuJ
         LWO7IpGrRfjzU4OlezhFdsfKfKQguQAUGFkG0Ymly5ZBmmyX0lkhgwI5b1L5EqcOJoWI
         +A4Ex03O4dbSTX37E7zXrNymknfW5xJFux+lzqEvjPVeogMVBweVcAxb8YX3+KsQiEJ7
         Sr2A==
X-Forwarded-Encrypted: i=1; AKwUvBw9LaJUjNBy3TjLIg8QGtdsZzUY2A/pBE+4dN+yJw0rMvjfM6Nj49BUswfpB3qRvnY9vNkDQQqXZQr3@lists.infradead.org
X-Gm-Message-State: AFq9FYLVl88w07z71MppycLSFvDy6E+nRqYe4KdbJ0abvjIVMtLjbhnc
	9zPs8GUVtjlWTGLFKrgub5u2i8L2vikEic2VurqAE0IunDOShxW/uYm4
X-Gm-Gg: AYBFou1tJKyN7Jdmpwgz3xAAx77omrDbb8ijFA9WKd1NtZicB7gEq0HOiBLUsgux1rK
	IfQlhnAJQGIpwM6lyzL7COu2lvjGB0+FY4Z9PWPZ0KoonfanP0xvuE5jsrtoDwZXJGv5ed2l7hi
	RPZ0fPHyjKk4pN51MX2nmb/pUhh+4F3ev4FqwXuSMq1NxsvEryG4xaoY0E6aV7ihdv/s2Fhd2Jt
	HyG9UmOz9gXEMHYNZxtyTwdEyXc1hbRR1WOEEFtsZZmJXlMz+bpa2+R5rJDNRagDVMck9HtZZ8N
	xrUQc7J5vXo2CEV7VkCfpWc4ibJdnHBtBJVNfyTgERLpsh1DbycQalQf4G/2V42BE0jQ9xUiJZ9
	8KfsvRyv8F4xpAUHL+LcNCJtTdZ4kc7P3gFHhdV13CzSQZDtwh4O16EhnvFmdUAh4EyeIJ/8Ay9
	/RT90oUSzGFHQDtn092otdZCUAGo8lluoyHMFtzXoYR1znOut1xJPO64HieptG7ngKYgxrD6AnK
	qmLGKr1EZUeO6QdPnLtB1+DZcWh
X-Received: by 2002:a05:622a:138f:b0:535:e8c:4258 with SMTP id d75a77b69052e-53645feaae2mr88127051cf.54.1792356872708;
        Sun, 18 Oct 2026 13:54:32 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8dac81sm80471341cf.6.2026.10.18.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:54:32 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] NVMe: KASAN slab-use-after-free in __run_timer_base
Date: Sun, 18 Oct 2026 16:54:14 -0400
Message-ID: <20261018205420.4080423-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_135434_405868_F29C691A 
X-CRM114-Status: GOOD (  10.12  )
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

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in __run_timer_base

on commit: 58161ead29e50d70a317ea26b472e0c7508e69da (2026-10-16)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/353855e21730d39b56943359215df2f8

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   97.002406] ==================================================================
[   97.002426] BUG: KASAN: slab-use-after-free in __run_timer_base (include/linux/list.h:1175 kernel/time/timer.c:1820 kernel/time/timer.c:2356 kernel/time/timer.c:2386)
[   97.002500] Write of size 8 at addr ffff88811d710e40 by task swapper/0/0

[   97.002533] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   97.002541] Call Trace:
[   97.002547]  <IRQ>
[   97.002552]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   97.002567]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   97.002602]  kasan_report (mm/kasan/report.c:595)
[   97.002628]  __run_timer_base (include/linux/list.h:1175 kernel/time/timer.c:1820 kernel/time/timer.c:2356 kernel/time/timer.c:2386)
[   97.002682]  tmigr_handle_remote (kernel/time/timer_migration.c:985 kernel/time/timer_migration.c:1076 kernel/time/timer_migration.c:564 kernel/time/timer_migration.c:581 kernel/time/timer_migration.c:1135)
[   97.002742]  handle_softirqs (kernel/softirq.c:645)
[   97.002757]  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
[   97.002768]  sysvec_apic_timer_interrupt (archkernel/apic/apic.c:1062 archkernel/apic/apic.c:1062)
[   97.002783]  </IRQ>
[   97.002787]  <TASK>
[   97.002791]  asm_sysvec_apic_timer_interrupt (archinclude/asm/idtentry.h:674)
[   97.002802] RIP: 0010:pv_native_safe_halt (archinclude/asm/irqflags.h:48 archkernel/paravirt.c:63)
[   97.002818] Code: 83 fa 01 00 cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 55 5c 19 00 f3 0f 1e fa fb f4 <e9> 58 fa 01 00 cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90
All code
========
   0:	83 fa 01             	cmp    $0x1,%edx
   3:	00 cc                	add    %cl,%ah
   5:	66 90                	xchg   %ax,%ax
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	f3 0f 1e fa          	endbr64
  1b:	eb 07                	jmp    0x24
  1d:	0f 00 2d 55 5c 19 00 	verw   0x195c55(%rip)        # 0x195c79
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	e9 58 fa 01 00       	jmp    0x1fa87		<-- trapping instruction
  2f:	cc                   	int3
  30:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	e9 58 fa 01 00       	jmp    0x1fa5d
   5:	cc                   	int3
   6:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[   97.002826] RSP: 0018:ffffffff85607ce8 EFLAGS: 00000206
[   97.002839] RAX: ffff8882d1236000 RBX: ffffffff85615880 RCX: ffffffff846b6184
[   97.002847] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000017cc4
[   97.002854] RBP: ffffffff85607db8 R08: ffff888258030f8b R09: 1ffff1104b0061f1
[   97.002860] R10: dffffc0000000000 R11: ffffed104b0061f2 R12: 0000000000000000
[   97.002866] R13: 1ffffffff0ac2b10 R14: 0000000000000000 R15: dffffc0000000000
[   97.002884]  default_idle (archkernel/process.c:767 archkernel/process.c:768)
[   97.002893]  default_idle_call (kernel/sched/idle.c:122)
[   97.002902]  do_idle (kernel/sched/idle.c:199 kernel/sched/idle.c:355)
[   97.002934]  cpu_startup_entry (kernel/sched/idle.c:454)
[   97.002945]  rest_init (init/main.c:732)
[   97.002987]  start_kernel (init/main.c:1190)
[   97.002999]  x86_64_start_reservations (archkernel/head64.c:310)
[   97.003060]  x86_64_start_kernel (archkernel/head64.c:291)
[   97.003073]  common_startup_64 (archkernel/head_64.S:418)
[   97.003088]  </TASK>

[   97.003095] Allocated by task 380 on cpu 1 at 16.265072s:
[   97.003104]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   97.003116]  __kasan_kmalloc (mm/kasan/common.c:409 mm/kasan/common.c:426)
[   97.003125]  nvme_rdma_create_ctrl (include/linux/slab.h:991 include/linux/slab.h:1312 drivers/nvme/host/rdma.c:2289 drivers/nvme/host/rdma.c:2367)
[   97.003138]  nvmf_dev_write (drivers/nvme/host/fabrics.c:1361 drivers/nvme/host/fabrics.c:1408)
[   97.003148]  vfs_write (fs/read_write.c:685)
[   97.003157]  ksys_write (fs/read_write.c:739)
[   97.003166]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   97.003175]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

[   97.003186] Freed by task 26 on cpu 0 at 76.560994s:
[   97.003193]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   97.003202]  kasan_save_free_info (mm/kasan/generic.c:584)
[   97.003210]  __kasan_slab_free (mm/kasan/common.c:264 mm/kasan/common.c:296)
[   97.003220]  kfree (include/linux/kasan.h:235 mm/slub.c:2748 mm/slub.c:6509 mm/slub.c:6802)
[   97.003230]  nvme_free_ctrl (drivers/nvme/host/core.c:5202)
[   97.003240]  device_release (drivers/base/core.c:?)
[   97.003251]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 include/linux/kref.h:65 lib/kobject.c:737)
[   97.003263]  process_scheduled_works (kernel/workqueue.c:3396 kernel/workqueue.c:3479)
[   97.003272]  worker_thread (kernel/workqueue.c:3560)
[   97.003281]  kthread (kernel/kthread.c:436)
[   97.003291]  ret_from_fork (archkernel/process.c:158)
[   97.003304]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

[   97.003316] Last potentially related work creation:
[   97.003320]  kasan_save_stack (mm/kasan/common.c:57)
[   97.003330]  kasan_record_aux_stack (mm/kasan/generic.c:556)
[   97.003338]  insert_work (kernel/workqueue.c:2272)
[   97.003345]  __queue_work (kernel/workqueue.c:2448)
[   97.003356]  queue_work_on (kernel/workqueue.c:2501)
[   97.003364]  nvme_delete_ctrl (include/linux/workqueue.h:700 drivers/nvme/host/core.c:268)
[   97.003376]  process_scheduled_works (kernel/workqueue.c:3396 kernel/workqueue.c:3479)
[   97.003384]  worker_thread (kernel/workqueue.c:3560)
[   97.003392]  kthread (kernel/kthread.c:436)
[   97.003401]  ret_from_fork (archkernel/process.c:158)
[   97.003411]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

[   97.003422] Second to last potentially related work creation:
[   97.003427]  kasan_save_stack (mm/kasan/common.c:57)
[   97.003435]  kasan_record_aux_stack (mm/kasan/generic.c:556)
[   97.003442]  insert_work (kernel/workqueue.c:2272)
[   97.003449]  __queue_work (kernel/workqueue.c:2448)
[   97.003457]  call_timer_fn (kernel/time/timer.c:1748)
[   97.003470]  __run_timer_base (kernel/time/timer.c:1794 kernel/time/timer.c:2374 kernel/time/timer.c:2386)
[   97.003480]  tmigr_handle_remote (kernel/time/timer_migration.c:985 kernel/time/timer_migration.c:1076 kernel/time/timer_migration.c:564 kernel/time/timer_migration.c:581 kernel/time/timer_migration.c:1135)
[   97.003492]  handle_softirqs (kernel/softirq.c:645)
[   97.003502]  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
[   97.003512]  sysvec_apic_timer_interrupt (archkernel/apic/apic.c:1062 archkernel/apic/apic.c:1062)
[   97.003523]  asm_sysvec_apic_timer_interrupt (archinclude/asm/idtentry.h:674)

[   97.003534] The buggy address belongs to the object at ffff88811d710000
which belongs to the cache kmalloc-4k of size 4096
[   97.003542] The buggy address is located 3648 bytes inside of
freed 4096-byte region [ffff88811d710000, ffff88811d711000)


Best,
Shuangpeng

