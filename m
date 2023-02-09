Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59280C6379F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJP+nQ6NybU1hCgG3W+y42BIRaVvtI26DZd/g+C4AdM=; b=aUbxMDv+aG1hAskplEZDfO4yAh
	pa+6JbZd5VrkAeXeL7DzOu3OnIinVci7xd4eB0VXP4jyfNZztaij17P3Op4/UvbGQC5OV5sYWusgl
	vXFZIRTFduCinIbAC9fD/0kPuCgaloff3cLPCVvc8BjFE/IqN+Yc+wvyq+obKXTKUrGLoYWgfUQnU
	09D7aaXvxQ4NqkSfCJB2BNHcydIShZ5U4q8vNRUrzDHXaKzBjwokDTkkoFVOOCKw+C4r+nQeA1ctA
	kYkUY0tixLA1bzxJVhzPogmXNE+U85o/7geMsDEDocvsdTN4hZORXpTdgsrX5fsxwtC0ufEyVkODJ
	PyzfeCsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4v0-001EFU-GE; Thu, 09 Feb 2023 11:16:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4ux-001EDU-N1
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 11:16:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2EDA161A18;
	Thu,  9 Feb 2023 11:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935CC433D2;
	Thu,  9 Feb 2023 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941402;
	bh=MpCiOHqhya3aRizMfpaodbu0HD3zzhJeJesP8MeQfOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgCgRLXIzgBjiSKvc5JZWXVox77DSaKsEoJMUUSNOGveYRGuD6IGSMTKiZuooWvWL
	 JcehB/nTPfraLGUtR034bgr3esmB4DegC5HUVhuH+t2oiBszVCCNnKpjqLAIt8wECz
	 kCA6qQVsdOAZY9PKUD6Pe+YfREBgWyIPnm7bg+zfCyAoKd2BE6l/r116s2x8ZQ6zmO
	 ZgZF85wO2QJuojCg6QoddOhSgRejcByox1ao0Cf0k5wtP43yEMrLV42lJa53ycNvyK
	 YyX8TvXRWwkGEFDzB3GdWJTNQgQIXFmV9jDYK1VTvMChOBQ2XqKVaoIy7i20BOY8sR
	 tJ3NE0bRAElkQ==
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
Subject: [PATCH AUTOSEL 6.1 26/38] nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association
Date: Thu,  9 Feb 2023 06:14:45 -0500
Message-Id: <20230209111459.1891941-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111459.1891941-1-sashal@kernel.org>
References: <20230209111459.1891941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_031643_806611_9FF76661 
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
index ab2627e17bb97..1ab6601fdd5cf 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1685,8 +1685,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
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


