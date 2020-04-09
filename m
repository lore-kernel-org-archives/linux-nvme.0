Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97AAC2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815A0217D8
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJ7uehEL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBVvWd9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815A0217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zceeS8Kyah6lexVMvoZFDCWaC01Z5tTQGqPvO5Pt9+I=; b=YJ7uehELT/imYR
	SIxV4H5n0AzuDFor/OYPSfY8eJV01mOiMY/R/lnbtlVP4im5jtp/c/d53ZJrvyzzotVt5AUPVGKUN
	7d4UvVpnvHURFNmi43dQtwvYnGg1hS27+oU8xS7UEgx4v0G/HyVLmD7EqBGBgji7znVyZLOtlWhQG
	TwnTEeP4HDlLNysm5g8OW7072TIcjN+Iow7wHZMssRunqAngf89Y+ERVU9dJrIv4qV/FCwBKMgClc
	CxUTkDYdJnL/iokD/ihUExydlhG4KccGHeJL8z3ABn1/9OHe851QCvojf/xDjyjrNp3nkJitbX+GH
	OmVmBHMb5Ok6d9rlhJuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZkh-0002K1-F3; Thu, 09 Apr 2020 16:10:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMZjs-0001RO-RS
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 16:09:14 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36BD92082D;
 Thu,  9 Apr 2020 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586448552;
 bh=z81fZTegpfz0Vb4vGrWWaA4y6Udzs8tSgBzUowB6yRI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gBVvWd9+TTIuRcJ8Kh05FGgaWYWOsCzjbXIer4Egv9LL8PQ8PzUSfVGLfC03wTKxq
 VMegkX1U23lSytIO01UD/7olhZG+TtxSdEIe7e/khBdD71o45UsgwqhE9Y/fNI4CEq
 epSH0YxI6Vb3RrDqkVh41v0ETZBEmSn3iM2yya18=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 05/10] nvme: don't directly update multipath queue settings
Date: Thu,  9 Apr 2020 09:09:03 -0700
Message-Id: <20200409160908.1889471-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409160908.1889471-1-kbusch@kernel.org>
References: <20200409160908.1889471-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_090912_903767_17CCBD6F 
X-CRM114-Status: UNSURE (   8.91  )
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

Use only the stacking limits to update the multipath disk. Setting these
directly overwrites the stacked settings of other paths.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09ffb2d85854..7e5d28ed7b0c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1907,7 +1907,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
-		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
 		if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
 			struct backing_dev_info *info =
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
