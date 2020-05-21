Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43980C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 02:23:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B4120748
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 02:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Blqx2OrM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpTFL06y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B4120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZjOek+swHkNsQS0IR2JTBtXOzNxTl38OjoBHfrkN3hE=; b=Blqx2OrM70Ac7Q
	V8fbyaeO2k9Dk4WOat5Q6x9IzugH2ANdNsk5cnoPTltTGXBpnStrjISIQiVmwgJn+/p0vsK+AJJwh
	H5r37GoKl7nuQ9glngD9ncMY6TGSXZx6xnkwm6UFpKhzaKtZL3DwefhEAcoqHbsbHZfogFW09fxcg
	kNzWZsV6dcAEsT0J1LKbC5d6ewu96K7oSbInRnFPMj5dscbvbNTPvpqDo3ncHYn+vxTd47zhTRwlo
	Qua5v4GQOJ+/G4F2zs/R+145PYwz3VIgKPfQX4/DdX1c+Ix9fatAcjY6L0UcGynCKiVsd7gfjjG1J
	YIKL6v6WiB31hw8Bm4BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbarQ-0000Gk-PO; Thu, 21 May 2020 02:23:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbarO-0000GH-7m
 for linux-nvme@lists.infradead.org; Thu, 21 May 2020 02:23:03 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F1AB2067B;
 Thu, 21 May 2020 02:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590027781;
 bh=PoOACBVFsB3x5jVZ/Lvm4oH+tN5zb/NxeIbgMfzFi6g=;
 h=From:To:Cc:Subject:Date:From;
 b=lpTFL06ybuHQtZlFXIrhP6TlNhHbg5RYyBbRAkAo0bA3YSg/W1AFtauhLsxWigP5v
 rpsJ6/rBS/2q/fZvC101NTD5hWn2EVRZ2deKUJCFWgJ9d/1qfGEBIhp4au+iMFBofz
 YnyEAAoQrKUV1celGNnBVjDTpbIUcFATC+DUOkoY=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme: set dma alignment to qword
Date: Wed, 20 May 2020 19:22:53 -0700
Message-Id: <20200521022253.3268324-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_192302_299502_C0255DC3 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The default dma alignment mask is 511, which is much larger than any nvme
controller requires. NVMe controllers accept qword aligned DMA addresses,
so set the request_queue constraints to that. This can help avoid bounce
buffers on user passthrough commands.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 805d289e6cd9..ba860efd250d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2283,6 +2283,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
+	blk_queue_dma_alignment(q, 7);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
 	blk_queue_write_cache(q, vwc, vwc);
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
