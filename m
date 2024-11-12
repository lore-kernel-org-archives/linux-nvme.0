Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47CAD597A7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eE8h0+L9wVlW/NWAMli/VxuMbvyejIgMR8r9kRZDbUE=; b=dmf80XO/rvJyYYDEdCGcZDpPzj
	hRAJnOOIPFd/1zqHFhUZnGHN9bl6dck70O2EYvxH2Db7jr9aEsQII4TsTKtUv2P1fsCrsJ/WDBgUf
	QjIxNKvVCsVhasZzJYbm+DWcRfkKQrHb4Tlzr/eMQ7XVAFFLb/cb0q4326zdm53DpO0bMv3mV8Aeb
	odS5JYUZfOux/tIGSnCGM2u8QQZE2PwHvyjJ4JnXARdlEbhy/AFwcK8Va91DzRB/Sl7y3chFLQggU
	jqVh/ZIEgYPDZK2SsPhtkl0w8SjXq56YCD5e8/MRs6yfpls7BrwEXCsgW2WzHNxlHZJwiB+7izLBc
	E/k6Kbnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAy7r-00000004xcc-2Zut;
	Tue, 12 Nov 2024 21:08:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAy5k-00000004xNQ-11IR
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 21:06:29 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4ACJ5KAx026460
	for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2024 13:06:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=eE8h0+L9wVlW/NWAMli/VxuMbvyejIgMR8r9kRZDbUE=; b=GJ3dBJPCi+E6
	o4wlqW8+6M5if5VGxpZRc+1vKebRY7viPn3cnCQ/PNprx9+Oca5zHGnTP4ms8hlH
	Mg/brQgtcuz98lVaa+ge+g5bqPaC1KIM4poSIM/2HGCnEdpo4ZJdCdDUg9J6xtN5
	sh6NTByWKOp/WCJN/TJ7+iJwZZNtPpAT/TVkgiuNARPM0LB9XwD5F3abzXsRXDFR
	EGPc7Zy9l3QbGRndVt6WomuzefTSlV7jP4/RW15Yv/6R7/rEgr45SIg+Nc9x+s7B
	IaUZNm3OKRI0xoKS/zbF+TA3iKKAnvbJNhFQtBgQevY4q7ISr2ZfOUD7ZdTSwo8C
	zt1ibR5bJQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42v5sbcq25-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2024 13:06:27 -0800 (PST)
Received: from twshared35181.07.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 12 Nov 2024 21:06:24 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1CF531502A724; Tue, 12 Nov 2024 13:06:21 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if possible
Date: Tue, 12 Nov 2024 13:06:20 -0800
Message-ID: <20241112210620.2650523-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112210620.2650523-1-kbusch@meta.com>
References: <20241112210620.2650523-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bUHWKxJai2JPruLfqJ0lSs4azIi6k0Lr
X-Proofpoint-GUID: bUHWKxJai2JPruLfqJ0lSs4azIi6k0Lr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_130628_427302_8835FEF7 
X-CRM114-Status: GOOD (  12.88  )
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

If the device supports SGLs, use these for all user requests. This
format encodes the expected transfer length so it can catch short buffer
errors in a user command, whether it occurred accidently or maliciously.

For controllers that support SGL data mode, this is a viable mitigation
to CVE-2023-6238.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 919f173043d18..8f59ff3be8cea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -515,7 +515,8 @@ static inline bool nvme_pci_metadata_use_sgls(struct =
nvme_dev *dev,
 {
 	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
 		return false;
-	return req->nr_integrity_segments > 1;
+	return req->nr_integrity_segments > 1 ||
+		nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
=20
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
@@ -533,7 +534,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req,
 	if (nvme_pci_metadata_use_sgls(dev, req))
 		return true;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return false;
+		return nvme_req(req)->flags & NVME_REQ_USERCMD;
 	return true;
 }
=20
--=20
2.43.5


