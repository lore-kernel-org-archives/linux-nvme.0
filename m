Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EACAC6FD1F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Mar 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CYu406OrZtJC38o8M7GbPJw+AnOjAIUuhhGKxWO56D4=; b=LgxRnIduZJ+DecaDWGWfyO+VLL
	1rntgVyJpv2s6rBwnfA1S5T1UO4TW4ez8cvC+sjWF4ty7K0+Zs8ktsJx8OZ5EbkBV6ZU1POaIqp+N
	syM27x/MTuDTg4aPuegX3nVbKKEmqB4oQ5F421i7jiDpoa5aNOFuA9iZqQ/Lz0dJspWpvWgMTtgDb
	lxtLvVKQoMrR56ELusai1ILV5LJP9FHec7MJ6FHWgxnVxdY/cAoGdM2MWmy4GJDt/4XCfbFMcCwFj
	TGMuzVi/Ge2Fi4Ecjh48Nw3aiqAI3x8HIY5kmStysKWlwzHETQTW+3lWw3SGEcbcRUXha07h3O36/
	JfxdKvPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRIb-0000000D1Oo-1zt2;
	Sun, 24 Mar 2024 17:06:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRIW-0000000D1Mg-3TMI
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 17:06:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 79251CE0B44;
	Sun, 24 Mar 2024 17:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31DEC433C7;
	Sun, 24 Mar 2024 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299973;
	bh=5otAryG/WYRNcxOQAOAJo949yLsICvxts9fIOJuqL1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6ka3JHUB3k6V7C91Zg4OuFBfh5wJBIZfetOtH7RsSW83GA6f5YHvTLEkWUWtHlro
	 c+K35N0QgDfJh3PFAUfFi3jN+r/J/8pLC/DCIR+K3ukPIyWr4GOYFywFeiGDCv9uQd
	 nYOsDwmJt6Le+YIF+tYnq3Upl/2mvOT+eGTBEaB+EJ6mfwks3N4NcdWZOi4FvXXe57
	 9QZeFS+HAoHO9IsqZmYPlfWrrebaZvhvSzKiKY1Pe67qMIBqiJ250L8ljklAN2k+HD
	 KaerEwlM3vFG4liB7uUSalwgiYsBuQoe93PpaqVsecIfZRPcB5F97eTd4Yqc+a9czs
	 KE5OVegNZZkVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 11/11] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:05:46 -0400
Message-ID: <20240324170552.545730-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170552.545730-1-sashal@kernel.org>
References: <20240324170552.545730-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.1
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_100617_070689_4AA11FA5 
X-CRM114-Status: GOOD (  12.51  )
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

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ced..39ee3036bd516 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1398,8 +1398,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1528,6 +1530,7 @@ int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


