Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B72C25B78
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/vGbmu/PAKUCeEba7j1KwBf/wCw+w1GYtbnsE7nvHA0=; b=cvEqVsArrWuPpc3u5sjZHxXzN1
	OBngWV4KYjNfLb0Tz5ILAhyBN55MfekDzvoLYt1Kg5gbfvqD2fBv2Gdvi1QhwkgLQ+1MQWdoaYgTg
	A2UZkPteqQN4C1649tv5g7G+MYR4hgq7MXoUetMimJZvKa1sOpUK7cyJJhQwJ2r7DnqRc1h6eHl+p
	UUYz4Irkb69cayoGXrnNtvxwz9pC20EGQYXTbHrlG9y2g/i85p1HNndLSq8B1I8ACeDwljZuUVumE
	3oOtj06MS5Cks4BVV9Hk2MxHQ1BpgleKtiwIwH6CJExL+q7npk+g1rmg8tvcj++ePb9ikRSoUkAlG
	VbitzZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNn-00000003W2x-3RzF;
	Tue, 04 Jun 2024 18:59:43 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNk-00000003W0k-1OVd
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 18:59:41 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Hmglj006342
	for <linux-nvme@lists.infradead.org>; Tue, 4 Jun 2024 11:59:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=/vGbmu/PAKUCeEba7j1KwBf/wCw+w1GYtbnsE7nvHA0=;
 b=AxygG0WagF3JvxBb6vlxItVJgto1jUSgodnp2bNVq/QjsiCRBY1rQBRQqSeCR2KVizXn
 Lt+MFLLn7zyV4xfPvc5G+DcxF0y2idQibEdFI8uDrjk7Nap61VvcO/HZ3LzgPdSmSiKo
 Q1sQ8NWjVIPGc+vNmqEXShh2nQ9udZ7p64vQIZoEmvvXEfAHgVfzViD1OVl5SAMvCcES
 pZvxdF2Fi9RrxvaDJTWQhMh8KoiaOV/yqHvCK9aFhXGVCc2rDzIINlZRIkAU0Qx2Cz5h
 /KtDa8fgY8NzFOES+VS1NUQFoJgKHWVl4D+Zr1zr5XbN7DLPFemP475YR6CUC37cyMEr LQ== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhqbxpg8m-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 11:59:39 -0700
Received: from twshared55396.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 4 Jun 2024 18:59:37 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 3174535076CD; Tue,  4 Jun 2024 11:59:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, <james.smart@broadcom.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 2/5] nvme: tcp: split controller bringup handling
Date: Tue, 4 Jun 2024 11:59:05 -0700
Message-ID: <20240604185908.3703052-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604185908.3703052-1-kbusch@meta.com>
References: <20240604185908.3703052-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: J3doxEftGAEthoz2AbQzEQH2GkxjTxfD
X-Proofpoint-ORIG-GUID: J3doxEftGAEthoz2AbQzEQH2GkxjTxfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_115940_526261_E39304E8 
X-CRM114-Status: GOOD (  15.34  )
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
in the error goto label's, which harm readability.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83b..5ee3bbc67f411 100644
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
+		return ERR_CAST(ctrl);
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


