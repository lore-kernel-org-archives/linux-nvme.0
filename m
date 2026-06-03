Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8B3CD6E5D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 03:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Cc:Date:Message-Id:
	Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q/9QSmlwvyQ7YX+ip3mA2ABV0en3bHcR7/Ftk9aBTEI=; b=HTXddmZTBSeTwbGC1H17bqOvYG
	Po5XLrAsfdif05wASYLSy5zi3gwpz9L72PKwq4eU2JhGwfkUNDXLCZ+ED3Zey+n9noE/Eg5Qarscq
	3HjdXTgajQWNSfkjkHacClnTF3fg3ZkwlAOjdew8YL/z0/kZ30s5qukQwss4VDYPqbSmajnGg4bdd
	dOhhMm1LPKcm6GTFbTZFUaLjf2sZAVfcqgROmSJ/83MRN849fhybeDi5lJXNHHj03hMf7JD5qzZI+
	WnZQwra+P/rE9lUP8kxLRxdKzEj2TuvsaK1GbwOjykVgLblx8NXDdSNK/6SO40Dyh0NKbo6laO+HG
	kEHUUBkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcCX-0000000EAfS-0uXp;
	Wed, 03 Jun 2026 03:23:29 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcCU-0000000EAeZ-3aP3
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 03:23:28 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-517583cb07aso27037441cf.2
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2026 20:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780457005; x=1781061805; darn=lists.infradead.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/9QSmlwvyQ7YX+ip3mA2ABV0en3bHcR7/Ftk9aBTEI=;
        b=RMPn7R4aSut6jMi+Kj+sD1roUgLezUmIJbRXhnfh1AQFx5iIGuQNYap/z9hlvraEX8
         Zo/U0trk+rVXiL72+8MAAjvVgz8+DZe1gv2vNXVm3pYHl0UAXgcSFGBkQwf9IbHwP6cU
         HKjK3719KfyuoGx+1Nb6WCrEo0uY2eg0CKEuHWCNmVlBNy17LKJn/wKVH77j+ECagFMJ
         QsW9+tp8m8Zce6U7zkCQTU9deJYhONXacSt4ZP/kF0YrqbfjszmmEaiQr48AGJsp2unO
         Rb8bGc0gGsTHgSiLPd2nhcep/NZr6rraVl8BK7szZe/nXUGI3Ql9ejS7wDFDgCNvuGMu
         xIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457005; x=1781061805;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/9QSmlwvyQ7YX+ip3mA2ABV0en3bHcR7/Ftk9aBTEI=;
        b=cFBCekucEyH7pq+jaW76ME/jssRGjp0kBPSLdZQOpZLNMuOh3TJdGQHhEX1gG7kClm
         i0xY8PrgZIUjx6K5q6hK+M2Gp9hm+s0exTsCE9Q6PSUBpHe7qcGbkLoSOj4yvFJ/NrD3
         ejmKSVtaLx0u0gv5qNG3BvBV97Z8wdSRGg67d1pD+TDe1Gr7ICcrH6a/AxsBRda+KGMW
         cmTVU+QcM/mK89kFV4lv+Gm700CV2dF6iHkMxjB731PTyOLY6XE055yK1pcgWHovyqhJ
         CTtipTdXWY2Qm7Hyc5yqZ09TKKfGk+tJGFO9ylX3AdQkkBGE6bhuzdO738PzShDqbFf+
         F2ag==
X-Gm-Message-State: AOJu0YwZSdd5YPDEQRYFZCuOpO9Uo2Ssb6rVWQldyWSxnNkqBl8B03QW
	2AO+sdVH5K8iDbKEhMlbuGFjntNByIJrHQVWDQJKymLs4j2d4T2/CCmoAqDfuJHt
X-Gm-Gg: Acq92OH2Sj8lTQt/JW0ndnnQXcA/982OccUWfnQXu2ERUrZgoSQtHjQeOQ2Hk4wueUG
	bwNGSWR5wbEdrnfvViKPNdOxAG0eK4QhNcJrGhsm15sYNA5+XwfAAXf61mDfytWGHZFHreWQlLZ
	vBdCOjcSPClCPX6PJXvDQtZ3H1/6LyGd+mb5XD5iHzjCtirq7xkY8DT5FBB9h6slXM1CFUFwXMZ
	1swcQmK1vVUd3Ms25xrtHwy9lFryUJOoq3jc5Fl0m/qcuRUJZPVvjRS46M5r0EE7L2MBuHg+Wcj
	g8wTYV0E/BMVWSooyzMrbGw6q6BUpPXLgj8l2+ECHhVtweRcVBCt+QunDlVJ04/XViD9jkaYoPg
	Pjuumq6HZ89sB07YDJr+K2sRzxc1GO3GGXdyl6vso733VGQD62l/2TDbA/7B1t5TuMV97uTTXuA
	wFpi4W3PM/0DfXmVs3bVimvELkwCYRv8rz3g8lL5CeWLJ+9ymjNnb7da1qb/puLvey4/aYQErnc
	Fc=
