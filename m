Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D525EB2700
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z4luWetWNAHgVTtRJ+44LhDXNfaI1BjnbbQgOKQrdh0=; b=Pyb/QdiEW+zxpbHUbyQPfZjKAZ
	Jww0rRuj6eFNlc9jJ77W96i5Db5K2rHOivRgMzw7XFjfz725HL4uTauaYI+lLe37G+mv6yWlU3vMt
	hrhI0+udz0dTXGOqGDfpf1KUx5Sdrra9QOekHn/y2W0cz2UIWNHS2jlFggG/vywncHauVWfXBFQ9C
	YjNXVGnDIQpTf1758Gr/Ez1tPWra9isS3++0jzzXRAPlDX9K2Ix1vWeeNZxUNv5/0p0yYCjAH/J8T
	K6Wav4mh2AKKyAagIQxXeOqEdcmvkRWnsvcYzi3HPSt5kzqm7liirZydheVwXuOxOHRB05hLL3QIT
	HCzoI61A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vptYC-0000000HRgK-1M37;
	Tue, 10 Feb 2026 19:37:32 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vptY9-0000000HRfg-35uN
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 19:37:30 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61AHHhr93359428
	for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 11:37:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Z4luWetWNAHgVTtRJ+
	44LhDXNfaI1BjnbbQgOKQrdh0=; b=FQrRVCKuCymfd4Lw+tFhPfBrW4+ZrNhOIj
	cClh3MmLeqRA7c/a7VR6+YRkGil1ltBsGVcRou13S0TM6RdrQcWqBdFc7WlDi/i9
	dgKisepTyKTOW8pG7t756ClIKDjR1UMv6B0GjV3Bo11HC72iujqRtibvykHg08Z7
	KCnecv/vbaXPs60Ny38ENb7GgPdzQhzUanY8fK3NXvp+j1ngGw+1mpd40K7bwMNS
	RgQrVU78CIcVq8uzI0KQvo5QkRnxIuI8I3DzshDkomPHsv6xk83QaNHdx8cpCB1y
	wFGhbSC42xyDyCsLA4nfSnBTTm0a48v0dO1SZR9MkSFn9F02D3Tg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c84jbwm58-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 11:37:28 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 19:37:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 68C0677808C9; Tue, 10 Feb 2026 11:37:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] nvme-pci: ensure we're polling a polled queue
Date: Tue, 10 Feb 2026 11:37:13 -0800
Message-ID: <20260210193715.2543091-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2MyBTYWx0ZWRfX+N4MsOp6PwIx
 dVXD++lpmlaOghmfxdyrRWcsdQLEQPpQ//szzTrExcq5wHEQYmYqHTPR5umS2jujU3t2OE9wc7S
 mCe73lX/gNr4Kch/Nz10RztJubibJTuT3HQ5m/DWZLAlzBqPKpBqDKifRLvVpEW64/mVk56nhkb
 8D4zOUdNJYdxHC1W/mOtVUWJBlyf1r7JZXOPckR9ITXliHsGrfzHPkd3cOS2kODkCEp9wPuypgg
 EdqtlDcpSw5l9F5Pe5X/egXh0ayKTyEpJAwEnpQu5p7+1kijINhHX2sLdYmTP0xLyt1y1J45He/
 lwDc340INSEnMmZxxyaes3fGJ48MFwjNz3EFh93Ygm/8ZcvY0tcUtmycUFyhpcDI89eW/H5ZeGH
 o8Qx0xKvt2/o8bj8vPPK3l6D+EBVKmzlqsE3yG+g/bx04ZzPg36fXVJpkJJ3+pKVVvYjDNBvbDN
 2PKzbDcDsqVHRnDbUIQ==
X-Proofpoint-GUID: q2UwIxr2JnyGS0FkGhBpE4v_MuETprkY
X-Proofpoint-ORIG-GUID: q2UwIxr2JnyGS0FkGhBpE4v_MuETprkY
X-Authority-Analysis: v=2.4 cv=KdnfcAYD c=1 sm=1 tr=0 ts=698b88f8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=y5eEo3cvQwTL6TJZsNYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_113729_894000_164629D0 
X-CRM114-Status: GOOD (  11.56  )
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

A user can change the polled queue count at run time. There's a brief
window during a reset where a hipri task may try to poll that queue
before the block layer has updated the queue maps, which would race with
the now irq driven queue, which can cause double completions.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 80df992d1ae82..5a3e27305176f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1496,7 +1496,8 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, st=
ruct io_comp_batch *iob)
 	struct nvme_queue *nvmeq =3D hctx->driver_data;
 	bool found;
=20
-	if (!nvme_cqe_pending(nvmeq))
+	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
+	    !nvme_cqe_pending(nvmeq))
 		return 0;
=20
 	spin_lock(&nvmeq->cq_poll_lock);
--=20
2.47.3


