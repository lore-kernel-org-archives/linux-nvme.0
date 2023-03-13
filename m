Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F24C6FD19
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=45OBRNw99GzJGIhtZHgHZKLw7P4kwjECWmUuG6ryuFY=; b=v5ZuGluQtx1jvtqT4Cr/hFnuaL
	pkQqo+aBYfLghIRV97NYLc3SpfV4yq9wThmx2F7QQD+F64yMg00iGjtBFut25TyqAGd6jf+Lh1cMM
	pg+pjy9YotS74ZEKgwxrpRVWhGczkBMkPr7M9QQCKahBaEDyFpCTcZpXEJVF4TDPDuvGMjz7PtLfg
	VYOSOiFJKMjk8dIKSs3k+fPnNarnWxTwC8WQ9XOto3aUXwcWFAqWGHgEmCxfSwIWmOEvybVoDCS5K
	GDghsKxbYkCds6/Fu9zTtAW0TNHi4TtexiVxrH/zUSDLV8U37/tZ0y9ZEZGY4+ShXFdbGLVuuPGh5
	iCEXZ+Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbgVf-005Rjk-Ln; Mon, 13 Mar 2023 11:38:35 +0000
Received: from [1.203.97.246] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbgVb-005RjK-H6
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 11:38:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 2DE467C0112;
	Mon, 13 Mar 2023 19:32:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.13])
	by smtp.cecloud.com (postfix) whith ESMTP id P250386T281460279865712S1678707127136560_;
	Mon, 13 Mar 2023 19:32:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b89d09873d542a81b5d3bcc70d1fa290>
X-RL-SENDER: zhangyanjun@cestc.cn
X-SENDER: zhangyanjun@cestc.cn
X-LOGIN-NAME: zhangyanjun@cestc.cn
X-FST-TO: kbusch@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 111.48.58.13
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: zhangyanjun@cestc.cn
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	zhangyanjun@cestc.cn,
	xiang.li@cestc.cn,
	shaopeijie@cestc.cn
Subject: [RFC PATCH] nvme-tcp: fix possible crash when only partilal queues are allocated by nvme_tcp_alloc_queue
Date: Mon, 13 Mar 2023 19:32:04 +0800
Message-Id: <20230313113204.2205730-1-zhangyanjun@cestc.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_043831_886468_4B39EAAE 
X-CRM114-Status: GOOD (  15.24  )
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

From: Yanjun Zhang <zhangyanjun@cestc.cn>

In storage clusters constructed by nvme-tcp driver, we have encountered
the following two kinds of crashes on the host kernel repeatedly.

one crash info:
[16802.107284] nvme nvme4: starting error recovery
[16802.109166] nvme nvme4: Reconnecting in 10 seconds...
[16812.173535] nvme nvme4: failed to connect socket: -111
[16812.173745] nvme nvme4: Failed reconnect attempt 1
[16812.173747] nvme nvme4: Reconnecting in 10 seconds...
[16822.413555] nvme nvme4: failed to connect socket: -111
[16822.413762] nvme nvme4: Failed reconnect attempt 2
[16822.413765] nvme nvme4: Reconnecting in 10 seconds...
[16832.661274] nvme nvme4: creating 32 I/O queues.
[16833.919887] BUG: kernel NULL pointer dereference, address: 0000000000000088
[16833.920068] nvme nvme4: Failed reconnect attempt 3
[16833.920094] #PF: supervisor write access in kernel mode
[16833.920261] nvme nvme4: Reconnecting in 10 seconds...
[16833.920368] #PF: error_code(0x0002) - not-present page
[16833.920600] PGD a21a12067 P4D b998cf067 PUD c00be5067 PMD 0
[16833.920731] Oops: 0002 [#1] SMP NOPTI
[16833.920852] CPU: 28 PID: 1324 Comm: kworker/28:1H Kdump: loaded Tainted: G S                5.15.67.cl9.x86_64 #1
[16833.920980] Hardware name: Inspur NF5280M6/NF5280M6, BIOS 06.00.04 07/07/2022
[16833.921086] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[16833.921191] RIP: 0010:_raw_spin_lock_bh+0x17/0x30
[16833.921294] Code: ff 66 90 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 65 81 05 f0 ab 35 4a 00 02 00 00 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 c7 09 69 ff 66 90 c3 cc
[16833.921539] RSP: 0018:ff5d9770a078fdf8 EFLAGS: 00010246
[16833.921658] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[16833.921787] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000088
[16833.921912] RBP: 0000000000000088 R08: ff4f755fca433f00 R09: ff4f7558374a7874
[16833.922040] R10: 000000000000000c R11: 000000000000000c R12: ff4f7563dbbdad80
[16833.922177] R13: 0000000100fc48f3 R14: ff4f754b6dbfa278 R15: ff8f97707db0b905
[16833.922317] FS:  0000000000000000(0000) GS:ff4f756fccd00000(0000) knlGS:0000000000000000
[16833.922454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16833.922593] CR2: 0000000000000088 CR3: 0000000b8477e002 CR4: 0000000000771ee0
[16833.922731] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16833.922869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16833.923007] PKRU: 55555554
[16833.923138] Call Trace:
[16833.923271]  <TASK>
[16833.923402]  lock_sock_nested+0x1e/0x50
[16833.923545]  nvme_tcp_try_recv+0x40/0xa0 [nvme_tcp]
[16833.923685]  nvme_tcp_io_work+0x68/0xa0 [nvme_tcp]
[16833.923824]  process_one_work+0x1e8/0x390
[16833.923969]  worker_thread+0x53/0x3d0
[16833.924104]  ? process_one_work+0x390/0x390
[16833.924240]  kthread+0x124/0x150
[16833.924376]  ? set_kthread_struct+0x50/0x50
[16833.924518]  ret_from_fork+0x1f/0x30
[16833.924655]  </TASK>

