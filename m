Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779AFFC6171
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWIdamZUV/daqLi0XaMr2NW2huZHn5RwNbZdv3Y9OBM=; b=H78cyAGwZwrCY2M7AI636ny6ba
	BgRcuEq5wiuo9D7buAmII1F8oMibGi9ETuS9v8vgFA+SzHAmizd9kKBigjFMxevxmzIAYURLnFLwT
	q2s5O+mCHd12Y3mnDBk/HcVDucO8Q+bjY+v792SQf3nXR0DyKHrBJRtuasHXKGCnYrto5+n7jGxpd
	PLG/ANl1c17XYvAJ5EoUx7WUG3jxXPRJ+ynHOYL+xFFXmHSYkLoRceU6aVL+i0gpUqZULTN6EMWPO
	kgzQs/dQ6CnpP9h9igjITe+faM1OXNi11/4VGzZ/iZz4HKtbuFJeocsVwLx0lH309mbZriccA5Fjb
	i3nDEOHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spC0h-0000000Gwdb-1jpc;
	Fri, 13 Sep 2024 19:31:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2d-0000000GoL2-1bOH
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:31 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2LlM003051
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=RWIdamZUV/daqLi0XaMr2NW2huZHn5RwNbZdv3Y9OBM=; b=
	LKbwMfgGhLRc6oJ2BAVl3N4UNTH0SbpitrSMMSwvxps3IanpH0HsvJwBegSkQLZo
	xtQ566wFijhLEAk03KoDXz1BBbHloLyTwHrO1FKFtf/6/L1HoQsF84eAzqeRnzyC
	LSFrPAKEdTC3Tkp6YWM5u1SkqT0tzhWK9Mp7vbheeubxhXn9/wjTBjFXMTfFlXUB
	RKR3VlKPCgf82TDnjBI/0mpBWSVax4EEin672AE/pkRlcCs9/CMMiY65qBaSjDS1
	MLEVQoNEUOx6IJ33S4q5lfutcHt/DAH5miwUtpufY+0Zs6kvOSX71cM+N1FJCH+U
	+19TRb7p1U7wFGscel6TFA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kha4qjc4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:09 -0700 (PDT)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8DC0712F9104F; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCHv5 7/9] nvme-rdma: use request to get integrity segments
Date: Fri, 13 Sep 2024 11:28:52 -0700
Message-ID: <20240913182854.2445457-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Q4OmSZS0sfvuthl27Oj_3Oac0c-ewLFy
X-Proofpoint-ORIG-GUID: Q4OmSZS0sfvuthl27Oj_3Oac0c-ewLFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112911_558334_28C456AA 
X-CRM114-Status: GOOD (  13.14  )
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

The request tracks the integrity segments already, so no need to recount
the segments again.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 15b5e06039a5f..256466bdaee7c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1496,7 +1496,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *=
ibdev, struct request *rq,
 		req->metadata_sgl->sg_table.sgl =3D
 			(struct scatterlist *)(req->metadata_sgl + 1);
 		ret =3D sg_alloc_table_chained(&req->metadata_sgl->sg_table,
-				blk_rq_count_integrity_sg(rq->q, rq->bio),
+				rq->nr_integrity_segments,
 				req->metadata_sgl->sg_table.sgl,
 				NVME_INLINE_METADATA_SG_CNT);
 		if (unlikely(ret)) {
--=20
2.43.5


