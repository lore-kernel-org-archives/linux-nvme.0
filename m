Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75269604DB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75269604DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C+hzerBbr1QoTak74w74LCru+4iId3wiMuRbCMMT0CM=; b=Yn4L0HhsulrbEB
	+r1rQQZsvQpagUKTFGJo56kpFeovUR8x7m0EGgWBpBc1qIgxgfEx2Lps0gMGO/vVIBuU7YHUZ2+/F
	34OJTVSwHwQEmmzOh0VT2cxJ2GI18ScfZ5Ety7kuu7y7TtkkKQBcjojAV0+CRs2x6PRKAscmq9ygb
	QeWibSfOLsAZlrjEfZl0Yre9IwV84JSAHBRJDSULIbwQ45Evfx0anLNc+GiA2ew+Cz2dpocskWoFn
	40qWBKqo/gY2pa+8mNG9+qyCgpdJevSoSTnBvm3pgMucKorXJrDdjSfpXTr27ROc7rf9BYe/lgmm4
	PjGRDEBlWXpKg+GZnSMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUsfR-003C1K-Ay; Mon, 27 Sep 2021 15:35:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUsfO-003C0Q-3q
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 15:35:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B40604DB;
 Mon, 27 Sep 2021 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632756941;
 bh=Q9+I4wEImnOLr+V45cPev4boT5DC7GTCSjTGy4LHB8c=;
 h=From:To:Cc:Subject:Date:From;
 b=Bbe6MG/sIZlfd7j0Z7SWSkQNRe1rilXRFw6/rELmbymUmfJWXEPwYOcTIZdx+knMf
 mwl/ee5Ww5G5z1hWB2agF3rSHWiW+vpdgdtdeDfr1sqvAEurWy78Kj9MgjTw9KSgaA
 bTaTR3DR9D/0fWVatQa1zelJi6Lz03f/iF6k0oCZv687v7Iu9NHYC6AmHpB4+uPo2S
 iabiS62MQKVXD6HJHQAD4mAi4LkW9gOmj1abjn4V6Lv7KseWbHntQxbZnAyLY9Elyw
 ajlBTWDu3R0BpxQ0rQnHPSkMGKFJ+l1xud/nuZImTQ2SaBb6ilyPJWK0cCLL8Rbs3v
 pwecnp8mbF8gw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Sven Peter <sven@svenpeter.dev>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 Aditya Garg <gargaditya08@live.com>
Subject: [PATCH] nvme: add command id quirk for apple controllers
Date: Mon, 27 Sep 2021 08:35:39 -0700
Message-Id: <20210927153539.372986-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_083542_199638_0BEB77E9 
X-CRM114-Status: GOOD (  14.97  )
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

Fixes: e7006de6c2380 ("nvme: code command_id with a genctr for use-after-free validation")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
Cc: Sven Peter <sven@svenpeter.dev>
Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
Reported-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 6 ++++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..afbd47e16293 100644
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
+	if (!ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN)
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
