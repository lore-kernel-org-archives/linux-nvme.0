Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2F1C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kAk319M+zQTIwJgoZngfMiGpMWfuk1qcs4eFYB4cZgQ=; b=QnLGTFadkpovW5ujii8ueGcLoF
	CfDbZPBWVy1gxixgu/z3YB+lnJZgs49KJ4wFq6a1WF6WvCtdvUV/afQnxT5u1DBt//QCIZ8P49cPn
	95qTco2hONgHPMWiUPZscv1wEOntICJ41ociHp38wsNlzH2377vVPm7BRJ9EOXUpcnHElCduYem/J
	sKlVTgEMlRONaFG3ORfPr/Ay5vxJRlIEOJ2TqXv+vauV9r92mxca3zBrD0lmiVLGQgY+jMF/AfM4+
	35/h/kUAEY1LbK07xwA7NuAijoa3vEdYWmyXj6EF7B1TRcN/rAiKHM8fJiZCl27/Pt+k3cCzi+rKo
	3m4am8Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLT9M-00F2Zb-0f;
	Thu, 04 Jan 2024 19:13:04 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLT9J-00F2Xk-0c
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 19:13:02 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HilCk015968
	for <linux-nvme@lists.infradead.org>; Thu, 4 Jan 2024 11:12:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=kAk319M+zQTIwJgoZngfMiGpMWfuk1qcs4eFYB4cZgQ=;
 b=e18p/Ag9xkNO5YuEq1iZsCZ0vA4dU5x5PFmAs5Ei4xMkUvI92xH6upFHaO99lqEnBEyj
 jZvXkqVowMdhUKvp5aFuOFsP6cY/IRvlilti5eRF2Qo9AZ+RQTf8WfClpr9YlDnGI0gb
 1m+utvca5FmOY8k1nb3CIccC/ccDhmcBV236TaPdYL/MTTjfSeqvA5eGySwk6ri3b9kq
 iRm0BqLPy+TilgBKrNP7cGLX3+K1K9CiWUmkpJ2OYyey2tI2boM0SqBtassTCtDn2Scw
 Zf3c1wVPV9hdtxxvPjhoiBv4o5s054lccMO3ALStkt5wXegFGGRkfFglgGVlFNTpPpxB ew== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ve1b80pbv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 11:12:57 -0800
Received: from twshared10216.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 4 Jan 2024 11:12:55 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id A95B623D67866; Thu,  4 Jan 2024 11:12:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: respect user max_discard_sectors setting
Date: Thu, 4 Jan 2024 11:12:44 -0800
Message-ID: <20240104191244.737208-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3GkqUNH-P4RyuFLlC3B8GftCaOiVieK4
X-Proofpoint-ORIG-GUID: 3GkqUNH-P4RyuFLlC3B8GftCaOiVieK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_111301_242060_C2A7B2D9 
X-CRM114-Status: GOOD (  16.59  )
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

From: Keith Busch <kbusch@kernel.org>

A user can change that attribute to 0 through sysfs, but they can't
change the hw limit. Check the hw limit instead to know if the driver
previously set up discard capabilities.

Fixes: 70200574cc229 ("block: remove QUEUE_FLAG_DISCARD")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50818dbcfa1ae..8d56c102974ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1748,7 +1748,7 @@ static void nvme_config_discard(struct nvme_ctrl *c=
trl, struct gendisk *disk,
 	 * updating the hardware limits when overridden through sysfs.  This is
 	 * harmless because discard limits in NVMe are purely advisory.
 	 */
-	if (queue->limits.max_discard_sectors)
+	if (queue->limits.max_hw_discard_sectors)
 		return;
=20
 	blk_queue_max_discard_sectors(queue, max_discard_sectors);
--=20
2.34.1


