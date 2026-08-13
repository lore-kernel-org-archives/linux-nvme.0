Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94C6C5CFDB
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=iaplxS5GhXCQwol88E64zD+uBbxKgP82FZ6K+TUTjrw=; b=Yt5VBmjjlgAAs9
	Eagp4+yLRaoPil/x4A3b/fCtQc8TDm1kkr2FR99zBfTQ29wxABkEUb1jIJmLdoBWPyHgmflmE/c6+
	TpDDE5R6F3m/a338T2RLDrUigCHuWDVZzRSqj2HXCFn1yH+nF67wfxku+5MmR/Q4Oqo+Con66NmJF
	PDd+JABnh3T0I3fhnIV8810GfkjwFXQ+CM2qvLSQ1GnP2x98tZVje+BHBFRAd7f9tQ6vRXi1aLOOG
	osasTI18yRt+I14pfG/Bm7uGUeWtFjXxBcZ+ZnHDj/1FXr+GXEU3WOFKvSs+oloda9nO8PLCVjB1o
	aq1LnsvCQYwyK0fz/tnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuR1O-00000000C3G-0jhO;
	Thu, 13 Aug 2026 08:42:42 +0000
Received: from mail-ot1-f72.google.com ([209.85.210.72])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuR1L-00000000C2R-2vlq
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 08:42:41 +0000
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7f36427abfdso814504a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2026 01:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610558; x=1787215358;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iaplxS5GhXCQwol88E64zD+uBbxKgP82FZ6K+TUTjrw=;
        b=YzIRXyIAnSu67n6VFvshrndS27oWMhTvijhZJlnmO0Uo840vthULYzabPMcX2fYBf5
         coyMQYHevkliVwH4BFQ14Ho6Io8auj/LAJOWeRu0Ch3ocVTBDqCIyjWc5NzZ67rgfdZn
         vICc3vBtkyVM4ddWt1xzEsZ9gZeN+7FkT+dNNap5GMRPnOaJ3UhBeQaqqhMJY+FHLyP0
         iETN5rKsWf0sP4QbsIwXqutAFe1J9w7auN5vu8lxNFL/64vNNoN5wKmTDqO8nP7bcW0e
         t25k9ZD0QJ69l3ZTAcX7TK7zOg3X6PB8NSWBfyTr6Mh1NcPx7EAQCYSbcXzf5w2jeazc
         /lkw==
X-Forwarded-Encrypted: i=1; AHgh+RrGjRvvsoC8PMRvOGxwihf4nEb8TjzaUQmA1Wi7vG1Ud+l286cvikyqjZ0pH3N1+DpeVns+3mosruok@lists.infradead.org
X-Gm-Message-State: AOJu0Ywt8DU/a13Qp9UBTbG1l6625ERDY5EP4prBuURYb/OnE3fYBQRZ
	LlqRjemnOqtDOzSQ+YQ5jJhE9GsJJSTC2EuQV0i0dkwn9vDbH0vlXFxwFq9HZMyh+r/eGVm/Lv3
	Nf1oSMW5PeIa31rdqMi7hs+eYSYAH5/jgHDcBdvTrH1X7UGHjm3wWcI3gpYk=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:995:b0:6ae:4d93:cdc2 with SMTP id
 006d021491bc7-6b0c41b84f0mr4239106eaf.5.1786610557670; Thu, 13 Aug 2026
 01:42:37 -0700 (PDT)
Date: Thu, 13 Aug 2026 01:42:37 -0700
In-Reply-To: <6a7bbaa4.a2bb2777.31c27d.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7d837d.c5ad36c8.12f49d.002c.GAE@google.com>
Subject: Re: [syzbot] [nvme?] WARNING in nvmet_fc_register_targetport
From: syzbot <syzbot+18b6b27f58e98c240814@syzkaller.appspotmail.com>
To: cassel@kernel.org, hch@lst.de, justin.tee@broadcom.com, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_014239_740479_EE74878D 
X-CRM114-Status: UNSURE (   8.61  )
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

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1119f479580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=18b6b27f58e98c240814
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174e8ac6580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18b6b27f58e98c240814@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 00007fe0eeb9c063 R14: 00007fe0eebc6cc0 R15: 0000000000000002
 </TASK>
------------[ cut here ]------------
!PageLargeKmalloc(page)
WARNING: mm/slub.c:6602 at free_large_kmalloc+0xbf/0x100 mm/slub.c:6602, CPU#2: syz-executor838/6035
Modules linked in:
CPU: 2 UID: 0 PID: 6035 Comm: syz-executor838 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:free_large_kmalloc+0xbf/0x100 mm/slub.c:6602
Code: 28 90 0f 0b 90 80 3d f7 c8 9a 0e 00 0f 84 87 b4 b5 fe 48 8b 74 24 28 48 89 ef e8 8c 3b 0c 00 b8 00 f0 ff ff 45 31 ed eb 9d 90 <0f> 0b 90 48 83 c4 08 48 89 df 48 c7 c6 53 4d 19 8e 5b 5d 41 5c 41
RSP: 0018:ffffc9000347fa28 EFLAGS: 00010202
RAX: 00000000000000ff RBX: ffffea00016377c0 RCX: 000000000000002e
RDX: 0000000000000000 RSI: ffff888058ddff20 RDI: ffffea00016377c0
RBP: ffff888058ddff20 R08: ffff888052911000 R09: 00000000ffffffff
R10: ffffffffffffffff R11: 0000000000000000 R12: 00000000ffffffff
R13: 1ffff9200068ff5e R14: dead000000000122 R15: ffff888058ddff30
FS:  000055557f333400(0000) GS:ffff8880d5fec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557f335768 CR3: 0000000058747000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nvmet_fc_alloc_ls_iodlist drivers/nvme/target/fc.c:569 [inline]
 nvmet_fc_register_targetport+0x114c/0x1c30 drivers/nvme/target/fc.c:1411
 fcloop_create_target_port+0x156/0x5a0 drivers/nvme/target/fcloop.c:1558
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0eeb63277
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fffdd23d920 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055557f333400 RCX: 00007fe0eeb63277
RDX: 000000000000002f RSI: 00007fffdd23d970 RDI: 0000000000000003
RBP: 00007fffdd23d970 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 00007fe0eeb9c063 R14: 00007fe0eebc6cc0 R15: 0000000000000002
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

