Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579D0C021A8
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KUFWpH6egchJAWx19U8haLTY7myNUDauDv68eEWnZGQ=; b=X/GxGjCXKR+5hnSn5fesxLVhE4
	1zi6IOldb6fOOtiKOnZPIVswl7HwfbdXNXI6EwRMnaXA9/IfG+2I6cXDKa4ODAbgsGUh45ZbwMK4b
	cOZ7rHqAj/du4ljs9xxxsKxaL04TKEUbkXMLHF4GerGDIjZD9N8TBlI0j6JvMsu/sEYnbPemtHQvL
	VA1ALD4GqeTroVxsSeZTy1/7jXN3ov+KWvo5NQxuCpVKmqC22gjzqRJ8kUX2qHEA62yQofFPKculX
	yGUN25PQAHfznUCR9MuKki81qa5MCB8rCTf9R9VLCzVYCtcYRngxbb3MtfkIaqXKGFsfM8/8WcF7z
	Ta36aiiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5T-0000000A0Ii-3F7J;
	Thu, 13 Feb 2025 06:52:39 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5Q-0000000A0Fm-0Cyg
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:52:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0966BA41E8E;
	Thu, 13 Feb 2025 06:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F32FC4CEE4;
	Thu, 13 Feb 2025 06:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429555;
	bh=XUL1YHepa7b67xKmGCrCDvMLZXnOcLMyOiExGcqzZf4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FiR6rmGnKN1Ml55NVgrordLO4BKdOqH6Q8iCDH84x2dAfpEFLX1oXOZ4y1NuaTEpg
	 yJr1qipb1soZKxJDbKv5hoJVMH+aVN9ti+/rBxbt5g1f6H9VlBF7Iq6gsB5PRu32J7
	 EMTAyl0KUE/uVTGJmgVqqXpjLtzerOJWI+BeD6ypls84MkOpseCBBkFRezMUgBT/RU
	 1wz3sECFGa9mDNRPobY9Gs0JvTxnEmQmKtXUnTdwrRQ2yQuKa/q6vo0VTiLd41r8Xv
	 KasN85VuwY83LFPQV7ECXy9Qp3ENHfTZ/xTBaWpaAVCuQ9JaLKKpT8bX/VRhTB1zDd
	 14AcuKEe7pssA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 3/4] nvmet: pci-epf: Avoid RCU stalls under heavy workload
Date: Thu, 13 Feb 2025 15:52:30 +0900
Message-ID: <20250213065231.598527-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213065231.598527-1-dlemoal@kernel.org>
References: <20250213065231.598527-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225236_227746_63D36601 
X-CRM114-Status: GOOD (  14.06  )
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

The delayed work item function nvmet_pci_epf_poll_sqs_work() polls all
submission queues and keeps running in a loop as long as commands are
being submitted by the host. Depending on the preemption configuration
of the kernel, under heavy command workload, this function can thus run
for more than RCU_CPU_STALL_TIMEOUT seconds, leading to a RCU stall:

 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:   5-....: (20998 ticks this GP) idle=4244/1/0x4000000000000000 softirq=301/301 fqs=5132
 rcu:   (t=21000 jiffies g=-443 q=12 ncpus=8)
 CPU: 5 UID: 0 PID: 82 Comm: kworker/5:1 Not tainted 6.14.0-rc2 #1
 Hardware name: Radxa ROCK 5B (DT)
 Workqueue: events nvmet_pci_epf_poll_sqs_work [nvmet_pci_epf]
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : dw_edma_device_tx_status+0xb8/0x130
 lr : dw_edma_device_tx_status+0x9c/0x130
 sp : ffff800080b5bbb0
 x29: ffff800080b5bbb0 x28: ffff0331c5c78400 x27: ffff0331c1cd1960
 x26: ffff0331c0e39010 x25: ffff0331c20e4000 x24: ffff0331c20e4a90
 x23: 0000000000000000 x22: 0000000000000001 x21: 00000000005aca33
 x20: ffff800080b5bc30 x19: ffff0331c123e370 x18: 000000000ab29e62
 x17: ffffb2a878c9c118 x16: ffff0335bde82040 x15: 0000000000000000
 x14: 000000000000017b x13: 00000000ee601780 x12: 0000000000000018
 x11: 0000000000000000 x10: 0000000000000001 x9 : 0000000000000040
 x8 : 00000000ee601780 x7 : 0000000105c785c0 x6 : ffff0331c1027d80
 x5 : 0000000001ee7ad6 x4 : ffff0335bdea16c0 x3 : ffff0331c123e438
 x2 : 00000000005aca33 x1 : 0000000000000000 x0 : ffff0331c123e410
 Call trace:
  dw_edma_device_tx_status+0xb8/0x130 (P)
  dma_sync_wait+0x60/0xbc
  nvmet_pci_epf_dma_transfer+0x128/0x264 [nvmet_pci_epf]
  nvmet_pci_epf_poll_sqs_work+0x2a0/0x2e0 [nvmet_pci_epf]
  process_one_work+0x144/0x390
  worker_thread+0x27c/0x458
  kthread+0xe8/0x19c
  ret_from_fork+0x10/0x20

The solution for this is simply to explicitly allow rescheduling using
cond_resched(). However, since doing so for every loop of
nvmet_pci_epf_poll_sqs_work() significantly degrades performance
(for 4K random reads using 4 I/O queues, the maximum IOPS goes down from
137 KIOPS to 110 KIOPS), call cond_resched() every second to avoid the
RCU stalls.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/pci-epf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index b646a8f468ea..565d2bd36dcd 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1694,6 +1694,7 @@ static void nvmet_pci_epf_poll_sqs_work(struct work_struct *work)
 	struct nvmet_pci_epf_ctrl *ctrl =
 		container_of(work, struct nvmet_pci_epf_ctrl, poll_sqs.work);
 	struct nvmet_pci_epf_queue *sq;
+	unsigned long limit = jiffies;
 	unsigned long last = 0;
 	int i, nr_sqs;
 
@@ -1708,6 +1709,16 @@ static void nvmet_pci_epf_poll_sqs_work(struct work_struct *work)
 				nr_sqs++;
 		}
 
+		/*
+		 * If we have been running for a while, reschedule to let other
+		 * tasks run and to avoid RCU stalls.
+		 */
+		if (time_is_before_jiffies(limit + secs_to_jiffies(1))) {
+			cond_resched();
+			limit = jiffies;
+			continue;
+		}
+
 		if (nr_sqs) {
 			last = jiffies;
 			continue;
-- 
2.48.1


