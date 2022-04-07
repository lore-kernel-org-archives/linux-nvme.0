Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D689C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 01:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sYH7iDAc7RIqnchkPdabstey3mHe3hCzTazpZFx3NeU=; b=AFGNHpEWhe3CHB4IC/qaX7C7qT
	vGxiEGSCRofki1wZF6Ay2u5b8OGFMaP2Reho6pBXV8ydjHB9q0+JZCGh7Em8LNBJpw7KTSAGB9yQN
	jTwIPtR5qJPyAN0xAdsHHDMkyq0Ju3QYF4MJ0FBfxXC0OkErfd4J6uVS1qA5neZD6g37o0T4+VK5w
	XfelxVSm0A/55o2qgVcu9k8utIAs7nKsg9RPZcGYx8x7X3atTxcSHoOr1AdC+3aoEgnbz0omV0gcM
	KlmZP/lndz28NBS0jBqjtHH0/ln/ZuM1kVhCiUF6fiA4b5iQgFhB6Bpi5cSEk8lMVpsD4Z219QaG2
	Ti4+KmTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncGg4-008U8z-Qi; Thu, 07 Apr 2022 01:11:12 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncGfn-008Tzd-EK
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 01:10:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4341FB8268E;
 Thu,  7 Apr 2022 01:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FBAC385A6;
 Thu,  7 Apr 2022 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649293851;
 bh=m6CnjI7lRuS3hxI4uCG5AZi8oJALHqfLbWsem59FOGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R4PlBPy29bP2pH0VlVSEDxxoeVnXiuPm+4QwWiOfo8p43tIkyTKnYRYyS4Wr0BCOB
 iaJg3GzfqxNtWoX5M5I7dk/0hGM3cCAlGkUdI0nQ17WXS/MrFwxamj+YDsthcBNGkR
 HAaxyIyDVroqxcICkPtseclDGVUK1yTO+UcEF+V7wqysHD06HmKzEt06AQDXq2432z
 ixbHjJpL1VIVPW4nhumKgy6lU1ykTbZAqch/L2Lx3ifGKJcf6yeA67J9lWy3rYKLdE
 dm3V0n/jhtG+H6t5MHuAoq8fxty8J5DTiPozvl/NRO8cMpBGTtIFRtOjqk/Qg3rZYY
 dAm1CoyRbrJ7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Monish Kumar R <monish.kumar.r@intel.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 11/31] nvme-pci: add quirks for Samsung X5 SSDs
Date: Wed,  6 Apr 2022 21:10:09 -0400
Message-Id: <20220407011029.113321-11-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011029.113321-1-sashal@kernel.org>
References: <20220407011029.113321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_181055_675702_9BDE42FB 
X-CRM114-Status: GOOD (  13.89  )
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

From: Monish Kumar R <monish.kumar.r@intel.com>

[ Upstream commit bc360b0b1611566e1bd47384daf49af6a1c51837 ]

Add quirks to not fail the initialization and to have quick resume
latency after cold/warm reboot.

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..c1150e01394c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,7 +3463,10 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-
+	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
+		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
+				NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.35.1


