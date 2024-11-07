Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A04D5D683
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnKEtck3bSBXLZOBO8mZiCilDJLHn/yuemzdwUj51ig=; b=wXjzcIkVMsKtO5ZtAN5wVzuDFa
	99CNw8hDPNVuzCdVi5DI4zbejZfEb982bchBvGvSqAEDBSPTNPnseDlrrZnojQ+vm7Q788DqbkvN0
	1PkDQCveZz+RTUVGv0uCvl5YJqxtkafgSbAc9l4PrYcfZySKRhobS4G8lerq6cUIjMXnubb/0yBr7
	wsOC0MHd+tyqnyekGF4GdApaLdNeXOgYNRYnisPXOFjzOC7c+eyAxSBtKHM9cUT1ANJnnmldw51eD
	AomJ2KtcjlBrufC0OTW31i/eFFXDHs9xepvwDAmMlQg/e2ihKkickOmyQW5BgXDervEeS+LOQ8qHL
	kbEG+U7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98c3-00000008A6k-2mDI;
	Thu, 07 Nov 2024 19:56:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lg-000000086XR-2SdT
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:22 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IumSf016028
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=vnKEtck3bSBXLZOBO8mZiCilDJLHn/yuemzdwUj51ig=; b=SL4WTHJRmIkP
	E79lIhjKCiKJIHAo+UdpEFO8Jmc9VGbvrO5FD8TqirHDlVK+WKlgf3RGko2p3Z27
	5M57LifSMTTASLHD/ODODT/MOTBlojKH7ME2kPAYR/HUi3VKY1n/66iE2Dwytw7z
	GQ2H2dSzcyEg7J+bDSQcJy5AU3+rVtYP9ncNpBWiNBt4Iw6jy7TiKhC/nhLp1yVn
	EUlGcdtbiRHjzkji4EHhRr+X7mC7GxjlyyXbWsIjtBmaeuGXK0//+MiL7WX8Vtjd
	gMGq2X6Dt4/jLiPNIIRJ2Ea38KG3gIDngo4Etspv5k90+fS5KRh8JyPNUBUz9qJk
	0sQKM5ApDg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s396rbah-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:17 -0800 (PST)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9151814DC3A04; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 09/13] nvmet: implement csi identify ns
Date: Thu, 7 Nov 2024 11:38:44 -0800
Message-ID: <20241107193849.995554-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XLIFdJNIfj0noqLg16QF7XxwxjiKNvd7
X-Proofpoint-ORIG-GUID: XLIFdJNIfj0noqLg16QF7XxwxjiKNvd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113920_774304_277D0BD3 
X-CRM114-Status: GOOD (  10.84  )
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

Implements reporting the I/O Command Set Independent Identify Namespace
command.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 6d3a1d2103bf3..516af7b419189 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -893,6 +893,35 @@ static void nvme_execute_identify_ns_nvm(struct nvme=
t_req *req)
 	nvmet_req_complete(req, status);
 }
=20
+static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep *id;
+	u16 status;
+
+	status =3D nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	id->nstat =3D NVME_NSTAT_NRDY;
+	id->anagrpid =3D req->ns->anagrpid;
+	id->nmic =3D NVME_NS_NMIC_SHARED;
+	if (req->ns->readonly)
+		id->nsattr |=3D NVME_NS_ATTR_RO;
+	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
+		id->nsfeat |=3D NVME_NS_ROTATIONAL;
+
+	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -940,6 +969,9 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
 		nvmet_execute_identify_nslist(req, true);
 		return;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_id_cs_indep(req);
+		return;
 	case NVME_ID_CNS_ENDGRP_LIST:
 		nvmet_execute_identify_endgrp_list(req);
 		return;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 93a0abfab5b0e..22375c87591a2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -563,6 +563,7 @@ enum {
 	NVME_NS_FLBAS_LBA_SHIFT	=3D 1,
 	NVME_NS_FLBAS_META_EXT	=3D 0x10,
 	NVME_NS_NMIC_SHARED	=3D 1 << 0,
+	NVME_NS_ROTATIONAL	=3D 1 << 4,
 	NVME_LBAF_RP_BEST	=3D 0,
 	NVME_LBAF_RP_BETTER	=3D 1,
 	NVME_LBAF_RP_GOOD	=3D 2,
--=20
2.43.5


