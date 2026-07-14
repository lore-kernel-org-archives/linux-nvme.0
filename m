Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAACC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 04:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SD0ZA3N2bw82UKpiuVyEOOxwKrpgNohC5QkebRbHs2o=; b=af5on00CsoIGnAnFC679LTt7op
	q6gbp7Xg67TS1zhc0kY3xzI6dLC5/1u6CfPx1xpmxWEkOpmqRh760mNSkZRmHJk3mhBH9MuqbE8lC
	ygXZqSLo+Z85LI1lqUj8A8pG+ksKIRCdXLzDE4jh84XJxbXyMp20/s36Z3mH83yLBG6XPucDieFIG
	ms1lhSP/rb7SsrTwGnwKFnNOAk3ZCP8sv564599ky833YMNST3VKEShztrGb3GG2LiiJbL1EVWgw/
	hJTeHYN1nwkyLXGe0CSg/J4c6JAlWOB00/TQ+GY2MazL2b7dNPwsw5zLCdyT1FKqvrHRupkN+ih/M
	noL6Srkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjUKQ-0000000AqUd-2kUT;
	Tue, 14 Jul 2026 04:01:06 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjUKO-0000000AqUI-0nGH
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 04:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784001664; x=1815537664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V6t26n22e1LUi4zwRSILaQMWmA99rguLVjUQ6X6MDs8=;
  b=AQjhTzP8Ki7GARxcsePP7z+Pv6LFCU8j6LskTzGtv1PX8v+v8kVCELJV
   cMolDtskHolPSbzIIlb7Kuj+gmCfCpYzdnvubWoxzXGuvO7lHgGkbWf70
   ANoDj3R7OiYbwHLaSyQKzVzyzBbhPwfmTjH81SA9FsQIre7R6ZhddYO0+
   XF3eToDBaZDXYFzB8f2JUFIxNuiVA9VmdIM/AELNV/xifAYMGs3Flxzcn
   jxTTN8yRmLMNWEFXe8WKQ85TG1W9bs1iLwrwu1fkfpiJOdzMNsvTauWih
   k8+UH5IMQLOdJGWdCyehMvq2z2CdnKcapFMOXcayK0lODSuOhZB+uwIYI
   Q==;
X-CSE-ConnectionGUID: zE3OSDq8TAiYKTk0b+Drhw==
X-CSE-MsgGUID: abWhsibxQ2mYMmt5tbIVZQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="149436122"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2026 12:01:03 +0800
X-CSE-ConnectionGUID: aOBMKMpTSmOaU2f4umGZ0g==
X-CSE-MsgGUID: NHXanf56QPqS7azeXES+cQ==
IronPort-SDR: 6a55b461_7O5Ex/ZFURN6Jw/7jWWMsBN6aOM139DiJ4ls7shYy4AOeWe
 nryfmBhJm8uwAcyW8ok+KSrAiXgNZ7nYTVFmFEw==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jul 2026 21:00:33 -0700
X-CSE-ConnectionGUID: BG2NME92QiSRQ5Cned/aIw==
X-CSE-MsgGUID: h1nMv75gQb+RMcnsefc3/g==
WDCIronportException: Internal
Received: from shinmob.dhcp.fujisawa.hgst.com (HELO shinmob.ad.shared) ([10.89.84.176])
  by uls-op-esai2-o.wdc.com with ESMTP; 13 Jul 2026 21:00:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] nvmet: pci-epf: fix use-after-free in nvmet_pci_epf_exec_iod_work()
Date: Tue, 14 Jul 2026 13:00:31 +0900
Message-ID: <20260714040031.207362-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_210104_313141_030CE2E6 
X-CRM114-Status: GOOD (  18.58  )
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

nvmet_pci_epf_exec_iod_work() submits an I/O command with req->execute()
and then waits for the command to complete and transfers the data back
to the host. This wait is not needed for commands that do not transfer
data from the device to the host. To decide whether that wait is needed,
it reads iod->data_len and iod->dma_dir after calling req->execute().

However, once req->execute() is called, the command may complete
asynchronously on another CPU. For commands that do not require a
device-to-host data transfer, nvmet_pci_epf_queue_response() calls
nvmet_pci_epf_complete_iod() directly, which can free the iod before it
reads iod->data_len and iod->dma_dir, resulting in the KFENCE use-after-
free:

 BUG: KFENCE: use-after-free read in nvmet_pci_epf_exec_iod_work+0x288/0x798 [nvmet_pci_epf]

 Use-after-free read at 0x00000000fdfa6d03 (in kfence-#63):
  nvmet_pci_epf_exec_iod_work+0x288/0x798 [nvmet_pci_epf]
  process_one_work+0x15c/0x4f0
  worker_thread+0x18c/0x30c
  kthread+0x130/0x140
  ret_from_fork+0x10/0x20

 kfence-#63: 0x00000000e3de0e71-0x00000000c938ad62, size=712, cache=kmalloc-1k

 allocated by task 10 on cpu 0 at 73.995480s (0.005122s ago):
  mempool_kmalloc+0x1c/0x28
  mempool_alloc_noprof+0x40/0x9c
  nvmet_pci_epf_poll_sqs_work+0xd4/0x344 [nvmet_pci_epf]
  process_one_work+0x15c/0x4f0
  worker_thread+0x18c/0x30c
  kthread+0x130/0x140
  ret_from_fork+0x10/0x20

 freed by task 131 on cpu 3 at 73.995521s (0.008385s ago):
  mempool_kfree+0x10/0x20
  mempool_free+0x44/0x64
  nvmet_pci_epf_free_iod+0x88/0x98 [nvmet_pci_epf]
  nvmet_pci_epf_cq_work+0xfc/0x280 [nvmet_pci_epf]
  process_one_work+0x15c/0x4f0
  worker_thread+0x18c/0x30c
  kthread+0x130/0x140
  ret_from_fork+0x10/0x20

Fix this by referring to iod->data_len and iod->dma_dir before calling
req->execute(). The remaining iod accesses such as iod->status are only
reached on the device-to-host read path. In this case,
nvmet_pci_epf_queue_response() signals iod->done instead of freeing the
iod, so the iod stays valid.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
- Reflected the review comment to make the code simpler
- Link to v1: https://lore.kernel.org/linux-nvme/20260713043250.75514-1-shinichiro.kawasaki@wdc.com/

 drivers/nvme/target/pci-epf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..485ce759391a 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1594,6 +1594,7 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 	struct nvmet_pci_epf_iod *iod =
 		container_of(work, struct nvmet_pci_epf_iod, work);
 	struct nvmet_req *req = &iod->req;
+	bool no_wait;
 	int ret;
 
 	if (!iod->ctrl->link_up) {
@@ -1638,14 +1639,16 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		}
 	}
 
-	req->execute(req);
-
 	/*
 	 * If we do not have data to transfer after the command execution
 	 * finishes, nvmet_pci_epf_queue_response() will complete the command
 	 * directly. No need to wait for the completion in this case.
 	 */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE)
+	no_wait = !iod->data_len || iod->dma_dir != DMA_TO_DEVICE;
+
+	req->execute(req);
+
+	if (no_wait)
 		return;
 
 	wait_for_completion(&iod->done);
-- 
2.55.0


