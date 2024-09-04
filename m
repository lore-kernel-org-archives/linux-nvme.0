Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA640CD4F20
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PAGpf/UPAc9rFDLEQebGE5/D0j//o/WEEpf7l0XZ+M=; b=y6jtIzR3tPoCePHX8hTncAgzO9
	uZ7cYGaOXTrp96fVvZs2eRmMOrPcl/T74NXRNJU2euvL1kszAXRu8fNJtrO+rb1VoEkiaqT8J/qp3
	Jo849bhIggIyqgGY6iB9k55f7hFf1oADa1fNEVN1lsaaaCKT7YLC+n2Iwt6WY8WwQRwBFckb/ht+g
	c0EH8nngAF6ytx4O7nwh61AEO3ditm0bSn6e05ap0l+WCwe++H13CQ9kx7yH0+Mvu5d8w9BOkI3To
	m+hvz9G78vGurHzU82t+3HhmAGmMBGr8Ed0djGbE3bSitLbAqM4feYVHfQolcEpKmCricfK0LSTiU
	uMw0Fr4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruD-00000004zXZ-1XgK;
	Wed, 04 Sep 2024 15:26:49 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slru9-00000004zW2-3QXv
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:47 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484F7NrT018169
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=/PAGpf/UPAc9rFDLEQebGE5/D0j//o/WEEpf7l0XZ+M=; b=
	WcZ8iVmHX9iXjyHoQrIn7V6wfWSmW8wfICQcMbWYb8nv2nMiEr/9JiGopqAio7r0
	NRhQYm5SUQarsIiM8qcC11WrSAhxQ2WedjIs9uZGJcPYGyjdydQpRv4s3tEImtIX
	Jky/3qOqyLss7LTdgh8mVM7Gg8m6r3T6uCirDD0pXJYb/Gb3gxdgbVgp2nAMpH6n
	TH6Nw4TzIKJTScciuvC/Vm8nLDtrd+ci4DC6Jc1Hiiaw0S5BkxHa8Ep0Bd1ALgJC
	rRpAEtojrzfOZ2ltWP6Y4qFbpbFNTcDvhL8231fRzKiI/eUtUDifE1zrplDQ8hEZ
	8jvvnJBmZbBPW+rn5L4x+g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eejbkfeg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:45 -0700 (PDT)
Received: from twshared4923.09.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B7C9312A036E7; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 03/10] scsi: use request helper to get integrity segments
Date: Wed, 4 Sep 2024 08:25:58 -0700
Message-ID: <20240904152605.4055570-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9mj0dyoEvEOoCpSLijlHE9yobleGLwyu
X-Proofpoint-GUID: 9mj0dyoEvEOoCpSLijlHE9yobleGLwyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082645_999321_4BD4C364 
X-CRM114-Status: GOOD (  11.49  )
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

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/scsi_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3958a6d14bf45..dc1a1644cbc0c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1175,8 +1175,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *=
cmd)
 			goto out_free_sgtables;
 		}
=20
-		ivecs =3D blk_rq_count_integrity_sg(rq->q, rq->bio);
-
+		ivecs =3D blk_rq_integrity_segments(rq);
 		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
 				prot_sdb->table.sgl,
 				SCSI_INLINE_PROT_SG_CNT)) {
--=20
2.43.5


