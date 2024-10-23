Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1505CCF5397
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJWh9eX5g2c7vwSEeiADQIm1k5O2tv7bt9GY016ftiY=; b=DxKy93CcrFU1nVrL8WS2wjrpDE
	K91VIn32at/XVLRANVaAn+7140C71oknMD4NI+FLUiT5gF1X1j37L/7ZWlafyJvQQGYcaMMmw6epI
	YYn1OjSkruKpkjtfSY3p75X2BV0DBSAyGjy7096dAJE+vMWEo6DggJADCeUTLDtGBQ/OsBS/KVn1f
	3szqgFCjiomg9zHoOulR50OX6dfRjAWQNkJyEPTfNClGWBguwWtUeR/ELCrP5UoIaTqEq8uqL/WEl
	zB1F4be4LI7r1ucYBTbhT1SNt+YFoPXJr2b3C+zLbgBdN+fmZA8AiNDpaYakc96SSlxPtsS5/72jk
	DjQWbnAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cPs-0000000Eim2-2ASE;
	Wed, 23 Oct 2024 14:32:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cPG-0000000EiJd-0mBZ
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:32:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 456C6A44F27;
	Wed, 23 Oct 2024 14:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC3C4CEE5;
	Wed, 23 Oct 2024 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693933;
	bh=dNvjYXQ1uETg4goYAoDXVhbZdnJoONpUIibtngoe230=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3ampTQddSZkF1zcZeu9CCn9I6RCG6SPYHSBH4n8Ioq8Rzj4HfyGzMYu2VuckXhrK
	 M9FUH2sWsfeKKX0ehtfxvgdiMt2YwEM8OIW06szUwMO57g7NlQxxxCLYIr5MB3mleT
	 4ds5pb9nfhPWJOr2FYJTy8p+J1GFu74nCR54xMfm19hl6ZjX+jEVVS7S7l/L20aW2e
	 L3t/84gZ9Cc9rlA6xbTG7GD5X4hj3WPzB1gpl8NMn69PtEFUG18LBqlBXR0hhmwX3h
	 2X8nuN9zI0oClcYI3NViJ6Q3C9mOGAqFcB2DmhGjZVzGmbU/vnhGSjPch609rv/725
	 cTP3RNBExIFcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 07/17] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Wed, 23 Oct 2024 10:31:46 -0400
Message-ID: <20241023143202.2981992-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_073214_312949_D50A9C3C 
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
index 0729ab5430725..dc25d91891327 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2394,8 +2394,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
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
@@ -2430,10 +2435,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
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


