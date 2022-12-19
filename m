Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498AEC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CeJyXV+m7UKGoLnT5AHBvRhEfcBcXn9RGdz5YRszuzw=; b=yYS5ia9eLs+jMDtdZEst5OhRkP
	4uPy0tf0y/d8Eg74HZKSSDzHz98rDYWgzOTchXFf6zVTXgLyvp0lJlRzdEV/jDYlyCZTl+A3YooHw
	6ASstM+kl86ji6JiBr1d3yKMSUepNGAr+tE5iqDr7ZrfzCtqmkr2PRGTFwSisEOBcegaEbGnqI6/M
	6YghLyU9muxPvYQ/cUAvxO7uUwZIlcFZTRtpkYDptmLphiR98gfrj9I713lNZc6Hr51n+tthMpig4
	vnWO5bOQPJuLynJ2kolx14NdJxqvtvKJrsUYKIWUMx4maXB17RGdaHTRJs39X3uTgYWJJkJNbNcn3
	8vGS+auA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7M9Y-001MWE-Q2; Mon, 19 Dec 2022 19:50:24 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7LM5-000Nlz-Nc
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 18:59:19 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJI4Lm6016178
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 10:59:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=CeJyXV+m7UKGoLnT5AHBvRhEfcBcXn9RGdz5YRszuzw=;
 b=hmfpNHQHubtejmLvBtzbIpMYdrnh1F73mH/Gk0Vx7YAkTbwIYtZ+yNzi9z+Mq2bYA5OJ
 fPSL8/aO7S2yZRo4CEIPjl+I+zCR5Q0Spd3EoZBDJ8sHu7LaEev5usjAectakTyaIrp1
 OcZQ7Sy+P1x2ef6m796bGfcxHSxpgz5YcdWuL1unL0tNOosjzqlT0lZX+Vv0JgqrnGqA
 rWfithPyVd2aKp4WLE+rY7q4XuzTsMhhRYAaHbHyj4zqnOA3E/WL/sT89+tlY+A2hEmg
 f82xX+AUr4uNWC3wuxFNNdzbM0U3VRf70xbw0g3beIPAtxh6XGHTpvMkYmOMnkUy+1sw lw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhdy90dr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 10:59:14 -0800
Received: from twshared0337.04.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 10:59:13 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id AC771D31584F; Mon, 19 Dec 2022 10:59:07 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe
	<axboe@kernel.dk>
Subject: [PATCH] nvme-pci: Fix mempool alloc size
Date: Mon, 19 Dec 2022 10:59:06 -0800
Message-ID: <20221219185906.3595984-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B9UCqhpL6N8VhNB95Lqx4oq4OojNQHAR
X-Proofpoint-ORIG-GUID: B9UCqhpL6N8VhNB95Lqx4oq4OojNQHAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_105917_829038_7F32266D 
X-CRM114-Status: GOOD (  17.56  )
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

Convert the max size to bytes to match the units of the divisor that
calculates the worst-case number of PRP entries.

The result is used to determine how many PRP Lists are required. The
code was previously rounding this to 1 list, but we can require 2 in the
worst case. In that scenario, the driver would corrupt memory beyond the
size provided by the mempool.

While unlikely to occur (you'd need a 4MB in exactly 127 phys segments
on a queue that doesn't support SGLs), this memory corruption has been
observed by kfence.

Cc: Jens Axboe <axboe@kernel.dk>
Fixes: 943e942e6266f ("nvme-pci: limit max IO size and segments to avoid =
high order allocations")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bbf..fa182fcd4c3e8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -380,8 +380,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 val=
ue, u32 *dbbuf_db,
  */
 static int nvme_pci_npages_prp(void)
 {
-	unsigned nprps =3D DIV_ROUND_UP(NVME_MAX_KB_SZ + NVME_CTRL_PAGE_SIZE,
-				      NVME_CTRL_PAGE_SIZE);
+	unsigned max_bytes =3D (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
+	unsigned nprps =3D DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
=20
--=20
2.30.2


