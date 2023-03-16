Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A65CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FXO3kZxDO90kAdcRgJ6UdEQqeUfF7ULEBk+jttSoX4M=; b=XvUrgVUo5TGkLcPLOjuUWqt2li
	JsZtcbjT4P+jJHvsc3oiObLcxVNiRlcNFJckRr8QIBhSuKYFxrLEtb5bE/aKTSS0gz9APUA+mZqNs
	SY+2EtNtWzKpkVcMDoUkwhDAH+kc4uZs5NvUHfSX8G1IZeBzZaBxpr5ckIm2MaK7BlbF2Q2fSgfvS
	RMUQOQ9fDc76Lw40UWaHJBWWL1t11BxQ8qMDY59ek18cGdH53yuwJ1GddFIAg51A1N9m8P6WFhMHv
	ubZdTRDgYsUMnH8rywtqSBSclF4IHP9KcxFTBy0x2LRvprNGZLLbJagcs6K/cN5DklGYmwDbCh+1G
	BJwZadiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcoHv-00GdyX-1W;
	Thu, 16 Mar 2023 14:09:03 +0000
Received: from [2001:4bb8:182:2e36:7cdf:e29:79f5:38af] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pcoHs-00GdxP-2x;
	Thu, 16 Mar 2023 14:09:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: cleanup nvme_should_reset
Date: Thu, 16 Mar 2023 15:08:57 +0100
Message-Id: <20230316140857.873370-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Both the comments and the code flow in this function are rather
confusing.  Directly return the expression that the reset is keyed
off, and update a comment to match it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 04f4c6818f2878..d98cde62128f7d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1229,11 +1229,6 @@ static enum rq_end_io_ret abort_endio(struct request *req, blk_status_t error)
 
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 {
-	/* If true, indicates loss of adapter communication, possibly by a
-	 * NVMe Subsystem reset.
-	 */
-	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
-
 	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_RESETTING:
@@ -1243,13 +1238,12 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 		break;
 	}
 
-	/* We shouldn't reset unless the controller is on fatal error state
-	 * _or_ if we lost the communication with it.
+	/*
+	 * Don't reset unless the controller is in a fatal error state or
+	 * affected by a subsystem reset.
 	 */
-	if (!(csts & NVME_CSTS_CFS) && !nssro)
-		return false;
-
-	return true;
+	return (csts & NVME_CSTS_CFS) ||
+		(dev->subsystem && (csts & NVME_CSTS_NSSRO));
 }
 
 static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
-- 
2.39.2


