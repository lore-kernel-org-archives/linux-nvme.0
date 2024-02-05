Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B99C48292
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 19:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kLHk+Fttuke8MGobuFMbJVPwjp24Y/4HJb4js9rFfvo=; b=gz8EsFhbF4JRad91qia9A0JOCX
	LKp6Asja/YolkZX7jaTpH2tYEMuBwuaNKdUtBv1QwUJUS/km2NfPSrIAlf9v4OGQuw75rnroblNp4
	r7iUDxvXFC/uxT2Cswb3OduAAspPBSkrPHbT8PELzWYiKfZms42tD871zuhyc5ffY8u3pESNHDaAB
	tZDqx2UyrjPtfSFkoE7Y2xXIkyMAH8NVWLwCPjG3woSvJTobcbwZKv4/RCMap8lRAl1/WDtUvHClE
	RQKm5N5QThG4i+akeKaabs8smPTgWNkhIZ1Fcy9RQwAmcNCOmqJInKANelWHH2Ma99QHSzHc3MwSs
	jwSGqFkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX4UH-00000004Y7b-08lD;
	Mon, 05 Feb 2024 19:18:37 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX4UE-00000004Y65-26aQ
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 19:18:35 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415HK3Wa019392
	for <linux-nvme@lists.infradead.org>; Mon, 5 Feb 2024 11:18:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=kLHk+Fttuke8MGobuFMbJVPwjp24Y/4HJb4js9rFfvo=;
 b=n2dBhs5kqDiJu7ymJK+KXMQmrr1viHPeTv/bSpC3P43mvmPOn0PiNNcLJ5d7pDYCCXZU
 T9AGyyPFRDDddl3UpaafEcGD8qR5y9OPO5D5Dnq3QYqW4GB/N44jvt3/yqVhsqB9QlEZ
 Gvg+WsNGxphc3Fw7fPuAl3d/RKZmfOojYkRL1/Tv1Rcid/gdsp9NpmyuK2nlTErmTatt
 5qmp72LmBeisiFO9KNKxScLYqC/iTeFfQRf7rBpGhCgXVEL1akSYcWguXhZgRaN+YVjL
 wvI6d48382szVgeuJ4MQKDZ3XRyS0Qd9gvzWd0teAZMYJTG+JRwf8a4PHM7nxPLV7uTG jw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3w2k62d5ck-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 05 Feb 2024 11:18:33 -0800
Received: from twshared25691.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:18:31 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 62C5824DAB020; Mon,  5 Feb 2024 11:17:04 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: implement support for nvme relaxed effects
Date: Mon, 5 Feb 2024 11:17:03 -0800
Message-ID: <20240205191703.2990948-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -1kS_9_dfLu0_Yyxg7Bb_bJh0nu0mPz4
X-Proofpoint-ORIG-GUID: -1kS_9_dfLu0_Yyxg7Bb_bJh0nu0mPz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_111834_575094_E30E3D3F 
X-CRM114-Status: GOOD (  15.65  )
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

NVM Express TP4167 provides a way for controllers to report a relaxed
execution constraint. Specifically, it notifies of exclusivity for IO
vs. admin commands instead of grouping these together. If set, then we
don't need to freeze IO in order to execute that admin command. The
freezing distrupts IO processes, so it's nice to avoid that if the
controller tells us we don't need to do that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 include/linux/nvme.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 975245527c1fc..75927e8579857 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1153,6 +1153,10 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, s=
truct nvme_ns *ns, u8 opcode)
 		effects &=3D ~NVME_CMD_EFFECTS_CSE_MASK;
 	} else {
 		effects =3D le32_to_cpu(ctrl->effects->acs[opcode]);
+
+		/* Ignore execution restrictions if any relaxation bits are set */
+		if (effects & NVME_CMD_EFFECTS_CSER_MASK)
+			effects &=3D ~NVME_CMD_EFFECTS_CSE_MASK;
 	}
=20
 	return effects;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bc605ec4a3fd0..3ef4053ea9500 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -646,6 +646,7 @@ enum {
 	NVME_CMD_EFFECTS_NCC		=3D 1 << 2,
 	NVME_CMD_EFFECTS_NIC		=3D 1 << 3,
 	NVME_CMD_EFFECTS_CCC		=3D 1 << 4,
+	NVME_CMD_EFFECTS_CSER_MASK	=3D GENMASK(15, 14),
 	NVME_CMD_EFFECTS_CSE_MASK	=3D GENMASK(18, 16),
 	NVME_CMD_EFFECTS_UUID_SEL	=3D 1 << 19,
 	NVME_CMD_EFFECTS_SCOPE_MASK	=3D GENMASK(31, 20),
--=20
2.34.1