X-Received: by 2002:ac8:5844:0:b0:50f:b13e:b746 with SMTP id d75a77b69052e-517787847f5mr27759121cf.44.1780457005139;
        Tue, 02 Jun 2026 20:23:25 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:6079:17ed:fd11:8e45])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07f0dsm14808491cf.3.2026.06.02.20.23.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2026 20:23:24 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] KASAN: slab-use-after-free in nvmet_fc_tgt_q_put
Message-Id: <F54D7903-EA2A-4DF8-92BD-839877786139@gmail.com>
Date: Tue, 2 Jun 2026 23:23:13 -0400
Cc: linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
To: justin.tee@broadcom.com,
 nareshgottumukkala83@gmail.com,
 paul.ely@broadcom.com,
 hch@lst.de,
 sagi@grimberg.me,
 kch@nvidia.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202326_901016_29162196 
X-CRM114-Status: UNSURE (   7.93  )
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

KASAN: slab-use-after-free in nvmet_fc_tgt_q_put

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic =
patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/57055c1ccb14132218674ec5f3f31d34

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[ 755.638997][ T62] BUG: KASAN: slab-use-after-free in =
nvmet_fc_tgt_q_put (drivers/nvme/target/fc.c:845 =
./include/linux/kref.h:65 drivers/nvme/target/fc.c:855)
[ 755.639021][ T62] Read of size 8 at addr ffff8881789bd010 by task =
kworker/u9:1/62
[ 755.639025][ T62]
[ 755.639049][ T62] Tainted: [D]=3DDIE
[ 755.639051][ T62] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 755.639055][ T62] Workqueue: nvmet-wq fcloop_fcp_recv_work
[ 755.639063][ T62] Call Trace:
[ 755.639066][ T62] <TASK>
[ 755.639075][ T62] dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[ 755.639082][ T62] print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[ 755.639145][ T62] kasan_report (mm/kasan/report.c:595)
[ 755.639167][ T62] nvmet_fc_tgt_q_put (drivers/nvme/target/fc.c:845 =
./include/linux/kref.h:65 drivers/nvme/target/fc.c:855)
[ 755.639172][ T62] nvmet_fc_free_fcp_iod (drivers/nvme/target/fc.c:742)
[ 755.639183][ T62] __nvmet_req_complete =
(drivers/nvme/target/core.c:800)
[ 755.639228][ T62] nvmet_req_init (drivers/nvme/target/core.c:1228)
[ 755.639235][ T62] nvmet_fc_queue_fcp_req =
(drivers/nvme/target/fc.c:2574 drivers/nvme/target/fc.c:703)
[ 755.639309][ T62] nvmet_fc_rcv_fcp_req (drivers/nvme/target/fc.c:2706)
[ 755.639320][ T62] fcloop_fcp_recv_work =
(drivers/nvme/target/fcloop.c:695)
[ 755.639326][ T62] process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[ 755.639334][ T62] worker_thread (kernel/workqueue.c:3478)
[ 755.639346][ T62] kthread (kernel/kthread.c:436)
[ 755.639361][ T62] ret_from_fork (arch/x86/kernel/process.c:158)
[ 755.639382][ T62] ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[ 755.639388][ T62] </TASK>
[ 755.639391][ T62]
[ 755.695276][ T62] Freed by task 8206 on cpu 1 at 750.648915s:
[ 755.695819][ T62] kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[ 755.696265][ T62] kasan_save_free_info (mm/kasan/generic.c:584)
[ 755.696716][ T62] __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[ 755.697150][ T62] kfree (./include/linux/kasan.h:235 mm/slub.c:2689 =
mm/slub.c:6251 mm/slub.c:6566)
[ 755.697522][ T62] nvmet_fc_delete_assoc_work =
(drivers/nvme/target/fc.c:1071)
[ 755.698028][ T62] process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[ 755.698518][ T62] worker_thread (kernel/workqueue.c:3478)
[ 755.698929][ T62] kthread (kernel/kthread.c:436)
[ 755.699300][ T62] ret_from_fork (arch/x86/kernel/process.c:158)
[ 755.699713][ T62] ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[ 755.700142][ T62]
[ 755.700357][ T62] The buggy address belongs to the object at =
ffff8881789bd000
[ 755.700357][ T62] which belongs to the cache kmalloc-2k of size 2048
[ 755.701604][ T62] The buggy address is located 16 bytes inside of


Best,
Shuangpeng


