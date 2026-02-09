Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B1DE81BA9
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W1d2Q44PBPc63sk/1tI/lBXjgDDmI9WU37N5alT7Wlw=; b=BIY5xOw2EoHhnSEZ/edWWJ697e
	yx2uVjb6czQBWZOvswbF8EKlryM69wREO+94Jn7C7mTCVQ32NCh0W4567ZtTEHrLO82yx19KnTkEP
	E6NdgGXJ16OYdhjOtx1EwUova25q0kC3K5AWUV9HaBKuNbYsrGC5d+VQwV9MY6/9w5K/dJoJRUzLV
	z+VINEb9uED/zI72IoNPzInBM/A4lvkHqCYIBDSVsLqD2DaixWB3aSWYVMhTP54nz197GYa+bP5SZ
	zDyWiu6rsJkrqJ7pUESeIMXqLJkbCQBLqqXHYrPgtdoSCcV8r7xNNQ9ToE7qdsL7FG5XWIOBEAZX9
	msvs2e7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpQ6b-0000000FLbQ-02af;
	Mon, 09 Feb 2026 12:11:05 +0000
Received: from m16.mail.163.com ([220.197.31.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpQ6Y-0000000FLaf-1I45
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 12:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=W1
	d2Q44PBPc63sk/1tI/lBXjgDDmI9WU37N5alT7Wlw=; b=onmAlw8MwrNfECE3pL
	2HGySqimQq+8vulHBRpltrSpf66WS4dPfweQoKWI0JR5EG379luSKh+1066t8OGX
	cGmdVQY4mQ7Mcpmtz/hNV+uobKgjSNBWpzoJUxEkYaHXXtf9sj0Upqo8MWx54ImK
	wDi5jWP0fgHJU50IlEdCcjlPc=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXC_muzolpla36Jw--.11722S2;
	Mon, 09 Feb 2026 20:10:24 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Junnan Zhang <zhangjn_dev@163.com>,
	Shouxin Sun <sunshx@chinatelecom.cn>,
	Junnan Zhang <zhangjn11@chinatelecom.cn>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	Zhaolong Zhang <zhangzl68@chinatelecom.cn>,
	Yaxuan Liu <liuyx92@chinatelecom.cn>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix potential I/O hang when CQ is full
Date: Mon,  9 Feb 2026 20:10:19 +0800
Message-ID: <20260209121020.119853-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXC_muzolpla36Jw--.11722S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryUuF1DWrW7JFW8uF1kGrg_yoW7Wr4rpF
	W3KrZ8Gas3WryIyw4UXF4jvry8Can5tr9rJF92ka4xJa4qk3sYvFy3K3WYqrW5Wa4DW34Y
	vFn8trW8uF4rJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR3PEDUUUUU=
X-Originating-IP: [118.112.177.142]
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbCxhCcMmmJzrCA9gAA3Q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_041102_717672_BCA10229 
X-CRM114-Status: GOOD (  19.09  )
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

When an NVMe interrupt is triggered, the current implementation first
handles the CQE and then updates the CQ head. This may lead to a timing
window causing a lower-level CQ full condition, which in turn leads to
an I/O hang as described below:

1. NVMe interrupt handling flow: nvme_handle_cqe -> nvme_pci_complete_rq
-> ... -> blk_mq_put_tag(when not added to the batch processing flow)
notifies the NVMe driver that it can continue issuing commands.
2. The NVMe driver issues a new command while the CQ head has not yet
been updated.
3. The underlying layer finishes processing the new command immediately
and attempts to place it into the completion queue. It then detects that
the CQ is full and discards the command.
4. The NVMe interrupt flow from step 1 subsequently updates the CQ head.

The sequence diagram is as follows:

      driver              irq             underlying(virtual/hardware)
      ------             ------                     ------
  1. Wait for tag
                        1. Read CQE      CQ is full, wait for head update
                        2. Handle CQE
                        3. Wake up tag
  2. Get tag
  (blk_mq_put_tag)
  3. Issue new cmd
                                          1. Process cmd
                                          2. Try write to CQ
                                          3. CQ is full, discard cmd!
                        4. Update CQ head
                            (LATE!)
  4. Cmd timeout

In this scenario, the NVMe driver observes that the command never completes
and reports a hung task error.

[ 7128.239445] INFO: task kworker/u128:1:912 blocked for more than 122 seconds.
[ 7128.241536] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 7128.242675] task:kworker/u128:1  state:D stack:    0 pid:  912 ppid:     2 flags:0x00004000
[ 7128.243862] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[ 7128.244736] Call Trace:
[ 7128.245283]  __schedule+0x2ea/0x640
[ 7128.245951]  schedule+0x46/0xb0
[ 7128.246576]  schedule_timeout+0x1a7/0x2b0
[ 7128.247364]  ? __next_timer_interrupt+0x110/0x110
[ 7128.248281]  io_schedule_timeout+0x4c/0x80
[ 7128.249129]  wait_for_common_io.constprop.0+0x80/0xf0
[ 7128.250083]  __nvme_disable_io_queues+0x14d/0x1a0 [nvme]
[ 7128.251084]  ? nvme_del_queue_end+0x20/0x20 [nvme]
[ 7128.252016]  nvme_dev_disable+0x20b/0x210 [nvme]
[ 7128.252908]  nvme_remove+0x6d/0x1b0 [nvme]
[ 7128.253709]  pci_device_remove+0x38/0xa0
[ 7128.254423]  __device_release_driver+0x172/0x260
[ 7128.255189]  device_release_driver+0x24/0x30
[ 7128.255937]  pci_stop_bus_device+0x6c/0x90
[ 7128.256659]  pci_stop_and_remove_bus_device+0xe/0x20
[ 7128.257594]  disable_slot+0x49/0x90
[ 7128.258336]  acpiphp_disable_and_eject_slot+0x15/0x90
[ 7128.259302]  hotplug_event+0xc8/0x220
[ 7128.260080]  ? acpiphp_post_dock_fixup+0xc0/0xc0
[ 7128.260993]  acpiphp_hotplug_notify+0x20/0x40
[ 7128.261835]  acpi_device_hotplug+0x8c/0x1d0
[ 7128.262702]  acpi_hotplug_work_fn+0x3d/0x50
[ 7128.263532]  process_one_work+0x1ad/0x350
[ 7128.264329]  worker_thread+0x49/0x310
[ 7128.265114]  ? rescuer_thread+0x370/0x370
[ 7128.265945]  kthread+0xfb/0x140
[ 7128.266650]  ? kthread_park+0x90/0x90
[ 7128.267435]  ret_from_fork+0x1f/0x30

Reproducing method:

In a cloud-native environment, SPDK vfio-user emulates an NVMe disk for
VMs. The issue can be reliably reproduced by repeatedly attaching and
detaching one disk via a host shell script that calls virsh
attatch-interface and virsh detach-interface. Once the issue is
reproduced, SPDK logs the following messages:

    vfio_user.c:1856:post_completion: ERROR: cqid:0 full
      (tail=6, head=7, inflight io: 2)
    vfio_user.c:1116:fail_ctrlr: ERROR: failing controller

Correspondingly, the guest kernel reports a hung task error, displaying
the call stack detailed in the previous section.

Fix: Update the CQ head first, then process the CQE, and clear the bitmap
to indicate that free slots are available for further command submission.

Fixes: 324b494c2862 ("nvme-pci: Remove two-pass completions")
Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Signed-off-by: Yaxuan Liu <liuyx92@chinatelecom.cn>
Signed-off-by: Junnan Zhang <zhangjn_dev@163.com>
---
 drivers/nvme/host/pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d86f2565a92c..904f45761cd2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1438,7 +1438,9 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 			        struct io_comp_batch *iob)
 {
 	bool found = false;
+	u16 start, end;
 
+	start = nvmeq->cq_head;
 	while (nvme_cqe_pending(nvmeq)) {
 		found = true;
 		/*
@@ -1446,12 +1448,19 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
+	end = nvmeq->cq_head;
 
-	if (found)
+	if (found) {
 		nvme_ring_cq_doorbell(nvmeq);
+		while (start != end) {
+			nvme_handle_cqe(nvmeq, iob, start);
+			if (++start == nvmeq->q_depth)
+				start = 0;
+		}
+	}
+
 	return found;
 }
 
-- 
2.43.0