another crash info:
[68988.971395] nvme nvme2: starting error recovery
[68988.973561] nvme nvme2: Reconnecting in 10 seconds...
[68999.335529] nvme nvme2: creating 32 I/O queues.
[69003.817099] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[69003.817355] nvme nvme2: Failed reconnect attempt 1
[69003.817360] nvme nvme2: Reconnecting in 10 seconds...
[69003.817398] #PF: supervisor read access in kernel mode
[69003.817400] #PF: error_code(0x0000) - not-present page
[69003.817401] PGD 0 P4D 0
[69003.819376] Oops: 0000 [#1] SMP NOPTI
[69003.819610] CPU: 23 PID: 1941 Comm: kworker/23:1H Kdump: loaded Tainted: G S      W   E     5.15.67-0.el9.x86_64 #1
[69003.819876] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.21 08/25/2021
[69003.820152] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[69003.820445] RIP: 0010:nvme_tcp_try_recv+0x5c/0xa0 [nvme_tcp]
[69003.820746] Code: 00 49 8b 6c 24 18 48 89 ef e8 30 5a ff d6 48 89 ef 48 c7 c2 90 67 63 c0 c7 83 b0 00 00 00 00 00 00 00 49 8b 44 24 20 48 89 e6 <48> 8b 80 c0 00 00 00 ff d0 0f 1f 00 48 89 ef 41 89 c4 e8 4d 5b ff
[69003.821413] RSP: 0018:ffffab53cff17e18 EFLAGS: 00010286
[69003.821760] RAX: 0000000000000000 RBX: ffff9c60e1279c80 RCX: 0000000000000000
[69003.822117] RDX: ffffffffc0636790 RSI: ffffab53cff17e18 RDI: ffff9cb4bb1708c0
[69003.822482] RBP: ffff9cb4bb1708c0 R08: ffff9cc5df4f1128 R09: ffff9cc5df4f1128
[69003.822858] R10: 0000000000000050 R11: 0000000000000000 R12: ffff9cb446bd1a00
[69003.823242] R13: 0000000104185f8b R14: ffff9c60e1279c88 R15: ffffcb53be0c6d05
[69003.823632] FS:  0000000000000000(0000) GS:ffff9cc5df4c0000(0000) knlGS:0000000000000000
[69003.824036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[69003.824446] CR2: 00000000000000c0 CR3: 0000000780610002 CR4: 00000000007706e0
[69003.824867] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[69003.825278] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[69003.825685] PKRU: 55555554
[69003.826084] Call Trace:
[69003.826490]  <TASK>
[69003.826894]  nvme_tcp_io_work+0x64/0x90 [nvme_tcp]
[69003.827313]  process_one_work+0x1e8/0x390
[69003.827739]  worker_thread+0x53/0x3c0
[69003.828163]  ? process_one_work+0x390/0x390
[69003.828594]  kthread+0x10c/0x130
[69003.829027]  ? set_kthread_struct+0x40/0x40
[69003.829470]  ret_from_fork+0x1f/0x30
[69003.829953]  </TASK>

By analyzing the vmcore, we confirm the direct cause is sock->sk=NULL
and sock->ops=NULL attached to the struct nvme_tcp_queue. And we found
this issue occurred during the execuation of __nvme_tcp_alloc_io_queues
every time. Such as when nvme_tcp_alloc_queue failed to allocate the
29th I/O queue, the return flow would free previously allocated 28 I/O
queues, but possibly some io_works attached to these allocated I/O queues
have already been queued. So we query that directly freeing these allocated
I/O queues may result in this issue. To avoid this issuse, we try to make
the following code modifications, but have not verified to be valid yet
because of the occasionality of this issue.

Now, we can not confirm the caller of queuing on the io_work during
allocating all the I/O queues, but we doubt that the socket interface
sk_data_ready=nvme_tcp_data_ready initialized by nvme_tcp_alloc_queue
may do this action in this interval. Hope to get some suggestions, Thanks!

Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
---
 drivers/nvme/host/tcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9b47dcb2a..5782183b8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1761,6 +1761,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
+	struct nvme_tcp_ctrl *tcp_ctrl = NULL;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i);
@@ -1771,9 +1772,11 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return 0;
 
 out_free_queues:
-	for (i--; i >= 1; i--)
+	for (i--; i >= 1; i--) {
+		tcp_ctrl = to_tcp_ctrl(ctrl);
+		__nvme_tcp_stop_queue(&tcp_ctrl->queues[i]);
 		nvme_tcp_free_queue(ctrl, i);
-
+	}
 	return ret;
 }
 
-- 
2.31.1




