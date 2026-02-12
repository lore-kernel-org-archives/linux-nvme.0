Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1395EE3698
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7XTVZ013sAXQrGVwNTtLR+2DdO6KsekhbVl5CMTsfA=; b=YMBWLaPITUsX9MRPf9hsPJFwJg
	/mMBn/tEY+i/Gvesa7P6PH1MD4m8N3Kaqws9GE9PUCtQsuXwS2GG20vvMvirdjHdYHXUz3pxf+MVU
	bWA2xwbohr4MUSpNWw9Qoxk6fLmnNJf6V50tZ5Z1dz+Xumxeg5DCiZ1ncbcafAyqoTM4CeDdn/f2k
	uFHsTaDxmftVX8RAv5TBpLu+dUz8Rt4Q+Zzo693H5vkEfwZFAirei4Cdj99FGFeL1W2DZk0LnTNlU
	Nm7Vs8gGgRiAXvbyeUiwZpaujl5f9JHZ6WHD15GUHTUTC+lkheyytCsd/1lVHKjNMXqUBPT4rOJTL
	EivNVe5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr2-00000002NwB-1Eab;
	Thu, 12 Feb 2026 16:47:48 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZqz-00000002NvJ-1jAu
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 16:47:46 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CCcdcT3777876
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=e7XTVZ013sAXQrGVwNTtLR+2DdO6KsekhbVl5CMTsfA=; b=Feom1RQz/Cho
	Ag24NtRQ5B1U3PzbEa/8np2VIxKmV/LQrjzU0VwRww7S6WTP859kzJvon0+QAJoL
	Ig/sGrsvkD48vfOt4oAXREPCfudnO48tOQQ7XwIHmut418/qJLaB5oJp+90eJd9L
	uEur1fDi/ynI9zQuOhfDm85Wv878GDu9CpUqFi5TQ0WEw9Nf8LptPyYwTKms2Z4f
	i8FxHK0INY1lXQtw7cmngSwHhkGMmQzazGHg77bSfDvBJb6vid7nzwkeuCAj+knW
	UGIDEulY/q3mdRN7osS0ZzP0LFBpW7agbzj+GsaU8HdIstEEl11wUejfZuaMIdxD
	JR/puD6kgg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9f23an8s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:43 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 16:47:42 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 576D17A6B555; Thu, 12 Feb 2026 08:47:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/3] nvme-pci: ensure we're polling a polled queue
Date: Thu, 12 Feb 2026 08:47:31 -0800
Message-ID: <20260212164733.3006071-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212164733.3006071-1-kbusch@meta.com>
References: <20260212164733.3006071-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Yel3n6UV5VN7xKoqsRwtZ53dHAimw5LA
X-Authority-Analysis: v=2.4 cv=fOI0HJae c=1 sm=1 tr=0 ts=698e042f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=y5eEo3cvQwTL6TJZsNYA:9
X-Proofpoint-ORIG-GUID: Yel3n6UV5VN7xKoqsRwtZ53dHAimw5LA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyNiBTYWx0ZWRfX8fR+4xMUzkdc
 F288KGblxkePIWiFZs7Uy9JBvxVx7ROe3WYj1H+pNVseHn/avHQnSgUv7j6DsOazuASOypihr0m
 nTJVHZWCFwYX0lBHZiNlCpUHH82osSSKNcrx0xLVyi9bxOHiJf7j0tgyh6rVDEL1mTBfcnz/a9S
 giK0KQNjeKR9Nwt7Q2q9Cg59rB2zTgqM0NBVnY+2qwhJkNcegLq3lMJI3Mdlmqx+6dYfv0FdGLA
 XKaTfYOSjBDt8ftSRW+gUWs3fpF1n+rfIObvYHn6+FESUTCYU9thaKXh98ISQ96bRQYo56UD/Ve
 t9MYuRD8918Y7fm65FBU0J8iyKNY0j35yaIFYHFhMVZISjlPQ126Qs5RmDTtutfQ3XBuiqK+iqM
 4hosDpifIFSQVWJecT2r5TCTG8wbBQGba8JZLDLIgWsL27X6Abau0RCz+26fZaE3Owzn0SwkhYN
 fcyLorryrJ3x3IE4QTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_084745_570669_EE34B24A 
X-CRM114-Status: GOOD (  12.38  )
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

A user can change the polled queue count at run time. There's a brief
window during a reset where a hipri task may try to poll that queue
before the block layer has updated the queue maps, which would race with
the now interrupt driven queue and may cause double completions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0f2104326ab4..4ee4d7ead5a92 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1627,7 +1627,8 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, st=
ruct io_comp_batch *iob)
 	struct nvme_queue *nvmeq =3D hctx->driver_data;
 	bool found;
=20
-	if (!nvme_cqe_pending(nvmeq))
+	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
+	    !nvme_cqe_pending(nvmeq))
 		return 0;
=20
 	spin_lock(&nvmeq->cq_poll_lock);
--=20
2.47.3


