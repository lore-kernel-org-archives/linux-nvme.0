Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC6FCF5395
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AqHcbIqAR5jlXZsefLnVlvGkxcHryTJwC/DlxaMV+WA=; b=a3rOatP9U0dOrSscRkDEpKuoCs
	WKBHCq2ZOoIpMg1XV5i66JvegadLgFuihFoaP4C48Ds4XKALysdk6XpiJ6VAssKeGPgpMPXI818xb
	FUV5qEwTC4lMRuj1IHTFQsbIQfl6jXaxgZu1OlHlE5s9hiUGSgc2ERWPg370dvFJjYhOJsdmzoeRw
	qcSWYCRQ7gZcwXpBzYOAKLWGAOvQF1CKMLSofyhXURtjLBydGT213VO1WcAR/vAa4WbseeGRM/YxZ
	ba3vnYfacxqjPQ2zFvZWMbgmfUzIUwTqgmfvZgjPbouUl+mrIfcpF/75Wm9QGWFErPZD0uWU2UjTd
	V/R3NmPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cPg-0000000EicH-3ts3;
	Wed, 23 Oct 2024 14:32:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cOw-0000000EiEV-2249
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:31:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5EB5B5C0697;
	Wed, 23 Oct 2024 14:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7887BC4CEE7;
	Wed, 23 Oct 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693913;
	bh=Nt2IQe3cEkYs4dGfixs/VEPyhmJBULF20D33p93h7WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/zaDNmQwLohcYVgqNguqm5XZrP4lSySxgZ0yheK3N2ophd9Sx/8iNaSjmbwnliTu
	 xPaHU/Q5osrm51/mTcJnck86i+AdAKMQn1Xnv6QHBdEikedkXBZ4roIHgxLwStcyUE
	 33hmmXDrEkWuErdaf3uXRjZpo31kpXp5oxR9r5rPRKFrjQPXRvB6BSLqKLNmwbmPD/
	 5KDS+gC5wGRrzEkA3eEQeKji5wgl5YtQlxMvXtEAiVPhx79UzqhDIYuDTpkmkEvnAm
	 M+XFj7PLiKo7wblo36SJdDsT0ug6BeMziMJVx+MFUc0XNd0qMDHpn5NE2zZFjIv1fP
	 GB+jm3NRAJ9+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 22/23] nvme-loop: flush off pending I/O while shutting down loop controller
Date: Wed, 23 Oct 2024 10:31:06 -0400
Message-ID: <20241023143116.2981369-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_073154_639727_7E650987 
X-CRM114-Status: GOOD (  12.57  )
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

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit c199fac88fe7c749f88a0653e9f621b9f5a71cf1 ]

While shutting down loop controller, we first quiesce the admin/IO queue,
delete the admin/IO tag-set and then at last destroy the admin/IO queue.
However it's quite possible that during the window between quiescing and
destroying of the admin/IO queue, some admin/IO request might sneak in
and if that happens then we could potentially encounter a hung task
because shutdown operation can't forward progress until any pending I/O
is flushed off.

This commit helps ensure that before destroying the admin/IO queue, we
unquiesce the admin/IO queue so that any outstanding requests, which are
added after the admin/IO queue is quiesced, are now flushed to its
completion.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 48d5df054cd02..bd61a1b82c4cd 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -265,6 +265,13 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	if (!test_and_clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags))
 		return;
+	/*
+	 * It's possible that some requests might have been added
+	 * after admin queue is stopped/quiesced. So now start the
+	 * queue to flush these requests to the completion.
+	 */
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
@@ -297,6 +304,12 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
 	}
 	ctrl->ctrl.queue_count = 1;
+	/*
+	 * It's possible that some requests might have been added
+	 * after io queue is stopped/quiesced. So now start the
+	 * queue to flush these requests to the completion.
+	 */
+	nvme_unquiesce_io_queues(&ctrl->ctrl);
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
-- 
2.43.0


