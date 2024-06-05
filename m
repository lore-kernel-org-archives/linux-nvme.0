Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C487C27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yu8WZy6FOXpdjegyEM9M+PupwOmvBcnFm2y6GjrrC64=; b=lk30vGipja+EDuk8ybDpX10/EP
	E+A4cEShKUOAQqaqBAuIrQUM7uqYXVW9hfkotD9xg4RaNEqnWh7rz5YFzbhWRpx2Z42EHRrBHgc7B
	IgYPSQho14IKbz5+HgYbbG08YTFdn+W8/6No5d+swAKmPPD5Xwxby1ET/uL2Da8gwwjERGHRB5Wtm
	iwyXY59b934Bwj8Q8SDjXEaBpvq/JhN0GXHPCPKNVcYeocuXYcFldv+hkiUZyBpEcWWiv+FhMeDNr
	JY/nFvTavD0zsr45tUyvjbrnMM1lF78haDGkk5u50ZM6mUr3AmABSC2XfcAIqw/f+1xF4BOD6ewtS
	7XPDlvbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpOw-00000005s34-2mri;
	Wed, 05 Jun 2024 12:05:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpOj-00000005rub-2wAr
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:05:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E36436189B;
	Wed,  5 Jun 2024 12:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F897C32781;
	Wed,  5 Jun 2024 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589144;
	bh=9+I3qk58P2Tix1QmChv9y7ZaEhThCOAIIu7ewW9ZtCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntiqb7sdOtqKeY4i0szQRof4wur3l4q1h2VymufQXGk0F1GjMXdYyzqp2vq3T5klV
	 wBrbdni+au7wBspwm8OZqGE9dZXYvzorqSN4dWerVDBZkABdx/3Bz+FXt/T2CBJdh0
	 o0NyOhCN+bRUV5Wvacct+/tNEm0z4RqY6ALVJdtlrVFn+m1GubHHz1sNvpFhUzGN6C
	 rqJzua/Th5F82as6Lemj01VQ476GFripe3v+2GzoFzkcUdIzfGDbOlD+yioAGfSJ9G
	 RIlfm9qwiS4ZFBfdn+W7bM3UPQj7HidGmwl6+cEWBSDWm+0xgHljeRca+NbkOUw50F
	 d2/wlxD6educg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Alex Turin <alex@vastdata.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 09/12] nvmet: fix a possible leak when destroy a ctrl during qp establishment
Date: Wed,  5 Jun 2024 08:05:19 -0400
Message-ID: <20240605120528.2967750-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050546_055871_169F093B 
X-CRM114-Status: GOOD (  15.14  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4 ]

In nvmet_sq_destroy we capture sq->ctrl early and if it is non-NULL we
know that a ctrl was allocated (in the admin connect request handler)
and we need to release pending AERs, clear ctrl->sqs and sq->ctrl
(for nvme-loop primarily), and drop the final reference on the ctrl.

However, a small window is possible where nvmet_sq_destroy starts (as
a result of the client giving up and disconnecting) concurrently with
the nvme admin connect cmd (which may be in an early stage). But *before*
kill_and_confirm of sq->ref (i.e. the admin connect managed to get an sq
live reference). In this case, sq->ctrl was allocated however after it was
captured in a local variable in nvmet_sq_destroy.
This prevented the final reference drop on the ctrl.

Solve this by re-capturing the sq->ctrl after all inflight request has
completed, where for sure sq->ctrl reference is final, and move forward
based on that.

This issue was observed in an environment with many hosts connecting
multiple ctrls simoutanuosly, creating a delay in allocating a ctrl
leading up to this race window.

Reported-by: Alex Turin <alex@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2c44d5a95c8d6..ef2e500bccfdf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -801,6 +801,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 
+	/*
+	 * we must reference the ctrl again after waiting for inflight IO
+	 * to complete. Because admin connect may have sneaked in after we
+	 * store sq->ctrl locally, but before we killed the percpu_ref. the
+	 * admin connect allocates and assigns sq->ctrl, which now needs a
+	 * final ref put, as this ctrl is going away.
+	 */
+	ctrl = sq->ctrl;
+
 	if (ctrl) {
 		/*
 		 * The teardown flow may take some time, and the host may not
-- 
2.43.0


