Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9BBCD5BAA
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jP2sN46tVBszV8MtjTdzs0Z0jqFLvZfoYWZV/p8KOgI=; b=xw2ycUhuGEoNbmoRmPG+1MhkDR
	qF4xhtGwswLgmihGebXUe8L1arSrH3CtBlTxSY+GtrjyrBxVlG5PQ6aBa2kLIcdxIr3/m8bLmszUv
	M89uykVsV4U7H7/IBPYjP1aPItkhGXeS8SMyrwO6WJgHUEe4qIY/HQqbAh/vAun1WMQ1M4bedCwzg
	lY55AH+ALuPFW+zyfgKQZqblk2N11wcxqBhHVqBVNxzuCJgIGCfOVaIgGCXkJs6pwwKlZYJ90Bdg4
	qDMC+ZDxxPQh6zxrtBKIjrXKcO/nWCahEDpjMvw8koBwHtUz5167FyxRor2Hg+eIy6rctWmCerRDK
	NCWVq9XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPl3n-00000005LyM-0kqa;
	Wed, 20 May 2026 17:50:23 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPl3k-00000005LxR-39ne
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 17:50:22 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCibgY2117374
	for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 10:50:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=jP2sN46tVBszV8MtjT
	dzs0Z0jqFLvZfoYWZV/p8KOgI=; b=TUu5Y0xI5ElNCnmfPBc4axSgf7QfIuQ0XH
	zXIinNdzlt29gafxs6j0SiC66grv4nSWXUFahG4BMIPJubqrSPbH80lvMc4WDPtp
	jupXkR3NLx1LKgCR6hfU3N5/oWx9gq8UmY7qqnP4zapz0sEyPRkThTGKGjHRpg6a
	hrXev+kwKkRolKlKEuOZn66uecw8Iv2L3gYlK7q/xzr6vLHO2C4ad7UfORMj1LJr
	/30n9O6Q6Ci91beoyiJgkPWKr2zJ+D3Z028vzhPeLQVtY2GTqAzDeN1Y3vG5ERNQ
	PWfzP/P5awcD1fYqGn0wLq8OzFqsmN1amgIKAjPvfX+1meH/8z8w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8vj5qmgq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 10:50:18 -0700 (PDT)
Received: from twshared9871.01.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 20 May 2026 17:50:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 148F61AC8087C; Wed, 20 May 2026 10:50:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] nvme-pci: fix dma_vecs leak on p2p memory
Date: Wed, 20 May 2026 10:49:52 -0700
Message-ID: <20260520174953.2989852-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kbpB6N1CaGG-WgZvNBCJHFy2-UTeTpJs
X-Proofpoint-ORIG-GUID: kbpB6N1CaGG-WgZvNBCJHFy2-UTeTpJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NCBTYWx0ZWRfX2tPiEOfQan+G
 fZakxmlkW0d/phSYRmrJSHe3vrsIJINefHBm2Xr/QZyfydiyPXoh774hnxt+7i9fK37LWa31FUb
 GfLDxFPbe+QB0bWfondBYj6BhtrgfHmtWM6C+Ru330ZZYUVsmxsqrNHcbq7gV4iZhHxLmZ30qg+
 /AnZx4XwiyJj96AyT2QKOpLjdNJC/6QfRMKs7BYAJ7UVqpRNiK70+A+wvQL0It+ImHDw3WZJbfU
 4VvtOov1sP8r0ZE/x77FNmN1F7xNLOAXLJdULT5nuGaRlSTWKZTIaIQGjdc6SCfTmlnH4744JB0
 xIjyeaiyYagGU+B4IbVadfJimdf86a1Y59h2VWAz4btPXff5atcqt23hX+c+aDdLxb6ATksgP4F
 /vXDk/XjECizXXdVZd9i66Rl8ROOkWWFCNHLJ22QBaawT0DvDm2OOQ7aDDOzvkvbnge8jOoekB3
 XkNsLggKvV39M5LCGlA==
X-Authority-Analysis: v=2.4 cv=ZJvnX37b c=1 sm=1 tr=0 ts=6a0df45a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=18sGt-ITlrfkJqLZJRMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_105020_917566_DFAF0E98 
X-CRM114-Status: GOOD (  12.00  )
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

We don't unmap P2P memory, so allocating the dma_vec for it was being
leaked on completion.

Fixes: b8b7570a7ec87 ("nvme-pci: fix dma unmapping when using PRPs and no=
t using the IOVA mapping")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 139a10cd687f9..744b388eea956 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -966,7 +966,8 @@ static bool nvme_pci_prp_save_mapping(struct request =
*req,
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
=20
-	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev))
+	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev) ||
+	    iod->flags & IOD_DATA_P2P)
 		return true;
=20
 	if (!iod->nr_dma_vecs) {
--=20
2.53.0-Meta


