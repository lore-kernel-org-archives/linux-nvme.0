Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505DEC7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ee7zkfkz0ElD5DeGj3xRrhurSxFte+i1r6t1nyCC+FQ=; b=p3gIm9fDd7rJAJGwygFGXY1GlR
	we1A8T2JUOb3jkQTsTMaIb3tic6xKqCyEzIrr7H/jT7/8iqB6COUr5S/blTTRma+eiuTZR0UU0P0L
	kb/QKBsrWrvCXXeqHn6EMD9VXBT58qxCu0OcTjum4cxIfnhtSWp0iTuAmQr8CzVqkk6+NLO9nfjbz
	koUAFqNE+MR9JZyidntI3TWs07ruDT2C1MCYqGJi9erDn6sKQPyyK3fVRT/9glj5WxLnTXSlI4B0t
	YylrHBox1TpSdm5cQZ7rUfZYTXpsXgKT12wDDPC7FtEqnUndzb7YpyUz0723tf6fnxuqVGSH9pwQX
	H+ZWBhSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q41BG-00EOmd-32;
	Tue, 30 May 2023 15:22:38 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q41BD-00EOm1-2v
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 15:22:37 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U9HwV8032457
	for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 08:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=Ee7zkfkz0ElD5DeGj3xRrhurSxFte+i1r6t1nyCC+FQ=;
 b=gPwIidGaFB0R7XJNsJMvw4mXLfDHonwLDF+QCSfGYmDXmqB4ubH0/8XBlOm5jLOChZLH
 fQCPHT1pZFQJN5cpV/qrbt9qIZliTtgtiQATj/kTfxFUaEcUSIkRmdJKCeXJWMORRtnI
 esA61i9TWCsFcYijZgGUDWKFJVlqTeq7To1feqaMZDTn8BN674TdlhDgnKcbShZEmk0A
 rA2epYEroqWoH0oyMQ2Xwdh5nnZ+JLL9FU1yj9HWivEyswDK0w2D704Y4I02YogBkG9Q
 uDsR/n6RF2PdLcrdHAS9K1oc57CqrO3xQ3Grp28+9Qa9BDM8xZUBA9VL8OOWS7jw1w33 zA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qwecytcab-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 08:22:32 -0700
Received: from twshared29819.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 08:22:26 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D3F11194AC3CB; Tue, 30 May 2023 08:22:21 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: skip optional id ctrl csi if it failed
Date: Tue, 30 May 2023 08:22:21 -0700
Message-ID: <20230530152221.2388252-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3HtbxvM-GBSGyeG-_-y_70LrooStNYet
X-Proofpoint-ORIG-GUID: 3HtbxvM-GBSGyeG-_-y_70LrooStNYet
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_11,2023-05-30_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_082236_159915_FEA1D2B9 
X-CRM114-Status: GOOD (  18.24  )
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

I frequently recieved report is the driver requests the optional
Command Set Specific Identify Controller structure. Some controllers
report this in their error log, which tiggers other warnings to user
space monitoring the devices.

These error entries are harmless and of questionable value to save in
the log, but let's reduce their occurance by not resending the command
if it previously failed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217445
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f0cbb77b2493..0fe8d9c18759a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3064,7 +3064,8 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl=
 *ctrl)
 		ctrl->max_zeroes_sectors =3D 0;
=20
 	if (ctrl->subsys->subtype !=3D NVME_NQN_NVME ||
-	    nvme_ctrl_limited_cns(ctrl))
+	    nvme_ctrl_limited_cns(ctrl) ||
+	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
 		return 0;
=20
 	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
@@ -3086,6 +3087,8 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl=
 *ctrl)
 		ctrl->max_zeroes_sectors =3D nvme_mps_to_sectors(ctrl, id->wzsl);
=20
 free_data:
+	if (ret > 0)
+		set_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags);
 	kfree(id);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2d4f59e0535a..2f11f1d9a85ac 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -247,6 +247,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_ADMIN_Q_STOPPED	=3D 1,
 	NVME_CTRL_STARTED_ONCE		=3D 2,
 	NVME_CTRL_STOPPED		=3D 3,
+	NVME_CTRL_SKIP_ID_CNS_CS	=3D 4,
 };
=20
 struct nvme_ctrl {
--=20
2.34.1


