Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A13CF5396
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfAovUD2pi9mkDSIvOOPYdZEKNe0TkIRIQVvdrqsmL4=; b=BsCPbqicrEL9Fk2D+sbe2TyCTK
	wBZr+YQknudEMb/ZoHNEA9mV3aXV0LC7dpqMN3zCIgWfoI5Cl4vY9o6fqaf7TeTyTD1rOb5kTfMVU
	SxsH8xeqa2SS9A3+S/4+xfV6W0diXlCjnmJp9AooGsxdvsfrdip8OrYzlXzG1mV64HqYA9fUJn1MB
	maGI/7MdPM2+1uDOdz3gaInLirmjs9VW0EuZFPJh37MN0SyLEApoBewnjxuatTHvSS/s/NcnpXWqw
	VCjQ36OdkUw48iWdj7v1FUWdd4072/7uvhkt9y/Qbpu5AxkyAM5F0ZpYQNlBzYjQmoVGa1+BWUI9O
	AzsK+3Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cPa-0000000EiWE-2xJt;
	Wed, 23 Oct 2024 14:32:34 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cOc-0000000Ei77-275N
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:31:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 66051A44F45;
	Wed, 23 Oct 2024 14:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174A8C4CEE4;
	Wed, 23 Oct 2024 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693893;
	bh=q1OZjb80glGL02e2p03kI221IdO0Idodp+8LAuZylP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehrnwjOrjdJMywo3g66O6qTY1POYpqq5E8q60X4Fhbvg294rBsjOCPLl9KRUtRv1z
	 PhIuFXBOFXz7HfvHKErDYTHfNI/p67c45MN48kzDzF7FmJw4jPXDeACaCWl/jkPIMy
	 +O08RuQq33XUEkvVQpa4P1zfhnCQLWtblmqnfI7PZR8ekHItg3c+xI7/XWQ27qhcs8
	 XS+UQf0VLUCmTSlvk+gFTA6KV6b8fnb2Bc470q4tKh+m6Z8vgDeKKjRQgvpBLD82TD
	 HDf71cKDKpXdWkE0hmjqDJhM4iHpspIVKqtV5RggQVPD1qZOcNAQg0zdmxfTBaNwnp
	 0bRjHXOtH74qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 10/23] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Wed, 23 Oct 2024 10:30:54 -0400
Message-ID: <20241023143116.2981369-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_073134_726326_4408D35C 
X-CRM114-Status: GOOD (  12.21  )
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

From: Greg Joyce <gjoyce@linux.ibm.com>

[ Upstream commit 0ce96a6708f34280a536263ee5c67e20c433dcce ]

Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
is ready and able to handle commands without returning
NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82509f3679373..e25206c7de80c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2250,8 +2250,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
-		ctrl->ctrl_config |= NVME_CC_CRIME;
+	/*
+	 * Setting CRIME results in CSTS.RDY before the media is ready. This
+	 * makes it possible for media related commands to return the error
+	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver is
+	 * restructured to handle retries, disable CC.CRIME.
+	 */
+	ctrl->ctrl_config &= ~NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2286,10 +2291,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 		 * devices are known to get this wrong. Use the larger of the
 		 * two values.
 		 */
-		if (ctrl->ctrl_config & NVME_CC_CRIME)
-			ready_timeout = NVME_CRTO_CRIMT(crto);
-		else
-			ready_timeout = NVME_CRTO_CRWMT(crto);
+		ready_timeout = NVME_CRTO_CRWMT(crto);
 
 		if (ready_timeout < timeout)
 			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
-- 
2.43.0


