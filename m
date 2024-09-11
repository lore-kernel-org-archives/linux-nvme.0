Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF177EE57D1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCcbzM3MMHAMV620abi92+dMJQhH3HijYO4U0ETevPE=; b=wvzqseW8xUbzAemBOpgT2lgtxg
	iBWuHwNoeWq2vGEkvH7YbY13GDkBwSHn+j+w21IAR6UguAK8dmCoianlThgFgvksI5PXqjFTQz5V1
	t9HOQpXQ/yc0AwVXMj53Bf9gL2Ln8VjSbjqkYRnsonvG6W0BOPBD7xmERHZiC90oArI+1KmV3FIdY
	7OMR2olCWn7nGblJ9LXTGNuWADtZNlU2qtMypd91vFOfDNofLHCEZV1Msp81ImNd6H391BH1wE/3J
	FBVH2QUbXS9Q54tyuP9O757drDMKYv72rwW1Zl7VPam4124JJlKIPaK1fMeMfqJ6yyQV4sKFjGyHB
	dU96v2/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThx-0000000AqmC-0uKI;
	Wed, 11 Sep 2024 20:12:57 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThr-0000000Aqj2-2oC2
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:53 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48BHjWc0004157
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=qCcbzM3MMHAMV620abi92+dMJQhH3HijYO4U0ETevPE=; b=
	iWL94cyRzUWVIsjw9eySCKzyp26DhTVKz0SqbCxpYO5ea4n89S9DdMin69HDV5IJ
	et20WEKbf0mXvRZsO+Uf8cFK05GxHBgnUb2j+zb00vpifEmxrYBdlcZbGcb7MF6X
	EkDwJ07Wf8wrsP7FI0rWk9GRqnq2WpUmQM3zZlDA04fvm+mbSEgiRi8SHDAUP+el
	bKMGvb6HH7obev1iCYeeOGNeLSXQeNq6bDPQ/oNMbN6LXy8bwQ64+v0td7iBUJWj
	gPbjM0YY/4SZ/9BRGLsFg2GxJKHknncB8zJdJZtpz2EU1uh3IjqnaE7Bfb9ly9VS
	l23ch9/G7pegpSrL1z/4vg==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41k44nnb06-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:50 -0700 (PDT)
Received: from twshared25838.31.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 112E712E5EDB0; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 06/10] block: provide helper for nr_integrity_segments
Date: Wed, 11 Sep 2024 13:12:36 -0700
Message-ID: <20240911201240.3982856-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2xtNrGVabUVKs4_WWJdOGKYLCE3UH9lg
X-Proofpoint-GUID: 2xtNrGVabUVKs4_WWJdOGKYLCE3UH9lg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131251_852704_87F0182A 
X-CRM114-Status: GOOD (  11.70  )
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

Provide an integrity equivalent to blk_rq_nr_phys_segments().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681b..33557af495100 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1156,6 +1156,11 @@ static inline unsigned short blk_rq_nr_phys_segmen=
ts(struct request *rq)
 	return rq->nr_phys_segments;
 }
=20
+static inline unsigned short blk_rq_nr_integrity_segments(struct request=
 *rq)
+{
+	return rq->nr_integrity_segments;
+}
+
 /*
  * Number of discard segments (or ranges) the driver needs to fill in.
  * Each discard bio merged into a request is counted as one segment.
--=20
2.43.5


