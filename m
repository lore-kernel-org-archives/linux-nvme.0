Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0515C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:06:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E537164EFC
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E537164EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=He4yQaQE3bKwRWitc8BwZbw7h2+uW4enalczcCYz0n4=; b=IxrA9ffJyftB7+5uTWWrWTF68
	evFaWS1y85jLNMR5T5ejOGGCrLJFUTZo/pAxG2Lt96tiRuWh6drc3fj8YEQvp8tGxSfy1+LiWZoEL
	6Bvew6RE5KVUin2hG27L8FDgpjme1AvkqkY1u1b/O9O1hQUdNRfFQghJ+1Oj5ElZJWxiZDVzXZL4b
	ATRsjw0kiSpMAtya8+FfZVr7bkK5ukNBaxRFIgqTFjOVSwkudsUMmRmW+tn+QnWWL//yJUuhNOD1G
	ya267/cD4kjiQotL5qFHeOT4TAVwHezvY0LCgCBv51DcEPbCT+gNLqMDWL5x5/+NwaBb91mC3ULoG
	tu5+Ep0Yg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKdc-0029bc-46; Wed, 17 Mar 2021 01:06:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKWK-0027d6-5f
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:58:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA7C464FA5;
 Wed, 17 Mar 2021 00:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942722;
 bh=RIRFGEqrcd5TIFcmBQsp4YlMG8xjpmPckwKgKpxzPq4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=blVOzqAT0oakViqRsYaVpxZYpTlHvIBVbWf+wI5n0/yi8oFCSPEZY9mz4plcB9Mfl
 CyTd9bIIstgTECfVE8brnOdgqJWCLRRsctXXZb+h2iIYSZqZkRG7RQ0w8i8Iy2x9+z
 jeTfU7tVNQQjghtMhfRrJUgo3ayBMtlK3TD2DVPRvnqHukOMzVlo3zZQnTpz0f96Wz
 D6bkerX2G/HHTZb2shxiXwiL6aK++eI9ujH/V4q7BguhBZOvdfkDBH09dbV3+TqgV9
 7ohFb+QuMGefpm2tiTHtcfvQb1heVDJ98VcBUCs9K4bHDxW4lagy84cuPcOr2qZDxB
 JgNghPTF9mz9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 32/37] nvme-fc: return NVME_SC_HOST_ABORTED_CMD
 when a command has been aborted
Date: Tue, 16 Mar 2021 20:57:57 -0400
Message-Id: <20210317005802.725825-32-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005802.725825-1-sashal@kernel.org>
References: <20210317005802.725825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005845_126537_78E661AA 
X-CRM114-Status: GOOD (  10.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit ae3afe6308b43bbf49953101d4ba2c1c481133a8 ]

When a command has been aborted we should return NVME_SC_HOST_ABORTED_CMD
to be consistent with the other transports.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 65b3dc9cd693..0d2c22cf12a0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1608,7 +1608,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
 
 	if (opstate == FCPOP_STATE_ABORTED)
-		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+		status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
 	else if (freq->status) {
 		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
 		dev_info(ctrl->ctrl.device,
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
