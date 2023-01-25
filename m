Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06922C27C76
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jan 2023 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nhW7tFBCsciKzmXsA08QvCPgsfG/MDv3TQEupdaZIA=; b=eukYGI9NHcQjvIiD0Aj3Z/rbQx
	asqoUKOFmg3Y4O/1kvV5eNTD6j1Ktpnq3yhKK+5w/Ir2Rek0jAGuLCYHyOpLMhGjz0YocqyaglGZ2
	6lf7VB1b7HRl6g1bDXo1Pr3d+iDZUsuO5SxJpF5NT/K3rKhcf/mijCQRYs30zZ+SL7YsHBVf1amh0
	x/mwGvOwrkiZBow20EEpmJaGaoFXncAZd2vLP7JYiYPN1ReDNtuG1gu+V9SvRpwc3xh8csR5GDQ7Z
	/2B3scRcAp1xHMXCZAj5K0g7ELbFSkQLGrq3AqI+zI+JuW9eURr+fD86XRiUhdIURloASL4AFxTGp
	f1zJae9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkFJ-008IbO-Ju; Wed, 25 Jan 2023 18:11:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkFD-008IZF-KO
	for linux-nvme@lists.infradead.org; Wed, 25 Jan 2023 18:11:37 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30PGP4bI004699
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:11:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=2nhW7tFBCsciKzmXsA08QvCPgsfG/MDv3TQEupdaZIA=;
 b=P2pNbjeWYj8eO6sN9ieufbJmhoR5IANdJ/g6v7blBdUhgKsH/J/L88dfjWCEpIBdJ0cT
 MMQMBQQe26xs0dRF+0mqR3u+r4O5/uWh9X147i4tlphqypYEjFtrpU0CwatzfanwSpeg
 1jvQpBvFIYQHRbxyGzeUBc4wN67Fj4DKn1XA/sr3uvlqgmorhee9sHHgDUksUle1iCFX
 Th8eaXAp6T1MHOhrvmBcsLptwzc4X9mYAtuyk628wqiwZjmCRNQsq93rp5DraZKqQ2SK
 pHGBZNbeng7dXwhIL5uXXOa2DyeAk8pCRi/O5OggKxcDDNGszdxI0Aq6zxmg2NL4VoMA Kw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3nagrx0psa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:11:30 -0800
Received: from twshared9608.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Jan 2023 10:11:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CE27CFD0E99F; Wed, 25 Jan 2023 10:11:26 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@list.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] nvme: always initialize known command effects
Date: Wed, 25 Jan 2023 10:11:23 -0800
Message-ID: <20230125181124.395668-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230125181124.395668-1-kbusch@meta.com>
References: <20230125181124.395668-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XR9uBez6FaNuMZh9OM_gjsDgJ6gcysVV
X-Proofpoint-GUID: XR9uBez6FaNuMZh9OM_gjsDgJ6gcysVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_101135_829205_BFD52B49 
X-CRM114-Status: GOOD (  19.52  )
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

Instead of appending command effects flags per IO, set the known effects
flags the driver needs to react to just once during initial setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 84 +++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 564ce60bad148..df929ba9bcc21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1061,41 +1061,12 @@ int nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
=20
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
-			NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static u32 nvme_known_nvm_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_cmd_write:
-	case nvme_cmd_write_zeroes:
-	case nvme_cmd_write_uncor:
-		 return NVME_CMD_EFFECTS_LBCC;
-	default:
-		return 0;
-	}
-}
-
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 =
opcode)
 {
 	u32 effects =3D 0;
=20
 	if (ns) {
-		if (ns->head->effects)
-			effects =3D le32_to_cpu(ns->head->effects->iocs[opcode]);
-		if (ns->head->ids.csi =3D=3D NVME_CSI_NVM)
-			effects |=3D nvme_known_nvm_effects(opcode);
+		effects =3D le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -1108,9 +1079,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns, u8 opcode)
 		 */
 		effects &=3D ~NVME_CMD_EFFECTS_CSE_MASK;
 	} else {
-		if (ctrl->effects)
-			effects =3D le32_to_cpu(ctrl->effects->acs[opcode]);
-		effects |=3D nvme_known_admin_effects(opcode);
+		effects =3D le32_to_cpu(ctrl->effects->acs[opcode]);
 	}
=20
 	return effects;
@@ -3112,6 +3081,45 @@ static int nvme_init_non_mdts_limits(struct nvme_c=
trl *ctrl)
 	return ret;
 }
=20
+static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
+{
+	struct nvme_effects_log	*log =3D ctrl->effects;
+
+	log->acs[nvme_admin_format_nvm] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC =
|
+						NVME_CMD_EFFECTS_NCC |
+						NVME_CMD_EFFECTS_CSE_MASK);
+	log->acs[nvme_admin_sanitize_nvm] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBC=
C |
+						NVME_CMD_EFFECTS_CSE_MASK);
+
+	log->iocs[nvme_cmd_write] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
+	log->iocs[nvme_cmd_write_zeroes] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC=
);
+	log->iocs[nvme_cmd_write_uncor] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC)=
;
+}
+
+static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl=
 *id)
+{
+	int ret =3D 0;
+
+	if (ctrl->effects)
+		return 0;
+
+	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
+		ret =3D nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!ctrl->effects) {
+		ctrl->effects =3D kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
+		if (!ctrl->effects)
+			return -ENOMEM;
+		xa_store(&ctrl->cels, NVME_CSI_NVM, ctrl->effects, GFP_KERNEL);
+	}
+
+	nvme_init_known_nvm_effects(ctrl);
+	return 0;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -3125,12 +3133,6 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
rl)
 		return -EIO;
 	}
=20
-	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret =3D nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
-		if (ret < 0)
-			goto out_free;
-	}
-
 	if (!(ctrl->ops->flags & NVME_F_FABRICS))
 		ctrl->cntlid =3D le16_to_cpu(id->cntlid);
=20
@@ -3153,6 +3155,10 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
rl)
 		ret =3D nvme_init_subsystem(ctrl, id);
 		if (ret)
 			goto out_free;
+
+		ret =3D nvme_init_effects(ctrl, id);
+		if (ret)
+			goto out_free;
 	}
 	memcpy(ctrl->subsys->firmware_rev, id->fr,
 	       sizeof(ctrl->subsys->firmware_rev));
--=20
2.30.2


