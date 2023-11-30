Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE497C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g6elE72Qu/owK2C9fRSyKzoFUWtLP0XSLOvlJ9W7J4g=; b=GrxkjZBBRD8t2k36mLOm2tMDFQ
	9cXtqdz6TU/C4KZuwZSnvobK3jzpZVA9g2NSAFzQKICEaGesRoQcVN2SWdhGES9O745VWAJ0AyjRU
	2X/v777RMDZWgF6684Nt4Skjr1uE3qoABsozEfBmPHkuyzayaXzNjqRuj+O3EgNvnbpcipiaaWaVO
	buiENR+29gGwlPoITn3sa6KPkBNOtIur0RsgB0D5vY7Empy/H0u52Eyd0+6b0fzUdAt5LDgE1DjD/
	QiSIwD6jmZ54rMSffZ4Pi2TcZTndGojU//fSMF2oKDb45FFBR7v3EfS3EvLa4WglXICOA4kWiWEXB
	z3hGLl5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8nVc-00BphZ-0F;
	Thu, 30 Nov 2023 20:19:40 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8nVZ-00Bpgx-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 20:19:39 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUIeXrN003268
	for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 12:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=g6elE72Qu/owK2C9fRSyKzoFUWtLP0XSLOvlJ9W7J4g=;
 b=hr037noxh3tb4NoY4NpHyPwRrBqaQVqelm3v6WNDyzKW5yyiidjT8NPB0zLTXmFNMBEg
 2D7vJpOY3PVC+vICHN475ZOYPktBJSEfcjb+kH4Wj30LWhlma2uegYCNDRfZEKEx2gwB
 mICx5FAW+FqcMvCrazVA0mqoR95lcTSZqJdSchTm7ctlIHwaQW50WiDw2G8jRyQMnsGJ
 aWl4O8pzFTlOJSG2sW+ccfpp7QXfbtQFE9qryMujVcNicz8L+5mSDTPNQhWXtRHP07eq
 p1+aI2FuVPasaU5kN+mjE1YKLx/cokrixFeLfB39IAO5AzFu3Ly9iszICREByN76f1R1 rw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3updt8qmhn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 12:19:33 -0800
Received: from twshared6086.02.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 12:19:32 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 8327B226B1070; Thu, 30 Nov 2023 12:19:20 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-ioctl: move capable() admin check to the end
Date: Thu, 30 Nov 2023 12:19:19 -0800
Message-ID: <20231130201919.2486553-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nsGR-3P46VYjv-Oaf_Pv3IpmrF95e0pn
X-Proofpoint-GUID: nsGR-3P46VYjv-Oaf_Pv3IpmrF95e0pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_19,2023-11-30_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_121937_870199_6882A5F8 
X-CRM114-Status: GOOD (  18.23  )
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

This can be an expensive call on some distros. Move it to the end after
checking the cheaper ways to determine if the command is allowed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 32c9bcf491a33..4d4453743d62c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -18,15 +18,12 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, stru=
ct nvme_command *c,
 {
 	u32 effects;
=20
-	if (capable(CAP_SYS_ADMIN))
-		return true;
-
 	/*
 	 * Do not allow unprivileged passthrough on partitions, as that allows =
an
 	 * escape from the containment of the partition.
 	 */
 	if (flags & NVME_IOCTL_PARTITION)
-		return false;
+		goto admin;
=20
 	/*
 	 * Do not allow unprivileged processes to send vendor specific or fabri=
cs
@@ -34,7 +31,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct=
 nvme_command *c,
 	 */
 	if (c->common.opcode >=3D nvme_cmd_vendor_start ||
 	    c->common.opcode =3D=3D nvme_fabrics_command)
-		return false;
+		goto admin;
=20
 	/*
 	 * Do not allow unprivileged passthrough of admin commands except
@@ -53,7 +50,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct=
 nvme_command *c,
 				return true;
 			}
 		}
-		return false;
+		goto admin;
 	}
=20
 	/*
@@ -63,7 +60,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct=
 nvme_command *c,
 	 */
 	effects =3D nvme_command_effects(ns->ctrl, ns, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
-		return false;
+		goto admin;
=20
 	/*
 	 * Don't allow passthrough for command that have intrusive (or unknown)
@@ -72,16 +69,20 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, stru=
ct nvme_command *c,
 	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
 			NVME_CMD_EFFECTS_UUID_SEL |
 			NVME_CMD_EFFECTS_SCOPE_MASK))
-		return false;
+		goto admin;
=20
 	/*
 	 * Only allow I/O commands that transfer data to the controller or that
 	 * change the logical block contents if the file descriptor is open for
 	 * writing.
 	 */
-	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
-		return open_for_write;
+	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
+	    !open_for_write)
+		goto admin;
+
 	return true;
+admin:
+	return capable(CAP_SYS_ADMIN);
 }
=20
 /*
--=20
2.34.1


