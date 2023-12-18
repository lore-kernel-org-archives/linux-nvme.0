Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46493C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CO2MidZ9z9MKA8FTB/dilOtFanW1U7uOJwRO49Qie8Q=; b=yJ/ZO8CaQfXc7CPRlFunPqSIao
	tkdN+ktUZzn0YkKAK2FN4x5+thxEVEl0xMrrumpGHKa6ulRiMJPL6U9r5tE8FDY6ECyWx8ylc7vtE
	R89fpGwr+Luc3zW5n75DThgsfMfJk1YPmwPDD/G4B3yMEwAfN83HE1QoHZ5krTuAW8W+568yzjUwg
	x8Urh3WKkj5Jk1b7pE3Bwj5htCAjPfYpNV9Bcsx6g2wtqH3dzxpaSZu901irTvNQ05iH0RSkLXuK5
	HviRZvhhF/2PxozIUJWdZktImcLK9+Xv0iMBnZQEJOdvacRTHuQQCAoCllsYMApGhH/B1sj6Quyyq
	Z7c0ROFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGPz-00BRFu-1w;
	Mon, 18 Dec 2023 16:24:35 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGPv-00BRDU-2O
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 16:24:33 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI3nBln007206
	for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 08:24:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=CO2MidZ9z9MKA8FTB/dilOtFanW1U7uOJwRO49Qie8Q=;
 b=glfgbb3LB2DuC9VitoqHCptUUpMAZTNa7Le/04lkM6uRK3LyGIhdLjsblPvcDg+B17bm
 Hg+FS8C84YAJ/anSbF/2+uXnJcLUz0yORYjy4R0ZMQT/WhHxo5SUMvK2O4rEKT8hCudX
 /CCPSnmFN5Z2DNAj616FEhRvCqF9gir/h6DCE2Qt2JXathBEB32H58UsG9YfadybTbES
 QkEXdMp/8vJOeyMs6qbtYP9517pmvJW5sah92xZgqM/YvM/Ws/EdB1BhnF2+bnDlEvG0
 uoWUNSZ8chcmSUD2VNg7JhW0n7k/iurmhH9HvBzDmJMxFpmTKqXcSVUOf7t25D6e+eNr hg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v183nnt9u-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 08:24:28 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 18 Dec 2023 08:24:27 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3375B2346288B; Mon, 18 Dec 2023 08:24:11 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, <james.smart@broadcom.com>,
        Keith Busch
	<kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
        Maurizio Lombardi
	<mlombard@redhat.com>,
        Michael Liang <mliang@purestorage.com>
Subject: [PATCH] Revert "nvme-fc: fix race between error recovery and creating association"
Date: Mon, 18 Dec 2023 08:24:10 -0800
Message-ID: <20231218162410.1087788-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NxVeZs57SslUM_OmlSnSLas2Vh5mokQw
X-Proofpoint-ORIG-GUID: NxVeZs57SslUM_OmlSnSLas2Vh5mokQw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_11,2023-12-14_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_082432_016871_43303DC9 
X-CRM114-Status: GOOD (  14.60  )
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

The commit was identified to be might sleep in invalid context and is
blocking regression testing.

This reverts commit ee6fdc5055e916b1dd497f11260d4901c4c1e55e.

Link: https://lore.kernel.org/linux-nvme/hkhl56n665uvc6t5d6h3wtx7utkcorw4xl=
wi7d2t2bnonavhe6@xaan6pu43ap6/
Link: https://lists.infradead.org/pipermail/linux-nvme/2023-December/043756=
.html
Reported-by: Daniel Wagner <dwagner@suse.de>
Reported-by: Maurizio Lombardi <mlombard@redhat.com>
Cc: Michael Liang <mliang@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fb22976a36a89..1d51925ea67fd 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2548,24 +2548,17 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, c=
har *errmsg)
 	 * the controller.  Abort any ios on the association and let the
 	 * create_association error path resolve things.
 	 */
-	enum nvme_ctrl_state state;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrl->lock, flags);
-	state =3D ctrl->ctrl.state;
-	if (state =3D=3D NVME_CTRL_CONNECTING) {
-		set_bit(ASSOC_FAILED, &ctrl->flags);
-		spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (ctrl->ctrl.state =3D=3D NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		set_bit(ASSOC_FAILED, &ctrl->flags);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
 		return;
 	}
-	spin_unlock_irqrestore(&ctrl->lock, flags);
=20
 	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (state !=3D NVME_CTRL_LIVE)
+	if (ctrl->ctrl.state !=3D NVME_CTRL_LIVE)
 		return;
=20
 	dev_warn(ctrl->ctrl.device,
@@ -3180,16 +3173,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctr=
l)
 		else
 			ret =3D nvme_fc_recreate_io_queues(ctrl);
 	}
-
-	spin_lock_irqsave(&ctrl->lock, flags);
 	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
 		ret =3D -EIO;
-	if (ret) {
-		spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (ret)
 		goto out_term_aen_ops;
-	}
+
 	changed =3D nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	spin_unlock_irqrestore(&ctrl->lock, flags);
=20
 	ctrl->ctrl.nr_reconnects =3D 0;
=20
--=20
2.34.1


