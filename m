Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB56C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXVgXKJzgRILKMLUXYh8CbkfQse6xZChLpiTQLamfDw=; b=3/0TRWbPBLtCfm4HvOw4qjQICv
	y80hU7085pZIyzcpxY+Yw474iiXohw9WGuVxEuEpx/m9Z9V4Y12I05L+QHsulTnqxc3Lkg7SmAPxR
	PPl6KVWroKMWZc1mErEEyPp2kWaLCA2rjUEJ1dnQTVHrh7VJiFhmGfIzoD/ZMIT1Dgpx2pWtUeHI4
	7Zs9xS3EWYjg/uYZK+I/Ch4xkLRgFUZfBkX+R7ExmHyK0gYFv8jYYlO0W8C5pNPLsU6nnHogDCxkg
	a46hT+IoBhF1igB+xg8Gz80DWwJO5xmI4271KdHIIXn36zt2Xd36ItL6e5rlmJ30h7bJrLyb9vSo1
	C8XNvHNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4yr-001GYB-KU; Thu, 09 Feb 2023 11:20:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4yc-001GPW-2Z
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 11:20:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8A1F5B8210B;
	Thu,  9 Feb 2023 11:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44891C4339C;
	Thu,  9 Feb 2023 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941627;
	bh=VDUNcmFfGTzo56vOCStREerT2zCA20lHUHxST9xIdl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WceDjkFiP1v+gXqWwpwRXv4H4eRzdulFy2jAnVOsRrb10ILzhCHRFVRX5S1ZSK2hx
	 vu7DEOFOpkJidUm6nvbkApC8IVt/9Jfc0VzHDZWkTl/pyH054gJxZFlN2MlAdm1Sdp
	 96+C+mCIAiwXH+7QWyzmGwt5amViGTYCD8CMXQp2shwcNSBQfA6isYTuUippRvpfBY
	 AVmMZLKYTtILEQUlToNWeNYa4ckZhndzIlmPM9rGzph4NyjdCZW5m8iEsSlESuUu1Q
	 Urz1uVwx5pNPgYVVPggtkdCFPhpettEf8J0ZWRwohorzMlr8t5ZTGXabSlbac0nAk2
	 nY4kbxE/em9PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amit Engel <Amit.Engel@dell.com>,
	James Smart <jsmart2021@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 6/6] nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association
Date: Thu,  9 Feb 2023 06:19:59 -0500
Message-Id: <20230209111959.1893269-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111959.1893269-1-sashal@kernel.org>
References: <20230209111959.1893269-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_032030_304051_EE2ACD09 
X-CRM114-Status: GOOD (  13.58  )
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

From: Amit Engel <Amit.Engel@dell.com>

[ Upstream commit 0cab4404874f2de52617de8400c844891c6ea1ce ]

As part of nvmet_fc_ls_create_association there is a case where
nvmet_fc_alloc_target_queue fails right after a new association with an
admin queue is created. In this case, no one releases the get taken in
nvmet_fc_alloc_target_assoc.  This fix is adding the missing put.

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 77e4d184bc995..68d128b895abd 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1325,8 +1325,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		else {
 			queue = nvmet_fc_alloc_target_queue(iod->assoc, 0,
 					be16_to_cpu(rqst->assoc_cmd.sqsize));
-			if (!queue)
+			if (!queue) {
 				ret = VERR_QUEUE_ALLOC_FAIL;
+				nvmet_fc_tgt_a_put(iod->assoc);
+			}
 		}
 	}
 
-- 
2.39.0


