Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB17CD6E75
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Cc:Date:Message-Id:
	Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZUIXUbkq9CBGBl58TAwO6tnCm3lHowZD0AFC0wgqMjs=; b=nOXu0lAVl4jM69RjEgmAPN3Rvm
	xIJON7FXa0jSArDFBsAV+huGhK/SPA7N1YfHG7xtB6mLZIOg0VbyjZ3VaMSawBdsqxo14MOLcfnFD
	/QTfG80t+LMzx/D4CrF2CXPeprgCbMcsSh8LZb5/N0+7YlA9mjtEAr8fLiWDrGLJZy9e6hmvulN5g
	ek6hmXaBYjtpuZU+BZOqZZeRq9uORxl5UxiQv6zXXvvtNPLALZBRWtmlVeGw5B9ZoJtWxhsRSRrae
	2metw7CL/xeuLwkPEMAgDdjrgaQzoTi0LAUAU2QVrsYb2KEYP61aUqVhWnpvrCbYJTiZ8qrjK89uK
	sqJn650A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVCiK-0000000HAJG-1t5O;
	Thu, 04 Jun 2026 18:22:44 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVCiH-0000000HAIv-2gCf
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 18:22:43 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-915336b83adso123203185a.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jun 2026 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780597359; x=1781202159; darn=lists.infradead.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUIXUbkq9CBGBl58TAwO6tnCm3lHowZD0AFC0wgqMjs=;
        b=XNY3JGapnu0Vr+pxBUsYTsvbAXxNCqQ5n55W+cKxPXIpccfsyMGZeqibtmd26FmhcN
         EB/bsdImRtDoAEE86DxclIy9wv6E5QxIZURngLu/4ur6ErvVnK+CLYpS/Uz/XRAa/TlG
         hHSX+UrfnMh7peN5Jmar9kIwwc0fiatGIdG2bLcBZGA73FJHBxhe/aepraeh44UJnsnE
         L0UPrd0BhyPDevGAKVjfcoylf7TRl9F1BBFEbjZEHyb3MmiEYY/P+Az9KNhd097662iH
         lDf11Bww3/IUjtqHu91TQq9eJGq/j3RIIP4ojNTpO+zC/iadXHyppLn7Ek+9VJYmg26U
         P/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597359; x=1781202159;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZUIXUbkq9CBGBl58TAwO6tnCm3lHowZD0AFC0wgqMjs=;
        b=SVcInElld6PV5axTeAlAvYu/cARZbaRVIQxbcVlPpEjiOzD7GugeBKEZFIz80nmhXC
         7322uZr27D8w2BbV91QQr7qGkbQ4XlMHaJG0wWKARepyoZVrpkMFmCDeLlqQmdN4XOgB
         Tzkcr99CBd2I1ke7q+9A7KeSJ+o2P+k70kpEhComJv0PfirwSrUITv23zjxuI8UAYdgV
         DyMcNFYHiFE+yy63oMFS6QidelJR+tKT+gF4zdmCp0g39YSka1H5sOFNPqHnGG/BG4Ze
         hHlE0R4Ga8PkxLCqHj0MDqpROqnLCGq5A8aA8j/Gr24t1Yjzg+5ZeWSrjtJi58MxBrXG
         5/OA==
X-Gm-Message-State: AOJu0YzwNF397dHoo3I1pJ2WW+MG/qV4oiaOM2Sr/SriVEVg8DZ8BZTR
	EE59iC42dqzpMxmh9ADSefAy0jJgYc2AyILaHXSbPZWS+6m/9HHRuQ8nkVGDqpoU
X-Gm-Gg: Acq92OF4zyRGaYZtXpuQ1SjQtNUAsWPdYOWkfWkjvuHj7U94eqR+5qNCF43X1Hd8Ngf
	zJ5t1AkN/ryYpsU56df2HprkfUI1W74x+81S/wVuj57znSkeCPGAuIjEFjJZHc9Cvp4s9FEGQyc
	xeDldnvSvrKLX1dYNMkPL9irkoFeAqLH9DHb1ttbmDxpSx3HjzINWpXze8qi5NIZ26lF/JahLy/
	ap3Hrml8s6VMDeLA5odqx2wsI1xNmY69zjy6xHv4I1apGt3pNsPzQ4CKRs8bIBLI5APOD+WLXF6
	jsdcAUSyulTgP9pHIQzrI0ozJM8RnwuJcmaoOCPmuSsasJKFpHqYGUy1zG/pOp+bUm0pqinEPQM
	3ZjcNHpbMY6WfrZHuKJHhB2LMPWS5RasRS6x5pVJ10FjdCWb3r6NQJ2+J+w3uJ66V5L4CcA3w44
	MKr/l2W+5DMrKogJSaKpLc0QFjayTPj91/EGbUrRPWvaXkaZQcKFSChGVPGOw5v/gb
