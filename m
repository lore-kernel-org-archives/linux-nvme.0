Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B08C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DVZesyw8054fYCo37bodGpTLzcbYYvhXEupFQIUWlbg=; b=AyXf167ZhB/aNUWYVfCThDuRRy
	oHnaBplxXy9rX7lQTGJZ9HD4flsPYp8b51Y3k3vgOQ5AVAH3dauY/BHF4ZJph+XxwaTblsWpLnquI
	d8Bv0iksZDbVqhW+W+QXqH7gSY1Un7lDcw8lCfJWIyNk/mvA/R6wpzcpIEZ2xqE7cMUNFnImdmVso
	hQaAZeTNCC0qSaPw04j5Tz2RcA4pHnHMrp9xdl06G62OhSnd97qy8JNwNmiAgVe6/+lBPS/B3M8Ul
	JyFjq/tXho4LkvI8pMlHzliUlOZaz9edEjkj0E85FPGA0vKGjQXQuNeBoWV72Hjxf3CGB2yNedW1h
	oLa6kgKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFeEI-00F3jN-2z;
	Tue, 19 Dec 2023 17:50:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFeEB-00F3eV-2U
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 17:50:06 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDWR1x015753
	for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 09:49:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=DVZesyw8054fYCo37bodGpTLzcbYYvhXEupFQIUWlbg=;
 b=M1mbe3Fqqmw2tZb8GASoQdvBGjJwEehqXi90WDTg5a3n2vIb0OK5XxndI+yPTAwapgjl
 KmDwHLZC2cch00cxXSiMNIMrsoXcfCc/Qsao3HwA69BJV0Oa3oRyiKQlKZbNNmAPevj4
 enu+ym9UW6Xg1nkR5WGYKhK/dSdkweCHoBNqyuHhd+Xb/Tvy+MzDBSxlHYOCUdbqS/ZG
 HMaRKQrHCE0wlIbWrRk+hSDGyy+41xkJ7SyTctVpS0FwdNZMNDf/YbV56LGru4xP87hG
 i92XA/TC4PqcYN+3Mrc65QXYDAljsVbL9YA+S0ASWFEjfFmldBXFyFF1XliAH4euap01 KQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v2xta63ta-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 09:49:55 -0800
Received: from twshared8457.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 19 Dec 2023 09:49:44 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id EADE523535867; Tue, 19 Dec 2023 09:49:34 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <james.smart@broadcom.com>
CC: <sagi@grimberg.me>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-fc: set numa_node after nvme_init_ctrl
Date: Tue, 19 Dec 2023 09:49:34 -0800
Message-ID: <20231219174934.20400-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dZT_q7i5Jww505JOKHHh5z8YOew2dz8r
X-Proofpoint-ORIG-GUID: dZT_q7i5Jww505JOKHHh5z8YOew2dz8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_095000_255345_DF47AC22 
X-CRM114-Status: GOOD (  15.26  )
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

nvme_init_ctrl() always sets ctrl->numa_node to NUMA_NO_NODE. Set the
desired value after that function call so it won't be overwritten.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9f9a3b35dc64d..2de506d58593b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3509,10 +3509,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_=
ctrl_options *opts,
=20
 	ctrl->ctrl.opts =3D opts;
 	ctrl->ctrl.nr_reconnects =3D 0;
-	if (lport->dev)
-		ctrl->ctrl.numa_node =3D dev_to_node(lport->dev);
-	else
-		ctrl->ctrl.numa_node =3D NUMA_NO_NODE;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport =3D lport;
 	ctrl->rport =3D rport;
@@ -3558,6 +3554,11 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_=
ctrl_options *opts,
 	if (ret)
 		goto out_free_queues;
=20
+	if (lport->dev)
+		ctrl->ctrl.numa_node =3D dev_to_node(lport->dev);
+	else
+		ctrl->ctrl.numa_node =3D NUMA_NO_NODE;
+
 	/* at this point, teardown path changes to ref counting on nvme ctrl */
=20
 	ret =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
--=20
2.34.1


