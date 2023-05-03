Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFF9C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bw8+k15c0QoOwdaFdBD9+2RRgFpUaRtCk2ejr4Ov76Y=; b=d+cHowb71AyUdjvbfb8j+mDRqJ
	NMBjsz0RllDCNezF7pdb9rIoTWrdoVL28x2rWdBdfbGcCPySx4leMyb4O4tXDFRTqFVD9dEFeujz1
	Aa4eIRhx3k4b2GoqbEj6ktx8Be42LXLZraFVfHjrk/Tz8Ut5N5ROE2KGhEytdmvAnLNLVC/vpzQwW
	JjOj8RocXK0Xy6qhDt7cWqmwDzVEHX1ut4hBCp/yTUHDBBbnlzMD4vzAfcSL9Qd6bt3r4S0H2SqTR
	AkayxwgtMILknQqYYPBqfimWMJBcw/dm9vIrUpOJohr64aLl/u19QfvbZRpYqnSI9oV/JQDzfEi1l
	epRki3mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puFB8-00549c-2b;
	Wed, 03 May 2023 16:18:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puFB5-005493-1b
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 16:18:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99B5E68AA6; Wed,  3 May 2023 18:17:59 +0200 (CEST)
Date: Wed, 3 May 2023 18:17:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, iommu@lists.linux.dev,
	Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
Message-ID: <20230503161759.GA1614@lst.de>
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421080800.18837-1-adrianhuang0701@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_091803_847717_A98F0A27 
X-CRM114-Status: GOOD (  20.24  )
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

dma_opt_mapping_size falls back to and is bound by dma_max_mapping_size.
So I think we could just do this:

---
From 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd Mon Sep 17 00:00:00 2001
From: Adrian Huang <ahuang12@lenovo.com>
Date: Fri, 21 Apr 2023 16:08:00 +0800
Subject: nvme-pci: clamp max_hw_sectors based on DMA optimized limitation

When running the fio test on a 448-core AMD server + a NVME disk,
a soft lockup or a hard lockup call trace is shown:

[soft lockup]
watchdog: BUG: soft lockup - CPU#126 stuck for 23s! [swapper/126:0]
RIP: 0010:_raw_spin_unlock_irqrestore+0x21/0x50
...
Call Trace:
 <IRQ>
 fq_flush_timeout+0x7d/0xd0
 ? __pfx_fq_flush_timeout+0x10/0x10
 call_timer_fn+0x2e/0x150
 run_timer_softirq+0x48a/0x560
 ? __pfx_fq_flush_timeout+0x10/0x10
 ? clockevents_program_event+0xaf/0x130
 __do_softirq+0xf1/0x335
 irq_exit_rcu+0x9f/0xd0
 sysvec_apic_timer_interrupt+0xb4/0xd0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1f/0x30
...

Obvisouly, fq_flush_timeout spends over 20 seconds. Here is ftrace log:

               |  fq_flush_timeout() {
               |    fq_ring_free() {
               |      put_pages_list() {
   0.170 us    |        free_unref_page_list();
   0.810 us    |      }
               |      free_iova_fast() {
               |        free_iova() {
 * 85622.66 us |          _raw_spin_lock_irqsave();
   2.860 us    |          remove_iova();
   0.600 us    |          _raw_spin_unlock_irqrestore();
   0.470 us    |          lock_info_report();
   2.420 us    |          free_iova_mem.part.0();
 * 85638.27 us |        }
 * 85638.84 us |      }
               |      put_pages_list() {
   0.230 us    |        free_unref_page_list();
   0.470 us    |      }
   ...            ...
 $ 31017069 us |  }

Most of cores are under lock contention for acquiring iova_rbtree_lock due
to the iova flush queue mechanism.

[hard lockup]
NMI watchdog: Watchdog detected hard LOCKUP on cpu 351
RIP: 0010:native_queued_spin_lock_slowpath+0x2d8/0x330

Call Trace:
 <IRQ>
 _raw_spin_lock_irqsave+0x4f/0x60
 free_iova+0x27/0xd0
 free_iova_fast+0x4d/0x1d0
 fq_ring_free+0x9b/0x150
 iommu_dma_free_iova+0xb4/0x2e0
 __iommu_dma_unmap+0x10b/0x140
 iommu_dma_unmap_sg+0x90/0x110
 dma_unmap_sg_attrs+0x4a/0x50
 nvme_unmap_data+0x5d/0x120 [nvme]
 nvme_pci_complete_batch+0x77/0xc0 [nvme]
 nvme_irq+0x2ee/0x350 [nvme]
 ? __pfx_nvme_pci_complete_batch+0x10/0x10 [nvme]
 __handle_irq_event_percpu+0x53/0x1a0
 handle_irq_event_percpu+0x19/0x60
 handle_irq_event+0x3d/0x60
 handle_edge_irq+0xb3/0x210
 __common_interrupt+0x7f/0x150
 common_interrupt+0xc5/0xf0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x2b/0x40
...

ftrace shows fq_ring_free spends over 10 seconds [1]. Again, most of
cores are under lock contention for acquiring iova_rbtree_lock due
to the iova flush queue mechanism.

[Root Cause]
The root cause is that the max_hw_sectors_kb of nvme disk (mdts=10)
is 4096kb, which streaming DMA mappings cannot benefit from the
scalable IOVA mechanism introduced by the commit 9257b4a206fc
("iommu/iova: introduce per-cpu caching to iova allocation") if
the length is greater than 128kb.

To fix the lock contention issue, clamp max_hw_sectors based on
DMA optimized limitation in order to leverage scalable IOVA mechanism.

Note: The issue does not happen with another NVME disk (mdts = 5
and max_hw_sectors_kb = 128)

[1] https://gist.github.com/AdrianHuang/bf8ec7338204837631fbdaed25d19cc4

Suggested-by: Keith Busch <kbusch@kernel.org>
Reported-and-tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 18ca1e3ae07086..922ffe4e28222a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2956,7 +2956,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * over a single page.
 	 */
 	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
+		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
-- 
2.39.2


