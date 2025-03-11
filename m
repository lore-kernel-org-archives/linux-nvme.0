Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D267CC28B30
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZ9V9RTfMd+QKDWzNRrfDAqoVE1jVIarl6Vk+9zhM8w=; b=YILcfQPNG7qws2ApDxfji29pur
	ejsYCvJgYi/kULqxUc7WixQQfPGb0OJTCZ0dRWNCYG5+TijYqy+48dIxT6pGgCoLC4EmRSUckeZCZ
	ytvEqJ2va0c+yTXMAjXIt60Mhw14lfN+o2TgsMNd4XuTBgbvTP7wqAWjB49qMiHoT1RE+FB31xOaq
	rBKasRrn4mY4GKtIuRs0KBaqeDA9zP9XLRcX1PNrrgAlShSa+Er4FR4/1/6Uq5RicAK37xj645+Va
	9t6Yf8RJG2aq6tyo2Pcka81LfxhiJxd9bGQDjbw44utRiGuDUUHQ5hI+0lAGSKcBUYlbJP8yYwc5J
	+suTx+Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwat-00000005GVt-1olJ;
	Tue, 11 Mar 2025 10:12:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaq-00000005GQt-1SaO
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 155FB5C5C4B;
	Tue, 11 Mar 2025 10:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352E3C4CEEE;
	Tue, 11 Mar 2025 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687931;
	bh=CD731s+uEHZveFfZilmbRuxJuovCqXftk6Ub+7Y6yYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u5mnjd80BVVpEvBjzJs3RCYFCAjBomGn7iQOnvdQWPohG1i/swLa5n6Uxg15i5AEJ
	 LXjOGXUzUOos5cZLvkuHkjvKQzJSFuHTCrP+NdKPdKn5tNV16dg1/MSB+6VpDl82vv
	 mwiwHfmZ+sG1RiNnQb31iIdyxhl8tn8m5g8tCXowvkF+nt2EKFyBkp2OSsEsY1RyiM
	 qx3A2QEZ/a3wjsdda4+lx6NGaFCTBfac6jqyP5T0EfkpwtEqv5MMn8CIDqk+yPbwIF
	 YU2/1CFcKKdYx8z/NAeniVpoo3B+SAs0IG8j79vQt9+jwGuVdwHWbMR1TZaUQqbqGB
	 bFwpLLSiDo00g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:38 +0100
Subject: [PATCH v2 12/15] nvmet-fc: inline nvmet_fc_delete_assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-12-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031212_433406_1D8FA8AF 
X-CRM114-Status: GOOD (  10.01  )
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
index c579810f0225eedaadf84eb24e1d890629327623..7ff6f065fccb3f772b785e393c122e45d624c802 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1083,13 +1083,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1097,7 +1090,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.48.1


