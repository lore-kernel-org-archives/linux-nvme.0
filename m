Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD78D5D688
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m/5EBVHYNmSAst2zok9MT0RS0v0QD1nReh133dQ15to=; b=ERkNmXvfVJEXbuzL9+WP7KJPhy
	d+KC2Ibu6r/wVLowUbmF/wZIJcUo/ToFQn3hYcHI0vGh8Xo16hJYd1OrywQ6XY05mjWnT+HJd/4Cp
	bp6aCd4vUjn1b77nMi056djmirnvXwBm77JB3RMTD5W6t+CbbKnkdgIKwh9WUIPblo9e7L/Sv+niQ
	Bu4RzxfQppbDYWYYiN+DWjCI3JEab7NDOeilwkK1+d/KVrvVIczJqGe9adnMA+6zIU3BtT7YsrsqK
	jvV+4QB+ev3TqOwDHPCdblmkcSvpURT5LG3vcDHr7IHPr2GQwGU0ZfxXuIeKKcAXYajlysZeJFLbb
	WGauvpbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cE-00000008AFP-3MKy;
	Thu, 07 Nov 2024 19:56:26 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lt-000000086ac-3qtB
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:35 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImVJD008391
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=m/5EBVHYNmSAst2zok9MT0RS0v0QD1nReh133dQ15to=; b=RudhIYIAcWwg
	atUAf59Ow0P7c6I6i0c5JNTFBilgjlZp3t4Ceyaiwxu55eMtyl+hkIf8IoF0cVVM
	2gCbzhrRcaXKPNudVfs8u+ulA9S+Fwasdchhd2rPIEBzQhXsR8k/U2UpmEuvvdnW
	+VzmNLNb5ISpkcbh0NAPzwysImGDkiXTwpTMq0cjtKZ6P85OwF66ZFIT1cRq0oCY
	LsZ3fPcXIZfCeNhoYKucX7Z7HOh+zThxiPlbozFQ0cqwFs7bdJikI2k1DNGYRfFM
	WATFmbpRNEXwdkNOtRfspvrN4JO1ZbzV8axvFdvik2sZMGQB6YkhLO4y/8F+5Efv
	kADmZMV5Vw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ruk2bnv4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:33 -0800 (PST)
Received: from twshared12347.06.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2FC3914DC39E6; Thu,  7 Nov 2024 11:38:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 01/13] nvmet: implement id ns for nvm command set
Date: Thu, 7 Nov 2024 11:38:36 -0800
Message-ID: <20241107193849.995554-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AF5BUpbBL53dOmgG4w1zggdVxRxg2uST
X-Proofpoint-ORIG-GUID: AF5BUpbBL53dOmgG4w1zggdVxRxg2uST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113934_038631_49232980 
X-CRM114-Status: GOOD (  10.14  )
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

We don't report anything here, but it's a mandatory identification for
nvme 2.1.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 081f0473cd9ea..8d06dba42bcb3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,20 @@ static void nvmet_execute_identify_ctrl_nvm(struct n=
vmet_req *req)
 		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
 }
=20
+static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
+{
+	u16 status;
+
+	status =3D nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
+				   NVME_IDENTIFY_DATA_SIZE);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -706,8 +720,8 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 	case NVME_ID_CNS_CS_NS:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			/* Not supported */
-			break;
+			nvme_execute_identify_ns_nvm(req);
+			return;
 		case NVME_CSI_ZNS:
 			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 				nvmet_execute_identify_ns_zns(req);
--=20
2.43.5


