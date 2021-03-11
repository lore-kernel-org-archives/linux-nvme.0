Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD717C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:40:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DF164FA1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DF164FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C73NPdxxWk4qIIB3lnZvftSD6WAbGkl0u09zSNq/sys=; b=SmrYeKdn6YiHdizopC+PrNjSm
	DT9767c34nR3AV7Fw7Dz723gc08+wVu+DUTtuKR3QSkdYk1+uXsGfXIw/DB5fjr/XDOdBQLNcn6iS
	QvXZSCM23Oez0AeJh+v7it1NTpWcPn/3LTnXpqhmlroP3pW7eFHYqRcmwBxiR+lzpF3xJgeOgnEKC
	2kTbgctNjuzyEh5miCSJe7MYGOomIaWsAs/7i0JzOaiHJCCwIEGwTlv6eckNhIoTa/S5op3hGUojM
	Cy8STVhBggrgz95Xb7vhhQERgUOT+n/8fX/vKMZ62HmCKikb9ZEaV2hbZ1Db9dZRJMHcBRrOIK4Kg
	6p7QkQH7g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKD7M-008LxG-7d; Thu, 11 Mar 2021 04:40:12 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKD7B-008Lu2-9N
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 04:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615437601; x=1646973601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rbfCz08vYMYTjfDeoLyHLdhicuh1FFUyA8DOwm0zqRg=;
 b=VuG7757s6+hVADLVOnckhgLFAt72yFXtUIRjYLHWCkmOlbcjKrsMtxMn
 EKRRXMO4eg5nAiwox95tKGadsmYx+LKp1QCzWLSZMvITVmei8QEFrQLTh
 TkWN/1YisrWoJGgrhRk/uPzavWkFuyyWdzkuwONk40n4SM2lqau50Bjcv
 5TVLwkKSKMPt20sfHTiP3inL2xUeQGrtuW9cesv4wjSyNxd1hiJwZDo8t
 b4XOs2zsLkzZNA3SP60SwUovFrtinSZQBcTCwExgRHa8AWWuHzTWM6yrj
 FHsEs0gPQaTxw7dxGXQ8mmvMbEnP4TT8FXrF5bi9vsDifngHCAQvn+vUt w==;
IronPort-SDR: na4TUNfE4Esij2YQjdOkKL5P3piLDE84pr/yi6hU0krMPHGSVAgumpPKsHrAPEsnJSoxqxkZ75
 haW8tt0t4ZBWsBQRNVO85htOqN0CyQAr39FgMH136HwFPhrNHv/u4e7ezx88wYx+FC0Q6qrDov
 BXG1l8orOkGYupuF19/B//+anjqn95wPT3IOEewOk9NWwTy7lf8AEVIRTjPUz/8gqNx0ZFDQAx
 vitFfVUzCiRRRKOX1cKpe5pdTmTyLW0vLEwghc25uf4Zr33oRdBHwF69QZjkJrxdswKQCHtATE
 g2Y=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="272567020"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 12:39:55 +0800
IronPort-SDR: uuFk5jEptaNqmIkRuwrXRrGn0YwANkMxnp5DqrZJBygEHED0m5kjJe5nNCpbhZ4tIt4h/K4Qih
 NvaF+1GXlp0KHoN0TyW1E+4cfjsFrIeqjHpXrIYlPD/B6Bw5zNURNMl8BIwT+Uw+6d+XjEX9lJ
 +jefPpl9otH1iQNP7TWo4ezqzxggv/E7WdgnM1aqdqVmj42N+rpyM3o9/Pfdrnu/tW4VL3ksD7
 92xP0grxflbdDNxf66iQHpBZbnEH/qvgvUzrBBo4seDwkKK+IiXsbe90nwKgcLtmbsavzBpE9m
 aK0ql0J+tKcmOhtKgO6+WvU0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:20:50 -0800
IronPort-SDR: kY1fp8YYc4tz6cZtyxLUls+FGL7lkJURxuHO0Q6JJlg/BNDBizHuRYNjCUTT1H5SVMGeYNuN4+
 2e24SfAfv14bASKMelWzNJ2UTff7TGDW9w3uAjXUVTqbu+K1GI74uFlsrqJLo25wC5nLA93tRG
 +Z/cKXkRrM+ufm8Zk5FXLN6xLPPOu3fTXpFV/LubdQuqzvKYUQEPN7DTIX0WsmLIPIbwzqFAVQ
 FAVA5z4OlWMkGPoSSNZ2YSzOLMnBSXdjksroGxi6D7x8F1cS8e4tQT2gc7q3j8rVmluz9HXmJ0
 abs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2021 20:39:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V11 4/4] nvme: add comments to nvme_zns_alloc_report_buffer
Date: Wed, 10 Mar 2021 20:39:08 -0800
Message-Id: <20210311043908.26146-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_044001_847767_19ACCE16 
X-CRM114-Status: GOOD (  14.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The report zone buffer calculation is dependent nvme report zones
header, nvme report zone descriptor and on the various block
layer request queue attributes such as queue_max_hw_sectors(),
queue_max_segments(). These queue_XXX attributes are calculated on
different ctrl values in the nvme-core.

Add clear comments about what values we are using and how they are
calculated based on the controller's attributes.

This is needed since when referencing the code after long time it is not
straight forward to understand how we calculate the buffer size given
that there are variables and ctrl attributes involved.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/zns.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index bc2f344f0ae0..c2d08d9cc269 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -125,16 +125,38 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	size_t bufsize;
 	void *buf;
 
+	/*
+	 * Set the minimum buffer size for report zone header and one zone
+	 * descriptor.
+	 */
 	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
 				   sizeof(struct nvme_zone_descriptor);
 
+	/*
+	 * Recalculate the number of zones based on disk size of zone size.
+	 */
 	nr_zones = min_t(unsigned int, nr_zones,
 			 get_capacity(ns->disk) >> ilog2(ns->zsze));
 
+	/*
+	 * Calculate the buffer size based on the report zone header and number
+	 * of zone descriptors are required for each zone.
+	 */
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
+
+	/*
+	 * Recalculate and Limit the buffer size to queue max hw sectors. For
+	 * NVMe queue max hw sectors are calcualted based on controller's
+	 * Maximum Data Transfer Size (MDTS).
+	 */
 	bufsize = min_t(size_t, bufsize,
 			queue_max_hw_sectors(q) << SECTOR_SHIFT);
+	/*
+	 * Recalculate and Limit the buffer size to queue max segments. For
+	 * NVMe queue max segments are calculated based on how many controller
+	 * pages are needed to fit the max hw sectors.
+	 */
 	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
 
 	while (bufsize >= min_bufsize) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
