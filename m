Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C628C0219D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23wjvayOI48W73EvvKlTDtDSsHCEpu+ER+9gLOKyHlE=; b=dNjqTnVXCSp9cJVUY+iGnJKhri
	VbNzT57GgXSdmKU4/rMd3rE1j1qtQO2bzAOS1SSpiqyjvC3KP/yCSICBCA/cljfg/g4Xq6Bf/6HOa
	ssbcTndqUrXIPloCa8kzyPqhw7vpGuf51DgSToXdXgBo/2PthbQzNA2wBvLfOg/g+vdpMB3A8GFwm
	y7vSXMvetNsG6k8adurPx238Ov+hzGU+b7epyW7CwsLTUveleOG0AvqYZSc1z858FdpPxhKqtnM5j
	JqumfDwxJ6P+bE38aLXMgVMlnpyG6AbZKhtCsdUW/FQiTPb3lX6zuVwYroHXkc0har3MEqX74yMG1
	S1X+WXQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thcvR-00000001nWZ-2s4Z;
	Mon, 10 Feb 2025 23:10:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwy-00000001aqU-2J9m
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Feb 2025 22:08:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=23wjvayOI48W73EvvKlTDtDSsHCEpu+ER+9gLOKyHlE=; b=ZSJ+WrL4ug9wK4e66NHKzRma9L
	hBfbQym4Yt1IsN1SEiUhSk4uIL4yBPVX56YgnNq0IC2uY3qimqicquCn3jJw7oFMh6m3wScLBG9pz
	wRKcOvTDZ4J+lOo6uXYAPAa9gQMoqgTj2nIEAMIfXTDBVBVz4mKEkNIIn8IL2+W2zzLsb/+Rpm4Iq
	LWCSK6emtx9vN2seA8WXeqvRcy1Z1w0x1cB5CYc2tP3bOxHAxd7GAD5J46YLu0ExrvOkjISe3iY0i
	pH3YqsLHIY9m36B5JmjOqODiqVEDfQAUGSqx8oG8Bf0GJRSDit5d0oCJO4uK317rIsunZiYmfSyOB
	umtK7oxA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwk-00000000JCD-3HCb
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 22:08:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EEF585C5EF5;
	Mon, 10 Feb 2025 22:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F06C4CEE7;
	Mon, 10 Feb 2025 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739225285;
	bh=7BOPl7Lf3TdDobpeJA7XyKGmKQ2SzoUEYiEUxPXAhkw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g6r4vTYtJMN0k1cxp8q9AsbxYuCEA2CsYurRnHine7OhfEOjVBQQz1g8Crl+IKzqy
	 a6YJEeYX6+EY1/LoNsIxPhSYflcvclYq7pzLDaRTjGFnleRnsMeyTKQMIgyf1fjf+5
	 5JfuB2oqbHpJzmBw5kGk+zPQ33HUJFeiN+enMCy1PefLXVHdPqn6DrY2/XFcY4zDdk
	 sXofHfyqMGCA/ep/TOYhAhG894V9dlXH5brHY13pKVb1ic+j5f065xcMD+Ay0syWJ+
	 xnhtpVj8h+kchAL65tea+0nlWnWPB4ksASRRkw3cB75HIeuzqbEErdh/a+Li5p5PY3
	 BBxE8E47HzkqQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 3/4] nvmet: pci-epf: Avoid RCU stalls under heavy workload
Date: Tue, 11 Feb 2025 07:06:56 +0900
Message-ID: <20250210220657.1762684-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210220657.1762684-1-dlemoal@kernel.org>
References: <20250210220657.1762684-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_220810_249823_AF114FD7 
X-CRM114-Status: GOOD (  13.84  )
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
cond_resched(). Howerver, since doing so for every loop of
nvmet_pci_epf_poll_sqs_work() significantly degrades performance
(for 4K random reads using 4 I/O queues, the maximum IOPS goes down from
137 KIOPS to 110 KIOPS), call cond_resched() every second to avoid the
RCU stalls.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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


