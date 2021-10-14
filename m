Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:46:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B66361108
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B66361108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uYFA6L9a6h2QfAWuD14sc6M4+ZNIQgrdvqLaZh1giMw=; b=madna9UGae0gcHyT9CqQuKH1dS
	EVdgOJ62wkiXfPv0oEU2RRj7OCq2cRobYWkDwjvy32Kvp7Rx27u10uzjKN1YGF3UzR8lssoN8mvMo
	SWGL6FO6ZkfWjcsNF4Su7K8tW+YeZw0Yo4CswhACUj6XP69YbKGd35AYJdTmbpKCQ6nWL40rbW6jf
	DAGWbD5CAh42g1wDQVVMgN6mjNvI2kFBl6HUpbrstzWkDfWx8zeUo2BfYQcYxpJWwApDMsDeQnOQG
	OUcCCU14PNGscfUdJnlnjFHMlMuhFvZXGATa+6VQXWlj6IL0IgOqazj8bOash0Yrbe6fxliASIEq6
	Nwusp4uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb3rk-003sne-6r; Thu, 14 Oct 2021 16:46:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb3rY-003slM-1j
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 16:45:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5071D60EBB;
 Thu, 14 Oct 2021 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634229947;
 bh=e2O7oEyTITDHVG+6xxv6C0QAfuqstPSfjX/8YojvMDo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U7EQp0H98m/kVHFPlhz8BCQqzAocc85gj5waFXo3GcCcRVy44gC759CCyT3VVYakT
 xniR79XTS9Zx9yeiWF9NIyIg0GA7/RXsusWRXmC5x+ZgzSbqDRobu98d/oeY7tigu5
 CCbjEIYmpr93PTuAE0PmFeZboIsz/nWHo4AG4Q+hrXsRLV5IGmDPdBOJD+9QvaBkg4
 CnUdAEY/ClLJr90ExpgO8n3O3cO4WtIvNM66N81zkfuLRmD1fGZG5TKzboXP4KThC6
 saNs8gDugYvDkwowm+xLSb7XMJGcFf7o/iUyA6A+JoF+TPZPl9R4X9tbXr1dPDYAEr
 DJTSx0P4EoPIw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: John Levon <levon@movementarian.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] nvme-pci: clear shadow doorbell memory on resets
Date: Thu, 14 Oct 2021 09:45:42 -0700
Message-Id: <20211014164543.1821327-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211014164543.1821327-1-kbusch@kernel.org>
References: <20211014164543.1821327-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_094548_142880_5DCEE7D7 
X-CRM114-Status: GOOD (  11.53  )
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

The host memory doorbell and event buffers need to be initialized on
each reset so the driver doesn't observe stale values from the previous
instantiation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0dd4b44b59cd..9dd173bfa57b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -245,8 +245,15 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev);
 
-	if (dev->dbbuf_dbs)
+	if (dev->dbbuf_dbs) {
+		/*
+		 * Clear the dbbuf memory so the driver doesn't observe stale
+		 * values from the previous instantiation.
+		 */
+		memset(dev->dbbuf_dbs, 0, mem_size);
+		memset(dev->dbbuf_eis, 0, mem_size);
 		return 0;
+	}
 
 	dev->dbbuf_dbs = dma_alloc_coherent(dev->dev, mem_size,
 					    &dev->dbbuf_dbs_dma_addr,
-- 
2.25.4


