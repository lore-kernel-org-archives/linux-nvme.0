Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7103D3176B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3Wi2ODGl2m9YSJi/NyLJYkuxGtXB1vOuxNNyfC4bk8=; b=KgzfhjoKX4Ft8Gze6WaGSoUAxn
	wEoq/zbin/sTxKAMPuE0WbTAWYGykSJd/XD2JUjsDzg3Grll0iYvZJJfZLG/Sp/ERT+iyi2NURLzq
	SIUsKtW6dn+KaK4LaHH2eFTUkAgTy30r+vaGhQMK7ObDdKnBXLGxb3fB+/de4iLBTS2hs3uXaLo5b
	yVwERmRGLLFY4FsFXscPAP+SqZXcSuEVC105q4pRIPK8Ao8zHqxvM+i4WQw9BMrPebVwjL/04bJ2M
	EDIZwACdTUQaAZMkMeZQ8NdDH4cW3v5vBatK3GdnRyXPl1WGBzqUf0x89dXVLVoEiSn9Lrm5s/n38
	Ofhk2wZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgA-00000000Gfm-4C6o;
	Tue, 05 Nov 2024 17:49:23 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng3-00000000GbV-100g
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:18 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAtR021574
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=F3Wi2ODGl2m9YSJi/NyLJYkuxGtXB1vOuxNNyfC4bk8=; b=ZG8tWRj8i8av
	MENsCKDMS5aN3I/BVhjhbykmIJwRiEDJLPyPseVmcMRROOo34nVJsohhp4qgsQI5
	Irnie63qtReR/3mDlRUE6jLX95XeW8A7lNBqxcarP/hdHQW3U60VYtwKMACkbKzD
	7MB1mzIVZOeP8G1yOY98fTcwfrld8CfZIkPYBYxJJ+LY3Rc4NBJjwtl4ox2j5bIk
	SzMA0mc0Qr3KfTrrTExxUomljmK/8A++/9FThJiOlRRLZDsZZGQbmrQ1bBr8q6k5
	wVbk4nW7EPVSlV11qjQ1Y+g7FsVjjM719YcVuPwXxtL51emGFlDi5tOzllBRasJl
	GkpYhSkCmA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42qjyptcpf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:13 -0800 (PST)
Received: from twshared13460.05.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7886E14CB3BD0; Tue,  5 Nov 2024 09:49:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 02/11] nvmet: implement active command set ns list
Date: Tue, 5 Nov 2024 09:48:55 -0800
Message-ID: <20241105174904.3612888-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rGMPE7X6HWZqqlZ73ZMGBdzl84oOY95h
X-Proofpoint-ORIG-GUID: rGMPE7X6HWZqqlZ73ZMGBdzl84oOY95h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094915_482039_1EE20D23 
X-CRM114-Status: GOOD (  11.39  )
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

This is required for nvme 2.1 for targets that support multiple command
sets. We support NVM and ZNS, so are required to support this
identification.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 9 +++++++--
 include/linux/nvme.h            | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 8d06dba42bcb3..a13242e791c0f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -576,7 +576,7 @@ static void nvmet_execute_identify_ns(struct nvmet_re=
q *req)
 	nvmet_req_complete(req, status);
 }
=20
-static void nvmet_execute_identify_nslist(struct nvmet_req *req)
+static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool ma=
tch_css)
 {
 	static const int buf_size =3D NVME_IDENTIFY_DATA_SIZE;
 	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
@@ -606,6 +606,8 @@ static void nvmet_execute_identify_nslist(struct nvme=
t_req *req)
 	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <=3D min_nsid)
 			continue;
+		if (match_css && req->ns->csi !=3D req->cmd->identify.csi)
+			continue;
 		list[i++] =3D cpu_to_le32(ns->nsid);
 		if (i =3D=3D buf_size / sizeof(__le32))
 			break;
@@ -712,7 +714,7 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 		nvmet_execute_identify_ctrl(req);
 		return;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
-		nvmet_execute_identify_nslist(req);
+		nvmet_execute_identify_nslist(req, false);
 		return;
 	case NVME_ID_CNS_NS_DESC_LIST:
 		nvmet_execute_identify_desclist(req);
@@ -743,6 +745,9 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
+		nvmet_execute_identify_nslist(req, true);
+		return;
 	}
=20
 	pr_debug("unhandled identify cns %d on qid %d\n",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e0..0f263c7e63192 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -522,6 +522,7 @@ enum {
 	NVME_ID_CNS_NS_DESC_LIST	=3D 0x03,
 	NVME_ID_CNS_CS_NS		=3D 0x05,
 	NVME_ID_CNS_CS_CTRL		=3D 0x06,
+	NVME_ID_CNS_NS_ACTIVE_LIST_CS	=3D 0x07,
 	NVME_ID_CNS_NS_CS_INDEP		=3D 0x08,
 	NVME_ID_CNS_NS_PRESENT_LIST	=3D 0x10,
 	NVME_ID_CNS_NS_PRESENT		=3D 0x11,
--=20
2.43.5


