Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A8EC02190
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wgrzGJ+fzBe+7Au/WdjdSOHGA7ivgXlOZ1VD13JU57I=; b=rxKjfdbxzqyMpaI7V7aD3Ra7Sf
	a95vFRwAuWond/LTq7RS8esZOhZvQ/1qR+brg87afyuhtCqDTjj3kQIXVtvmNQ3wH6wenqYZakZ9c
	2IwfhJtv25U4Y299zDwXXQI0Kzo5C3TLZj3YzbJlPGILIWjD5GLhtFkp3rbbHEMCpIW2jHtdQrJyg
	sbHYra82w+XWBJUJnCAtZz4ddDEomGtdudK/8XGqKXh8zNoExD4Xcz/jsV60Hyb2LPFv6XFiSqjFf
	23Q6DDt7/f8TSOZzbpPD89/TFw6zmqFbIc8uAo2OA66J6DMGBHOUwILq6LsOH/o0h/4NgMKAoNmz2
	gtWZupDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcofA-00000005MMa-38Vr;
	Tue, 28 Jan 2025 16:42:08 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoYT-00000005LQR-1ZLc
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 16:35:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8E376A41009;
	Tue, 28 Jan 2025 16:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E22C4CED3;
	Tue, 28 Jan 2025 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082112;
	bh=BYg80m4FjS4dU3qsCOeFHzQpyGsVbs++H0+ZTCLs+A8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YZVm6473C6+7opfNH14rx5dnUkBlj4zhaAjUpsEQNDNTCnLLu/Rzfzta8vrarHLqN
	 ZhGz827rekIWDNSPJqNcymJJTpVgANY8F7FXelNfiwuTGbuhooeCZf2GU3vPabISq3
	 J41ena74J/NVAvzzX+1ON8SQxvNNTuGNwZtbm3qTDG8IYEkjvZsFviB/FyxPAIhMkC
	 IHsztiFrrgcIL8rTVupJJutOZk7BOPcyHLRMy8OOFYIIwit6Be6gF6tw6kygbAET6o
	 oFLpQGww4yPZjTvx/oEyw9IrCmZhRP6emPlBSyNeS2AoydB9O5kjIpKagY+xc1Kqge
	 ZmjbkJYkNDsqQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Jan 2025 17:34:47 +0100
Subject: [PATCH 2/3] nvme-fc: use ctrl state getter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
In-Reply-To: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_083513_491382_6CE2CDA7 
X-CRM114-Status: GOOD (  13.80  )
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

Do not access the state variable directly, instead use proper
synchronization so not stale data is read.

Fixes: e6e7f7ac03e4 ("nvme: ensure reset state check ordering")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 55884d3df6f291cfddb4742e135b54a72f1cfa05..f4f1866fbd5b8b05730a785c7d256108c9344e62 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2087,7 +2087,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc && ctrl->ctrl.state != NVME_CTRL_RESETTING)
+	if (terminate_assoc &&
+	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
 		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
 }
 
@@ -2541,6 +2542,8 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 static void
 nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
 	/*
 	 * if an error (io timeout, etc) while (re)connecting, the remote
 	 * port requested terminating of the association (disconnect_ls)
@@ -2548,7 +2551,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 * the controller.  Abort any ios on the association and let the
 	 * create_association error path resolve things.
 	 */
-	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
+	if (state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
@@ -2557,7 +2560,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	}
 
 	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
+	if (state != NVME_CTRL_LIVE)
 		return;
 
 	dev_warn(ctrl->ctrl.device,

-- 
2.48.1


