Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D36C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 05:00:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CDC6529C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 05:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CDC6529C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EFEO0atieJ+plCC9w3nwErATMXOQSdJaFrjy0V7zyqY=; b=d3lXkrKmdpC+/V0mseU1V2haF
	2PLEsKmAie4brpa+2bprhPtm/sNCcVDrgLAw9SA5wQxDWGecu61+jtATpQUYvwjdYzCupu1F7ZrJQ
	4FGcXMnJzSKq+cg/u93bp2jR7cbA1JFdsg05KaQCo5Q9o4O9e2GZJinavFHzTYaljS0fwh3FSqQjR
	2zz0fSp/T566bsZbpZTlRZUJZJMq/oFD7JX/DyTTi5Q/EDPFLTlwqHR8uOCKyZocEiBN2mpQOAS41
	qzsp9trIF6AxBGmSTAWEtA68eGJfPn/Gb2axrmrFECkO830mEFOasEIwQSaBzb18qkl2Hog0Ds0CK
	hyJYpdDlQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUTi-003lTs-Hl; Tue, 09 Mar 2021 05:00:18 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUT7-003lLT-2o
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:59:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265987; x=1646801987;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SGRlpZ+oPHidxawqK/XFJmAMf6rzuPqDZP9hNHqfBKA=;
 b=dHUC/RM9mHgFUyBKnP+HaLHLhjojLvcRpzeSdzrUXVxluywfcU5nPB3u
 pQR2ij6uVbDO+QkPbNFiDCMQSGfiv0Y0ilp4yvzMApWCZVddnHSvPzW88
 QgKAK5+mJJk7WysiZ1DST8qSewiXjW1IYGONSQo6gPz5nkpTm7xt6KMyC
 VbnECAKEUJc1jhtdVp0UbVyVLQu9sisgrBbFly92bdIZzkY1U1G0XO61K
 OL9wmUn+085XH/f770cD6RoOb6njCliVly5SFR8Tj6NhO+DXDfiztP4hq
 XPk5cqW/klgi2ryzH0NcV9Rai3XOJ1aRKfmGnUJmIf3popsZ3NnRYh8oF w==;
IronPort-SDR: uQoDvsi+jsqmQ8V+juTyiai6dDIOGWsT21iMHWzhugqvf3vXTu/OmdgYRBa0moV1IEHCjMBWCZ
 T4RVx31O4M8RBD35K9kdKJ/Q0Ukh9RDe2z2yuBLShWoSyC44wQDuQ2tg7Td2wPcajE2zp/fpwh
 NsxQLS7jUl0KeUEcnvm5ffHpvvoK3gliz8Aq62hoMS4cgbM+sC2j2fQfVyZH0v85ld96MsaxY3
 z1JG6nM0MLCxP55TH07QRGdSoSGEhBfDBD1ZK73FGBu/6rc6hp7c2RFKfKLnc8GJrwTT+oO0LK
 u00=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="266008613"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:59:44 +0800
IronPort-SDR: aJo/MQlCnZ7d9SzzizdoBDEA8LMzy1/WbBJ+arn66NmlrjGCEkiXTKW2ln/YC3h4L2nbN51Jo9
 GTJQ2X3BWUAABq7Ux2piUwQc9kgYKLFhawUcB0qwBG35aHJztjqM1znlu0gN2FHTDx/r9Qlxb+
 av6TUpjK5Je0318VZQFzytSRtkIIzk0aJMaE5jpqKu/qGz5JN6rB9J6fKFiYIBWDun718MpT5P
 TaaXK/wioZig6lUOoy/QUU9TQz3r7iRdIUI1wpAQ+51KtSs70Um6FEF5VInIfJkIbil8l2R4ko
 TjvOsiaxvG71hwrQ4SDWRyGb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:40:37 -0800
IronPort-SDR: RJaXEMC1LCsBLJ2Tawe57XaiINB/X7nBD8qEbO6dLXwlCO0Ma/Nui7fWMzxUXeFP3GD2ulRX/Z
 pPylUelDduh+1MH3kulPukBbuyTB9DhFByKYSACLGHAdu+/zLwrDT8EC1KM6ArD24BIUT7jSMo
 19XVOCMfSd/ztBvgD1kZs2fqrS8HpUgs2hF3+Bu2zSFrWjUQHV8aC5A+vykRpxmKkKchMfr5cO
 Ri7UzFggXj/CV1clmEQ6Xkjf2kh0Jg5yu0pKFMFWlVotmwVpEj04yyiWRnZsKouVDwPteLhDn5
 jvs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:59:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 8/8] nvme: add comments to nvme_zns_alloc_report_buffer
Date: Mon,  8 Mar 2021 20:58:23 -0800
Message-Id: <20210309045823.18545-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045941_539744_F2042891 
X-CRM114-Status: GOOD (  13.84  )
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
index c7e3ec561ba0..03778e0e368b 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -120,16 +120,38 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
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
