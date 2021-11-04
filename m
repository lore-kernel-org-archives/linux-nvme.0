Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5433C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 07:14:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C6D61053
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 07:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16C6D61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W4BNZh7SLMYxLTh3m1M4vfaVsVtWn4LwaFKndlqTgFY=; b=nZc5SIZwmDHInB9sR9Cya9lsbZ
	SBKWIZIPIq57U/oMAqAdWNPQwvD2zdbvhXwR33VuI7ZSh4Vh15YaGqhF0OCbRh2DdxC5TDlBZcoyQ
	7Ny4M1R1aEG4DDMHFSVfxnhB/1zrwM4t6vi+lY2QEuV9b12VqKRDOmsyGsfoiDGp1DeaQ2jsmx7nY
	9jw7hRS98Mt4QXxvPlk8qoPJWduIH0nlhtChVXCwW0IAHzeqzJ1KXPpv3EBXgz8s+v75XyWdGdUc5
	PDEsBa0Bp6neu3GdBUy/vg12sLp377U2DWsP5qwHxJKHzZa6e+BSVAAMAhxITKBeIxm7X24Oet9q8
	NbFSW5tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miWwf-0089EU-8z; Thu, 04 Nov 2021 07:13:57 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miWwY-0089Aj-BY
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 07:13:54 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HlF9X1gkjzbhc2;
 Thu,  4 Nov 2021 15:08:48 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 15:13:33 +0800
Received: from huawei.com (10.29.88.127) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:13:32 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>
Subject: [PATCH 0/1] fix UAF when disconnect a reconnecting state ctrl
Date: Thu, 4 Nov 2021 15:13:31 +0800
Message-ID: <20211104071332.28952-1-liruozhu@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_001351_078102_880C71CF 
X-CRM114-Status: GOOD (  13.69  )
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

Hi all,

I got a crash when try to disconnect a reconnecting state ctrl:

[471911.294008] nvme nvme0: queue_size 128 > ctrl sqsize 64, clamping down
[471911.307202] nvme nvme0: creating 8 I/O queues.
[471912.594024] nvme nvme0: mapped 8/0/0 default/read/poll queues.
[471912.609217] nvme nvme0: Successfully reconnected (1 attempts)
[471943.120619] nvme nvme0: I/O 55 QID 8 timeout
[471943.120706] nvme nvme0: starting error recovery
[471943.374412] nvme nvme0: Reconnecting in 10 seconds...
[471956.880616] nvme nvme0: rdma connection establishment failed (-110)
[471956.893534] nvme nvme0: Failed reconnect attempt 1
[471956.893624] nvme nvme0: Reconnecting in 10 seconds...
[471970.192614] nvme nvme0: rdma connection establishment failed (-110)
[471970.205218] nvme nvme0: Failed reconnect attempt 2
[471970.205305] nvme nvme0: Reconnecting in 10 seconds...
[471983.504614] nvme nvme0: rdma connection establishment failed (-110)
[471983.517433] nvme nvme0: Failed reconnect attempt 3
[471983.517520] nvme nvme0: Reconnecting in 10 seconds...
[471996.816613] nvme nvme0: rdma connection establishment failed (-110)
[471996.829151] nvme nvme0: Failed reconnect attempt 4
[471996.829238] nvme nvme0: Reconnecting in 10 seconds...
[472010.128613] nvme nvme0: rdma connection establishment failed (-110)
[472010.141282] nvme nvme0: Failed reconnect attempt 5
[472010.141369] nvme nvme0: Reconnecting in 10 seconds...
[472023.440614] nvme nvme0: rdma connection establishment failed (-110)
[472023.453454] nvme nvme0: Failed reconnect attempt 6
[472023.453540] nvme nvme0: Reconnecting in 10 seconds...
[472024.521328] nvme nvme0: Removing ctrl: NQN "nqn.2020-02.huawei.nvme:nvm-subsystem:524a52c71888b039"
[472024.524616] ------------[ cut here ]------------
[472024.524703] kernel BUG at include/linux/iommu-helper.h:21!
[472024.524797] invalid opcode: 0000 [#1] SMP PTI
[472024.524883] CPU: 39 PID: 1226 Comm: kworker/39:1H Kdump: loaded Not tainted 4.18.0-305.19.1.el8_4.x86_64 #1
[472024.524998] Hardware name: Huawei Technologies Co., Ltd. RH2288H V3/BC11HGSA0, BIOS 5.13 04/11/2019
[472024.525118] Workqueue: kblockd blk_mq_run_work_fn
[472024.525207] RIP: 0010:swiotlb_tbl_map_single+0x20d/0x360
[472024.525294] Code: 20 00 48 21 c6 4c 8d a6 ff 07 00 00 49 c1 ec 0b 48 83 f8 ff 0f 84 83 fe ff ff 4c 8d b0 00 08 00 00 49 c1 ee 0b e9 73 fe ff ff <0f> 0b 48 c7 c7 20 56 a2 bb e8 d5 0d fe ff 85 c0 0f 84 5a ff ff ff
[472024.525447] RSP: 0018:ffff9ba2ce933c08 EFLAGS: 00010006
[472024.525534] RAX: 0000000000000000 RBX: ffff8f7bfdb3a010 RCX: 000000000000007a
[472024.525648] RDX: 0000000000000001 RSI: 0000000000008000 RDI: 001ffff1f20c42c3
[472024.525759] RBP: 070844202af8993f R08: 0000000000000001 R09: 0000000000000001
[472024.525868] R10: 0000000000000000 R11: 0001ad4dc7082f00 R12: 0000e10080080040
[472024.525977] R13: 0000000000000001 R14: 001ffff1f20c42c4 R15: 0000000000000040
[472024.526087] FS:  0000000000000000(0000) GS:ffff8f941fbc0000(0000) knlGS:0000000000000000
[472024.526198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[472024.526286] CR2: 0000557524c8c5d6 CR3: 0000001b8ae10003 CR4: 00000000001706e0
[472024.526395] Call Trace:
[472024.526479]  swiotlb_map+0x62/0x200
[472024.526564]  dma_map_page_attrs+0x108/0x170
[472024.526651]  nvme_rdma_queue_rq+0xcf/0xbf0 [nvme_rdma]
[472024.526741]  ? __switch_to_asm+0x41/0x70
[472024.526826]  ? __switch_to_asm+0x35/0x70
[472024.526911]  blk_mq_dispatch_rq_list+0x11c/0x730
[472024.526998]  ? __switch_to_asm+0x35/0x70
[472024.534906]  ? __switch_to_asm+0x41/0x70
[472024.534990]  ? __switch_to_asm+0x35/0x70
[472024.535074]  ? __switch_to_asm+0x41/0x70
[472024.535158]  ? __switch_to_asm+0x35/0x70
[472024.535243]  ? __switch_to_asm+0x41/0x70
[472024.535327]  ? __switch_to_asm+0x35/0x70
[472024.535412]  ? entry_SYSCALL_64_after_hwframe+0xb9/0xca
[472024.535499]  ? __switch_to_asm+0x41/0x70
[472024.535585]  __blk_mq_sched_dispatch_requests+0xc6/0x170
[472024.535673]  blk_mq_sched_dispatch_requests+0x30/0x60
[472024.535760]  __blk_mq_run_hw_queue+0x51/0xd0
[472024.535848]  process_one_work+0x1a7/0x360
[472024.535933]  ? create_worker+0x1a0/0x1a0
[472024.536017]  worker_thread+0x30/0x390
[472024.536101]  ? create_worker+0x1a0/0x1a0
[472024.536186]  kthread+0x116/0x130
[472024.536271]  ? kthread_flush_work_fn+0x10/0x10
[472024.536357]  ret_from_fork+0x35/0x40

This happened because this IO request try to access rdma resource which 
already was freed:

1) The network was cut off when the connection was just established,
scan work hanged there waiting for some IOs complete.Those IOs were
retrying because we return BLK_STS_RESOURCE to blk in reconnecting:

PID: 162851  TASK: ffff8f777cafc740  CPU: 11  COMMAND: "kworker/u97:2"
 #0 [ffff9ba2ce39bad8] __schedule at ffffffffbb549184
 #1 [ffff9ba2ce39bb70] schedule at ffffffffbb5495f8
 #2 [ffff9ba2ce39bb80] blk_mq_freeze_queue_wait at ffffffffbb04ce56
 #3 [ffff9ba2ce39bbc8] nvme_update_disk_info at ffffffffc0827393 [nvme_core]
 #4 [ffff9ba2ce39bc58] __nvme_revalidate_disk at ffffffffc0827810 [nvme_core]
 #5 [ffff9ba2ce39bc78] nvme_revalidate_disk at ffffffffc08295db [nvme_core]
 #6 [ffff9ba2ce39bce0] revalidate_disk at ffffffffbaf5d285
 #7 [ffff9ba2ce39bd08] nvme_validate_ns at ffffffffc082c724 [nvme_core]
 #8 [ffff9ba2ce39bde0] nvme_scan_work at ffffffffc082d2f1 [nvme_core]

2) After a while, I try to disconnect this connection.This procedure
also hung because it try to obtain ctrl->scan_lock.It should be noted
that now we have switched the controller state to NVME_CTRL_DELETING:

PID: 163003  TASK: ffff8f91ac10af80  CPU: 25  COMMAND: "nvme"
 #0 [ffff9ba2ce0bfcd8] __schedule at ffffffffbb549184
 #1 [ffff9ba2ce0bfd70] schedule at ffffffffbb5495f8
 #2 [ffff9ba2ce0bfd80] schedule_preempt_disabled at ffffffffbb54993a
 #3 [ffff9ba2ce0bfd88] __mutex_lock at ffffffffbb54b640
 #4 [ffff9ba2ce0bfe10] nvme_mpath_clear_ctrl_paths at ffffffffc082e795 [nvme_core]
 #5 [ffff9ba2ce0bfe38] nvme_remove_namespaces at ffffffffc0829c01 [nvme_core]
 #6 [ffff9ba2ce0bfe70] nvme_do_delete_ctrl at ffffffffc0829d03 [nvme_core]
 #7 [ffff9ba2ce0bfe80] nvme_sysfs_delete at ffffffffc0829d77 [nvme_core]

3) In nvme_check_ready(), we always return true when ctrl->state is 
NVME_CTRL_DELETING, so those retrying IOs were issued to the bottom 
device which was already freed:

PID: 1226   TASK: ffff8f937663df00  CPU: 39  COMMAND: "kworker/39:1H"
    [exception RIP: swiotlb_tbl_map_single+525]
    RIP: ffffffffbad6749d  RSP: ffff9ba2ce933c08  RFLAGS: 00010006
    RAX: 0000000000000000  RBX: ffff8f7bfdb3a010  RCX: 000000000000007a
    RDX: 0000000000000001  RSI: 0000000000008000  RDI: 001ffff1f20c42c3
    RBP: 070844202af8993f   R8: 0000000000000001   R9: 0000000000000001
    R10: 0000000000000000  R11: 0001ad4dc7082f00  R12: 0000e10080080040
    R13: 0000000000000001  R14: 001ffff1f20c42c4  R15: 0000000000000040
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff9ba2ce933c68] swiotlb_map at ffffffffbad677e2
 #8 [ffff9ba2ce933cc8] dma_map_page_attrs at ffffffffbad65918
 #9 [ffff9ba2ce933d00] nvme_rdma_queue_rq at ffffffffc07182ef [nvme_rdma]
 10 [ffff9ba2ce933d78] blk_mq_dispatch_rq_list at ffffffffbb04fdfc
 11 [ffff9ba2ce933e30] __blk_mq_sched_dispatch_requests at ffffffffbb055ad6
 12 [ffff9ba2ce933e70] blk_mq_sched_dispatch_requests at ffffffffbb055c70
 13 [ffff9ba2ce933e80] __blk_mq_run_hw_queue at ffffffffbb04d411

I tried to give a solution in following patch.Any suggestions are welcome.

Thanks,
Ruozhu 

Ruozhu Li (1):
  nvme: fix use after free when disconnect a reconnecting ctrl

 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.16.4


