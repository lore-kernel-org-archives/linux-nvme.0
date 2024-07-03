Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F95C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZXQ/x4zIGok6jUni55ZGWApVZx5AhuM5kDQURweZVc=; b=t5Yr5PBLZdagwoC5UsfE4QXuVu
	i2c+JPqKtHjAC/vt28BgvLwx4DWYSbVJjj56a1fZ/sqbM45x5MR/cDAzIPJUK6bqsBWolgViIPYox
	lRulevkkHuRkkCmSm+9IJ0MVKnR6CG4TP1XyuK2kvAuR71pCgA8XbOrSN8pHMlN2DCtz+GVJbr0aF
	D0O3or++gyImCf7D+eaTkgLo1i1VRqknER1OKckMlEvSZVY4Vt6tht4EWVvuTmPsaDSeg5Ixadmyx
	zjMOr63KWb8lsl6VO1QDHzgCA03UuLrDeqj9kk8fMdepcryRy6RygDTPHnzUzRqL5xQhbSlmvN7FV
	txgCV+3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Ng-0000000AM9F-1EmL;
	Wed, 03 Jul 2024 13:50:44 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Nc-0000000AM6Z-2gll
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 13:50:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CEDE8CE2B0C;
	Wed,  3 Jul 2024 13:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CA8C4AF0E;
	Wed,  3 Jul 2024 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014638;
	bh=74fX1LbNjcxwF7gSuOOuaJjEwbS5QVKZjNbqAjq9F98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YK+2yI/AdKxiUiXBpZOL71UAxBPeTSvAfFXzFSiwCyjwJ/2bN4sllaRMxs5QcGbk5
	 FdKOXkR8xoeOG/HWUMWqYSXo6sO5B92N27WwWElE9/YSho2SggG/9qb6bPyiAwuG3L
	 /xPo+FHyYqfilYQx0mYCg5/uwI8pjZ9CWLuEfYfF+HlBU3ZeBfMJJiTpy6MtAWRolG
	 kDVTTjPLgB93PJ8NY38sHf8BlLmFurIHKjuaMnTRDZBDG/Ocgdn5TLj3lSBpDU7wca
	 0G1uzZecdWcZ12IdFwwIYIhzHg1fP6CCnrXz1dTTcYYuVm29wbYI4Wmq15KIQzHFFC
	 PpgRpMM4hik4g==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound workqueues
Date: Wed,  3 Jul 2024 15:50:21 +0200
Message-Id: <20240703135021.34143-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240703135021.34143-1-hare@kernel.org>
References: <20240703135021.34143-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_065040_913798_8C5246FB 
X-CRM114-Status: GOOD (  11.37  )
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

We should switch to the 'cpu' affinity scope when using the 'wq_unbound'
parameter as this allows us to keep I/O locality and improve performance.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index df184004a514..889a5a28e3b7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2812,6 +2812,11 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		nvme_put_ctrl(&ctrl->ctrl);
 		return ERR_PTR(-ENOMEM);
 	}
+	if (wq_unbound) {
+		ret = workqueue_unbound_affinity_scope(ctrl->io_wq, WQ_AFFN_CPU);
+		if (ret)
+			pr_warn("Failed to set 'cpu' workqueue affinity\n");
+	}
 
 	return ctrl;
 out_kfree_queues:
-- 
2.35.3


