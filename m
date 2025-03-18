Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0396C35FFA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LHcMlaxlKpgSw3uTYaShrwIYEju/JA5g/HgySF7Ic0Y=; b=k1qOpv4btbQ6XfOj7ALm2l+e23
	JWntLShUP4dQ3R4a0OnENhYmOaoqlNKXF/Sbtf92uW9UI/b+k4Gbfdsf2zxN8bUP69hL3h0ZO7mJf
	D8WrW1+Xgsj8MHTVwOKPVOGdrjMYAfimtt8eIEYXbQxiHmG9467K3Sasdi4jcUiGwplnDcBST+ebX
	TnMIpCW1/NqM/XbWicAn+YELuKPtXJuYWsDC59CQrTE5zuOzUhfUbqWTXmzSTpeTwpQxUj0WzF6Dg
	LG42uC4Bf+MBv+bY9FVrjVwfvux/0FiAeZVCW10qvLk3O3P695nTfnirA/KT3zxakfYy5ug6y+U9B
	wWc/fF/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN7-00000005YA1-21Ce;
	Tue, 18 Mar 2025 10:40:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN5-00000005Y64-0hTc
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D2917A48F37;
	Tue, 18 Mar 2025 10:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A97C4CEF1;
	Tue, 18 Mar 2025 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294430;
	bh=l5T+lHKE6WpThvpfNbpbK6W7jMYdmU6ezmfxslSOgOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nKvRs/2O/M2buEmMQtl+vqHVLCEpcjHpvGBN7mGenAWyFhODGcqFbwuCb6ax/pGxM
	 KX3hJjYIhtYT3P7LDxjcvIlW8jD8SoECx8/+0yp5jRrgC8/80yfW7ERCkmjODD/19I
	 zCEbvF5lXoPBuQ5j1AEcYOh3CsYuHXzuRWeXdsOf5TVVXKUfbXr2830pOrdm7wYAmc
	 pTNnqwSuL8SSU8LbPfVV5v7UzAk/RFbi7EPrs1WtluKowEIgbD+PN0M2YZqrST8WxI
	 fbgKaKc2fySQGSySZUPTyHuBWw+qjscRTKSBhUDdXl6qWR9q67SKpJNjZJTC51xX6i
	 duF99/rxgxOCw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:05 +0100
Subject: [PATCH v3 11/18] nvmet-fc: inline nvmet_fc_delete_assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-11-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034031_294149_C39C0EFB 
X-CRM114-Status: GOOD (  10.14  )
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

No need for this tiny helper with only one user, just inline it.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8edb2b7f7a70d0a0a366f59f7db7af371e3799a0..05290506602469fc98d8463d0f1fcb6cf2422fde 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1087,13 +1087,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	return newhost;
 }
 
-static void
-nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
-{
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
-}
-
 static void
 nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
@@ -1101,7 +1094,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.48.1


