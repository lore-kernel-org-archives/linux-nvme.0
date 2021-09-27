Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A524FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:44:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9DD61041
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C9DD61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FFnPsjXFw2v/25dIxexy6y7avru0Olmb0s9wiEEn24I=; b=so7ScdXYmRYcZM
	a4kCU+u0Gn6XkftuDyA597iqCJeXL64hEuSmDSbx3jXN7w+FGJUcIERxhrWlmsrl+nwY0hHbOLumE
	ETQnOTql6HXUXFFQmmKTPn1/XmZhhL8atG/P73P2t0akbxsp8IPApDANMw5qFyZo8h2+FXgtAonAx
	09Q9hZshSaZ/1FBrcgFM+013K+5+WRQqKKTJJ5jMrN3MpdIpC1KVrC0EU85HVoE6SooxB6918w7Dm
	6ssa/64nIjtIuZAnvuAU9g3YWLgmfgWNaq8ShWwVUCA1snCYrGFxJE4oPOe5fm7su3WN8PJ/EKIEr
	z+Y8gdGUGgpY4yWP64qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUsmf-003DNn-U1; Mon, 27 Sep 2021 15:43:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUsmc-003DLl-Hb
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 15:43:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BCF160F94;
 Mon, 27 Sep 2021 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632757390;
 bh=P86cBH1nf5DfPMZ7Grlz7Pivw0MvErpNkzJ45WZUB2I=;
 h=From:To:Cc:Subject:Date:From;
 b=c+JNOFl2zUqUZoLIu0lznJURo6n+3GWiKgHBRErKfwx1Vkvxlg3aA5vGHd4xmmGjt
 xvfsaF7ytHSDsXUH2kOKWkGOqJjX5WUoirqc5GGoW3PkcCpFJYX0SopwzFYvI50YeB
 musN90yK8x4SBq0a3Feu3JL3Zc2V1H7diD8AsocJk6JLpPbplMt9l+oraAZgG1UDkJ
 6QrLs/TBVaHJcTFM79ycuv3M41cZ9A/dE/zgZhkQkW6Wgc4U+wDHDyL7BQfVukL1Be
 lEpqlDDAff+hybok1TodgI1AdxbLrZLot2eiyqRmKIrg9Sc+bOTl9DaX3roMeb1ACO
 GXKVD7awT7yZw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk,
 Keith Busch <kbusch@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 Aditya Garg <gargaditya08@live.com>
Subject: [PATCHv2] nvme: add command id quirk for apple controllers
Date: Mon, 27 Sep 2021 08:43:06 -0700
Message-Id: <20210927154306.387437-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_084310_637369_95E2C3A0 
X-CRM114-Status: GOOD (  14.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some apple controllers use the command id as an index to implementation
specific data structures and will fail if the value is out of bounds.
The nvme driver's recently introduced command sequence number breaks
this controller.

Provide a quirk so these spec incompliant controllers can function as
before. The driver will not have the ability to detect bad completions
when this quirk is used, but we weren't previously checking this anyway.

The quirk bit was selected so that it can readily apply to stable.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
Cc: Sven Peter <sven@svenpeter.dev>
Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
Reported-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: fixed logical bug checking the quirk setting

 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 6 ++++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..7712a8f78337 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -978,6 +978,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
@@ -1026,7 +1027,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	nvme_req(req)->genctr++;
+	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+		nvme_req(req)->genctr++;
 	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..ed79a6c7e804 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -138,6 +138,12 @@ enum nvme_quirks {
 	 * 48 bits.
 	 */
 	NVME_QUIRK_DMA_ADDRESS_BITS_48		= (1 << 16),
+
+	/*
+	 * The controller requires the command_id value be be limited, so skip
+	 * encoding the generation sequence number.
+	 */
+	NVME_QUIRK_SKIP_CID_GEN			= (1 << 17),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..456a0e8a5718 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3369,7 +3369,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
-				NVME_QUIRK_SHARED_TAGS },
+				NVME_QUIRK_SHARED_TAGS |
+				NVME_QUIRK_SKIP_CID_GEN },
 
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
