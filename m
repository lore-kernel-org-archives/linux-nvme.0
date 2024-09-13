Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BF9FA3750
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJlLK4m9aT2f6rk7dnQeBXLeEgmslFG5sIDCnnhlqKo=; b=gDSy7avXjCrtxS14csTQ2qSkXc
	2bWfhPZ17RM9+CtIZ4ZXW2Vt53iUYvvUKEw8lK2QNCAcGcciJNrOhn1wQEUcDIDHwTKXPebZR7FSU
	BWlPkRMgJ3lQFJ6SCqxiI1D+Nm43uAqwsBAARR9pYpB6ECu+ZeYYUQEeUXXpJpXDGj2ayv+2IABXV
	Db6tqGqrGfKgfFWpNO99SLUgpZq8u9Ro3Kn9BP3wPoE6pIhfHBYLxZlCRNYAbYCdWOsVYdSo01ZCd
	lRZ1XTp4vDaOKyIpeZspnfpZEBKHkEB2YVrvHadoKsAiCLvOpOv9E0cC86hJ5+iPDmAROmHYTmQvc
	+7hQ/xRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spC0k-0000000Gwex-2Qqr;
	Fri, 13 Sep 2024 19:31:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2m-0000000GoNQ-0f4D
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:50 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48DI29uZ031774
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=KJlLK4m9aT2f6rk7dnQeBXLeEgmslFG5sIDCnnhlqKo=; b=
	VgAm0THENlnROo0/l9H2cTlDi8sF5O+bTqkT0kOTCKkUyZ2EqmRHC6g1zC+14WB4
	M0wBiAX74vOZ8Xb9pAiN/C0gw7oFmvE71BCx+felSOgKbclP374T8Owmnn45JFkT
	j6M+Z1ovwTe1Z0uZ/WE+TM8040ThReWsBbDq3I4DOMnZppJIMDMloLmysdpCr6DF
	Fglugvj3m+0GlDxGMdRRsyELTChal3F7w/JQj+qRFiP+m4yPlqnIf1szcT7Uu9Hg
	tVE0EhsVgbM0+DmRktwzyQTTxHZn5o64dSo2ZycQLadKmk0e258ZHH4oV5oT25+Y
	KJdzi8eXeaGqFp/d8X8gQA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 41mpbqa2gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:19 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8186112F9104D; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCHv5 6/9] scsi: use request to get integrity segments
Date: Fri, 13 Sep 2024 11:28:51 -0700
Message-ID: <20240913182854.2445457-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: al45_MsA_ilwSTh-EadX7gYEKIH6bvav
X-Proofpoint-GUID: al45_MsA_ilwSTh-EadX7gYEKIH6bvav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112920_455666_3F489B66 
X-CRM114-Status: GOOD (  11.53  )
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
 drivers/scsi/scsi_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3958a6d14bf45..c602b0af745ca 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1175,8 +1175,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *=
cmd)
 			goto out_free_sgtables;
 		}
=20
-		ivecs =3D blk_rq_count_integrity_sg(rq->q, rq->bio);
-
+		ivecs =3D rq->nr_integrity_segments;
 		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
 				prot_sdb->table.sgl,
 				SCSI_INLINE_PROT_SG_CNT)) {
--=20
2.43.5


