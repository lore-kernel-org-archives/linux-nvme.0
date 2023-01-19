Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC814C004D4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mNNdjqxlDmb9yw7VC7TkaauJ70dMQdMvEdky9A8HRNk=; b=l1Sn3CaopoSBKal4irHxugpF7j
	6e8VTe9hrcNIeIYHx+u+WusL/khjxe89H9YpFTBVa6svGcZPUKjKKO0IobkGe7nRn+Z9FpBDQpYex
	Wve4lKxapXuCqoGoQkvIhcWtNfezzFjojE/knMKn3jY6aC3lSlEe6yYuCZE+hR7azkT7OZRshMcYG
	RQssupqDUnpVRDb0MNPYXLV/R/fSJCscXncrfLxzNgcxD/77vWxR8jxJ8JNBztf8htqBYiyo7KGac
	lEr+k8IfYMe+ledjfyqiZizYd31/qaBvOIW+9gDMG1ncAwtTVt1/LRBWAiH/y7cIDU3k0E3KjfPNb
	igfi5tmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIXyz-0063g5-0N; Thu, 19 Jan 2023 16:41:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIXyt-0063b2-6p
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 16:41:42 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JCOICt018874
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jan 2023 08:41:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=mNNdjqxlDmb9yw7VC7TkaauJ70dMQdMvEdky9A8HRNk=;
 b=a1en+wPj4R0ZRaWE4Z10/9aSIY15NvOAIy4828h5QmXKIDzLcH/NLFKmDGNzuV4FIE73
 aZCoXwC+vbKdDPggOCXSLAgpVyL6LQbrndu/Ke8TGR1Q2aoBT06T7R7X0IuaGgkG7oXY
 0A2IPyYp2ECh7dFD9bXigqmk4JtpckOhu3/V3QDg9/Y8pcPBX7oqfcw0YbjTUdOuAHLd
 s6qvIH/kEgwVMvZ11Xr87Sx2ljhDgKXDx1Zqkd5o0wHcWvL1BVLuMtF1XG/LrsOmrQe3
 3pi3XQ2xDlKbXlyggcxie5p9PTyA2oZfx3BPbOSO6Ca+GytqWJaxxtjr1pkooi7aXLoQ xw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6vy6m3yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 19 Jan 2023 08:41:33 -0800
Received: from twshared21680.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 08:41:33 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E877CF580056; Thu, 19 Jan 2023 08:41:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme: always initialize known command effects
Date: Thu, 19 Jan 2023 08:41:28 -0800
Message-ID: <20230119164128.2159217-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0PTgb0CwYWfIYOzfxlDm9hybBekiRrLq
X-Proofpoint-GUID: 0PTgb0CwYWfIYOzfxlDm9hybBekiRrLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_084139_491606_3AF28093 
X-CRM114-Status: GOOD (  19.15  )
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
 drivers/nvme/host/core.c | 83 +++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa7..d7d2c2b342ba4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1060,41 +1060,12 @@ int nvme_submit_sync_cmd(struct request_queue *q,=
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
-		if (ns->head->ids.csi =3D=3D NVME_CAP_CSS_NVM)
-			effects |=3D nvme_known_nvm_effects(opcode);
+		effects =3D le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -1107,9 +1078,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, st=
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
@@ -3122,6 +3091,44 @@ static int nvme_init_non_mdts_limits(struct nvme_c=
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
+	}
+
+	nvme_init_known_nvm_effects(ctrl);
+	return 0;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -3135,12 +3142,6 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
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
@@ -3163,6 +3164,10 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
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


