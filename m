Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FFECD4857
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtkxDOQrx1Rg5NzxikIzXHuhR2yFcTtLhhIWMA6/swA=; b=SE917msH4LbuopSX2fUuVrypeg
	AQ91CQbF259Pls6Vn7/QSf2PywI4vxYjH8pFP4cOeTFj3hsi3YZy6ApNBra3lcmeLzJ+9ezi/fEcs
	zs55jLJI434f9loIytdf+Y89HEx49akVFknuP3h2MLaSpWHZPImNpfpzqzc1LN/HiIcY/WGXOG4j2
	NtOp9Y2FS5IGMFkTKhpO4aIMJtqBhogZ7q3263VELJ/5OJweQp9QXkE+RBZCXrsfqR7e54+Z6u8oD
	pj7jUxrjGGi5uaLIIWZxWBIaGzmZhoBCnYIvwgGetD3V5EfGbkcYtlm2mp4G5b1YrsWfJVvSHUGIH
	wNZbpvRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruH-00000004zbY-3wcM;
	Wed, 04 Sep 2024 15:26:53 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruE-00000004zXX-1GBc
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:51 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DoYWU030424
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=vtkxDOQrx1Rg5NzxikIzXHuhR2yFcTtLhhIWMA6/swA=; b=
	CzsZeyu+NICK0kL6N+7EH6c+Q2ef0hYEvS4+uyv6H+z2M4z1PRNqUcRTy/jtjmzx
	DvUOPc5SyoGrDuTFop/iebQfl3cJv85LExffkOiM1iuGSrsGvVTOd9Xk6ic2wdlW
	9tk5OpXDX16eRDgwauwVyHcXo7VTUG4b4t1GbZ5oaHoNxa7JIaNa6Vie1lH8Hdo4
	9qyDdJkzBWQhSJwyFyJEnBco/I3PmMffLxrlEbX7/6a9mjeHzeEG7M1bMNrrbfRN
	pMBt5UI+ls9t3QF3e2pNt8VJPRLm9OtCF2uWzPc51qGAaA+sPa60qiJBr/VU1hfR
	46GKo83b1Hsxv/qT961xew==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41e5y5xxc7-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:48 -0700 (PDT)
Received: from twshared4923.09.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id ADC0912A036E5; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 02/10] block: provide helper for nr_integrity_segments
Date: Wed, 4 Sep 2024 08:25:57 -0700
Message-ID: <20240904152605.4055570-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mklNUYUenf6OwhKybajWmYj06Ykjbf1g
X-Proofpoint-GUID: mklNUYUenf6OwhKybajWmYj06Ykjbf1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082650_477321_5332AF97 
X-CRM114-Status: GOOD (  10.24  )
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

This way drivers that want this value don't need to concern themselves
with the CONFIG_BLK_DEV_INTEGRITY setting.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8d304b1d16b15..3984aad9bf64a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -228,6 +228,18 @@ static inline unsigned short req_get_ioprio(struct r=
equest *req)
 	return req->ioprio;
 }
=20
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static inline unsigned short blk_rq_integrity_segments(struct request *r=
q)
+{
+	return rq->nr_integrity_segments;
+}
+#else
+static inline unsigned short blk_rq_integrity_segments(struct request *r=
q)
+{
+	return 0;
+}
+#endif
+
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
=20
 #define rq_dma_dir(rq) \
--=20
2.43.5


