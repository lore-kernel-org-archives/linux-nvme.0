Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3167ED3176B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ViwSdidsLoOqjGjo7EQzVbZ2mRGTZyUrI/Lwy/FJ5/w=; b=2G+ceu6jc6QICh6zBkIn8TdT7t
	rkZDMJmCSZZXxHv5mOgAGuCVvwLUhSoQT5lVjjbIvEfD/rIlu4hKM+fy9+apExLDBHwikAxh0Wl19
	9HdjekixKp4qhkUM8Ya2iCK0Pyl1SH0bpDHVgKHzXi1vMLGHrCaLvzFTfffW3E64Ji0lqIqrUcbAG
	XB0LH4iTePVi/Cay7Ou5xu3BcmqGIV7Cf+ewojc4ON8Z2rcJNjwy7nAcT204vySo5tQUffHqOYVBO
	HXblaJi0mDVi64I/qYC9jnxCJmUkZtp83i+DA0Z8FAQdtiXvhaf1QIGESaHp7N/xubPtosgRiJUZl
	xtc2T32A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgD-00000000Gi4-0phD;
	Tue, 05 Nov 2024 17:49:25 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng8-00000000GeL-3P2k
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:22 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAtZ021574
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ViwSdidsLoOqjGjo7EQzVbZ2mRGTZyUrI/Lwy/FJ5/w=; b=XgHyebxx9LVW
	tEHYA03U5d+hwc+ujyUdlDbQAa6uKXLsuMvwF5R7/4naCH8y2fp5orDd2YCGAhjQ
	PqjzHBsT83/Oy0vVC84AOkVMfYV2Q7zvwCZwPFmYAaNzbwE7BuSULh9PtVspyjwR
	5lk1rF1c7viBM1zWFBqpzFB2WRTOv6kXdqU3gfbRJ23KJ4+j4KZFFlR5wkxOSZCR
	s4Qc2DBARyIWRqe9BR4iH91GFfR7Wkczx4h3squhIOnPmvfJ5IIDVHLaUhMg/Kt3
	gWo3aJPzGgF6D5+6mnx/KvpF2+0AsgW9KUUGuEWeBLYVwbaeN9lfz7B43Jsy+AqM
	QdMLlwwC/w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42qjyptcpf-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:19 -0800 (PST)
Received: from twshared15700.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A47EC14CB3BDA; Tue,  5 Nov 2024 09:49:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 03/11] nvmet: implement supported log pages
Date: Tue, 5 Nov 2024 09:48:56 -0800
Message-ID: <20241105174904.3612888-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _YGqH9Jp1RfE3x6Cr7a4DxASOiStyHLy
X-Proofpoint-ORIG-GUID: _YGqH9Jp1RfE3x6Cr7a4DxASOiStyHLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094921_034145_3C7E894D 
X-CRM114-Status: GOOD (  11.38  )
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

This log is required for nvme 2.1.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 29 +++++++++++++++++++++++++++++
 include/linux/nvme.h            |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index a13242e791c0f..b8229d6c9998d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -71,6 +71,33 @@ static void nvmet_execute_get_log_page_error(struct nv=
met_req *req)
 	nvmet_req_complete(req, 0);
 }
=20
+static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
+{
+	__le32 *logs;
+	u16 status;
+
+	logs =3D kzalloc(1024, GFP_KERNEL);
+	if (!logs) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	logs[NVME_LOG_SUPPORTED] =3D cpu_to_le32(1);
+	logs[NVME_LOG_ERROR] =3D cpu_to_le32(1);
+	logs[NVME_LOG_SMART] =3D cpu_to_le32(1);
+	logs[NVME_LOG_FW_SLOT] =3D cpu_to_le32(1);
+	logs[NVME_LOG_CHANGED_NS] =3D cpu_to_le32(1);
+	logs[NVME_LOG_CMD_EFFECTS] =3D cpu_to_le32(1);
+	logs[NVME_LOG_ENDURANCE_GROUP] =3D cpu_to_le32(1);
+	logs[NVME_LOG_ANA] =3D cpu_to_le32(1);
+	logs[NVME_LOG_RMI] =3D cpu_to_le32(1);
+
+	status =3D nvmet_copy_to_sgl(req, 0, logs, 1024);
+	kfree(logs);
+out:
+	nvmet_req_complete(req, 0);
+}
+
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
@@ -323,6 +350,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return;
=20
 	switch (req->cmd->get_log_page.lid) {
+	case NVME_LOG_SUPPORTED:
+		return nvmet_execute_get_supported_log_pages(req);
 	case NVME_LOG_ERROR:
 		return nvmet_execute_get_log_page_error(req);
 	case NVME_LOG_SMART:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0f263c7e63192..a94e2280d350e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1245,6 +1245,7 @@ enum {
 	NVME_FEAT_WRITE_PROTECT	=3D 0x84,
 	NVME_FEAT_VENDOR_START	=3D 0xC0,
 	NVME_FEAT_VENDOR_END	=3D 0xFF,
+	NVME_LOG_SUPPORTED	=3D 0x00,
 	NVME_LOG_ERROR		=3D 0x01,
 	NVME_LOG_SMART		=3D 0x02,
 	NVME_LOG_FW_SLOT	=3D 0x03,
--=20
2.43.5


