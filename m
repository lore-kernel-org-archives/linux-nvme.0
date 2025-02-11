Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85301C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=12Zqd9ZOThRCFg/F3L+rZZCvlfWg2uAMV4tgYs8lnc0=; b=iXJm4tquZTSquPxpOZVYCHt2Mq
	lTIGJDpRzMZfDtRaLJSwR3kdvbMpPmjjycCM44+U65FKBit2RZR/bzNB1MOSucIaoMt3IomrbLf1J
	XBuFI5+ZOSPw7VtLhFp5r0XGrh8BeAYxneSLBhjFXU659eyUyB0kZGkw5p8ldUYqP+t/WeS6AHlmA
	s/oDZSL9zSf7JN/oZX/X9w3dIMcKezihdMY7HOMMQFgSkVF/fasj2eKyexiIaUzXjzcTVNRxBPYsH
	hOSustkwN+D50fsLZpBF6rgksXi3GTL5/2fJdDzkL1f32Qr9re3Qxa333pbw1wRJVnAf/Htq6mV5m
	ylM+HP/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf9D-000000028c3-0TjN;
	Tue, 11 Feb 2025 01:33:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf9A-000000028aQ-3IR9
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:33:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 69135A41726;
	Tue, 11 Feb 2025 01:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947FC4CED1;
	Tue, 11 Feb 2025 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237587;
	bh=EsV3B9F5AWzE3L9ceW3hP97e8ozRHkUwY5GAy6Wjt5o=;
	h=From:To:Cc:Subject:Date:From;
	b=WRf3DAq5wx22fx7QNpin3tIyw6V9aFVyHOW0WTeSywuEtf6xhWH7WLfXuaInZf9Pi
	 6ZcY7IWL9DrJKwqWLS/JRpO+P89sDH72CnqLJNAV1eZ5bWHZ570WsBHHxOb0gwXbvG
	 qUNZKNoydvcvgUiolxej9xntZ0ATfEYZBgdO7ij9Uq/uKsR91NKqYGBaRdaMZaxaR7
	 VNu7rRnIt8zzggI8lZj4HH2YDslNAPAlbTP0Br8/r9LajMtylI/+oY0yUwn2Npd6bm
	 XnrQT8rreBb1TILQqhO4//mFBOdKLZidFs4I1sxAPTuEPWJhYidQcxZmzChmB9ehLA
	 AYCisfwStrOAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 1/6] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:33:00 -0500
Message-Id: <20250211013305.4099014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_173308_891507_17AD9F3A 
X-CRM114-Status: GOOD (  12.05  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit d3d380eded7ee5fc2fc53b3b0e72365ded025c4a ]

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0d2c22cf12a08..f3c0bff714eba 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3164,8 +3164,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
-- 
2.39.5


