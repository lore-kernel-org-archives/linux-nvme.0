Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F4CC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 04:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lyIXFrXHvjo5sm4l/OrUU2zbqNaro8lJd2GLynCUgz0=; b=p2SekF/x3KKH5PXrFckPbBzWgz
	Fprp8Km1Rg2YOhRS+iK6Lywvh5Xm3dT5EZ+6NItW9Khj/enm9mbO+gvfVeSeUidoShN02JxPuCmMv
	l92KAY2XsDf/sy8vVP89uGf2/n8KwOAjJKtzjS582HYfAodQOpbtD5whR1+UxjRdg9uZ1VodfTJWG
	NppVwZMbsq7okoMlNXa4U+7RoV24fy3v4VfRshkkeIsqR0ue5cTGa6Lw1xNKMiQhKTX1b9CF5oQbh
	335RN9BNYGk+bZdhueb3pBEQv/GhQjBiDVgAvy//Mrddqs0fWIBm36zYtrYgN1Np52J6LBbXShg3G
	QhU1x0Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj8M9-000000085kD-2h8h;
	Mon, 13 Jul 2026 04:33:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj8M7-000000085jn-1pIP
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 04:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783917203; x=1815453203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HFXrX2iEfc1ySXxALzj568kn1SYGTNz27Ujs6oIP/0c=;
  b=ZiLEyyYKhvy9kgzlTzAtyQylpNayS0ds6/lrPlbHxbS705H5QT0srVDm
   45knjpYd9uUTQgmDeFpm1l5eKECmGRC8Y02kY17XG1zy8nyIMZGLRI5hR
   uwmVLsmpD9FBXlzH9lOo0frDMo+BpHGt5YWD2tZmpjrFrGfwDMq0txp4L
   BaiwlOliSMeNKVYguRX88bZldY1bbIHY/UwfeL8dECQlCK18tZ+ReMkb9
   rKDSNkZ+puH0g6qDWQJ5mxUFZ0sK0sBEmKflwwmqgHUUU+IcmMS5UIn/y
   AIYHq9GyH+kq2LMtRXJk6F2FdJfoTz55EZ4muw8sS3a8GejFGtx8rLCzZ
   Q==;
X-CSE-ConnectionGUID: bx2oidnpS9C0uVNcv6QbRA==
X-CSE-MsgGUID: Zr0wmyJHSDqR4Dda7E9IDA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="151812934"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 12:33:22 +0800
X-CSE-ConnectionGUID: KwO1ZH98S1eq+pYhO3mVlQ==
X-CSE-MsgGUID: Vm82rwNSTuuhkSvUf7d+tw==
IronPort-SDR: 6a546a74_V2C3QCMUfHyzHvRSBrQ3/ka5brQcCV1bTWJaATytqLoA8v6
 djZdB++w5B5KV9uYe3szbIoYieGapy7mwdD/7Yw==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 21:32:52 -0700
X-CSE-ConnectionGUID: HQRRWQi3R4Kln3RMXRtBmg==
X-CSE-MsgGUID: T10j5yjyROGi0iVTBPlI5w==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai2-o.wdc.com with ESMTP; 12 Jul 2026 21:32:51 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet: pci-epf: fix use-after-free in nvmet_pci_epf_exec_iod_work()
Date: Mon, 13 Jul 2026 13:32:50 +0900
Message-ID: <20260713043250.75514-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_213323_550694_5643816F 
X-CRM114-Status: GOOD (  17.18  )
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

Fix this by reading iod->data_len and iod->dma_dir into local variables
before calling req->execute(). The remaining iod accesses such as
iod->status are only reached on the device-to-host read path. In this
case, nvmet_pci_epf_queue_response() signals iod->done instead of
freeing the iod, so the iod stays valid.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/pci-epf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..05044a110169 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1594,6 +1594,8 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 	struct nvmet_pci_epf_iod *iod =
 		container_of(work, struct nvmet_pci_epf_iod, work);
 	struct nvmet_req *req = &iod->req;
+	size_t data_len;
+	int dma_dir;
 	int ret;
 
 	if (!iod->ctrl->link_up) {
@@ -1638,6 +1640,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * Hold iod fields since iod might be freed when it does not have data
+	 * to transfer.
+	 */
+	data_len = iod->data_len;
+	dma_dir = iod->dma_dir;
+
 	req->execute(req);
 
 	/*
@@ -1645,7 +1654,7 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 	 * finishes, nvmet_pci_epf_queue_response() will complete the command
 	 * directly. No need to wait for the completion in this case.
 	 */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE)
+	if (!data_len || dma_dir != DMA_TO_DEVICE)
 		return;
 
 	wait_for_completion(&iod->done);
-- 
2.55.0


