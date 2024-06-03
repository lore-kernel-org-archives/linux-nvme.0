Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C775C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wcn4bx4b0ZQ8LlKZvIIYe10EqzewatO9IhP9Y7BaTI=; b=ZBwt4nH/SacFvTxfGmPUJO0tbh
	3fN66q8fDT2/yQ8b7iAy+wGPQ2s1tAmy1CM01JCeEPAtc2tQknQXGKpA0goVk8/Z9Tv+ir/pFkoDK
	hHAKdVSry7+mG11USAaeVr3Y9HVFEKEfiSM8KJ2rGDGmOPSLIB7zBBGY4Ch+ALShgLdi+UhTFBqyb
	xp9t4YzDEuXGylRqS7vv8s6wBRCI8omRqqdCU8bzFgrVAHQ77vEGddjzSVO+KYlO5xQhh5qA+PMuw
	xqbksf4tthL77Om0Gt62a0en/TxKQ8DnPs6DJQkkm3ZIEwns6e7rhMd9mVMR9pab6HjzC80v9reRX
	HptcAKMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkV-00000000a9u-3Kki;
	Mon, 03 Jun 2024 23:05:55 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkS-00000000a7j-0pvj
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:05:53 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453N28oY024373
	for <linux-nvme@lists.infradead.org>; Mon, 3 Jun 2024 16:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=6wcn4bx4b0ZQ8LlKZvIIYe10EqzewatO9IhP9Y7BaTI=;
 b=iF1E9VJgKY4s0PXJKEX4dMz2+uQKtPQM6RL8P9HLXJSuoD52QuknuKXH7XKhJh4uAi0B
 hMeNTa1/hkpdV1QaqwNqtw+8WmBsOYWh6Y8W5UvI66Qkz6U3uCmHOys8K3yXqZBhMu9y
 ki8jwZMCMfruWUQIDpvh581xLH8CyTMBJ5s6L3HYxUiUx16ipBKcRgaKuS5Ptdxf5LkH
 ZudWSKH+l0Lp0dA0dtdIqX34z8Cl9Tioxm/CsEQQlXbdW/P+KUt4s6B3AdsJQ4Ymqaax
 fGcmJGHt4nb/e1nwgCoHkK2edNeCVKJy8QJNED8rXMaTTSS+Gz2R4AEVC48MQMVh8B4o xg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhq55r0ms-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 16:05:51 -0700
Received: from twshared24816.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 3 Jun 2024 23:05:31 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 94C9B3481EC2; Mon,  3 Jun 2024 16:05:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH-RFC 4/5] nvme: fc: split controller bringup handling
Date: Mon, 3 Jun 2024 16:05:22 -0700
Message-ID: <20240603230524.3854115-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3K80FKeWTPQSWRq51YOOevLZsgUJAkIF
X-Proofpoint-GUID: 3K80FKeWTPQSWRq51YOOevLZsgUJAkIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_160552_287942_0D041710 
X-CRM114-Status: GOOD (  16.16  )
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
to navigate. The nvme fc driver's error handling had different returns
in the error goto labels, which harm readability.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fc.c | 43 ++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f0b0813327491..43bc8f16b3a78 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3444,12 +3444,11 @@ nvme_fc_existing_controller(struct nvme_fc_rport =
*rport,
 	return found;
 }
=20
-static struct nvme_ctrl *
-nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
+static struct nvme_fc_ctrl *
+nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
 {
 	struct nvme_fc_ctrl *ctrl;
-	unsigned long flags;
 	int ret, idx, ctrl_loss_tmo;
=20
 	if (!(rport->remoteport.port_role &
@@ -3538,7 +3537,31 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_=
ctrl_options *opts,
 	if (lport->dev)
 		ctrl->ctrl.numa_node =3D dev_to_node(lport->dev);
=20
-	/* at this point, teardown path changes to ref counting on nvme ctrl */
+	return ctrl;
+
+out_free_queues:
+	kfree(ctrl->queues);
+out_free_ida:
+	put_device(ctrl->dev);
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
+out_free_ctrl:
+	kfree(ctrl);
+out_fail:
+	/* exit via here doesn't follow ctlr ref points */
+	return ERR_PTR(ret);
+}
+
+static struct nvme_ctrl *
+nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
+	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
+{
+	struct nvme_fc_ctrl *ctrl;
+	unsigned long flags;
+	int ret;
+
+	ctrl =3D nvme_fc_alloc_ctrl(dev, opts, lport, rport);
+	if (IS_ERR(ctrl))
+		return (struct nvme_ctrl *)ctrl;
=20
 	ret =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
 			&nvme_fc_admin_mq_ops,
@@ -3597,20 +3620,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_=
ctrl_options *opts,
 	nvme_fc_rport_get(rport);
=20
 	return ERR_PTR(-EIO);
-
-out_free_queues:
-	kfree(ctrl->queues);
-out_free_ida:
-	put_device(ctrl->dev);
-	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-out_free_ctrl:
-	kfree(ctrl);
-out_fail:
-	/* exit via here doesn't follow ctlr ref points */
-	return ERR_PTR(ret);
 }
=20
-
 struct nvmet_fc_traddr {
 	u64	nn;
 	u64	pn;
--=20
2.43.0


