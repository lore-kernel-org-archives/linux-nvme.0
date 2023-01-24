Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1EFC61D97
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EG0/DEWsl2+w822R6f1ZAJd4t5fNnBDTxjkme++ULU0=; b=RfAt5OVKtf+CbRRs4B2mBA2Cvh
	PdHM/PNDUK92CIaSdUZijU4rcb2WHp5O2eHL3zPgjnEx0Is5ZCQacAbiMnEIWXpGFfX1bZn3SOWNV
	I4+/0coPCpYz9vcko+xA4qDlBA8zAiROXthGRhlqNkQHd5kIaOrsLnirAfutAtTQLAX6/zXMecm1i
	nprmQcF8ikqvr9vHgsZ+VDs9L45JpGQKpnpEEx9kfLqFxw6f13E9hp3pCtwJrKzZw55SQqV3CiZbc
	YSxyAOL/5RSy8Qu6o+WgIXt6QJbj20H/Xj06aRQM+NdFwpIRsYRcmuPYqT05N+Z2WXClVE5QHUPM+
	L54vA9gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKQrE-005Q7J-04; Tue, 24 Jan 2023 21:29:32 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKQrB-005Q63-31
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 21:29:30 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30OLRJjJ027938
	for <linux-nvme@lists.infradead.org>; Tue, 24 Jan 2023 13:29:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=EG0/DEWsl2+w822R6f1ZAJd4t5fNnBDTxjkme++ULU0=;
 b=nwemHTdlxONKE3VJxA8e/R+LedlhaoPbBMkYa6D+mMwGyLok6BOWyZF3Fkx7aXdOiZZW
 jv3mQxY584pVkjLOsYOJFDX3ZyhgTBOMhhpD9mtgkejRNXRUewr3Stpu615pU2xdPtC5
 xuWmjA+W+EEPdM131u0VkXl6JVkW/rSBpoYG1lSwQnUpvIwyx6M1tB/a+LuQ9w/xfpbN
 bumH8ptR6IiJuMuXgolEzsTTjK7gA+ao8aBBjPX6uSMKdjC0wy5t5/IzHcJjZ9Vn6hGd
 GVT2WQaLsPtpVSjJaluE972mkFP0+rLDDt8CUvws7igRPkof5LyGNHVf1VvcrQzaJMxe VQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3nagrwu4py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 24 Jan 2023 13:29:25 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 24 Jan 2023 13:29:24 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id F3DF1FBFC1D2; Tue, 24 Jan 2023 13:29:14 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix passthrough csi check
Date: Tue, 24 Jan 2023 13:29:14 -0800
Message-ID: <20230124212914.4911-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pGoKTAI7NEoqqxsK9cE2rw0-2FIgVXRU
X-Proofpoint-GUID: pGoKTAI7NEoqqxsK9cE2rw0-2FIgVXRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_15,2023-01-24_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_132929_296300_6D318CA5 
X-CRM114-Status: GOOD (  15.67  )
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

The namespace head saves the Command Set Indicator enum, so use that
instead of the Command Set Selected. The two values are not the same.

Fixes: 831ed60c2aca2d ("nvme: also return I/O command effects from nvme_c=
ommand_effects")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d307ae4d8a575..2990ed331a1aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1093,7 +1093,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns, u8 opcode)
 	if (ns) {
 		if (ns->head->effects)
 			effects =3D le32_to_cpu(ns->head->effects->iocs[opcode]);
-		if (ns->head->ids.csi =3D=3D NVME_CAP_CSS_NVM)
+		if (ns->head->ids.csi =3D=3D NVME_CSI_NVM)
 			effects |=3D nvme_known_nvm_effects(opcode);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
--=20
2.30.2


