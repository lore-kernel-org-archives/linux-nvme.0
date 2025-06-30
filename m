Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4C9C83000
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 07:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ujjgqqXOtlPYVV/HT9eFQMeHN1KRR0n6pH0A7HMg59U=; b=WrRwJJYnZqsgQgiqhAZodBZxLL
	YYyTqEaimf4Z9HPWdKXw5gs52NHQfLIhz86QUrJ/qhREggXvOOjkbQixKMRWE6/rxItdzd7I0OrRs
	QkL0vCXtLOWOiFPG0eMnaGo77wLZ8akH+mOHu/mD6Wnb9e64WJ/y/mrq1T1SGpg9zzPUyF/Z8xXNc
	AwEiN4ipOfvEzjr0Y/yLr2OuhaJweQmtqNTDdeS/wPgdWBVEWo4w2v4Dckkrc6YgGpJz+XZB0naBP
	MhZt4oUGMaIkq9mVV1lFwdPUgCorMszlYpea4PhKZCw4g2o10P8LNk1cjyqR+/UJZ7c41VcaYjwrY
	WajrykIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW9Fw-00000001VdZ-0EeO;
	Mon, 30 Jun 2025 07:48:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW9Ft-00000001VdE-3ztX
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 07:48:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 552EC450E3;
	Mon, 30 Jun 2025 07:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98640C4CEE3;
	Mon, 30 Jun 2025 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751269725;
	bh=IGonEX7fdwx2zaIQ2Ed7iAwROhIBFXnO4UDZiR+mK2c=;
	h=From:To:Cc:Subject:Date:From;
	b=GhBmnCLn+QbTtm+FgpTLCZQ5Hi2V9KywEFLWTIQ7rOHz4Omilz5GZphw1RdrmCtj8
	 fGNHKZ6QyRNcfTiNWKSGoGQcs3jhnvOYSCj+nt/PcEuBeeFFOTVcd/BYPbQbyHRqaO
	 81L2JSziLcwpXVSsHjab4WvZ2/RiyCxfK/f5wYn0RV4inKBwiPE2SUHcAiltjXGPut
	 Mpnrq3qgzs176EwzeNLpyzuXV1YUQwwpmhpsorsJVFI9gYl/x/hyP+UpSknczajP75
	 Rvtz5RnVoSUCrZG0eVfUXEglbYIDEovpoCv7dkW7AfkqAM7e306sCyL402ovdEwZhd
	 yBv1fz093oZLA==
From: Geliang Tang <geliang@kernel.org>
To: Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: geliang@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: fix suspicious RCU usage warning
Date: Mon, 30 Jun 2025 15:48:32 +0800
Message-ID: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_004846_032018_540A29B4 
X-CRM114-Status: GOOD (  12.74  )
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

From: Geliang Tang <tanggeliang@kylinos.cn>

When I run the NVME over TCP test in virtme-ng, I get the following
"suspicious RCU usage" warning in nvme_mpath_add_sysfs_link():

