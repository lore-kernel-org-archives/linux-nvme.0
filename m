Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291F5C7619A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 21:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hoCrxtOTnL5Blpi/NDOu5cN35jUwJjDeuuuLWnpT/zE=; b=rgeeRH90mQxSIWgtE0CkjFBYim
	prhKjkMK0yKiDub1WtWmilmlbyu7Q27XsW5n9ZDLJhz3OGz9Mk+OiMmT1I+g/8pTXVg75lpCF3snM
	3jo1ao+hs7BuUMG6dovzuKNlz1hNo2Lqg+gBI1nxDHlRRY8xnhQugrb86O0dzSDrcNMta52tuHhrj
	jnVtfCU74RbPSMb6Xhqw5O//tyx8RXJYKpAJryHcogfaXhvEMzLahXxTQ3JQm1wVu0AhSvf5NiNNn
	lA8wOtJayFVA//xz0keLBJvwCaYL6DnFxwkLlpbl7lEAZH6sLiNlKMRtHNlbmOA3V5RhbIk+1WpTw
	ldBLjoUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkB8I-005oEl-2E;
	Wed, 05 Apr 2023 21:57:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkB8F-005oCD-0h
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 21:57:32 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Evlbj002602
	for <linux-nvme@lists.infradead.org>; Wed, 5 Apr 2023 14:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=hoCrxtOTnL5Blpi/NDOu5cN35jUwJjDeuuuLWnpT/zE=;
 b=Ogm3rK2eldmRyRmqkQgxpSSMO2MS2VhiZLyrXnlT0aVJths0Bv6uH1D/w0fWrjjruDrw
 5hocpdb1nW/y2E3nsGcKbYScHvoXVYV5QlGNoi0xXs0azbsgqUSJhCfNQDtp/AGAcpBE
 rcrTzc2+HHi50j0n5SEEUgKz5IpnF6UPOVHmXeHt7RMn3NCu5EYXopjDEk7O/6hyyeeh
 7af1KmKPlh6NRa+DcfY3MDD/MwOomWd5Zoz/okgUhIZZZT5RTMbiaTqQvaxtceVqtT6r
 Aagf89P5TNBNPtw6RJu0Ueg5U7Xcn6CuoR2wKaKamCCgEbfGRfT3Oas5irjEt1S2qn4F ww== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3prytdekda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 05 Apr 2023 14:57:26 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 5 Apr 2023 14:57:25 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 6552D15533310; Wed,  5 Apr 2023 14:57:21 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Nate Thornton
	<nate.thornton@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme: fix async event trace event
Date: Wed, 5 Apr 2023 14:57:20 -0700
Message-ID: <20230405215720.2872579-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5sxoi9QuBWGIeLDLsypIFIME0tQcFLEE
X-Proofpoint-ORIG-GUID: 5sxoi9QuBWGIeLDLsypIFIME0tQcFLEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_145731_437581_F2CAED43 
X-CRM114-Status: GOOD (  13.80  )
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

Mixing AER Event Type and Event Info has masking clashes. Just print the
event type, but also include the event info of the AER result in the
trace.

Fixes: 09bd1ff4b15143b ("nvme-core: add async event trace helper")
Reported-by: Nate Thornton <nate.thornton@samsung.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  |  5 +----
 drivers/nvme/host/trace.h | 15 ++++++---------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a9bac91a4cd..bdf1601219fc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4819,8 +4819,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl=
 *ctrl, u32 result)
 	u32 aer_notice_type =3D nvme_aer_subtype(result);
 	bool requeue =3D true;
=20
-	trace_nvme_async_event(ctrl, aer_notice_type);
-
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
@@ -4856,7 +4854,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl=
 *ctrl, u32 result)
=20
 static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
 {
-	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
 	dev_warn(ctrl->device, "resetting controller due to AER\n");
 	nvme_reset_ctrl(ctrl);
 }
@@ -4872,6 +4869,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ct=
rl, __le16 status,
 	if (le16_to_cpu(status) >> 1 !=3D NVME_SC_SUCCESS)
 		return;
=20
+	trace_nvme_async_event(ctrl, result);
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		requeue =3D nvme_handle_aen_notice(ctrl, result);
@@ -4889,7 +4887,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ct=
rl, __le16 status,
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
 		ctrl->aen_result =3D result;
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 6f0eaf6a15282..4fb5922ffdac5 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -127,15 +127,12 @@ TRACE_EVENT(nvme_async_event,
 	),
 	TP_printk("nvme%d: NVME_AEN=3D%#08x [%s]",
 		__entry->ctrl_id, __entry->result,
-		__print_symbolic(__entry->result,
-		aer_name(NVME_AER_NOTICE_NS_CHANGED),
-		aer_name(NVME_AER_NOTICE_ANA),
-		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
-		aer_name(NVME_AER_NOTICE_DISC_CHANGED),
-		aer_name(NVME_AER_ERROR),
-		aer_name(NVME_AER_SMART),
-		aer_name(NVME_AER_CSS),
-		aer_name(NVME_AER_VS))
+		__print_symbolic(__entry->result & 0x7,
+			aer_name(NVME_AER_ERROR),
+			aer_name(NVME_AER_SMART),
+			aer_name(NVME_AER_NOTICE),
+			aer_name(NVME_AER_CSS),
+			aer_name(NVME_AER_VS))
 	)
 );
=20
--=20
2.34.1


