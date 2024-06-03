Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCABC25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5bR3bY6o22kgHifcQDlmTetHExUvDKJF6pKOMX9Nyg=; b=s4OIXGO6ZRxE1hQOHdraAdwPNh
	nWGAaTiSF7Y7dbbZWdj3MulzLTyaAqoums4N2dmc20fgGeC/R64u0gamD9HvHaNhQtzdeXKR5ofcY
	/kieDCwG1QdHIRU8uBLeGqzb+WWU/4mPYqWTvSGpg2GFXz2E8yjCzdb66dtOB049Z7BGd6ih4ozN0
	OkJVNt6KHpaQUcZ8+rT6HLd16LhgF67FEap2H9b2e3r4/0W/FvGkJyneyYvMxlnrUwRJWGEyxtt4R
	uRGVA2sQfvHrt7szHBbARa+7nWIpDlh4coZY45keV5Dm2bY6ybkzKBj1XgqLSE7yuKnJwci/Q/d1j
	7+0116JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGl5-00000000aMh-0jZo;
	Mon, 03 Jun 2024 23:06:31 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkz-00000000aL6-3Er8
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:06:29 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 453MxXGZ001702
	for <linux-nvme@lists.infradead.org>; Mon, 3 Jun 2024 16:06:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=t5bR3bY6o22kgHifcQDlmTetHExUvDKJF6pKOMX9Nyg=;
 b=HwOpRcBFAvLEyC/+GH2LBm89VwIk26klPitFcBNhkFIo5W7piDMFsfRpXy9Fkc3btEzp
 /yz8Hg8cZr5MBkFik3Tp9QXGDxQ9JzLreE3ynNfbxOzsvSQFgOgLqeeV8Y/Oz4b87Cyj
 NQn06f5gpeBy5y6YuJFvBDkwsxSZYuJluCB6PdlTQfASSr708ZhocMNfyCyRg5gcCsxc
 U/5QHnYc/zl2O7qZn0vgcynXA5vLmiKJBubTMijFerJ29iB1pRyj2mwo0f6D4fcqQ3Kj
 YLBPAOqnUiHxWlccqYC4HlDULEC36b69uhmhIQOvT25BowRbOJpAD6DHUypIlLSr/d2p bA== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by m0001303.ppops.net (PPS) with ESMTPS id 3yhq42r15x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 16:06:24 -0700
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 3 Jun 2024 23:05:36 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 063D03481EBB; Mon,  3 Jun 2024 16:05:25 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH-RFC 2/5] nvme: tcp: split controller bringup handling
Date: Mon, 3 Jun 2024 16:05:20 -0700
Message-ID: <20240603230524.3854115-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xt7BkcsK_-7rnu1wO6CAnLE06CC4QOe9
X-Proofpoint-GUID: xt7BkcsK_-7rnu1wO6CAnLE06CC4QOe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_160626_033801_FF627D64 
X-CRM114-Status: GOOD (  15.08  )
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
to navigate. The nvme tcp driver's error handling had different returns
in the error goto labels, which harm readability.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83b..7f75d01dcbed0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2686,7 +2686,7 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_optio=
ns *opts)
 	return found;
 }
=20
-static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
+static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
@@ -2761,6 +2761,24 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
 	if (ret)
 		goto out_kfree_queues;
=20
+	return ctrl;
+out_kfree_queues:
+	kfree(ctrl->queues);
+out_free_ctrl:
+	kfree(ctrl);
+	return ERR_PTR(ret);
+}
+
+static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
+		struct nvmf_ctrl_options *opts)
+{
+	struct nvme_tcp_ctrl *ctrl;
+	int ret;
+
+	ctrl =3D nvme_tcp_alloc_ctrl(dev, opts);
+	if (IS_ERR(ctrl))
+		return (struct nvme_ctrl *)ctrl;
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		WARN_ON_ONCE(1);
 		ret =3D -EINTR;
@@ -2786,11 +2804,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
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
 static struct nvmf_transport_ops nvme_tcp_transport =3D {
--=20
2.43.0


