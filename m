Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3793AC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0bcbzTbZjM2buqsfEg9CtbbQxbsL5cRM7QEPa2uQMQk=; b=edWp9ckSGVQa17N0xbRpsxEApR
	iNg8qFJq6Aub1amaETpkxFHpd71DNiEqwmJYtr/ISLXgxVkiPq7rEWXFXCabpbJVDuwV7yM1gRca4
	n8DqFryyH2BeBiUJtck51kvUs4BBDH/e0YF2mj2mv/h+01v2YujvgOFOiJOtf5ByKYmgFZHBGxFDr
	DCquMijzQj/c5UrwQ7bLBRNXdDaJLNivTmxqhS4Z5ElpAv4gS1qyxeckpehvWgZ97qG6aaDqxANy/
	QjrL8qgqCJYm5rq/EaELmRLG82rWUboFtJUivAMqK+bZFnTonNSb3EkUOA3RT1Ws8X1MlljbiL2aD
	xXcZdv7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ZN9-00000004clY-3BdB;
	Tue, 15 Apr 2025 06:02:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ZLO-00000004cX4-3xre
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 06:00:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ACB2B4A486;
	Tue, 15 Apr 2025 06:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8F7C4CEDD;
	Tue, 15 Apr 2025 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744696826;
	bh=MWEkB6gFH4bbKgXoq8Jhv67egdNMQOXDSD3owBn5GJA=;
	h=From:To:Cc:Subject:Date:From;
	b=fWWe59RdLoCx+u/Td/watLqZ0OAKbNxkx4kGCTWpx2GX5WYU1HtA6e1xNhI9w+ROI
	 NM1Tgryv24u/lEsqz+gg/I8M5WVC4qB5ME0QDbGoBJcu7d13jcnkb7mVQVXZCL1+np
	 kLX+HgbB+R6CzResN2+3YJV4bDvhueMD6RE6xaD36eIM5LMkWWAXtW928hphOBOOT1
	 l+jQH/Mw1kMkD3YcAXwOGMQFvlRCGXbb5jb6oWLctt1PVrtYiBEPbfncis8kL3H4t1
	 JS4wV8BU6MbKHduzElDxpiuBJFQuxuAVN9bPh+s8l4QHHxjuiRo5/7dQJPuGuUGNeE
	 ekgVZ6Z3c3O+g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] nvme-tcp: remove redundant check to ctrl->opts
Date: Tue, 15 Apr 2025 08:00:21 +0200
Message-Id: <20250415060021.16472-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_230026_999123_BAB494E0 
X-CRM114-Status: GOOD (  12.40  )
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

When checking for secure concatenation we have already validated
that 'ctrl->opts' is set, so we can remove this check.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 72d260201d8c..e20a994d63c2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2358,7 +2358,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
-	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+	if (ctrl->opts->concat && !ctrl->tls_pskid) {
 		/* See comments for nvme_tcp_key_revoke_needed() */
 		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
 		nvme_stop_keep_alive(ctrl);
-- 
2.35.3


