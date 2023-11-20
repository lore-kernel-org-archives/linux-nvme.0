Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9737C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CghMiU6rTPflgKwqw1g0B671AmFPWRNn+sp5h7wKvnM=; b=W74r99pz6Oyn7A5XRF8SXdgnXq
	Dud3WEXTqjL2Cbj9PxZ8lCf1Ne0iovYnvfHJsIIQTP4Zju2kY6VFKwgb6ee5GOPqQnryNvJu8p0fg
	s52no+afLS91cPczUdxmgMB7iUsdcWYIZncbSVYjkNi9BU03961Hh4XtOy5Ru+zJvWN8r9jBlUUu8
	SC4h5rH6yPQsZXQa2kNzzhlOVeAg4f+0nciU/JmumszsiX1WONIzea/97x9JQ9BrfTA593PXiGAMH
	lYZaKmsGhzbs6PSZTU5B/BpFQGz1vX3CKXSCPPgtBGSB6PGyQ0Pg82PEINMSv3vA6QWz0Oqlu/J6M
	2JtraOBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r58QQ-00E2jo-0g;
	Mon, 20 Nov 2023 17:51:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r58QN-00E2hl-2Z
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 17:51:09 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHoplH013929
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 09:51:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=CghMiU6rTPflgKwqw1g0B671AmFPWRNn+sp5h7wKvnM=;
 b=KHPdzPrTOumboHdSJMF5d58CM0yUh9uZgjjhK3QEuYbY/rtjunNq4zu5Cc+PF3OU83Yw
 pq34sunfjTp34m9ZIdYI36i/pgpBLupGQM+sUp5N5FkMaMuAfhtnR+aTUNYhshTxHKWs
 yuHIXcXsIa4yDgVHjryDPm9Q3b6H6Zo+9ubbc0o8CuOM4o3MN4slztlBMMkGtE1EY2gM
 QIRK9SOinEiXlTCUzQSBTKr81zKKbfU/7EpVFuTWk5b7pnWrvjoC1Ibfn/KnSQGHPFZA
 snzI4+UPmlODNumbjnzBMBtfK3FPm2mwQDY3gRHNw3DoKBy8GSoYq5n9uk3ODvj0N0hS 2Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ugajcrxdd-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 09:51:06 -0800
Received: from twshared4397.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:50:49 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 6BFD521EF22AB; Mon, 20 Nov 2023 09:50:36 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] nvme: introduce helper function to get ctrl state
Date: Mon, 20 Nov 2023 09:50:34 -0800
Message-ID: <20231120175035.978147-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ngXNJnIoMToGmWpXWhlqcgJEzXA6gZXI
X-Proofpoint-GUID: ngXNJnIoMToGmWpXWhlqcgJEzXA6gZXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_18,2023-11-20_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_095107_946223_F0DF510A 
X-CRM114-Status: GOOD (  13.25  )
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

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb1254..578e6d311bc9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -387,6 +387,11 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 };
=20
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctr=
l)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
--=20
2.34.1


