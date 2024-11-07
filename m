Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1833D5D688
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+pBuekStyvz/IOoN08a2IjvlXdeHIAi0alb67KzwY3w=; b=zDL8kFwjksNbJtWBAj7Mvmxxfa
	p2f7me2kUEsm8hbj1+r4SByfj2ez9kBEcflxJO3YybGFWfGadnmgzlCL/xKfOV7o0QICy/tMox010
	NeBlh+UKmniV5acRUOHOZlJsSghOzR1dFRbxODpoIDsns3cNx7QxaXMjL0X3QyvxIShDzGc61i+WX
	n7iiqcpY9lMUiD901V6tzPTMwQ1HSibem19+ZK81QzQ8GMCerq3Alvk36Vt4ip3YEwBM5QZH8e2PW
	GVVj1owNhWwEAMjeuFZU5FZW41VjGBaHsWkVdSzN0iv65krLyfBRQSduImIoknAUk5J3pf5LIb4js
	HU5AI7yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cS-00000008ARF-1had;
	Thu, 07 Nov 2024 19:56:40 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Ly-000000086d2-3Atg
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:40 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImOgA015822
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=+pBuekStyvz/IOoN08a2IjvlXdeHIAi0alb67KzwY3w=; b=OwLzCWZlMQgl
	MQW17HxsT4Eqzx4GngMFJOZpCEDtvDxdq2MfCN8U1r2pl8fDJuJ+AwNjXT6PBl+R
	AIbZAu6+M9AP3eZBkARQ4jSL8D/4Per7mQ/5572qvv2MZvf22A0+Irp4kaCUEDuv
	mMu0uLbw8AxIQuTcxlH7i2CAPAlHh0FA7Xp9uqRgRldwzCrKKddyh9SuhFC1x0Q6
	dV+sH0kaRx5CzWxDeA7Gq5mBfUXJIEstudRR0zbrhxp4dlKZAuxGN/3NErz/TWep
	juTbNnLmsvPssj0zMr16sityfIrlSx88j+Sv4yHhC4iNC86On6agu5ACrZbjWbeW
	ZggRCC0QCg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ry2hjj4t-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:38 -0800 (PST)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D486414DC3A10; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 13/13] nvmet: report ns's vwc not present
Date: Thu, 7 Nov 2024 11:38:48 -0800
Message-ID: <20241107193849.995554-14-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3KAeUSBXw7pJj6wCkri0cmT5PVZlgDN-
X-Proofpoint-GUID: 3KAeUSBXw7pJj6wCkri0cmT5PVZlgDN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113938_855670_14AD8176 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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

From: Guixin Liu <kanie@linux.alibaba.com>

Currently, we report that controller has vwc even though the ns may
not have vwc. Report ns's vwc not present when not buffered_io or
backdev doesn't have vwc.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 516af7b419189..f688d7fdf7d67 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -915,6 +915,9 @@ static void nvmet_execute_id_cs_indep(struct nvmet_re=
q *req)
 		id->nsattr |=3D NVME_NS_ATTR_RO;
 	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
 		id->nsfeat |=3D NVME_NS_ROTATIONAL;
+	if ((req->ns->file && !req->ns->buffered_io) ||
+	    (req->ns->bdev && !bdev_write_cache(req->ns->bdev)))
+		id->nsfeat |=3D NVME_NS_VWC_NOT_PRESENT;
=20
 	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 	kfree(id);
--=20
2.43.5


