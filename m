Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0770D5B154
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hspb9b5oN7Ssmgf3bt9g3A4hwZTQH2EOWPydzNz52qE=; b=KHgtO/4aPOMfb5GjRnBKPeduaS
	ln8jnKoUAX1kzv2Rv67Yk9PIn6yEsuVS/3fLeJSeusoEMUNJ4fuZZ8BsQzMaBh/WdTO/eJLYVlSne
	21Pq7BomfOD5BebFeuZ/Dax+rPUJlGY1kWMXQJWcmAwC2jIif10L54xb8oP6hdbt+dCfLkOaH+9U/
	BpzQX689K08dxb8oFvyLzD4OjoIIUtvjh6I3h/1VSAfdW0FSgg4tcYDmzVjj57sTwlE8NCOWJzZZf
	f6Ef29kysbztE3+bA5rUHs1MF+Rmkrtz/UvsDr3r5SXJfY40ifDQM/FZ3yvdQLTmh4SRv/cPNdsjn
	vPlKrxpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5X65-0000000CJJc-46RS;
	Mon, 28 Oct 2024 21:16:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Wjj-0000000CG81-0q2Z
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 20:53:17 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SK79Wx012735
	for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 13:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Hspb9b5oN7Ssmgf3bt
	9g3A4hwZTQH2EOWPydzNz52qE=; b=GfjL2g7k8SyzgtZLv0pK0Ybg0uVvVfQe4s
	JM2gV8mb3kItT848m3aqJaALk6B9953YkCSLVzflVwi9HlW9FJoda9E0kl9QOeLt
	womsAXbkkXVoG+yCoDBnoUGA5DBsA7+8bVOC2mL47EWtA+dpw8TX5RA0A3tmgBGQ
	lS31jHU/hoTHCuK08Q9v88tROTwjNczuWYVZHU9OKjtmHjygbQYjXlaWFmmZSSKX
	QxvkdtQfMQX0YctNcDQjUDv8YSM6cwM5s1j+TRmmdDj4dRwuZAyOm7saiqcIIYFd
	/V0/oo8MjD2RpKHTlYdVR6Sj3HKotQd0CG7HWD48tzU03Ak22bgQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jbbckht7-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 13:53:13 -0700 (PDT)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 28 Oct 2024 20:53:02 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 91C73148C1306; Mon, 28 Oct 2024 13:52:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe
	<axboe@kernel.dk>
Subject: [PATCH] nvme: re-fix error-handling for io_uring nvme-passthrough
Date: Mon, 28 Oct 2024 13:52:53 -0700
Message-ID: <20241028205253.2054407-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BdKHOwwGn6_6NLfjXxuHE-sGvhAZORzN
X-Proofpoint-ORIG-GUID: BdKHOwwGn6_6NLfjXxuHE-sGvhAZORzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_135315_373737_3D41E5A3 
X-CRM114-Status: GOOD (  11.72  )
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

This was previously fixed with commit 1147dd0503564fa0e0348
("nvme: fix error-handling for io_uring nvme-passthrough"), but the
change was mistakenly undone in a later commit.

Fixes: d6aacee9255e7f ("nvme: use bio_integrity_map_user"
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b9b79ccfabf8a..6c531088043b7 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -422,9 +422,13 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(stru=
ct request *req,
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
=20
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
 		pdu->status =3D -EINTR;
-	else
+	} else {
 		pdu->status =3D nvme_req(req)->status;
+		if (!pdu->status)
+			pdu->status =3D blk_status_to_errno(err);
+	}
 	pdu->result =3D le64_to_cpu(nvme_req(req)->result.u64);
=20
 	/*
--=20
2.43.5


