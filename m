Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AA8C7115D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YeAqGFD/xlXxbKWQdmK2afim53mngK1HgVKCLss+cJE=; b=URqCihMH0lN/ZZMSNdeL6+nQOl
	gGLcgj9HXqVOXtlPOypoaro1kSYcwM/veSiTrZk98fsUa6P8uV48N+4PgZ/AjpotamU8qmPdXgDIA
	Myow/j0+giycT1r217quewuMQ6cSaOM/NNIrpZjCTPifwpqPhwiifZY09l+JHjt+jvOn1jOwJ/JfM
	JF0OQ+lLp0QIXDvYk/N6pwrewsEA0QE1wdOHKCLUJYzS6PMERloVqmn+sQ/jtfwUcf7yiJh2j4O5y
	FgegdIvALaG19OcHuDy8ZDNwc2C+JtZOAcFRDNe8kuDCWTJi3SMRK4DLgC8KmmIKhhX1BLBGn8G7k
	waS3FUsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTaxe-00000001mlN-2VZr;
	Mon, 23 Jun 2025 06:47:22 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTarr-00000001lPy-0x5Z
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 06:41:25 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0SfFZ017235;
	Mon, 23 Jun 2025 06:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YeAqG
	FD/xlXxbKWQdmK2afim53mngK1HgVKCLss+cJE=; b=F0jmll2UlwZjKGWtK2e7Q
	j0yuIPhG5FMD32loIVNYBbC6ozJ/OmiPCP9r4s3OIafIT7FtNwBbfcBY/QiHOKlY
	Y8/Z3REKY3xTyzHPQbjAMRUKmnDoS9T3I7CIon5s5HEAS24NiSSnMTFm1p09qob9
	U95nEIpawSCDUmO/lwkOrRIIrpRQ3wv5Cro6JQfwxe9PMpwxVAujvNeBuYkD7rhx
	KtefKrRWsDbdfDxZL3R6i8vnHu6dof+tM3um50h//OUwfe0X06j0xhwEB+WoA2+p
	OfUHmpmugFq58xw1iZE22Bntip6phqK4XgKs8cAs0pDyf0xmdno1e5LGVpSDGqNd
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y20gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4kieW028823;
	Mon, 23 Jun 2025 06:41:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnfduq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55N6fAju006422;
	Mon, 23 Jun 2025 06:41:12 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpnfdt5-3;
	Mon, 23 Jun 2025 06:41:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
        corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] nvmet: Remove redundant assignment of error code in nvmet_ns_enable()
Date: Sun, 22 Jun 2025 23:40:21 -0700
Message-ID: <20250623064036.4187788-4-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230038
X-Proofpoint-ORIG-GUID: H2xUzxREbbDoLv2D2P7rMubS6q-x5DV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzOCBTYWx0ZWRfXz5dJ+iFtdUsQ SuZU4GAsiKOiLnzjVarCnsG3+dvxdUisoLQUxt+OjLdV+ol4VmXIPq6VaM2pbFufiUjIpxj+fg7 mpmGbD3X35NAjIwnURuUmjFGD/clEql5kBWKe/AkWXhV9f9NFPasdYSl3TpI9OJnp17cjoifnfA
 TIsu3TAwJSvMfuv5VP0v4Rs1j13j5pH1G6XXl8hrk0ZxfvJyZrtva1AfqCKYpPwC/UnUuI6tl+y o9Li/Ed9a0BaAr6+dfTE/Bl/zGWZmuEHBI9opvgrP7GeXNNJzbiU7XPL1FBIU4xgaxknS07pfoJ 561FKGeuFs1ccTZoa7agLmUvXNQ5TlFLEfXt1M/SgwEx7q8E6ZBWDwKPRvPTOCdljr+h6iwm5Jj
 4FuxC2n68lrMPJPdQ+hlYnIA5PJd/tZJwTGQmVsOPMKRmva0wVFP5ShdACoaSF3zfNyJMInm
X-Proofpoint-GUID: H2xUzxREbbDoLv2D2P7rMubS6q-x5DV_
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=6858f709 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=hQNXMjqaqMWDSZxnGksA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_234123_274879_54E0C329 
X-CRM114-Status: GOOD (  12.83  )
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

removing the unnecessary ret = -EMFILE; assignment since it is
immediately overwritten by the result of nvmet_bdev_ns_enable()
The initial value(-EMFILE) is redundant because it has no effect
on the code logic or outcome.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/nvme/target/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 175c5b6d4dd58..884286f90688a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -581,8 +581,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ret = -EMFILE;
-
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.46.0


