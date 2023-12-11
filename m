Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C69C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDUxA0DgCnX0ZIsmhjvhwavZ//RB0u2wuWSktnzAhe0=; b=3BARDee7U1hbduKI5kW1ACWtt7
	93mabvpYQSMyTSOW8xgKu3TXwZ5gdTmvFFrq13e4dlPUn3+Bqx/WZPT1Mjd4uYtLCCSbUfKoTuJgK
	heGdUO7APP82xMPs2WE2jqD3z+0rhCeINNjVtXR54gMvhO91ubfbtqXK6hfLBKRSY8kW9gm11qKQB
	XSS0XmlB1iti+hSeu4kjkT/7VXw3M7rsOPigwcQAqudRUqukwEQJDY6b5ZLpuMBPPf6LedVV0Ye1q
	UxZBmvPcrY7J8Ib+Zy2O69uOr5aiUA+Jq946g+Z80+UgrCDk1Bcy+FVG/wnT1XTtMt/Qb6wi/VEWj
	mBGVo78A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgpY-00545c-1T;
	Mon, 11 Dec 2023 14:00:20 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgpU-005446-1L
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:00:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 1C7A6B80E63;
	Mon, 11 Dec 2023 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25541C43391;
	Mon, 11 Dec 2023 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303214;
	bh=dT3TjpU5nkeVbApxHkWNYjJktKleH4Jfc/XG8mWzMKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWc7TwGA1vCcS3JtS9qg5KNymYBVaVbV0SjLSDcPmo1PCAf/NOoMowc3PrK/C7f0M
	 DQDPG22tfRh4HaN/WX3p/vHFwwGTHJLAvNh1oM6A51IermLPXJ5899c6JzXxAu9GFX
	 ng1jbJkESdHhnzClfEN3z02QEdQQOyn338Vn0UwoNzuITSXW0lpzhcRZS4VyAFVKbV
	 Gki7Ktne0tEjL2r2VVxi2OGuAcpeFbstsGNb2a52C4mY3mkZp0P3mOiUp+6ZrDY++/
	 wRyn4eChBxNRkS1rXOzzxaQb+gb+B+EbyvBxxdR2Pv7Bt9u45+wvXzmyVC7Z1pPcKm
	 HMRmWjaMCIUPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 14/19] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 08:57:48 -0500
Message-ID: <20231211135908.385694-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135908.385694-1-sashal@kernel.org>
References: <20231211135908.385694-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.142
Content-Transfer-Encoding: 8bit
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 590ffa3e1c497..e523427d8a581 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -360,6 +360,11 @@ struct nvme_ctrl {
 	struct nvme_fault_inject fault_inject;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0


