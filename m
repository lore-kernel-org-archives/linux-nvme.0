Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0278C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:31:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8844235DD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8844235DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HGVSAV9AsQxUG4sJ+GYogd5N4zzM6S2UE0UwvzOLbiE=; b=BMfu/e78tuetOBxKL3NxudSGFS
	xKnPGasOP2o3VXTsqbIMiFUg00ZmXDBBN4TJWy8dKwTjSj3r55Lv9+UetofUJ8+ttDnezgpVy3W3I
	85rKkh+kPstg4DxKZ7USzcAh4tJ+3syYWhxFHlolo827jCTW50k7BOHjV4Vah5ZcMQhtG8XsnHj5N
	2tTWRe3JXXepV9c+rYbYwq7c/PJ4iidh4sy6kORPolzkyXNGg9fOJ8zUxmhLNF3ZsKzks6JNnrCFS
	NZhDrpBal+iagsXZplm6XyGMWoe+e4xDxBH+HOYZinm83tJ0mPX0AXEibfwJV+G2JYdF5MaPB0NHS
	HIf+BdLw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0IdI-00067Z-Nu; Fri, 15 Jan 2021 06:30:52 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0IdG-00067F-ID
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 06:30:51 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id BDCAA5C0151;
 Fri, 15 Jan 2021 01:30:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 15 Jan 2021 01:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=5cJMz4MozLzvx4dLK3xvc7v4a/
 +uoO5QyfAy1IyqwCk=; b=X+jitGhPuM9Qh3ZypQH/dBf912PqJ7MRxGHHmQcRd1
 oknV951WmiNtebl7B+cKkJ2PyrUXFX27sG3rw1vDneFknzam+OtxZAMxvUoUTd7m
 3VxWTA8w9NcWZGxVTocPJtPeCh5/W+toHeRqHGcQLxO7p5aLsTlKen3t2IYloT8i
 VJ8WoMXmq1dWpbj0A1wic6jc9EkW4x1iMMW7o9mY1uBbdjxOjcPeh6BDuD1BsX/u
 vkcVzd9h+lh9+0WY7ltt5XBASC3+wPszP05cKsDH6uGLlxMGYpqe2fhMnX9LvI7h
 VDifv66QsdAXM20fMiryvkO7vHrDin+MLorI0LbGcqrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5cJMz4MozLzvx4dLK
 3xvc7v4a/+uoO5QyfAy1IyqwCk=; b=oMJ7Iu5F7Jb4XrOfFIs8wN6CyIf/CL7kz
 5X2REhF39rparOM1Wx7h5aV+MWIKp+Kuf+vNIa7JhRIUPac/3lUoFWE7QNgi9q1+
 IB5Op4hbJ3pqzAxBfTRFOKyhJHMPjzY1EmvW5uAIr3c2+CdRnwZWHC71dglxx4qr
 eMvDiyBi+C5MsknFgVTUpzPyJfQKSnPSe57GlG4fF7xG4VJOwLDNX+wXMmyY76pV
 YfRxyxn7g5bnspSCb1PQ8rTijECJagq3lnled88KA9sS/1X4mQ4bsm3wpak40IKP
 UgUxnr/XFv1ae/7/6KH7xcytWUWApXZB6lOb40ppzL5Nof49Lq6fQ==
X-ME-Sender: <xms:mDYBYEOu133gN-8QLSRjT2E4PM1XhLmXa74OjWVMEtlzOeAzMCE2kA>
 <xme:mDYBYK-AH2M1d-hFZ2--dXiRv1_DTqW227isqOwdRj2_q17798mwl7dK6iev7NbeB
 t_L0tqqQYvHB-jjQRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdelhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
 kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:mDYBYLRcu9y7sSctEJAMf9Dicc1pqGhdfs6SkKkDsmi9ltIa91ogGg>
 <xmx:mDYBYMuc4yO7WGAOwXCFQIWj6HghCEpwk_F7PP2N8s54nrF4frM8DA>
 <xmx:mDYBYMfoL5hR4zb2tizZNhI61b3ydR6SiCoVPFHjLVon6_q4YVpZrg>
 <xmx:mTYBYBFk9XuIsMaPYvuVM8bTKNs3SDkoe6yCejutwd_1bv-oyYoGTg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1E284108005F;
 Fri, 15 Jan 2021 01:30:47 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Date: Fri, 15 Jan 2021 07:30:46 +0100
Message-Id: <20210115063046.274495-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_013050_784961_09A47C77 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Klaus Jensen <k.jensen@samsung.com>

Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
by the host.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 include/linux/nvme.h    |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50d9a20568a2..62eb83030a5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -23,6 +23,7 @@
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
@@ -1787,7 +1788,7 @@ static u32 nvme_cmb_size(struct nvme_dev *dev)
 
 static void nvme_map_cmb(struct nvme_dev *dev)
 {
-	u64 size, offset;
+	u64 size, offset, cmbmsc;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int bar;
@@ -1795,6 +1796,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (dev->cmb_size)
 		return;
 
+	if (NVME_CAP_CMBS(dev->ctrl.cap))
+		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
+
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
@@ -1808,6 +1812,13 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	if (NVME_CAP_CMBS(dev->ctrl.cap)) {
+		cmbmsc = pci_bus_address(pdev, bar) + offset;
+		cmbmsc |= (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
+
+		hi_lo_writeq(cmbmsc, dev->bar + NVME_REG_CMBMSC);
+	}
+
 	/*
 	 * Controllers may support a CMB size larger than their BAR,
 	 * for example, due to being behind a bridge. Reduce the CMB to
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
