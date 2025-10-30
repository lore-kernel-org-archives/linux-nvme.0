Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F814CCF9F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUoK7sK+NUOOUrJQJNcCbyliC0stdxH0JrlOxnMOeIY=; b=dSM6YkWR/ZFZOR0MB/nI+PbA2a
	1M05VOvfajeWe93WlD4KWW4eSqF950rUPCZTc67JnUaE5xNTZgn+wk+X49yoxXtPgp+MQYemjpIQs
	6l1edw/Sj1TMIDDCL/KrJEz5v8EIqXipTdlDBzim/ZZtDm6oMrQtc8exw4f8gCvA4c3Puwplr7oSW
	czcl7WTSeaxWTJMhGoGyM4PtKg7qUjsRB+ErtxTbRpnEHNoODl5AjOKfi44NU+i3d7aUz3zcafmpa
	29nBv7Bk9CApT41VVTZEqrl6JhtO2YFagt94NFg7X767bSvG8EjjxS4To+6RjxOW8giEE5VDCPLBr
	QwVgUcMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXY-00000003w9t-07uV;
	Thu, 30 Oct 2025 10:05:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXV-00000003w8p-3hIK
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 10:05:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0065A45944;
	Thu, 30 Oct 2025 10:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7862EC4CEFD;
	Thu, 30 Oct 2025 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818752;
	bh=SP1ioKSaDdMcidA7eYCAEjoEi4/LMlq8R1no50L2IRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=et4SFdyIawUd5x6LQxcCM6jCvAN/uXHLEyMWIlaC4VyTGkZRcaPeeDLbkXNfw5dLH
	 Bby/g7oU0w5wQEoOUG0snaFyx65o/GXWYDCwpbEt+muwXO6r55NCBpPxSKzMSMBODn
	 1wEgn5gz+QowarVYi0wyR2SCXPs8flL52iw38RPCPy2O7pH6yoqxVsyp6kGhOHivJF
	 NeHvL/coZjmUAe+iuVI/UI2gLxfkc7NqnT02tAXO0sBVMVaeelr9f+lAjupUhqdMDZ
	 p3drvSxZksygoVw62F/4rTgcR14aWIUmxkvfzQ3HKFJURvWfpf7MwpfFy4SIFmrzpp
	 JqGJU/wahqrsA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:45 +0100
Subject: [PATCH v2 1/5] nvme-fc: don't hold rport lock when putting ctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-1-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_030553_945992_6E724CA8 
X-CRM114-Status: GOOD (  12.75  )
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

nvme_fc_ctrl_put can acquire the rport lock when freeing the
ctrl object:

nvme_fc_ctrl_put
  nvme_fc_ctrl_free
    spin_lock_irqsave(rport->lock)

Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

Justin suggested use the safe list iterator variant because
nvme_fc_ctrl_put will also modify the rport->list.

Cc: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..3ff70e6e8131 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1468,14 +1468,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 {
 	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
 					&lsop->rqstbuf->rq_dis_assoc;
-	struct nvme_fc_ctrl *ctrl, *ret = NULL;
+	struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
 	struct nvmefc_ls_rcv_op *oldls = NULL;
 	u64 association_id = be64_to_cpu(rqst->associd.association_id);
 	unsigned long flags;
 
 	spin_lock_irqsave(&rport->lock, flags);
 
-	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
 		if (!nvme_fc_ctrl_get(ctrl))
 			continue;
 		spin_lock(&ctrl->lock);
@@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 		if (ret)
 			/* leave the ctrl get reference */
 			break;
+		spin_unlock_irqrestore(&rport->lock, flags);
 		nvme_fc_ctrl_put(ctrl);
+		spin_lock_irqsave(&rport->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);

-- 
2.51.1


