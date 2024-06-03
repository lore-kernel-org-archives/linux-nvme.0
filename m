Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA3C25B78
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXCcfgyT3idg6cnJ8JBdzdzz49+J7yRzjPk0fA4r4ns=; b=kYB+xdGh8P/tF38RPGFB9kukCc
	ngyGSiOwHSESN6Rvz/XquMkpl1PPsR2UgPe/iA38gqnJYbTcEx//R1flpjFoMTmWQ0FkiOPNcEJR7
	+oOh6Q517ZWxKMlunYFsak+1XsCsQhrIv7JBL4cDOtmVeu0kgiA24GjclXWFO6vGzZWL8sISQc88b
	0gpViApTlqUUP/tjMeEx29Y2Jg/ubiH14ZUhUBfND80qDbu4jJmQKOV9CjqJhrJiJEpvL9CvTgPSh
	WgCEoDlCmBiz9ZB5A2HmSeGFjY6c6lZpF2t4VF8xigwos13VgaoqSwYOp+S5RcadtznmfBbZnZOL9
	M1y98jyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkU-00000000a9K-3gAU;
	Mon, 03 Jun 2024 23:05:54 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkS-00000000a7R-0q5I
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:05:53 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453N28oW024373
	for <linux-nvme@lists.infradead.org>; Mon, 3 Jun 2024 16:05:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=eXCcfgyT3idg6cnJ8JBdzdzz49+J7yRzjPk0fA4r4ns=;
 b=ebDhH8awp2pGCJv31mI748jm3a0xY64e3h4cdNdPDjYrIVTEUBA/385vfvVkn8BOzkDl
 I5JqwsX+Sg/UMPhfQYlI6u9hUvwqhqb4nF9G/30uo3RbNzkyV1OHh6eK2IhqSEfFwAac
 bK6Ub8m2s99qYFwOYW5GlT4KHiJb/hUq0YjHvWjeDNbtUWnNZ9wk11HM9AYyTgzGIw06
 LjqJSSx2e4D5G7LxsKHeulwA82/AGxLXnVmXs695S8aOXJ+lLr2gJFWEj4p15hF8JSOG
 dLPC/DXc4ZGQ246of8UJHXOQF9APo3vUtm+zRoVCgtrKLVyi9Dl5R22NCFPBiXP8Cjxp Iw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhq55r0ms-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 16:05:50 -0700
Received: from twshared24816.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 3 Jun 2024 23:05:31 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 3E18D3481EBE; Mon,  3 Jun 2024 16:05:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH-RFC 3/5] nvme: rdma: split controller bringup handling
Date: Mon, 3 Jun 2024 16:05:21 -0700
Message-ID: <20240603230524.3854115-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n4gMZF-S7puR3aybpcQf1vG5NQKcrtku
X-Proofpoint-GUID: n4gMZF-S7puR3aybpcQf1vG5NQKcrtku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_160552_288400_2D23B1D3 
X-CRM114-Status: GOOD (  14.75  )
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

Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
Split the allocation side out to make the error handling boundary easier
to navigate. The nvme rdma driver's error handling had different returns
in the error goto labels, which harm readability.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 51a62b0c645a7..dab8ade8e9489 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2237,12 +2237,11 @@ nvme_rdma_existing_controller(struct nvmf_ctrl_op=
tions *opts)
 	return found;
 }
=20
-static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
+static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
 	int ret;
-	bool changed;
=20
 	ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -2304,6 +2303,26 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(str=
uct device *dev,
 	if (ret)
 		goto out_kfree_queues;
=20
+	return ctrl;
+
+out_kfree_queues:
+	kfree(ctrl->queues);
+out_free_ctrl:
+	kfree(ctrl);
+	return ERR_PTR(ret);
+}
+
+static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
+		struct nvmf_ctrl_options *opts)
+{
+	struct nvme_rdma_ctrl *ctrl;
+	bool changed;
+	int ret;
+
+	ctrl =3D nvme_rdma_alloc_ctrl(dev, opts);
+	if (IS_ERR(ctrl))
+		return (struct nvme_ctrl *)ctrl;
+
 	changed =3D nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
=20
@@ -2326,11 +2345,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(str=
uct device *dev,
 	if (ret > 0)
 		ret =3D -EIO;
 	return ERR_PTR(ret);
-out_kfree_queues:
-	kfree(ctrl->queues);
-out_free_ctrl:
-	kfree(ctrl);
-	return ERR_PTR(ret);
 }
=20
 static struct nvmf_transport_ops nvme_rdma_transport =3D {
--=20
2.43.0