'''
[    5.024557][   T44] nvmet: Created nvm controller 1 for subsystem nqn.2025-06.org.nvmexpress.mptcp for NQN nqn.2014-08.org.nvmexpress:uuid:f7f6b5e0-ff97-4894-98ac-c85309e0bc77.
[    5.027401][  T183] nvme nvme0: creating 2 I/O queues.
[    5.029017][  T183] nvme nvme0: mapped 2/0/0 default/read/poll queues.
[    5.032587][  T183] nvme nvme0: new ctrl: NQN "nqn.2025-06.org.nvmexpress.mptcp", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:f7f6b5e0-ff97-4894-98ac-c85309e0bc77
[    5.042214][   T25]
[    5.042440][   T25] =============================
[    5.042579][   T25] WARNING: suspicious RCU usage
[    5.042705][   T25] 6.16.0-rc3+ #23 Not tainted
[    5.042812][   T25] -----------------------------
[    5.042934][   T25] drivers/nvme/host/multipath.c:1203 RCU-list traversed in non-reader section!!
[    5.043111][   T25]
[    5.043111][   T25] other info that might help us debug this:
[    5.043111][   T25]
[    5.043341][   T25]
[    5.043341][   T25] rcu_scheduler_active = 2, debug_locks = 1
[    5.043502][   T25] 3 locks held by kworker/u9:0/25:
[    5.043615][   T25]  #0: ffff888008730948 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x7ed/0x1350
[    5.043830][   T25]  #1: ffffc900001afd40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0xcf3/0x1350
[    5.044084][   T25]  #2: ffff888013ee0020 (&head->srcu){.+.+}-{0:0}, at: nvme_mpath_add_sysfs_link.part.0+0xb4/0x3a0
[    5.044300][   T25]
[    5.044300][   T25] stack backtrace:
[    5.044439][   T25] CPU: 0 UID: 0 PID: 25 Comm: kworker/u9:0 Not tainted 6.16.0-rc3+ #23 PREEMPT(full)
[    5.044441][   T25] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    5.044442][   T25] Workqueue: async async_run_entry_fn
[    5.044445][   T25] Call Trace:
[    5.044446][   T25]  <TASK>
[    5.044449][   T25]  dump_stack_lvl+0x6f/0xb0
[    5.044453][   T25]  lockdep_rcu_suspicious.cold+0x4f/0xb1
[    5.044457][   T25]  nvme_mpath_add_sysfs_link.part.0+0x2fb/0x3a0
[    5.044459][   T25]  ? queue_work_on+0x90/0xf0
[    5.044461][   T25]  ? lockdep_hardirqs_on+0x78/0x110
[    5.044466][   T25]  nvme_mpath_set_live+0x1e9/0x4f0
[    5.044470][   T25]  nvme_mpath_add_disk+0x240/0x2f0
[    5.044472][   T25]  ? __pfx_nvme_mpath_add_disk+0x10/0x10
[    5.044475][   T25]  ? add_disk_fwnode+0x361/0x580
[    5.044480][   T25]  nvme_alloc_ns+0x81c/0x17c0
[    5.044483][   T25]  ? kasan_quarantine_put+0x104/0x240
[    5.044487][   T25]  ? __pfx_nvme_alloc_ns+0x10/0x10
[    5.044495][   T25]  ? __pfx_nvme_find_get_ns+0x10/0x10
[    5.044496][   T25]  ? rcu_read_lock_any_held+0x45/0xa0
[    5.044498][   T25]  ? validate_chain+0x232/0x4f0
[    5.044503][   T25]  nvme_scan_ns+0x4c8/0x810
[    5.044506][   T25]  ? __pfx_nvme_scan_ns+0x10/0x10
[    5.044508][   T25]  ? find_held_lock+0x2b/0x80
[    5.044512][   T25]  ? ktime_get+0x16d/0x220
[    5.044517][   T25]  ? kvm_clock_get_cycles+0x18/0x30
[    5.044520][   T25]  ? __pfx_nvme_scan_ns_async+0x10/0x10
[    5.044522][   T25]  async_run_entry_fn+0x97/0x560
[    5.044523][   T25]  ? rcu_is_watching+0x12/0xc0
[    5.044526][   T25]  process_one_work+0xd3c/0x1350
[    5.044532][   T25]  ? __pfx_process_one_work+0x10/0x10
[    5.044536][   T25]  ? assign_work+0x16c/0x240
[    5.044539][   T25]  worker_thread+0x4da/0xd50
[    5.044545][   T25]  ? __pfx_worker_thread+0x10/0x10
[    5.044546][   T25]  kthread+0x356/0x5c0
[    5.044548][   T25]  ? __pfx_kthread+0x10/0x10
[    5.044549][   T25]  ? ret_from_fork+0x1b/0x2e0
[    5.044552][   T25]  ? __lock_release.isra.0+0x5d/0x180
[    5.044553][   T25]  ? ret_from_fork+0x1b/0x2e0
[    5.044555][   T25]  ? rcu_is_watching+0x12/0xc0
[    5.044557][   T25]  ? __pfx_kthread+0x10/0x10
[    5.044559][   T25]  ret_from_fork+0x218/0x2e0
[    5.044561][   T25]  ? __pfx_kthread+0x10/0x10
[    5.044562][   T25]  ret_from_fork_asm+0x1a/0x30
[    5.044570][   T25]  </TASK>
'''

This patch uses sleepable RCU version of helper list_for_each_entry_srcu()
instead of list_for_each_entry_rcu() to fix it.

Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e040e467f9fa..5e11b0fdf250 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1200,7 +1200,8 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
 	 */
 	srcu_idx = srcu_read_lock(&head->srcu);
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		/*
 		 * Ensure that ns path disk node is already added otherwise we
 		 * may get invalid kobj name for target
-- 
2.48.1


