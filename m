Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32098C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 13:05:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E7421D41
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 13:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qjC/v7kU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwhnv5/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E7421D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Z++Rwl50ayoBV6aqmLKm4DgIStPI2QhpIoLWPwqr/E=; b=qjC/v7kUZs43nKAxWePaStAt2
	o1gNGi7gl+pYFdiHy/Krm82Ah/0yt+XF6KZJFZRKsyLubYTjSzJd27fPFGIeY+7GQqtE7a3PicLAI
	ahumga0tTR1DEfj9EE70keUDDOa8LgnP88GSjIrcipdbvClAnchxnyfzhzE2A3VHIv2ThBZcyeP1r
	6EwxSizAyycVewWjaIUk4ZgQvir3O2PnWT+4QjJFmfIygh4iPyj3+f2PTRSQbQk8cxPpP5jKlHA5n
	aS2o9F+ZxeqTzcBpByTU59lZRRGzVwVj+boIanne9M2PGXip8OJXf4cfRO2l1OBMGEzf0zDr1uKet
	7I2MkBAAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHoAd-0002xR-4j; Mon, 14 Sep 2020 13:05:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHoAZ-0002w9-4Q
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 13:05:19 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9EE722267;
 Mon, 14 Sep 2020 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600088718;
 bh=MzWnIxtOue9UZv1v1Vab4i0yZPiIvaGLn0jYHvew5aY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kwhnv5/zl00RRXY17cN6NHgle0dG4pa383Dm5rXUg/S+k0DUU/YGQ2g6oqwn/pzaN
 WuzNFbzrT+9KMS4Lr98zLs9U/h4ODgktGoQBz6CJMqxrJoE08VJpUd0z/DoGs9zKk0
 VzQR0i8mfPpAe7o3Ky0G92yKpt4ubafHU/MM6vcs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/19] nvme-rdma: cancel async events before
 freeing event struct
Date: Mon, 14 Sep 2020 09:04:56 -0400
Message-Id: <20200914130502.1804708-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130502.1804708-1-sashal@kernel.org>
References: <20200914130502.1804708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_090519_254887_E52ACF9E 
X-CRM114-Status: GOOD (  14.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Milburn <dmilburn@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: David Milburn <dmilburn@redhat.com>

[ Upstream commit 925dd04c1f9825194b9e444c12478084813b2b5d ]

Cancel async event work in case async event has been queued up, and
nvme_rdma_submit_async_event() runs after event has been freed.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f393a6193252e..8a11e26d17683 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -739,6 +739,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 	}
 	if (ctrl->async_event_sqe.data) {
+		cancel_work_sync(&ctrl->ctrl.async_event_work);
 		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 				sizeof(struct nvme_command), DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
