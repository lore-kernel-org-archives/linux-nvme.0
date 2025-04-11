Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871DEC3601E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rFZ0QbnEPSTOtYkzH/k3PUcoSgPQYyur8q4ynZlsKps=; b=W5wGPEHmWK/Z4jixqFFZHHR0+4
	jRhaFIuuSIbzE4HADCQIiS/QF4WY0sg9nmh2htaKRkK9mA00a7gCMs0aeBYLu8Vc5G9E+4dgsv0E+
	APBYZEBTO2HdNW8dWGMjg0FAL3BO4DHUzZ71Qi7PW8ZA6L4Y1/aPaRcd0SskkxWVq2PdnY+8nqlMK
	7d3cNLHmCWlLiYRim7gCMck6v1VxbT3zYoocAc2frnnOBPGx5qEeEEzWYvsbh+EtrUVZuIMxL5Hwq
	jlpxxsvNkN0JWQo0ZQmufKV4+aoUV2Q4koBJ9WaH9vLmHiTIjyv95FsSQA7qy+OgS2WDgKQqaLwpj
	H9xLBnMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Q2-0000000CGHW-1cJR;
	Fri, 11 Apr 2025 01:42:58 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Pz-0000000CGFr-0jFB
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 01:42:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D5385A42FB3;
	Fri, 11 Apr 2025 01:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544EC4CEE3;
	Fri, 11 Apr 2025 01:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744335774;
	bh=UN2CuVhZz8jMYldoIkeu/TcOsUEYwn3owGgLo0QFvp0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lEt9d/M7SGDeKGpZn/qSvPKqM+zX/iBSGnx9tsZmHTKP4c2hLVfAlyrOo2w9vGNc4
	 0ZvRJUV9PzxHtCRVtGnm1t37eYcfCjJvCPTmENkL/lS8dlnML66OBTcfmDCpi6//Sd
	 XK/T24DX5CDR74AVLcrLgwHVwZZD1/Pz8L7vFDxjjxXhYCVIZYhYAqFGtDhT1wx90e
	 XCRE1MOvRe2TI8YDVL1lVmLHulVUK1f8T4adS2aq97OLJ94fpnJ1u4wi6lZUb5TnQA
	 8v5as0zs67RgRyss7xovrMfuDZXs2N2OnCiy6PVX7U+pDHjhx4/odesnvHUJfYFQdf
	 10dg/WQXGBCsA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 1/3] nvmet: pci-epf: Always fully initialize completion entries
Date: Fri, 11 Apr 2025 10:42:09 +0900
Message-ID: <20250411014211.1070887-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411014211.1070887-1-dlemoal@kernel.org>
References: <20250411014211.1070887-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_184255_337607_17EAD799 
X-CRM114-Status: GOOD (  16.91  )
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

For a command that is normally processed through the command request
execute() function, the completion entry for the command is initialized
by __nvmet_req_complete() and nvmet_pci_epf_cq_work() only needs to set
the status field and the phase of the completion entry before posting
the entry to the completion queue.

However, for commands that are failed due to an internal error (e.g. the
command data buffer allocation fails), the command request execute()
function is not called and __nvmet_req_complete() is never executed for
the command, leaving the command completion entry uninitialized. For
such command failed before calling req->execute(), the host ends up
seeing completion entries with an invalid submission queue ID and
command ID.

Avoid such issue by always fully initilizing a command completion entry
in nvmet_pci_epf_cq_work(), setting the entry submission queue head, ID
and command ID.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 51c27b32248d..43296c05319c 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1648,16 +1648,17 @@ static int nvmet_pci_epf_process_sq(struct nvmet_pci_epf_ctrl *ctrl,
 {
 	struct nvmet_pci_epf_iod *iod;
 	int ret, n = 0;
+	u16 head = sq->head;
 
 	sq->tail = nvmet_pci_epf_bar_read32(ctrl, sq->db);
-	while (sq->head != sq->tail && (!ctrl->sq_ab || n < ctrl->sq_ab)) {
+	while (head != sq->tail && (!ctrl->sq_ab || n < ctrl->sq_ab)) {
 		iod = nvmet_pci_epf_alloc_iod(sq);
 		if (!iod)
 			break;
 
 		/* Get the NVMe command submitted by the host. */
 		ret = nvmet_pci_epf_transfer(ctrl, &iod->cmd,
-					     sq->pci_addr + sq->head * sq->qes,
+					     sq->pci_addr + head * sq->qes,
 					     sq->qes, DMA_FROM_DEVICE);
 		if (ret) {
 			/* Not much we can do... */
@@ -1666,12 +1667,13 @@ static int nvmet_pci_epf_process_sq(struct nvmet_pci_epf_ctrl *ctrl,
 		}
 
 		dev_dbg(ctrl->dev, "SQ[%u]: head %u, tail %u, command %s\n",
-			sq->qid, sq->head, sq->tail,
+			sq->qid, head, sq->tail,
 			nvmet_pci_epf_iod_name(iod));
 
-		sq->head++;
-		if (sq->head == sq->depth)
-			sq->head = 0;
+		head++;
+		if (head == sq->depth)
+			head = 0;
+		WRITE_ONCE(sq->head, head);
 		n++;
 
 		queue_work_on(WORK_CPU_UNBOUND, sq->iod_wq, &iod->work);
@@ -1761,8 +1763,17 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 		if (!iod)
 			break;
 
-		/* Post the IOD completion entry. */
+		/*
+		 * Post the IOD completion entry. If the IOD request was
+		 * executed (req->execute() called), the CQE is already
+		 * initialized. However, the IOD may have been failed before
+		 * that, leaving the CQE not properly initialized. So always
+		 * initialize it here.
+		 */
 		cqe = &iod->cqe;
+		cqe->sq_head = cpu_to_le16(READ_ONCE(iod->sq->head));
+		cqe->sq_id = cpu_to_le16(iod->sq->qid);
+		cqe->command_id = iod->cmd.common.command_id;
 		cqe->status = cpu_to_le16((iod->status << 1) | cq->phase);
 
 		dev_dbg(ctrl->dev,
-- 
2.49.0


