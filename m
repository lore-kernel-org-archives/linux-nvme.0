Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CC2C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e58hhCbQqGIbue0lcaSihyf87WLTBsb7LbOTOf9gFsE=; b=X+lJY4sn/QvYftHfW4/LaTLG/j
	ZMWBAMySpCjleTdBz0btUJPxikuQHZgaORUW9WShMEMDzJtvLokGP81WK4AXkDuZIUGe6EGntiJps
	SGExngX4kIfDzGrv4kyZ77BDWIXhKxyJZl4BRWPAC07RRds1YHAJ12uusCUjRHsYWwtUZHSJjLtuL
	iY5fmpStzcFQakH0+ts2bWSU/2LuKfbHjyqOg+OK47lqN+Z4HheSEwDkF+mTdp9PrzcMV/05ZYBbF
	avu6a3XujQspWRTVLftBYSJOOmd+GVYCcvnmVaYe+Ahx7TalplFwZTTxleQVn1aJaEk8mYT3hxP6e
	PlnrRH7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTw3-0089A1-0r;
	Thu, 20 Apr 2023 13:02:51 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppTvz-00898t-2F
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 13:02:49 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5465fb99so912153b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Apr 2023 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681995764; x=1684587764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e58hhCbQqGIbue0lcaSihyf87WLTBsb7LbOTOf9gFsE=;
        b=A3yKz7EWIUm8bPImF0hJ29UBBioqc/BF8qy2fYMX78O7Q1gsuCFo5QWOAmvXbfcE46
         RTfHee5GLNvr2OjMCFOh7UGQ0CD/CdMN1HwHXMeuFSmstYDOk/L4WubEp/SVmlpwmIA4
         aXtZ4dMG9GPNWe93Na/Xs3Av3vb2LO8sSczvqvy02XNEDczHpI/kijVZ20TI7Y3DMHas
         GGAJH5XLuLwhVZSeG2xJO+naTim2gH7zh3u8ZrNIVINClvf1v+/UDNAL4fqUcNXE41rq
         VaJ/fAmyY0UlQ5RyUjy+SVcW4i8ry7a/PJaHRgxwzWAlN/3+lPfyjsVMh4adtS0TltiO
         fGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995764; x=1684587764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e58hhCbQqGIbue0lcaSihyf87WLTBsb7LbOTOf9gFsE=;
        b=akRXJjVO0isCOfXBvH0TJT1EUAEXYs/OUDztz4bWU3e06t5JRg2h0+ViD0mcevl4DF
         0t5rxwphLPhSCsDh8E33jX781YVUUPd/Fq6JJ1STB2w4NWuQXpu6Ys2FP0ABuGw7f76r
         aCV7pcb+2KKhCcfJyMckkIyavyROYWyrQ90AULojNat0sX2jJd8TT3ae7bhYg/duOSxJ
         pHld4CT+1JUV0t56oGodgEsNpprFXlE44ehUDmDVaJgZkvN12lJaQ4e7j2zI90p/pshT
         u8/VbnaiM+NjfO9o7yf+F0WAhIbkfzynhQUDWZCOGn+eaATthUJksFaQ9Fnrto2KV5Cz
         z5QA==
X-Gm-Message-State: AAQBX9dZRBn1TLmpOVBFd2XJe3j/j3hACqvbQfHyTNAMxomN13TkiVw3
	w3hRav7ElktQrs0O5RUD8QQpqZ7zSgU=
X-Google-Smtp-Source: AKy350bDsp5dJP8AMQAC2SZZG57BUZUhDo4Xxud4SEdWezYGgZ3Y888jB/UKmf6wGSiDlnHtOgTyhg==
X-Received: by 2002:a17:902:da84:b0:1a6:b5b2:6a25 with SMTP id j4-20020a170902da8400b001a6b5b26a25mr1925972plx.2.1681995763657;
        Thu, 20 Apr 2023 06:02:43 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-221-73.dynamic-ip.hinet.net. [220.143.221.73])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b0019462aa090bsm1117078pls.284.2023.04.20.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:02:43 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH] nvme: clamp max_hw_sectors based on DMA optimized limitation
Date: Thu, 20 Apr 2023 21:01:55 +0800
Message-Id: <20230420130155.19281-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_060247_753432_71245327 
X-CRM114-Status: GOOD (  13.30  )
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

From: Adrian Huang <ahuang12@lenovo.com>

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

Reported-and-reviewed-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c6..c0d1ea889b4d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1819,11 +1819,16 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
 
 	if (ctrl->max_hw_sectors) {
-		u32 max_segments =
-			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
+		u32 opt_sectors, max_sectors; /* optimized/max sectors */
+		u32 max_segments;
+
+		opt_sectors = dma_opt_mapping_size(ctrl->dev) >> SECTOR_SHIFT;
+		max_sectors = min_not_zero(ctrl->max_hw_sectors, opt_sectors);
+
+		max_segments = (max_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
 
 		max_segments = min_not_zero(max_segments, ctrl->max_segments);
-		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
+		blk_queue_max_hw_sectors(q, max_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
-- 
2.34.1


