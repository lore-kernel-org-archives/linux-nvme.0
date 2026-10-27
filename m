Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495C606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B6v3U2yp;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=mLahcAjj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+El7GN3ABVO9vM31jJjliUxNOi3FKQJ/7NpwVz7amKE=; b=B6v3U2ypGuL5Hv
	s9WCekt++bTiagXWqO2G/QaX0NVYM4apTIvJrbXwhNBFutvS6ZOvh+Q/jbwO7aVzQ/1s3uMEpTPXT
	IRPoj8n5/PPolb2LcFAUeFg4Q/jUPK2Mefmc22toSovFRsZwc0OeQg+fjrymHz8J2sU+xIFX8cUkm
	ab2fAuwk5s5WBplCvJfgtR4ksFZcT62J/YVLDHY/0g6zGBinOY6DinlS1VZjb9qEGSsDLrYCIqvh9
	AQB5K/OHHRJaC1OMfS7QQpSjmqAIg0lHuVNrNM0Qx7BNlVcFBwd1GhYqilnHa6GIfIiJ/qgFNvp+3
	wdjEkIdm4HHTmjSXlbbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLqmg-00000005wjx-1JbO;
	Tue, 27 Oct 2026 23:40:50 +0000
Received: from smtp153-170.sina.com.cn ([61.135.153.170])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLqmZ-00000005wb3-3VCY
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 23:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793144443;
	bh=+El7GN3ABVO9vM31jJjliUxNOi3FKQJ/7NpwVz7amKE=;
	h=From:Subject:Date:Message-ID;
	b=mLahcAjjRXcoa2uqyJvKJVjD0z7oFETleqwQPhroolL1o84yWZTFSPU2CsY0EMnFm
	 ZhRduFu3BPsMjX0QrpxUZbU0FmMwtIezTb030iLQcBqmizNQM1gW19prfDgMQI941X
	 53DPNb51DVf9k9G1hZ2ewE4P8vXYMNDxONQpq6bQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([124.64.22.19])
	by sina.com (10.54.253.34) with ESMTP
	id 6AE1366A000025E2; Tue, 28 Oct 2026 07:40:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5950596291622
X-SMAIL-UIID: 15CC297E008E4881A65D3AD8A1C81AC7-20261028-074029-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+df0058a8d0bdce7c4059@syzkaller.appspotmail.com>
Cc: hch@lst.de,
	justin.tee@broadcom.com,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	sagi@grimberg.me,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nvme?] kernel BUG in nvmet_fc_remove_port
Date: Wed, 28 Oct 2026 07:40:16 +0800
Message-ID: <20261027234017.198-1-hdanton@sina.com>
In-Reply-To: <6ae09457.f0fe5aea.79aa1.008c.GAE@google.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_164044_491715_BB306BD2 
X-CRM114-Status: GOOD (  10.75  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Date: Tue, 27 Oct 2026 05:08:55 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6b4b543fa187 Merge tag 'parisc-for-7.4-rc1' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ce8f0d580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4c032ed87e6e91c
> dashboard link: https://syzkaller.appspot.com/bug?extid=df0058a8d0bdce7c4059
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db5e35580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1413f195580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6b4b543f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/003ef0d7eda6/vmlinux-6b4b543f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/022618083bf9/bzImage-6b4b543f.xz
> 
> AI-generated root cause summary:
> In the NVMe target subsystem, port attribute store handlers in
> drivers/nvme/target/configfs.c (such as nvmet_addr_trtype_store) do not acquire
> nvmet_config_sem and only check port->enabled. Because port->enabled is not set
> to true until after ops->add_port() finishes in nvmet_enable_port(), a
> concurrent write to addr_trtype can race and switch port->disc_addr.trtype
> (e.g., from TCP to FC). When disabling the port, nvmet_disable_port() in
> drivers/nvme/target/core.c indexes nvmet_transports using port->disc_addr.trtype
> instead of using port->tr_ops, causing type confusion on port->priv (treating
> struct nvmet_tcp_port as struct nvmet_fc_port_entry) and resulting in memory
> corruption, refcount underflow, and use-after-free.
> 
Sounds incorrect given the debug diff that survived a similar syzbot test [11].

[11] https://lore.kernel.org/lkml/6ad48c36.a6d1a155.34a93f.0091.GAE@google.com/

> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=df0058a8d0bdce7c4059
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+df0058a8d0bdce7c4059@syzkaller.appspotmail.com
> 
> nvmet_tcp: enabling port 1 (127.0.0.1:4420)
> refcount_t: underflow; use-after-free.
> ------------[ cut here ]------------
> kernel BUG at lib/refcount.c:37!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 6113 Comm: syz.0.43 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xd7/0x110 lib/refcount.c:37
> Code: 67 48 0f b9 3a e8 b9 e8 d6 fc 5b 5d e9 c2 d6 b5 06 77 19 83 fd 02 74 3e e8 a6 e8 d6 fc 48 c7 c7 c0 08 81 8c e8 ba 43 eb fb 90 <0f> 0b e8 92 e8 d6 fc 48 8d 3d 6b 27 3d 0d 67 48 0f b9 3a e8 81 e8
> RSP: 0018:ffffc900039d7c00 EFLAGS: 00010086
> RAX: 0000000000000026 RBX: ffff8880549e4678 RCX: 0000000000000000
> RDX: 0000000000000026 RSI: ffffffff81ebe399 RDI: fffff5200073af71
> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff9200073af85
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880549e4678
> FS:  0000555566238500(0000) GS:ffff8880d449e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8d01471220 CR3: 000000002d14f000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  __refcount_sub_and_test include/linux/refcount.h:400 [inline]
>  __refcount_dec_and_test include/linux/refcount.h:432 [inline]
>  refcount_dec_and_test include/linux/refcount.h:450 [inline]
>  kref_put include/linux/kref.h:64 [inline]
>  nvmet_fc_tgtport_put drivers/nvme/target/fc.c:1464 [inline]
>  nvmet_fc_portentry_unbind drivers/nvme/target/fc.c:1278 [inline]
>  nvmet_fc_remove_port+0x4c2/0x5f0 drivers/nvme/target/fc.c:2930
>  nvmet_disable_port+0x13c/0x200 drivers/nvme/target/core.c:400
>  nvmet_port_subsys_drop_link+0x26b/0x310 drivers/nvme/target/configfs.c:1189
>  configfs_unlink+0x3cc/0x800 fs/configfs/symlink.c:258
>  vfs_unlink+0x2f0/0xbd0 fs/namei.c:5661
>  filename_unlinkat+0x408/0x730 fs/namei.c:5731
>  __do_sys_unlinkat fs/namei.c:5760 [inline]
>  __se_sys_unlinkat fs/namei.c:5752 [inline]
>  __x64_sys_unlinkat+0xc0/0x130 fs/namei.c:5752
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

