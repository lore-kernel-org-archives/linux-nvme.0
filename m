Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275BDC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2DAb9LTnXfcZb3Q5zQGFMCy0spA+LcCMJYZzfSTmAbI=; b=U+LzSzLnoGE6WbXnI8NZLsU+Tf
	2kfkg3aCWsmq3gKvJrXNI1ObXScRYZZwwFACd9Ebz5JYE9TlclHh1ypX1xXBFefuZ4Ng9ehVXaqNB
	7o6nLuzRiXYHUWP0Cl9DHWXHzPtDC/Fd3neTp0QCwr7yPJtGKDjfeG1YVCyOT1GEhBbsa78kKMuLQ
	SA+XRbG2fIyt8LpAHW85DqsN+dMCM75Xw9WFxVmgIKM3uzM8mDtaOSLBV5LRPa1LcT3DKBhXfyWZn
	LM9IJWy6Z/pTps2xMwn5VWUmx6a8C+tQdRxPqm2idPiKcyuHQDAtP+pG7WexvWLvvn6uspOIoWyUz
	4KvW4vFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shA8Y-0000000DR72-3yFu;
	Thu, 22 Aug 2024 15:54:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh9ed-0000000DK8H-3ddb
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 15:23:17 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MDS1t4023217
	for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 08:23:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=2DA
	b9LTnXfcZb3Q5zQGFMCy0spA+LcCMJYZzfSTmAbI=; b=PvF6ZWntOrZbaere6+D
	Y9Ep4v5iylTURcimxuq1IohZFztqzdNqYiZI1Y5+u1Z3t4Ha1CrgQL8xu94PjY26
	7sb9ldekQ8ADnCrqhgbCTjYK/ikD6NSG61fw52TnHs6rv5xPJbBBlANHFobD0dPV
	SzNMpXAzQOJCC6qk4CfODGGK0OfUpAE0na5kNh7ZI6e4FHMk0v+HQA7AErKaNkiw
	cPvtCmhfiPdwEvb3GgnP4PB0nvlWHJDlJl22ofaWbOiyBfgo3MQqjNwcTKO/H96k
	DmAfxXWeLf2vAgfg7FX9AjTHmlbuLqhHeUHuDk/a6WDVzd+MCuPly4mHd+BMnxBt
	oZw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4160a42rh8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 08:23:12 -0700 (PDT)
Received: from twshared12613.02.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 22 Aug 2024 15:23:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E007B1218890F; Thu, 22 Aug 2024 08:22:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: use better description for async reset reason
Date: Thu, 22 Aug 2024 08:22:59 -0700
Message-ID: <20240822152259.3896264-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fxbtZYPlMfLJF5qvCAOQTIO0UbYlkYXs
X-Proofpoint-ORIG-GUID: fxbtZYPlMfLJF5qvCAOQTIO0UbYlkYXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_08,2024-08-22_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_082316_148703_1D3A20D5 
X-CRM114-Status: GOOD (  12.14  )
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

The NVMe AER notification of a persistent internal error triggers a
reset. The existing warning message just says "due to AER", which can be
confused with the unlreated PCIe AER condition. Just say what the event
was instead of the generic overloaded acronym.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33fa01c599add..8ef64cb2c26a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4437,7 +4437,8 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl=
 *ctrl, u32 result)
=20
 static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
 {
-	dev_warn(ctrl->device, "resetting controller due to AER\n");
+	dev_warn(ctrl->device,
+		"resetting controller due to persistent internal error\n");
 	nvme_reset_ctrl(ctrl);
 }
=20
--=20
2.43.5


