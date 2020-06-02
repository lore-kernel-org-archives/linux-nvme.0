Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ED1C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4543F2068D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KwpNYDmE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="apeExU1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4543F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fs1tCgOVM+ztkeSnFASNMH+M4T4WBxeP3Vn9gAbjZbA=; b=KwpNYDmEoCn2i6
	72zOok2sv+4GuoDqUR9e/HCrsHAh6tjgVSdNU4bGWv3EdSb3tYO8DPNqzpLw93tHys5kEZjw/OgVX
	pq0GG9PAOCyn0fdjtQUTJAMp6nO2JZIJnWC8jNk9GEqcS4Tf3jfgQP+oTR8wU7YFZyDPi0FWcGR0m
	p8RY9JOSjCLOhIcVxxbxBaHczzPQTmOKVEQJ2PrOtjynkiE5FphR0c9pb6V8VtGF630kzUvFmP+dI
	awbAOui4vPZfOfLsfP4/zaWD/eNTAUBPD1VRVRhz59nNLoreIG8yJyF3eEc/qieTmttZuLDwUHOFV
	aRynEaA+Nj3aLn7MPMnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jfwsB-0004tG-67; Tue, 02 Jun 2020 02:41:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfwry-0004h0-13
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 02:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591065698; x=1622601698;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bOJBAAW3CwUsq89p3TzonySceB/Ft9z91t+EHOHnV6c=;
 b=apeExU1/ZHXuJlh/M6wIBEe4e/GCFnoCgOtlkKC5MLA3IkN6Yuzs2wHd
 isHS1wi7Lnb9osrHm/Ic1CVjocAYVkJSkli4tYmsSA1d2QxX1hMr343DT
 ZiVG8XGvPbeX2PSXLN4pesqbXFRkKOPjX2Khz08V4BXifBbiAogx5tTtk
 FpHonLgB82GIGALsC+f7CdJntyX38xZKTZ+Yf4VYE5BvApEfQxF3RXv7A
 104g3EH6vQoGKpr3SVQJHX6WMXAXpnYz3UO442+HvGL9awGpKQw7fJwrc
 1p36ExYT6myLWxiL9hVk4yBtOUCx0ty6+dcYtBvDXczPmLiJTvB845XaF Q==;
IronPort-SDR: EwFN029Lebg3AUEUenjFxhN8tJQhm+M6KsIsImiirqcukDLFPosGtwZYuoAnIdS4xcbcOYbgof
 MDBR+KrMJdmdDn/yRiZEmW5/hsh2dGwGfpfd8HKQ0ghbrGbBz0kxyTxl3Vqj/YhRac4mGxXl8H
 nvK0naNsQwOFtV+dr6BN1SHdltzYTCZHS+KXTyPyJEVK6FASXkcfypqEgsYsXPyTEfoDvNNqfV
 4k3fA5PHwJRWkwpIOFTB78MyZxAzvq6zBwBZXeRX/zOT+DvX60/SwP7/ybuMyUuAzGePsESJOS
 N1M=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; d="scan'208";a="140415809"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 10:41:36 +0800
IronPort-SDR: etQdHac9qV3zjLyGvgncmvN8v7slTEd0mTGvc1r0qmKlUszeYt5jRBIxarE1qq5zDTRhl61DbI
 w4m4by9j94lF2ONx2G7rqUAQECLo6lN/0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 19:30:43 -0700
IronPort-SDR: NfszZ/1kiRjYv9GHFfLT5NtpdMvyBFhYG6so4mz35ebpPwibcCm+xpOv1FsI6l1v95R3Za5fzw
 U4rN/SXuvVmw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 19:41:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme-pci: use unsigned for io queue depth
Date: Mon,  1 Jun 2020 19:41:13 -0700
Message-Id: <20200602024114.5153-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_194138_149015_506046E8 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The NVMe PCIe declares module parameter io_queue_depth as int. Change
this to u16 as queue depth can never be negative. Now to reflect this
update module parameter getter function from param_get_int() ->
param_get_uint() and respective setter function with type of n changed
from int to u16 with param_set_int() to param_set_ushort(). Finally
update struct nvme_dev q_depth member to u16 and use u16 in min_t()
when calculating dev->q_depth in the nvme_pci_enable() (since q_depth is
now u16) and use unsigned int instead of int when calculating
dev->tagset.queue_depth as target variable tagset->queue_depth is of type
unsigned int in nvme_dev_add().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b307c06a783d..6bf8514bbbfb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -61,10 +61,10 @@ MODULE_PARM_DESC(sgl_threshold,
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
-	.get = param_get_int,
+	.get = param_get_uint,
 };
 
-static int io_queue_depth = 1024;
+static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
@@ -115,7 +115,7 @@ struct nvme_dev {
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
-	int q_depth;
+	u16 q_depth;
 	int io_sqes;
 	u32 db_stride;
 	void __iomem *bar;
@@ -151,13 +151,14 @@ struct nvme_dev {
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
-	int n = 0, ret;
+	int ret;
+	u16 n;
 
-	ret = kstrtoint(val, 10, &n);
+	ret = kstrtou16(val, 10, &n);
 	if (ret != 0 || n < 2)
 		return -EINVAL;
 
-	return param_set_int(val, kp);
+	return param_set_ushort(val, kp);
 }
 
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
@@ -2250,8 +2251,8 @@ static void nvme_dev_add(struct nvme_dev *dev)
 			dev->tagset.nr_maps++;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
-		dev->tagset.queue_depth =
-				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
+		dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
+						BLK_MQ_MAX_DEPTH) - 1;
 		dev->tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
@@ -2310,7 +2311,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+	dev->q_depth = min_t(u16, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
 	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
