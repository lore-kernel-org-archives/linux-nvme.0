Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F458EE57D0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXtaPgb+qvZzCCmfCvKuh+yhmFMjVQhQpX9blciC+FY=; b=w4yuS5aONCQdr1uTc0zlYEaY7o
	YtAsTlrNsGV0HKds4xqaoVf96yIXnGelKy3AYeelmmGek7ujqGpuph23glc0qVDjQj+5hskFf2IQW
	PPUIOyrPNhp7HHPNAoHgzjwpCP4F5BRB4j1Dcr3j1RQEZi08htDKp/07niKim4WTOg+ytdgAvFMY2
	zLcS/euBSp2HGdrmGmfs+IardVeZKf3861z0JMHl3gvTyc2m+N9xq1XsFdbycu/9CXulKcOg1CP5p
	rzbzU5EAJJfJP+ZxHtRkImyaP/uNFLH7E+st5ViWrk5RS7MIZl6SHL0pGCsAJ1AgUyPtItDaEhohC
	GmNw124Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTi7-0000000AqvO-06KM;
	Wed, 11 Sep 2024 20:13:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThv-0000000Aqkv-2WBY
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:57 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48BHjWcB004157
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=DXtaPgb+qvZzCCmfCvKuh+yhmFMjVQhQpX9blciC+FY=; b=
	YsjEMuYUTsSBN755HDJm+B6lwaH5xXA2582L+1+0UsJCx4UWxaoYuWZnluLltqJa
	Om1r9BUWJZfvZz39mDJTfIuLCDQGwx3Ebtx3TSp/JPiPAGZM8JS2O+q6YBV/Yc7o
	epKpGzkQjw7pLpDeSSBW8Dv8SaWUV6OZFrSyNDEjLekCSaArF10b9wA+dCsqZGlp
	L4H9p8mwECQcW/mG5mIY3hJxpzSO9XU8rxiV/wH/wRZeeHbddx5BcGVkI5/FDpX9
	WrTyJoLuL9DFGaeMEM18dGgZrGjV3PZBRFKk6UShyjAsZaFa/vF+3BK8N8DGFrNy
	Wj4udevGi7tXNnJfhtXhjA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41k44nnb2x-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:54 -0700 (PDT)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2BC5712E5EDB4; Wed, 11 Sep 2024 13:12:42 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 08/10] nvme-rdma: use request helper to get integrity segments
Date: Wed, 11 Sep 2024 13:12:38 -0700
Message-ID: <20240911201240.3982856-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HQACwXXkVCkL8e0zXWyaK4I3VvGBmz3K
X-Proofpoint-GUID: HQACwXXkVCkL8e0zXWyaK4I3VvGBmz3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131255_827722_3C28923F 
X-CRM114-Status: GOOD (  13.38  )
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

The request tracks the integrity segments already, so no need to
recount the segements again.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 15b5e06039a5f..537844ee906b3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1496,7 +1496,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *=
ibdev, struct request *rq,
 		req->metadata_sgl->sg_table.sgl =3D
 			(struct scatterlist *)(req->metadata_sgl + 1);
 		ret =3D sg_alloc_table_chained(&req->metadata_sgl->sg_table,
-				blk_rq_count_integrity_sg(rq->q, rq->bio),
+				blk_rq_nr_integrity_segments(rq),
 				req->metadata_sgl->sg_table.sgl,
 				NVME_INLINE_METADATA_SG_CNT);
 		if (unlikely(ret)) {
--=20
2.43.5