X-Received: by 2002:a05:620a:29d0:b0:915:a811:1707 with SMTP id af79cd13be357-915a9c12fb0mr52063185a.5.1780597359541;
        Thu, 04 Jun 2026 11:22:39 -0700 (PDT)
Received: from smtpclient.apple ([104.39.165.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00b474sm648962985a.10.2026.06.04.11.22.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2026 11:22:39 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] KASAN: slab-use-after-free in nvme_fc_fcpio_done
Message-Id: <C0EE55F1-9ACD-494A-9EEC-D94EDC220AF9@gmail.com>
Date: Thu, 4 Jun 2026 14:22:07 -0400
Cc: linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
To: justin.tee@broadcom.com,
 nareshgottumukkala83@gmail.com,
 paul.ely@broadcom.com,
 kbusch@kernel.org,
 axboe@kernel.dk,
 sagi@grimberg.me,
 hch@lst.de
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_112241_719138_81630911 
X-CRM114-Status: UNSURE (   9.21  )
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

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: slab-use-after-free in nvme_fc_fcpio_done

on upstream commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 =
2026)

This was found with nvme-fcloop. A previous fcloop-related report I sent =
hit
nvmet_fc_tgt_q_put on the target side:
=
https://lore.kernel.org/linux-nvme/56c826df-efe7-4c48-9142-c32c8e3415a8@gm=
ail.com/

This report is different in that the freed object is the host-side
nvme_fc_ctrl, freed through nvme_sysfs_delete() -> nvme_free_ctrl(), and =
the
later access happens in nvme_fc_fcpio_done() after fcloop calls the host
completion path.

To help trigger the bug more reliably, we applied a minimal diagnostic =
patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/b88810aba94d68ae11ac65b8d1e03a5b

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[ 117.632186][ T1165] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 117.632793][ T1165] BUG: KASAN: slab-use-after-free in =
nvme_fc_fcpio_done (./drivers/nvme/host/nvme.h:473 =
drivers/nvme/host/fc.c:2063)
[ 117.634328][ T1165] Read of size 4 at addr ffff8881269fc3f4 by task =
kworker/u9:2/1165
[ 117.634865][ T1165]
[ 117.635075][ T1165] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 117.635078][ T1165] Workqueue: nvmet-wq fcloop_fcp_abort_recv_work
[ 117.635098][ T1165] Call Trace:
[ 117.635108][ T1165] <TASK>
[ 117.635111][ T1165] dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[ 117.635145][ T1165] print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[ 117.635201][ T1165] kasan_report (mm/kasan/report.c:595)
[ 117.635207][ T1165] nvme_fc_fcpio_done (./drivers/nvme/host/nvme.h:473 =
drivers/nvme/host/fc.c:2063)
[ 117.635215][ T1165] fcloop_call_host_done =
(drivers/nvme/target/fcloop.c:607)
[ 117.635219][ T1165] process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[ 117.635232][ T1165] worker_thread (kernel/workqueue.c:3478)
[ 117.635248][ T1165] kthread (kernel/kthread.c:436)
[ 117.635258][ T1165] ret_from_fork (arch/x86/kernel/process.c:158)
[ 117.635297][ T1165] ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[ 117.635301][ T1165] </TASK>
[ 117.635302][ T1165]
[ 117.644920][ T1165] Freed by task 8162 on cpu 1 at 117.604613s:
[ 117.645351][ T1165] kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[ 117.645683][ T1165] kasan_save_free_info (mm/kasan/generic.c:584)
[ 117.646041][ T1165] __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[ 117.646377][ T1165] kfree (./include/linux/kasan.h:235 mm/slub.c:2689 =
mm/slub.c:6251 mm/slub.c:6566)
[ 117.646664][ T1165] nvme_free_ctrl (drivers/nvme/host/core.c:5102)
[ 117.646997][ T1165] device_release (drivers/base/core.c:2562)
[ 117.647344][ T1165] kobject_put (lib/kobject.c:689 lib/kobject.c:720 =
./include/linux/kref.h:65 lib/kobject.c:737)
[ 117.648052][ T1165] nvme_sysfs_delete (drivers/nvme/host/sysfs.c:401)
[ 117.648392][ T1165] kernfs_fop_write_iter (fs/kernfs/file.c:352)
[ 117.648769][ T1165] vfs_write (fs/read_write.c:595 =
fs/read_write.c:688)
[ 117.649088][ T1165] ksys_write (fs/read_write.c:740)
[ 117.649390][ T1165] do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
[ 117.649737][ T1165] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
[ 117.650124][ T1165]
[ 117.650282][ T1165] The buggy address belongs to the object at =
ffff8881269fc000
[ 117.650282][ T1165] which belongs to the cache kmalloc-4k of size 4096
[ 117.651226][ T1165] The buggy address is located 1012 bytes inside of
[ 117.651226][ T1165] freed 4096-byte region [ffff8881269fc000, =
ffff8881269fd000)



Best,
Shuangpeng


