Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD24C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:25:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F9923A5E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F9923A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rbh6Swju79uPivXRtChMyiOSGbAjvYLy4CmeEwtqeY8=; b=MEah7TPcQ3Sv/K+EJoo789e2CG
	jWJP8AWVHG6m6v0mnj7DO7oIVJh52bYXvt1EO8dJ2QEEs32jJiQrcvGD4pzVrcoYAnD9GHR1fzpVR
	lxejQp5QyQtqCSgvgo+zUAAZcGLiOo248G8Tb6kzp2RBiCltPz4kwv94EWlpOcJAo33qSqp1B3J/y
	gTKxNX6AyEhPjP3FpQOxZhBtmPuuzlpjbvSr+95SkOuGoQrViShcixPKSHfkP0q8Q8gvG9Nwpm4hv
	5tBG38xTmiLqAG+2enfRNzd0I2boTDUcUCIJgBNEgBDvSG0MbRA6wKmYoJwOnjLTOhFrX2y/B94rC
	iVA4v1kA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l02cQ-0000Qz-L4; Thu, 14 Jan 2021 13:24:54 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l02cN-0000Q4-RM
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 13:24:52 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 1F576156A;
 Thu, 14 Jan 2021 08:24:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 14 Jan 2021 08:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=ojI9k5Xtsko1s+LuXVZqpxKjqk
 tbd2gp304pFd7mNns=; b=JeedRGk35HS2XO5EHBXKuuUkOa+NsZnVovBsAIRs5r
 UpadfLuD2F5mUdqHLaVYnfCrxBnEUMweQScRgO8ShagXYFvVWxD59iwud4wlnlbm
 wlmTGruwNz1OlSnoE86pyysmwClKd9ZXlAF/yVNfIB5TS8QSvl7JIWbUpFvCyI+B
 AFQE6yaUnprCxYwSGaKX5mxMMY8e8OPmibxB4rzgjj1RHVbwNDDC6JbbTzIkqdnN
 LHO4uoPD9s9kq3n6Zln5eeHgs5oHIyO1S4OtI8tZ+iUUxl48B2syw6fb7mdGbVFn
 YksCWpu9cYa2/c15kfJzXzlC56x7z1OrZ992Z/N+Jacw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ojI9k5Xtsko1s+LuX
 VZqpxKjqktbd2gp304pFd7mNns=; b=fgfxJ1Fe9FF4yrOka3wu7evNqRMoKXl+W
 yuTS3A08TlPlKRYg/PvwffNCLa/ceo/iwuHPAkodSlxDK45vefgwFQdVn/73Fo8n
 gKIE1lyxiUNOehoEJ18ks/XMPqmLQyghx/aWgR2/ozHGMBAwfOPI1mSPGnDr04yC
 9Xy0Y8ArnW/4Bd5WTMuL79Tf/6i55cyrhNbWqbVea8GJJLbD61UVM+uMH5BlHeSJ
 nabGMelHgre1tQjCE8ZKApCecMh1e84XfM1oW6TLmIVpblO/AYDUjzMgkJnFzh3m
 rkbvqmr4CRFNxHzrie1dMjRY3eMxduVVWZ33g0/EvmzrsND3Vpd4A==
X-ME-Sender: <xms:HEYAYJ0yQT7CWwL3QMQ32TWbT2Y0YuduSPgwVYAQ-ZPyARZEYt6NXw>
 <xme:HEYAYAG37SuWBjW3OAXarcK3uGA96m3Mox4iBRCJv93SH16NRv8D0GoXca1cWTjOX
 IrIdscuR_PoeO8tyOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddtgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
 kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:HEYAYJ4p7tCnqMBsYZwhK5WsA2adpUzD0PiQNAYKe8S0Ue4RcfWGRQ>
 <xmx:HEYAYG0YV5VfyJxZEoiE0dJePDoZwYraEw4qSYnJiO1K8DpE-6I_Ag>
 <xmx:HEYAYMEYxxxZUomC3K6MhthQhLAhWkHAGc_DCgD6mMswzctCRMH7jg>
 <xmx:HUYAYABjzcObI4RtrNamOeiu329YaTitvGleHOrqrSYycncNqeZQYQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1A19424005E;
 Thu, 14 Jan 2021 08:24:43 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: allow use of cmb on v1.4 controllers
Date: Thu, 14 Jan 2021 14:24:41 +0100
Message-Id: <20210114132441.193782-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_082452_081403_B4A0FA29 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Klaus Jensen <k.jensen@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Klaus Jensen <k.jensen@samsung.com>

Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
by the host.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++++++++++-
 include/linux/nvme.h    |  6 ++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50d9a20568a2..9c2bbb242994 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1787,7 +1787,8 @@ static u32 nvme_cmb_size(struct nvme_dev *dev)
 
 static void nvme_map_cmb(struct nvme_dev *dev)
 {
-	u64 size, offset;
+	u32 vs;
+	u64 size, offset, cmbmsc;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int bar;
@@ -1795,6 +1796,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (dev->cmb_size)
 		return;
 
+	vs = readl(dev->bar + NVME_REG_VS);
+
+	if (vs >= NVME_VS(1, 4, 0)) {
+		if (!NVME_CAP_CMBS(dev->ctrl.cap))
+			return;
+
+		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
+	}
+
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
@@ -1805,6 +1815,19 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	bar = NVME_CMB_BIR(dev->cmbloc);
 	bar_size = pci_resource_len(pdev, bar);
 
+	if (vs >= NVME_VS(1, 4, 0)) {
+		cmbmsc = pci_resource_start(pdev, bar);
+		cmbmsc |= (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
+
+		/*
+		 * Writing the low bits may cause the controller to check the
+		 * validity of the 52 bit controller base address in the CMBMSC
+		 * register, so write the high bits first.
+		 */
+		writel(cmbmsc >> 32, dev->bar + NVME_REG_CMBMSC + 4);
+		writel(cmbmsc, dev->bar + NVME_REG_CMBMSC);
+	}
+
 	if (offset > bar_size)
 		return;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..bfed36e342cc 100644
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
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
