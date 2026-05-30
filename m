Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BCCCD4F54
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2026 08:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=km0xy1eoEMaUqT/HfnmIYnwJDsT/FIV7KLh005ZV6YU=; b=t3FE4ID4iz1sQI7SMTmDgXAZXG
	tEUeTV0DrKy2+ca+InyF7r7p4SIQXy3gR6T+eo2m6yWANxvY+ZFWjlSVTlRPDeg68BF2JC9VTCiUi
	3Z9xSp9MroipR+nZeE/wKVCtzotgwikqSOwxuAHTP3+yAnQUnqIyNehpxXaf13GhL9W8jU3cxB8QU
	RwLuPhRLxGgHk5xn2qQkl61Iy0sHbs7xzo6CQichgt3tpdz+NjNS/yS0eznxJyWPsmBTz/tTw+JiT
	O1RU8cNpyow//IiBWLN7HwPmvMJLdEqttf8Evn2slugNoqOudB2igun7RoUhqXUFD71dUV8cszADO
	jjK8bfug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTEiI-00000008X45-3SF7;
	Sat, 30 May 2026 08:06:34 +0000
Received: from mail-ot1-f78.google.com ([209.85.210.78])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTEiF-00000008X3k-3VXZ
	for linux-nvme@lists.infradead.org;
	Sat, 30 May 2026 08:06:33 +0000
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e6a306a7b0so1047379a34.0
        for <linux-nvme@lists.infradead.org>; Sat, 30 May 2026 01:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780128390; x=1780733190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=km0xy1eoEMaUqT/HfnmIYnwJDsT/FIV7KLh005ZV6YU=;
        b=J/++Y+jxCh1hx/lrFJBPqY/rAZwnkB6smsj03OsN+NLV876r2dEVmuXW6KYT4w2IpC
         92oSi5pymoC02RXPZUil4jbi7a8aQP3L/c2qzEbAOXzklX8nuHiDnlHq8mxEKXPeU8uL
         DEWBkYpWOxodPoUX+cDaoUuXP/xoDLipHKG4fr85AnaJvCl0vBfrgEtui/BK1pt9cB0O
         uXM4kC5S7QN2G5N2yQkKEdsqg+ZBL3KGCXdvTBcbuiw7SxRCEYAIpE0n0JVD+nZqS6nQ
         s5N+8KhPTvk4it2AP03PSAuDroVI/wdMUyNAYwhBHZdy+3r2XUWuwnXNpjFDPHLzhtMx
         Pa1w==
X-Forwarded-Encrypted: i=1; AFNElJ80DnnHPAaYjhWDpxA42F34J7pxQIR7RfoNBxIf67m24uXMHDSIGTKaxmbZJH2sCLylATOn01flGvQj@lists.infradead.org
X-Gm-Message-State: AOJu0YwCB17TRN/aK7GWDLZ2o1N2QHE5pXpcnZVuAp/oxRVnw61ih53Y
	BRa3aRv/mYfH3Y6Kt+cDTG8aaLNFCjx2ajdxfr6dHeiMZVefqNGxFU20Q5+j0m261c8Tvfu1YVH
	KFiX7Gqt4f6HHTFnxs1QEOyA/Pkzxhkoc9fb25eIMugev+4jdWMe3PYVJA1w=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d0a:b0:696:8cb7:3167 with SMTP id
 006d021491bc7-69e042c1b8cmr2543839eaf.14.1780128390195; Sat, 30 May 2026
 01:06:30 -0700 (PDT)
Date: Sat, 30 May 2026 01:06:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1a9a86.323e8352.141b09.0001.GAE@google.com>
Subject: [syzbot] [nvme?] linux-next test error: WARNING in __alloc_workqueue
From: syzbot <syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_010631_905181_A20FCC92 
X-CRM114-Status: GOOD (  11.02  )
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

HEAD commit:    7da7f0711261 Add linux-next specific files for 20260529
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1083d67e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a40d26c705073da7
dashboard link: https://syzkaller.appspot.com/bug?extid=d078cba4418e65f61984
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8bdcda3b30c/disk-7da7f071.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c571d67d2763/vmlinux-7da7f071.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6bdf4a6a4922/bzImage-7da7f071.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com

ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/platform/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:04: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:05: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
usbcore: registered new interface driver xillyusb
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 for vgem on minor 0
[drm] Initialized vkms 1.0.0 for vkms on minor 1
Console: switching to colour frame buffer device 128x48
faux_driver vkms: [drm] fb0: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
usbcore: registered new interface driver gm12u320
usbcore: registered new interface driver gud
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
rnull_mod: Rust null_blk loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=267)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
virtio_scsi virtio0: 1/0/0 default/read/poll queues
scsi host0: Virtio SCSI HBA
blk-mq: reduced tag depth to 10240
st: Version 20160209, fixed bufsize 32768, s/g segs 256
------------[ cut here ]------------
workqueue: nvme_tcp_wq is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
WARNING: kernel/workqueue.c:5856 at __alloc_workqueue+0x1d02/0x2070 kernel/workqueue.c:5855, CPU#0: swapper/0/1
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:__alloc_workqueue+0x1d07/0x2070 kernel/workqueue.c:5855
Code: e9 36 f9 ff ff e8 29 8a 37 00 e9 05 fb ff ff e8 1f 8a 37 00 e9 92 fb ff ff e8 15 8a 37 00 48 8d 3d ce a7 23 0e 48 8b 74 24 20 <67> 48 0f b9 3a 81 cd 00 01 00 00 e9 88 e5 ff ff e8 f4 89 37 00 48
RSP: 0000:ffffc900000677a8 EFLAGS: 00010293
RAX: ffffffff818e0c1b RBX: 0000000000000000 RCX: ffff88801d68dd00
RDX: 0000000000000000 RSI: ffff888027f28168 RDI: ffffffff8fb1b3f0
RBP: 0000000000000058 R08: ffff88801d68dd00 R09: 0000000000000002
R10: 0000000000000100 R11: 0000000000000102 R12: dffffc0000000000
R13: ffff888027f28000 R14: ffffc900000678c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125c7e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000dfb8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 alloc_workqueue_va kernel/workqueue.c:5950 [inline]
 alloc_workqueue_noprof+0xe3/0x210 kernel/workqueue.c:5966
 nvme_tcp_init_module+0x27/0x100 drivers/nvme/host/tcp.c:3050
 do_one_initcall+0x250/0x870 init/main.c:1347
 do_initcall_level+0x104/0x190 init/main.c:1409
 do_initcalls+0x59/0xa0 init/main.c:1425
 kernel_init_freeable+0x2a6/0x3e0 init/main.c:1658
 kernel_init+0x1d/0x1d0 init/main.c:1548
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	e9 36 f9 ff ff       	jmp    0xfffff93b
   5:	e8 29 8a 37 00       	call   0x378a33
   a:	e9 05 fb ff ff       	jmp    0xfffffb14
   f:	e8 1f 8a 37 00       	call   0x378a33
  14:	e9 92 fb ff ff       	jmp    0xfffffbab
  19:	e8 15 8a 37 00       	call   0x378a33
  1e:	48 8d 3d ce a7 23 0e 	lea    0xe23a7ce(%rip),%rdi        # 0xe23a7f3
  25:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	81 cd 00 01 00 00    	or     $0x100,%ebp
  35:	e9 88 e5 ff ff       	jmp    0xffffe5c2
  3a:	e8 f4 89 37 00       	call   0x378a33
  3f:	48                   	rex.W


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

