Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE9FC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J+fSrIvCxcgs+V1gODyWsNNx5JOxtGyFDCMQgbzOIno=; b=Q2ZxWzVkDmX31H1frfv0/wcCJk
	2mmgl85beAR1fmoFuFNe6Yd5XtGgwjvWt+IMgOKamJYykarL+WjkRWhDlLKGDy7izOo3wBUhv1yLx
	KNWrRlIW5J7wiw0I6r2FIbSsUFXMgF1EfPkY7JZ7vKA6Er2CkH2T2fQk5MI1YA8V3TR80hIVd1U6y
	+Cq8nlBfA2lhO4XuUdBOn1y1gk2pHWjnbXeTlTcCEVOLbFUX67x3ikGEeHnteCq0cCEi77wdGqEWm
	HdkW3d+ahUeDhHDOrVh1E/XJyr7K14JiPmuYs/KtSKl8X+Ql6rWXrE9KCrfp1ZCpgk4eHIA/d8g29
	QteAMdXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5Zu-007i7O-0B;
	Thu, 10 Aug 2023 13:19:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5Zs-007i6M-0N
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:19:49 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id DEAD721864;
	Thu, 10 Aug 2023 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691673581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J+fSrIvCxcgs+V1gODyWsNNx5JOxtGyFDCMQgbzOIno=;
	b=hRhqGGEzdtfGlOW4dSfMZklOiO7rZNYym16OETrXI/YwVi4k65bImbbby3HZy953ObkBfC
	6I5tGR4O1BFuheewRLKM5WBlQnrCJJ/aAXuKuiwyLIQqc0dfkN6T5+vm+AJS2hS+FQfn25
	dO9eBSkYq/r+7c1Ff7bAbT2nijdh/50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691673581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J+fSrIvCxcgs+V1gODyWsNNx5JOxtGyFDCMQgbzOIno=;
	b=RKZeKSzsaQRfa2bThMMSzKS79rg8JghFcENomhwdHsB/vi/4yIGvawGghd1Jf5EJe8vao/
	fHAmZnz6X2GwzQAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0536B2C142;
	Thu, 10 Aug 2023 13:19:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DFEE151CAE2D; Thu, 10 Aug 2023 15:19:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-tcp: use 'spin_lock_bh' for state_lock()
Date: Thu, 10 Aug 2023 15:19:39 +0200
Message-Id: <20230810131939.129343-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_061948_312675_CE5F64F1 
X-CRM114-Status: GOOD (  11.65  )
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

nvmet_tcp_schedule_release_queue() is called from socket state
change callbacks, which may be called from an softirq context.
So use 'spin_lock_bh' to avoid a spin lock warning.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 868aa4de2e4c..f131b504aa01 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1285,12 +1285,12 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 
 static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 {
-	spin_lock(&queue->state_lock);
+	spin_lock_bh(&queue->state_lock);
 	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
 		queue_work(nvmet_wq, &queue->release_work);
 	}
-	spin_unlock(&queue->state_lock);
+	spin_unlock_bh(&queue->state_lock);
 }
 
 static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
-- 
2.35.3


