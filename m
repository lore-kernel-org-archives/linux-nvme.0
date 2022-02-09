Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729BDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAdwstAYA/muUJ8UMA8LEOH0U5pZJxyi9cVe7iC9z6Y=; b=gUSViBD3BOSRz/zS3434QSfaKX
	X0JLL0DqnHaYaX+Z8rfPW+4hFjousAXj1rV4Ipq/c05fDntsOvk9Tluhf53oVXFSy3jatB9ks3uf1
	eUiQLGkB0vpMiYNw6R8epGIj8Sj+n7hygCYvnx+tPxfgDK9qf1EZUptJTUh9KNfa3YyEch5XDgSKp
	CqtZG3Q/V758jw62/tSZ2lgpl5QIxn0Wiy2wTVAzgsOk4EJ08OvrpuAd9vRsLiIq6C6LLm2b5e/kO
	3YZQL6Rxq122w6PxixihjzHEXDbjBtGb0VUZmM9yL0X9MlbSGjY/XoWIJAljnCn56DX4hoLMyYdKH
	P+56RYbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHs6u-001Eso-IE; Wed, 09 Feb 2022 18:54:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrxW-001Bhs-JP
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:44:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1E4C161617;
 Wed,  9 Feb 2022 18:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C010AC340E7;
 Wed,  9 Feb 2022 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644432293;
 bh=oyFYobVkluLYsmiNyANfzF/cCwasyGX2hI+4PT+cfbg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HDdHgAAAetlIR9B0WGsDdY/NzC4ANSSMJlEyZsburhwdUpqzocqcGWOKoD8+u5DKj
 /zZrgO5bExNIaEGkEpIuG26scIlfB0l8R8GbWwZorj4dUGEuxyCt2WQFVQc0qIufyo
 YmrUW1CQBHuizPIimE+xhEb1ZfCkkN/jqXT/DdsBcuk/RUzreHKH8A6uSkwbneRPkP
 6Fe00hyfVydD8VMrGoMaH2mtPkmj2OFeAWLgQsjWKD900I++Ci2QHLFj57OIgdLLTo
 xTmELlySf2a87pwWMcn6ZOymniupNWtfvdaCq0BaXfIB5ihht3OVvDiXhSiSJwHnk4
 h3o+MnsYa2u/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 09/10] nvme-rdma: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:44:08 -0500
Message-Id: <20220209184410.48223-9-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184410.48223-1-sashal@kernel.org>
References: <20220209184410.48223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_104454_739945_8E06CAB5 
X-CRM114-Status: GOOD (  11.25  )
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

[ Upstream commit b6bb1722f34bbdbabed27acdceaf585d300c5fd2 ]

While nvme_rdma_submit_async_event_work is checking the ctrl and queue
state before preparing the AER command and scheduling io_work, in order
to fully prevent a race where this check is not reliable the error
recovery work must flush async_event_work before continuing to destroy
the admin queue after setting the ctrl state to RESETTING such that
there is no race .submit_async_event and the error recovery handler
itself changing the ctrl state.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1f41cf80f827c..55f4999525037 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1050,6 +1050,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-- 
2.34.1


