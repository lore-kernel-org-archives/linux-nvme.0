Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381A0C3DA7A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jan 2023 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjSzvjm7rcB/zsJt8PhcUDcoiYavpJcbX7kIhKdt0bU=; b=IAvV3buXZvXzJ4WWIZhRqUKrLL
	4ogEaAxpJqj5VURDhhswYeOCQKaCL8wfseoIFZxJJTEJUt7JrUbb7D2bFoGdVkgFYBvpqk23JfQzC
	jAWe7i8hcTX0Ydhr5jKOnOFtkEwgYkdftbFNx86C28rcz3JgcdNUOC/+pc95HUBygyMmKS6xCM8eR
	iCP45AqRJPx75mdv18uf/PsZKlxbtdlYDgoBX82G50DPkF1YS4PZh5MUY8inzk6BNILsdnZb4C7c1
	KNDBsfv5aoEwtGHiHQhG5FQLHTy3MXJ84/7Sj3pEUOLh7X/z2PjlX1XazfK3kkVD47iG/zsTlDkrs
	kdje5xag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDZZ5-00G5ix-Az; Thu, 05 Jan 2023 23:22:27 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDWr3-00EYM8-H1
	for linux-nvme@lists.infradead.org; Thu, 05 Jan 2023 20:28:52 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305HtFsC011951
	for <linux-nvme@lists.infradead.org>; Thu, 5 Jan 2023 12:28:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=IjSzvjm7rcB/zsJt8PhcUDcoiYavpJcbX7kIhKdt0bU=;
 b=i50gTwiUdvQyPk7Z8M9yleQs0g/ua5cbYMMiZE1pz1tcN3y4fdyNzxAfxuICWb2bEZ/s
 tOVEJzcK0/9gFBGL9O6G/59CuRk69mXn+f8NUaQgGHSN/762uW1LhxAR+8y0ItuoQ97t
 AWIhGo+bbvTrmvLkjYWU3RgWmXepdg/0uCHpt48NnXS0muvopxa2A4n+0Rfq1FtZnyMc
 b+DaCcAqunxtnX9TJdfqXvKiBWjrN/0ennWFq+lFOFCfVDXZw8D9xB1ujwUMDpbi2bj+
 xCcW/obXZUIiE7cCQx2rfnwTF3XTk2HfWWoA0WC5k7+fDmFkQjzRSRYHWzq8oGxBqKYM eQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mwnjyn8b5-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Jan 2023 12:28:45 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:28:42 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 5548BE457D81; Thu,  5 Jan 2023 12:28:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/4] nvme: always initialize known command effects
Date: Thu, 5 Jan 2023 12:28:33 -0800
Message-ID: <20230105202833.3225645-5-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105202833.3225645-1-kbusch@meta.com>
References: <20230105202833.3225645-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BqpDoWdZlcS9yvziUfRW_cLbVVWworEJ
X-Proofpoint-GUID: BqpDoWdZlcS9yvziUfRW_cLbVVWworEJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_11,2023-01-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230105_122849_705776_F9E8EB11 
X-CRM114-Status: GOOD (  19.23  )
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
 drivers/nvme/host/core.c | 81 +++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa7..6b8d2b1a926d3 100644
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
+static int nvme_init_effects(struct nvme_ctrl *ctrl, bool read_log)
+{
+	int ret =3D 0;
+
+	if (ctrl->effects)
+		return 0;
+
+	if (read_log) {
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
@@ -3135,11 +3142,9 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
rl)
 		return -EIO;
 	}
=20
-	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret =3D nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
-		if (ret < 0)
-			goto out_free;
-	}
+	ret =3D nvme_init_effects(ctrl, id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG=
);
+	if (ret)
+		return ret;
=20
 	if (!(ctrl->ops->flags & NVME_F_FABRICS))
 		ctrl->cntlid =3D le16_to_cpu(id->cntlid);
--=20
2.30.2


