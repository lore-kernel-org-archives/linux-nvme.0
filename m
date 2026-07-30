Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9DBC54FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 06:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NgaQcascKl/erfpYNdi4wiCZz717aJIaPIaXtVxyeS4=; b=mFSFrQybfececwngLQ92O9FNz3
	1XTyilOkRMPJwx/TWNsNSaUdcw7ygofa4+WO6qBWxBsYWyk75PEBiRsBVD6rIoCyxwuHwmyW50I+E
	9UYG65ThRvOTqgKv6IaHd8WTRd3m1zB5JtDJnDjKmesjMb/3lcMS7Q8NWSZWDW1nABncaYoAoPTC8
	OfIw+1QXtilH4/J1sQNhoQl6JOOpFQdsV+vERwB2equRkDhvk7PmHKXuq0YWkZVD6midF9EO2pAXR
	OMZ9OtZ7DbMjSWnme0I5ullm09ws2iYoUKBblaVPEnX18DeHoz/tPxBBGl5xwcSrULQS/sOjLJzs1
	EoIF1Gcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpK73-00000009bCh-1m88;
	Thu, 30 Jul 2026 06:19:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpK71-00000009bC5-2lcz
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 06:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785392363; x=1816928363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wLMysQlKD0pjXjHcEvTibYkRVh28t9ot7Df95x9WU6Q=;
  b=GgR0PQzKPkE0BcgiQxs6Jd2rBUU7Ob5DobGJ6gd1XyMw+2raenNoigsZ
   le2fsR11sfACyGx49y8aQVsZ407YC5ZlJdZr2LVPCAUet3F8M+Q+S6EW7
   wpwuZCf+h79NL7DEAe4pVrWeGIcy0Cb+a1AseAkTKWp5VOQKDW9KItFqi
   iYqX5lmt0bF5rYK3ajOSwliSCUHFxiQpGl8WrJqXPUSayDvtwiw8DhW9k
   C2xvbkWf4Hq7tIfLoKVIqfiuN1wru7mDntR6HRROG8YKEIFjDDJ0R1V+s
   Bb/yTOspODa7OG8cHz3y5yyWccIa59ATBIkDSlh8rB4NSet+gt4Px9cpW
   g==;
X-CSE-ConnectionGUID: 66+CY8WyQhujtToyJhGm/g==
X-CSE-MsgGUID: lOHv3ht6Q0qt80BmALdmQw==
X-IronPort-AV: E=Sophos;i="6.25,194,1779120000"; 
   d="scan'208";a="151117911"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2026 14:19:22 +0800
X-CSE-ConnectionGUID: kmihSO8xSPCgR47ORr/D/Q==
X-CSE-MsgGUID: PoXbp+CMTkaqKOGiHNVyUg==
IronPort-SDR: 6a6aecc2_s4ipChyhDrGVPqorakbG7/tmweJybayfae4WDdet/ZDZMbG
 suRekkVgfDIDg6W7fo1Uu533x8vhtuPeFW6ZUtg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2026 23:18:42 -0700
X-CSE-ConnectionGUID: GoDrb031SreGtJ1gIrs3xA==
X-CSE-MsgGUID: P0IwSBH/SoaWBCvV8gqwFw==
WDCIronportException: Internal
Received: from 5cg21741p5.ad.shared (HELO shinmob.wdc.com) ([10.224.106.134])
  by uls-op-esai2-o.wdc.com with ESMTP; 29 Jul 2026 23:18:41 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] nvmet: pci-epf: fix use-after-free in nvmet_pci_epf_exec_iod_work()
Date: Thu, 30 Jul 2026 15:18:39 +0900
Message-ID: <20260730061839.75338-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_231923_703155_3A0612A3 
X-CRM114-Status: GOOD (  17.34  )
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
- Added a Reviewed-by tag
- Link to v2: https://lore.kernel.org/linux-nvme/20260714040031.207362-1-shinichiro.kawasaki@wdc.com/

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


