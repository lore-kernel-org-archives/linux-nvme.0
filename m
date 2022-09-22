Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29EEC6FA86
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UMtCSuBUiMR06RzflJB8pm+tqpYIjSzqR9RfydtTnTI=; b=W2o9nR4zKW8W56ceGrWBP8vLgI
	3GTIgMhO0Abor8LimtO0CN++oDAwKifm8lUiDrKBf04vLYj+koybSaaONqGxhKQ6hoApRdIQ8L2Nx
	Wvmw+3jC8Yl0zzsTJbt3zi1qY6IyuaAC2qxhEAjSNqJZkAePdM3PtprGyC1SUFqmzZ+E50tnatIHq
	0e2oWVPrzdoB7H02cu/qUgORR4KRleSQDKRQxeJOmEHEosR5lrHLeBk949mrTHaxZkV2EF+lc+orz
	GAa0smKb7C0c3zjUidOpqc1/Pd2nhhzxCKmRwXAM+KnqOgZWTNGsZrMSGbiBWg1/3irwKC6Z2ZM+i
	f3LMPfAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obO18-00GOuQ-NU; Thu, 22 Sep 2022 15:21:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNth-00GLPu-I3
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:13:55 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MEvPtk014166
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 08:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=UMtCSuBUiMR06RzflJB8pm+tqpYIjSzqR9RfydtTnTI=;
 b=dsDRuyhgxP1P0uevRZrCjZvDVDrUNNxCXFl34/jevO+eNp1XPUHKcENZ0T233VoKEnC2
 dPJ8oWVeP2g2BWooGPvy6GPJ2ijI04+mQnSUjNvIgHPge6SHO4bQo5NbgNzy3OoE3Q/n
 zqeczhnXpB9fNnBqknKhn+rkmtk/fozkPxM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jr6s3qcb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 08:13:51 -0700
Received: from twshared3307.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 08:13:49 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3EF548E894EF; Thu, 22 Sep 2022 08:13:48 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: ensure subsystem reset is single threaded
Date: Thu, 22 Sep 2022 08:13:47 -0700
Message-ID: <20220922151347.764639-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RquUXWtyHwM2mPr8LSFVpH28d2pJ-JGh
X-Proofpoint-GUID: RquUXWtyHwM2mPr8LSFVpH28d2pJ-JGh
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_081353_768106_8E00E599 
X-CRM114-Status: GOOD (  18.04  )
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

The subsystem reset writes to a register, so we have to ensure the
device state is capable of handling that otherwise the driver may access
unmapped registers. Use the state machine to ensure the subsystem reset
doesn't try to write registers on a device already undergoing this type
of reset.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214771
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/nvme.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a0bf9560cf67..70555022cb44 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -602,11 +602,23 @@ static inline void nvme_fault_inject_fini(struct nvme=
_fault_inject *fault_inj)
 static inline void nvme_should_fail(struct request *req) {}
 #endif
=20
+bool nvme_wait_reset(struct nvme_ctrl *ctrl);
+int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
+
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
+	int ret;
+
 	if (!ctrl->subsystem)
 		return -ENOTTY;
-	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+	if (!nvme_wait_reset(ctrl))
+		return -EBUSY;
+
+	ret =3D ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+	if (ret)
+		return ret;
+
+	return nvme_try_sched_reset(ctrl);
 }
=20
 /*
@@ -712,7 +724,6 @@ void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
-bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
@@ -802,7 +813,6 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *c=
ount);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
-int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8=
 csi,
--=20
2.30.2


