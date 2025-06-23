Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72317C7115D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6RhxZ4NYWYnwNolnd/NRWxzQE99/+94N9JG71P7TUE0=; b=IX9z1SWxKYZeF4tD3+HWha8156
	FrzebFqSFdkIUDQe9cC8nG/0YeAq6GaevjLltv0hIeo21lVi+Xfp89eTtqnK+wW+Rmwa3E47KzQuy
	Dc+XdE2pikL4IPktQko0V6pVY8PMFZFoCJA0a5x4i3/NjfDkHU+mFH8NbpnDxNjNBMZlUOBhExTWY
	xHoyou3KrO+5ClCVGL7Q0N5180vGvD95DhfrhqUWTAQkovh+/+hcLb1Y2f7o0oo1ebj/gV/xOHF0C
	ya2xU5b7MF5enZUAZkcBlpSAbfGup5ey6JL96NULHF+Mc4u0bVpeoeaRfGtVfKfIxlDIT616PMYMb
	W4r0IwIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTaxc-00000001mjP-27h9;
	Mon, 23 Jun 2025 06:47:20 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTarq-00000001lPT-1w8t
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 06:41:24 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0RYBm014906;
	Mon, 23 Jun 2025 06:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6RhxZ
	4NYWYnwNolnd/NRWxzQE99/+94N9JG71P7TUE0=; b=mvpire8qocfQxGZYV83O8
	LEFoW+HP9PU2z0v951boOFJXoBz7EiYyhnZyqPfwx+5rqYTHwrDo/QOm0O5aRbvV
	cm3b5Hxoe4AFiGdTVblNhhm4yaCPgrB21t9r4smSLZpVzfSKbyZPCnsK1g9HDV8c
	JArcdrrJXHssHGSwaeZJ/liYc4uOVegTLIaOBg2JMFervDFY3d3Uwb3rwO8TYrqT
	WSL4nDmmQWWgNufx3N4Jufjo/Y+nHeX1TGdhCpzkWFvSoNEsSn4Blg45E/qi28ng
	rq9iIy6npQrPhYCEs7+A6cvevA1098SRCkR7r8eP4H9OoJ677VvIvIr51ujZ+Pgv
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt18wjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4xtJR030685;
	Mon, 23 Jun 2025 06:41:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnfduc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55N6fAjs006422;
	Mon, 23 Jun 2025 06:41:11 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpnfdt5-2;
	Mon, 23 Jun 2025 06:41:11 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
        corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nvme: Fix incorrect variable in io cqes error message
Date: Sun, 22 Jun 2025 23:40:20 -0700
Message-ID: <20250623064036.4187788-3-alok.a.tiwari@oracle.com>
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
X-Proofpoint-GUID: 5JJfxtA_z4WTFMur-lkmZnxXOu7cA198
X-Proofpoint-ORIG-GUID: 5JJfxtA_z4WTFMur-lkmZnxXOu7cA198
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=6858f709 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=SRTLixNVdz0Y03tMcBAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzOCBTYWx0ZWRfX9r2QIbbfzSIE tNa1wAJozabi5VEgMP0o3GWt54ulo6PJ92UmZmyFcjMqtne9K0Dr/W3K7F7/0ACLJimedeKcW+W V5FzUDQR1LEP7QyeCeqgi7qd3RVC0vrZdVwWtTPDSL5lgX9Y6Xt7Pcta0dtihOk7geEO1XQ2UzU
 x95LqDgnujCHOd8r5fBa+RGalBhCRKWnn1e3/jf9zHwECBA6OF1emKiJLnh174DcAlIlhg79jpX mM64ro5tpXxBRWOjd919B2zpgYW4ji35/OKcLBT7sfJ3bnEzHAPdwqwRz3n2RMccUExoRJWAOyV CCNQBVo3dV2bqyoAg9C2CJ0JLSlb6WzRB+OZ0ar3pwxx/ivOYvmEtGwueDLVYhUTVAbahVB3Djf
 0RyfpQl5cPDIh9mBem5HbPZz6d0yxhIDd465qIR/1Lj7WMZbU/lhWVsstAudVk0B2Hv5BvqV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_234122_624040_B2123F8C 
X-CRM114-Status: GOOD (  12.99  )
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

Corrected the error log to print ctrl->io_cqes instead of
incorrectly using ctrl->io_sqes for the io cqes size check.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/nvme/target/pci-epf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a4295a5b8d280..44288d8f5aa11 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1860,7 +1860,7 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	ctrl->io_cqes = 1UL << nvmet_cc_iocqes(ctrl->cc);
 	if (ctrl->io_cqes < sizeof(struct nvme_completion)) {
 		dev_err(ctrl->dev, "Unsupported I/O CQES %zu (need %zu)\n",
-			ctrl->io_sqes, sizeof(struct nvme_completion));
+			ctrl->io_cqes, sizeof(struct nvme_completion));
 		goto err;
 	}
 
-- 
2.46.0


