Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C37CE7A8A
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Sep 2023 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PBm9fDFBLlybwN998ujNZX10tuyVG/gOk1texytK9uM=; b=kdYlpyBFdWGRkwWVntzM6wQieR
	LjLGTxx9dZkLUYc3TPQthIBUolBwIyWj9Kfsa8egQtpg4+hwa3vYyqZJglhK9jGp7hRlbtfWkP7g9
	r4zTva6DchVg3Mqb3d8OFl2d1JbB1JySouOujaI7iJVAh6Zke5tdMwZ3XyY5mhgAMuThW41af4q2S
	H8ihLWdsESsqSLJZRof0qsue5NCIKo0XFu7vCntu03pWPqhZm2+pgJ0byo78qbDOZ14u098cenyge
	EaD2KkRhakHM0CiQ83lF5h9PlVMuftBqDyeGfb5ddXjU9t8xj+4qcGhYY5XmsqePxKHbI2G16S6pE
	cTt1QP0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkOxj-00CHhc-0y;
	Sun, 24 Sep 2023 13:15:51 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkOxX-00CHhC-03
	for linux-nvme@lists.infradead.org;
	Sun, 24 Sep 2023 13:15:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C2A09B80189;
	Sun, 24 Sep 2023 13:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA03DC433C8;
	Sun, 24 Sep 2023 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561332;
	bh=aymlam7ACzIinEbCzC1waHwHwJM/KoAe8yLW9ndF/G4=;
	h=From:To:Cc:Subject:Date:From;
	b=vI5MxRlJRZ8OTAimgC8jsYEzXDWCTWALsVY3jQfOM+XjoN9AfFW7Gb1vGGJ2/oziH
	 RuvfO16zIFE5fMae5CJMeUWqjMKGrGCe0NfHzz+gYW2FCH+DVKlAaAw8EfpmE1ZwbY
	 ox+64o85THgDIZnU5DeYd/WypUiy3/yeBELyTgCUZVdkMxjoyaoSpb36HOkw4F1xXf
	 MXv9575m4glhPDF2LyoX79MIYx28C7ii6yup3L+Sso6D02Xl3g+afLZk9lYsyyCdu6
	 h+NTwWXW6LvCHqWvx9eSKM0q5T6H6g3MaYPO2UyEiCfiGyURvWF8yeYkT8cvchbdY8
	 c9jwFZxeOhVrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nigel Kirkland <nkirkland2304@gmail.com>,
	James Smart <jsmart2021@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 01/41] nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()
Date: Sun, 24 Sep 2023 09:14:49 -0400
Message-Id: <20230924131529.1275335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230924_061539_213314_AEE375F6 
X-CRM114-Status: GOOD (  10.92  )
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

From: Nigel Kirkland <nkirkland2304@gmail.com>

[ Upstream commit 8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c ]

The nvme_fc_fcp_op structure describing an AEN operation is initialized with a
null request structure pointer. An FC LLDD may make a call to
nvme_fc_io_getuuid passing a pointer to an nvmefc_fcp_req for an AEN operation.

Add validation of the request structure pointer before dereference.

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1cd2bf82319a9..a15b37750d6e9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1924,7 +1924,7 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq || !rq->bio)
 		return NULL;
 	return blkcg_get_fc_appid(rq->bio);
 }
-- 
2.40.1


