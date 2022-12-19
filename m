Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D24C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3KMpaWgtKsS8kGGCUyeaXHODO3jVBwhGRyjHeQQol2E=; b=HpBogrpR5HqzR6O8RnF7X0ad4J
	2FF9kR25XMrQUUiOR/ec6WMmKSiE5+LctHjBgUH40vIfA1ETTvRTXKnY/e0d7sya9TGZVH3ozvTot
	gIP6AwEgQi1G4l0nDYxu+h/1keLxqQ/UwTgTzYSAEIF1HsAsYfrRAMW8nWmrPzIwHSsdAe1n4fLbi
	Rs0fbfLhv0DBgITZj1FGUnHDNmGNV0ED9LMZ1DmYmxOvwp9wuUcJ1Dh87VECaMDTS6CZq5ue89g2P
	Rli9KzYA/+JSB8cjBnhqxLpCWCoQAYiBMKc7F9DqjZwXUMN4WeqgafWcr08VIjh8JHMDJjC0b1uw4
	QnBWXSZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7O6I-0049bs-QO; Mon, 19 Dec 2022 21:55:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7O6D-0049XQ-KN
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 21:55:07 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJK3BH0025215
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 13:55:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=3KMpaWgtKsS8kGGCUyeaXHODO3jVBwhGRyjHeQQol2E=;
 b=L7cSnLfYaSi01uynjjGYg1By83gLpDvyx6JkgpfRYcUqOXnvkgBlhYyKYdSVdzQnCbpA
 hdyfub/R6jfcnY0rH9RTMca+gkFwwdXubFs7PcUjY74ZNzZHvLn7DuRU+oyg5ruoLJdp
 mznU0K7EO0olPyQWNx5TKMBkl23hxAcSJiTwy/xEaC4+alZ+Z9weBeE5duPpz8oKpqRu
 22pfyyP/lLm1l083DeJGpRZ0NPyzJyhgSztSI7SooIDhmmkWIef+5h9Rg/8HJ5vg5G8Z
 PGV6lhYD8iLEGVvgLFljr49AxyRQbaJfcl/6c84L0/VnvJFl1MvhIaor+1245cfmlgbi 8g== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcg01vwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 13:55:03 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub104.TheFacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 13:55:02 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 13:55:01 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 48669D333B7D; Mon, 19 Dec 2022 13:54:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] nvme-pci: Fix page size checks
Date: Mon, 19 Dec 2022 13:54:55 -0800
Message-ID: <20221219215457.711617-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sUduMpYxz6bDBQshz5vbcOMQKCOaEXve
X-Proofpoint-ORIG-GUID: sUduMpYxz6bDBQshz5vbcOMQKCOaEXve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_135506_277895_F2907A2E 
X-CRM114-Status: GOOD (  15.76  )
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

The size allocated out of the dma pool is at most NVME_CTRL_PAGE_SIZE,
which may be smaller than the PAGE_SIZE.

Fixes: c61b82c7b7134 ("nvme-pci: fix PRP pool size")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fa182fcd4c3e8..f5e01861c881e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -36,7 +36,7 @@
 #define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
 #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
=20
-#define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
+#define SGES_PER_PAGE	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc=
))
=20
 /*
  * These can be higher, but we need to ensure that any command doesn't
@@ -382,7 +382,7 @@ static int nvme_pci_npages_prp(void)
 {
 	unsigned max_bytes =3D (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps =3D DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
-	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
+	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
=20
 /*
@@ -392,7 +392,7 @@ static int nvme_pci_npages_prp(void)
 static int nvme_pci_npages_sgl(void)
 {
 	return DIV_ROUND_UP(NVME_MAX_SEGS * sizeof(struct nvme_sgl_desc),
-			PAGE_SIZE);
+			NVME_CTRL_PAGE_SIZE);
 }
=20
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -708,7 +708,7 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc=
 *sge,
 		sge->length =3D cpu_to_le32(entries * sizeof(*sge));
 		sge->type =3D NVME_SGL_FMT_LAST_SEG_DESC << 4;
 	} else {
-		sge->length =3D cpu_to_le32(PAGE_SIZE);
+		sge->length =3D cpu_to_le32(NVME_CTRL_PAGE_SIZE);
 		sge->type =3D NVME_SGL_FMT_SEG_DESC << 4;
 	}
 }
--=20
2.30.2


