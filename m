Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ACBC88E5C
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Sep 2026 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=FkmW/KE1CGkFtTZ0aRXS/creYAddRQ91ghlXWYCbS8I=; b=CI9wHOD2R1btxm
	FuIqq8Rg8ivvr1B7Caw5a/9zU9c4l+BEMIgFGa/vxjbe/j0zIU7Arcgc+BpkNaT8brHk+K2r28Ujy
	DTWiPL8ikqxihUl7z4AY/UlHg9O70bX/dpFjO4RnjFu0VWpnG1OQcfJtitAOE7idj4kV1irGTaNDG
	JJJKkQkBIfoOLWuKiuh2lXtx+L7HlEkmt0NWZvGgY/dM6WkTY0oPBTxAn2B/ytc4C0gcmXz9eSmj0
	MAvceX2xLoytvnKPe4gaTOXynLfDZJgqgvi0e8g6W2pqE8dlZ7G6c/rBLfK+hVN4nYhPkO/4RD/4h
	1/xTYumusRcOf1gWxd0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5mDv-00000001mb4-2JhP;
	Sun, 13 Sep 2026 15:34:31 +0000
Received: from mail-ot1-f71.google.com ([209.85.210.71])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5mDt-00000001mad-14A0
	for linux-nvme@lists.infradead.org;
	Sun, 13 Sep 2026 15:34:30 +0000
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-80621978fddso344201a34.2
        for <linux-nvme@lists.infradead.org>; Sun, 13 Sep 2026 08:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789313667; x=1789918467;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FkmW/KE1CGkFtTZ0aRXS/creYAddRQ91ghlXWYCbS8I=;
        b=M1f0mP0UyQuLKPmN31DhFGxcwOb3+rCRGBfyB2fsKSAC/8YntVhYtWaJiFzTEpGJU8
         hrOn2L9ONAh6uMugEwxDscVRMAQTcOzOyhrfVW5QE51LB5ZE/XoVb30OITX8cAEEXBV9
         2Tc4aolgFN1XlmX7vA8AB4MqeR4nruPvjPzB3p+UJRj/n7IzumE9y6WBOhFcfi+2iOC9
         +MfaWiHzjPa79ku/TB4+Y1HSr7XLvkONrjHAXZRm+mTZMg83uxXgrujudgi+dH/1SDE8
         ac7yw/uso3MOEd40t+ymqmDCukFudX3noFfPk4U2lUjICjrLNg8zMFon6rjFrvqgwt9s
         RUnA==
X-Forwarded-Encrypted: i=1; AKwUvBzsHuFQl9x6lxcMrbNWognChzZx6VXnUK9F+s1bpX1N51iFe8L5osCvhqBq6I6jQR2AQBzGr00yrQE5@lists.infradead.org
X-Gm-Message-State: AFuF++mPFQ6VWB/KufxMAPVBHw8qX74lnQIZ/MM513/WBb97WQp+u3Ej
	b8ga23outjZp4t4LDQSe2lhd4yn1k37GVXdhEJl+ilDN5iOLvcWi8DCldq0x48plY0ooUBdvVJW
	oEVFstap+6Jbfj8jdrUeWGoMuCoCoNa1ew1VwM7rOleeTKiTEi2RRNQjT+xw=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f012:b0:6c1:b8a5:cbed with SMTP id
 006d021491bc7-6c24f6527a5mr4222634eaf.55.1789313666919; Sun, 13 Sep 2026
 08:34:26 -0700 (PDT)
Date: Sun, 13 Sep 2026 08:34:26 -0700
In-Reply-To: <6a9ed559.6e6c5f9e.240462.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa6c282.4c28b7d0.c1bba.000d.GAE@google.com>
Subject: Re: [syzbot] [nvme?] WARNING in nvme_loop_reset_ctrl_work
From: syzbot <syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com>
To: hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260913_083429_306392_07AFB0BC 
X-CRM114-Status: UNSURE (   7.11  )
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    2f0c1cf72f46 Merge tag 's390-7.3-3' of git://git.kernel.or..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159b19f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=4a1d521d19d6321f5aad
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1074f615580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: drivers/nvme/target/loop.c:455 at nvme_loop_reset_ctrl_work+0x1ad/0x5d0 drivers/nvme/target/loop.c:455, CPU#2: kworker/u33:1/38
Modules linked in:
CPU: 2 UID: 0 PID: 38 Comm: kworker/u33:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
RIP: 0010:nvme_loop_reset_ctrl_work+0x1ad/0x5d0 drivers/nvme/target/loop.c:455
Code: 7c 08 84 d2 0f 85 85 03 00 00 8b 9d dc f8 ff ff bf 01 00 00 00 83 eb 04 89 de e8 5e 1e 58 fb 83 fb 01 76 09 e8 e4 23 58 fb 90 <0f> 0b 90 e8 db 23 58 fb 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc90000727bd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffffd RCX: 0000000000000000
RDX: ffff88801c78cb00 RSI: ffffffff86b3f22c RDI: ffff88801c78cb00
RBP: ffff888028d84b10 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000fffffffd R11: 0000000000000000 R12: ffff888028d843e8
R13: ffff888028d843ec R14: 0000000000000000 R15: ffff888027346800
FS:  0000000000000000(0000) GS:ffff8880d5d59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fde19ca5e9c CR3: 000000002206a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

