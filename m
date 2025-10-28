Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0F5CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RBGV39ygFPcJmS2mBYLECFgMdX0cqonQmIBBXw1KGy0=; b=T9e/QxVj/l7Tkejs9ZsCE9oLxd
	147vcmiQDZuSDRp+vN6KPo9aQKzONmwPcNy5qU84eCsfMHhLiJ1EPNdOMFHgVUWoZf7YV4e/S4hUP
	iZPgqm1wlpuDBzXwLZN0NXhS70VUF0eY+MjT2FBYgpIRo9f2GPEDXpNMHyws5NdyUa7y6LPaOy6RT
	E6kYPlpniQ+q2t+01wHx2aOcdqJdgo/oXMx0SR3BKFunScS3AO+ZPoMZ7DD73N13oPdOu5Aq3Gtyu
	tYY+1UTUkQ0AiSszhZyzXIx2cp7ZPKMWMivHCcME20roKErD5SNKrj1CeyWKCm3xHjB9zIpFvHGSC
	kK31UpsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlak-0000000GAah-0rqT;
	Tue, 28 Oct 2025 15:26:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlaj-0000000GAaL-19jj
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:26:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 73EBE6200C;
	Tue, 28 Oct 2025 15:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEDDC4CEFD;
	Tue, 28 Oct 2025 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665192;
	bh=GTIbNeoxU6ONRl0I+KD8gbQC9oD3AKOkwvSlwjKDCsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=llQGr5a1BBWCntIQeV9zjqYoyxE+seNU1Zw5jkmdOLxnsjCFuguj5txU0sxwS+50a
	 Z5QZChZeL0H2DknXq/Sz7fs5cUKfphY/nzoGH5Wpu7/PyyS1MX5glZ78ZpiOTIdjoe
	 Wj8fIPjpSZhg0WRCxRVxxUIvBwTbz7quh7swuXAyMwCPNE9fdnqWf0fVXrhzI3/0PW
	 GgFRqVKts7wIhdGxEU02VTM0gTgS1LRRAmVvAWnYFQBCDdpAAsOtW96t+Gd72fFuMA
	 Qb95KsV/Eop1151XfVwckglZ75Nq4DYOp8FA3533VdZNnDOFqbQiXri2SjxpNP6R3G
	 6UtBKfurXnwSA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:20 +0100
Subject: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..2c0ea843ae57 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
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
2.51.0


