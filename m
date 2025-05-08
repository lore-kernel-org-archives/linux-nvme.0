Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89434C3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISmCxNkS/BWpMxSwO4HP3VqlA5Ba05nwxx1Cdb6Bmow=; b=WlocTJe45AM2BI8PQzLuFdBWup
	ST5se+knL+cJZOomBu2wVol5fRepGqFhFHDwd28uWgaNqL4kc/lI/IoGYU9qgH0gmjVUPAtP8r0kW
	FOm7JEzWXo2Jl/uiDzZWq4N7lezadCF4GYYTeeF6Jii5II4Qa02tANsUThp7tDEeY0m7VK5yoHGQf
	54tvri/hPrDg8rmHMCuqntEftKN3kecUK6NWKB8hGIvumajAIlseOV9qGuKX6kn9yWwHQeGGYgX47
	0IjnUaGhZJfP0wvSFp4FpKRFYKr2D5eWfMJFcYejXSW8aFqtRA1Xr8YBB/LZKGmQqieGN2fPXqriR
	ZLscAx9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdD-00000001yqL-0a4W;
	Thu, 08 May 2025 23:26:23 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdA-00000001ynw-3IXG
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:26:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E403CA4E2BD;
	Thu,  8 May 2025 23:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FECC4CEEF;
	Thu,  8 May 2025 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746779;
	bh=iJW576JtOU9+r5zSG5wXaNwHtvv8IZW1ZRIxkMMHlco=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A9WWoDRBvFii8eGEtbMbZimB2Fd4rT33hkffVDBo1FzTQAzoDVbM74FnF6qwJMScF
	 D44B7zpSeto4x+y9EP8069QfGVXKYmKUjpXiWbArL0x4V+WWRDUEIOU1XV05ejER6C
	 PMh3gk9k41ybJcPDQOTUwsc/mm679Bwvr4l6nv84NNh6/juLeo9ClHZyL9aiitWQjB
	 CpHxCjJoFTEhLVNWElYtZLRphfJYgcwTbvD5sBDZ54UDRFz/ZuP6TZxjslnttXSRNq
	 yIdWKY/qgTGS010/55l9gKuAiRgKe27zYPH11CdoQ7/pz+cC5dKxn9F2xjL9Ed+qIh
	 R9M3hLbJPPdHA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 4/5] nvmet: pci-epf: Improve debug message
Date: Fri,  9 May 2025 08:25:03 +0900
Message-ID: <20250508232504.437470-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508232504.437470-1-dlemoal@kernel.org>
References: <20250508232504.437470-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_162620_913023_D39A166D 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
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

Improve the debug message of nvmet_pci_epf_create_cq() to indicate if a
completion queue IRQ is disabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a6ccf3fcccc2..94a908b2340e 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1321,8 +1321,14 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 
 	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
 
-	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
-		cqid, qsize, cq->qes, cq->vector);
+	if (test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
+		dev_dbg(ctrl->dev,
+			"CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
+			cqid, qsize, cq->qes, cq->vector);
+	else
+		dev_dbg(ctrl->dev,
+			"CQ[%u]: %u entries of %zu B, IRQ disabled\n",
+			cqid, qsize, cq->qes);
 
 	return NVME_SC_SUCCESS;
 
-- 
2.49.0


