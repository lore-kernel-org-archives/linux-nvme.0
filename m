Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22579EE57D1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8cRKiRl5NKOm63ZSLGj0D8iymZNlBQh+9sNZDJtyFzk=; b=bpL8YlsO/Rm2Cyea6TRNbd3HEj
	0M+/UHbINPHLE1FecX3jPxRnf/+Zf10/EqsAUxWjbOSMrUJUJ320Pi1WR/6qqj5TUZFo3iLMz6efZ
	FDQ/DTb9i3rC7IHd/fUaTyKCulqVkN9d1XuVTmeXBW7wmFY6dFFMBdJSmCy1ZpahM2SGxI089Z5RK
	mSHE6XUwNBN784b4dY4OGcTSN1K4WfFfENJEskv8h5ONxJj9t32vWGEz5OhxoIBwHIuZ8CdVGNcjX
	7XVw3elB7qv8AF5R1tltXk1CNwDxFWsnxQGKnwi3acSc9wXEuKA8Gc4FS+3DlSQuDhALXuPO9NP56
	TkZGP3lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTi5-0000000AqtJ-08aB;
	Wed, 11 Sep 2024 20:13:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThu-0000000Aqk9-14KP
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:55 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48BHjWc7004157
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=8cRKiRl5NKOm63ZSLGj0D8iymZNlBQh+9sNZDJtyFzk=; b=
	cBo0sXCgcTw++B7ULOzkI5aK+3vrqATygZb0dekpRVBb8kfZ84g05gM5qy0DH/qU
	ortDXFzhyEMjHOjMOMXRZc98hzOJwFyMShxXjUhdUZxA+YZ6h/CjKMKm397ZXfky
	n5zIN9CYK8Ypo8vJQQ7bhmJ7iWS8OQ/X+lFiWr7wpuSuSDTJAQntPRevjBwmNNWa
	Wv00tFTMNYdaUQjAwSw9T+aX5xj9SDsaicybcKJOLpYKffKFRpzztXXfy6FookKR
	JC9gHkUC2oYibyus/tWqWhoWHKdAGbVKbouiSgw4sYzfysRkjXQFpi24tsEUIhdu
	g3NH6rl9cZFXG0BQP+sqPQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41k44nnb2x-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:53 -0700 (PDT)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1E58912E5EDB2; Wed, 11 Sep 2024 13:12:42 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 07/10] scsi: use request helper to get integrity segments
Date: Wed, 11 Sep 2024 13:12:37 -0700
Message-ID: <20240911201240.3982856-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 57mLlWN3biMoEAS1vOmdkk0jgOT6ekfx
X-Proofpoint-GUID: 57mLlWN3biMoEAS1vOmdkk0jgOT6ekfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131254_436890_FBABDD5E 
X-CRM114-Status: GOOD (  11.78  )
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
the segements again.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/scsi_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3958a6d14bf45..fa59b54a8f4c6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1175,8 +1175,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *=
cmd)
 			goto out_free_sgtables;
 		}
=20
-		ivecs =3D blk_rq_count_integrity_sg(rq->q, rq->bio);
-
+		ivecs =3D blk_rq_nr_integrity_segments(rq);
 		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
 				prot_sdb->table.sgl,
 				SCSI_INLINE_PROT_SG_CNT)) {
--=20
2.43.5


