Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6EAECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p+v2LcU3HK7utwb6+ReIcjyUubmPfvwFIPrIVZJqE7Q=; b=Sbk0rgU8Y8Bnh3r9d9Gl2jQp6v
	QEX3VTY1Q8+2RJCSFHf76FHYmrwQDjoOSNzhCeSDQxAwauNVcskU91mlgJyjcNh/1aPS59qCpd1RM
	KSN+ZluH+TYbzKsi5XbrUuQGnLaZkmnBY6gXVQX7K+f25R49dTfXge3j08G5susC4H9Asw9bABn2G
	6y8+1KA+mvNMcjx7n1TXDhm/e6ZoBaMmNtBfgSnNpo1T76IW+M6ZjgKbNCjJ9fHLSWVc4CpMgBY/C
	SV2BnEnyej/+e/GjbVUDCFWk0JV0Z2AaU/HeOOBmlt/IhWFQA9V2myUi6iN8I84c9Hn0bnokQs9JW
	AKmK4l5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTm9s-00Ct4v-Re; Thu, 01 Sep 2022 15:31:08 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTm9p-00Ct1S-V9
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 15:31:07 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819eIBw021080
	for <linux-nvme@lists.infradead.org>; Thu, 1 Sep 2022 08:31:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=p+v2LcU3HK7utwb6+ReIcjyUubmPfvwFIPrIVZJqE7Q=;
 b=XvyjtATOMYoc8p+yJANkAxfT6uS9UxK3ny+rUtvPjDip07oCqmqNvtnMBUD75LKca4fJ
 B+fft9qHlk2tNVChKZidOTxXC5o48g5Qi3Ba8Ih3sNEIjt644f2MNRWHdaT4w8rLbeKk
 IkGt5fF+crsCMbRXiJy6JAdEZKIJ2WdOEH0= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jat6s20kj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 08:31:02 -0700
Received: from twshared8442.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 08:31:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3687E8120174; Thu,  1 Sep 2022 08:30:40 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: requeue aen after firmware activation
Date: Thu, 1 Sep 2022 08:30:39 -0700
Message-ID: <20220901153039.4162460-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DMgj3C-tk1vaHAPuU_6vN6crvIrOXtFA
X-Proofpoint-ORIG-GUID: DMgj3C-tk1vaHAPuU_6vN6crvIrOXtFA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_083106_281592_08FDBA24 
X-CRM114-Status: GOOD (  17.18  )
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

The driver prevents async event work while handling a processing paused
event, but someone needs to restart it after the controller returns to a
live state.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216400
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..66446f1e06cf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4703,6 +4703,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_start_queues(ctrl);
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
+
+	queue_work(nvme_wq, &ctrl->async_event_work);
 }
=20
 static u32 nvme_aer_type(u32 result)
@@ -4715,9 +4717,10 @@ static u32 nvme_aer_subtype(u32 result)
 	return (result & 0xff00) >> 8;
 }
=20
-static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	u32 aer_notice_type =3D nvme_aer_subtype(result);
+	bool requeue =3D true;
=20
 	trace_nvme_async_event(ctrl, aer_notice_type);
=20
@@ -4734,6 +4737,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *=
ctrl, u32 result)
 		 */
 		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
 			nvme_auth_stop(ctrl);
+			requeue =3D false;
 			queue_work(nvme_wq, &ctrl->fw_act_work);
 		}
 		break;
@@ -4750,6 +4754,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *=
ctrl, u32 result)
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
+	return requeue;
 }
=20
 static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
@@ -4765,13 +4770,14 @@ void nvme_complete_async_event(struct nvme_ctrl *ct=
rl, __le16 status,
 	u32 result =3D le32_to_cpu(res->u32);
 	u32 aer_type =3D nvme_aer_type(result);
 	u32 aer_subtype =3D nvme_aer_subtype(result);
+	bool requeue =3D true;
=20
 	if (le16_to_cpu(status) >> 1 !=3D NVME_SC_SUCCESS)
 		return;
=20
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
-		nvme_handle_aen_notice(ctrl, result);
+		requeue =3D nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
 		/*
@@ -4792,7 +4798,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl=
, __le16 status,
 	default:
 		break;
 	}
-	queue_work(nvme_wq, &ctrl->async_event_work);
+
+	if (requeue)
+		queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
=20
--=20
2.30.2


