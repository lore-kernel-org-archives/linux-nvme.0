Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B1C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCE664E08
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCE664E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EqWzNBOibutXTWOfDrilUoZ9xDBGu0UvdPZH6IDPUZs=; b=Yo5+l2jZ4dL50QYM/rryhpsSX
	HSu+BNkk8pOQe6K6oKzeCk6WIuVXaV2tD4pIZV6WxuUhwFSNla7a9KiUNIdEaNqIx2mrkIBffvtp6
	bTGd7kmuElE3EIhiCHsGsVMKvCNLRwGlUM2c+wfwc9v4rxT7KM0CwaLbJo1fsd/ME8H2QryxezHmU
	D6q9r60UeBtJ4DU25hYxV7YI+HGBGBrhFQMIr7A1zE0S0krgW9ou5sKgvsTu/ra2EsQuLb+ZjO77Z
	x6vlFNh6/NX73k/Ak3uF9NU6uCEHQ9aPt0MefMbGIqZhNFw9kRTHYfh2Ae2kwVG0LsV5oNzWW1dCs
	bSvVepUBA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5VqQ-0006YW-V4; Fri, 29 Jan 2021 15:37:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5VqD-0006SP-Hi
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 15:37:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BABF64E19;
 Fri, 29 Jan 2021 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934664;
 bh=9erNqEszCSdiqeuy4x4zFS4PPl6fhA4J97iiuei19+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WyiyxfbMY2DMtxCfOAE8XK6b0w/bkSDdtm04uU8bBx/1jLKclHp5ajE4JdDua5FbB
 mwLhTJrUDVLGHWtWG+h0bhMjgX9+ZqDvWylDMudIDRo+SpnYRCemY0msPLiDKUSnWT
 lxp56eHS3FagSOgn4sMmcF5TwoOYXRoQiY8eq+wkUTlbogx0frOsNsQi3/BVtgvq+Y
 gMLDXAQ8nGkYh4qv+yrlUPrAkITuH6kHxj6eRrXRou8aOIvx3FO+mnvkKxhBUQ/NRj
 6YHASUMCqXlk0MDSuxKpjL+iy16BolpH14bX0ltA9BQPAfabK+OFizCxOHx3EDC9lQ
 E5xaD/G6A8O7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 25/41] nvme-pci: allow use of cmb on v1.4
 controllers
Date: Fri, 29 Jan 2021 10:36:56 -0500
Message-Id: <20210129153713.1592185-25-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153713.1592185-1-sashal@kernel.org>
References: <20210129153713.1592185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_103745_748671_1EA16FA4 
X-CRM114-Status: GOOD (  13.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Klaus Jensen <k.jensen@samsung.com>

[ Upstream commit 20d3bb92e84d417b0494a3b6867f0c86713db257 ]

Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
by the host.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
[hch: avoid a local variable and add a comment]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++++
 include/linux/nvme.h    |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77f615568194d..a3486c1c27f0c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -23,6 +23,7 @@
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
@@ -1825,6 +1826,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (dev->cmb_size)
 		return;
 
+	if (NVME_CAP_CMBS(dev->ctrl.cap))
+		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
+
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
@@ -1838,6 +1842,16 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	/*
+	 * Tell the controller about the host side address mapping the CMB,
+	 * and enable CMB decoding for the NVMe 1.4+ scheme:
+	 */
+	if (NVME_CAP_CMBS(dev->ctrl.cap)) {
+		hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
+			     (pci_bus_address(pdev, bar) + offset),
+			     dev->bar + NVME_REG_CMBMSC);
+	}
+
 	/*
 	 * Controllers may support a CMB size larger than their BAR,
 	 * for example, due to being behind a bridge. Reduce the CMB to
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d925359976873..bfed36e342ccb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -116,6 +116,9 @@ enum {
 	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
 					 * Location
 					 */
+	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
+					 * Space Control
+					 */
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
 	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
@@ -135,6 +138,7 @@ enum {
 #define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_CMBS(cap)	(((cap) >> 57) & 0x1)
 
 #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
 #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
@@ -192,6 +196,8 @@ enum {
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
 	NVME_CSTS_SHST_MASK	= 3 << 2,
+	NVME_CMBMSC_CRE		= 1 << 0,
+	NVME_CMBMSC_CMSE	= 1 << 1,
 };
 
 struct nvme_id_power_state {
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
