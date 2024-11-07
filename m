Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22459D5D689
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmtcxKFhyAcXaLgIBU0/Ujl1rwVrSmbOeIcDOs2sJBM=; b=B/hHP1QlB/FEiIs2p7SUFPaMJw
	P5ycp6rF4SkTzvOlsRSR3J1Wd4etSk1CTpMD9tnocLZ0OlBBd5qLI/90OdQvFBwGPLz7lHMnFRtEP
	yNteOuKpIigbsntHzIvqR5F1YhvmSJN732E3dwFifTShcRnFrcthEBK1VXl8hht76MhQN+9sjihnM
	fC/pPRrlAnHUsnTBnPjzCj3JK0crakaxmt3BJ6SEBGgyV7W+5qYlENnRlNnUO+Vkf5z0U6WcXQqZV
	xaeaCNPzLgNwsyk5kVdNMVP0jESN0hBbjSAOv4Q0tuJc5exxEdjjEIvwoXO1xnYnKzDKZd/Hw7xD0
	sS/bIeEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98c8-00000008AAG-3H6M;
	Thu, 07 Nov 2024 19:56:20 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lt-000000086Zy-07Rf
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:34 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImVJB008391
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=mmtcxKFhyAcXaLgIBU0/Ujl1rwVrSmbOeIcDOs2sJBM=; b=UxtY2s1otHNz
	IrVC+OD/1netgYmBAP9QcWKV59sVCDrVTum/cZ09Gk03KUIBcMzXATWDxL9JjSEw
	K9fbEuWny4Nw6UJPMYIyTYphGPthkfncrGKTCbLK30a8ork0bxOxa4fOSx6Z6RtU
	fpVyxLoAozYSPUgI0+uXcz2vjX/O1yZjB3tRs69tarJmgcwFB2YErlL8u3EWHqd7
	l57zD9uf5+sWXYUkx2LNYx2iaplxPCmzH+o7/1vLr9WZ90V3P0qdBpuKPL69PrVG
	6wk5BEpSy0aXuSYwx+WRi3CYEL44qfU4I7aYkqYkOSWE5sASQDCH5UZn1mBRoTtb
	ONRnxgnuIA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ruk2bnv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:32 -0800 (PST)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 64A4C14DC39FE; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 06/13] nvmet: declare 2.1 version compliance
Date: Thu, 7 Nov 2024 11:38:41 -0800
Message-ID: <20241107193849.995554-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ssyVHqVVEwt8xHCxW3wyJNRMXRE_co5d
X-Proofpoint-ORIG-GUID: ssyVHqVVEwt8xHCxW3wyJNRMXRE_co5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113933_131711_362D626D 
X-CRM114-Status: GOOD (  10.76  )
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

The target driver implements all the mandatory logs, identifications,
features, and properties up to nvme sepcification 2.1.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d7532..f902a630a5cf4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -21,7 +21,7 @@
 #include <linux/radix-tree.h>
 #include <linux/t10-pi.h>
=20
-#define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
+#define NVMET_DEFAULT_VS		NVME_VS(2, 1, 0)
=20
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
--=20
2.43.5


