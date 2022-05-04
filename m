Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D16C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0bQgyYmdQXpfVr16nOYbL89ixFZErZbL/iDh3/5KXbM=; b=PcHUOZbZal/hwfCNxS05nnv/8Z
	9jZPsxwdl4qLbTSPi+HsXVrwkANzYV3g2jmZMP9xyGuPhb5kFdVKNIWW7iSpzsIKFw0gYzHHirJRd
	v+DO7oRoZbcE0tKrb6CqrCcvIkh/Pbiojbsyj9Rs+qSjkLaUnH4K5OTSBN7Wb5opJDADdN7Jr01SX
	ie1svrCz0zBiY296F1tatsBgbiYHrb+Q6KfXh9hgxyMbGvnyn5l5Vgy3I5FaTEebjvPN91XFcCTcG
	jxrlhGvuO1Xeb2zFvBeSdXqMwuhCjH6DAp+n7K3Xa9ce05gyynkTGbDTlSd8/FinTHeKNu3RhWF8a
	kpvNOSdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmJyJ-00CBIV-9W; Wed, 04 May 2022 18:43:35 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmJyH-00CBIB-8T
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 18:43:34 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244DvgnC017430
 for <linux-nvme@lists.infradead.org>; Wed, 4 May 2022 11:43:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0bQgyYmdQXpfVr16nOYbL89ixFZErZbL/iDh3/5KXbM=;
 b=oP8P6FraFGzDintZ78w3EA3xILEgb68hlfbewrJPgeILb5J+kCrKGtohS7gy5ghYnaBz
 6F/6Il2F7LIv9oiTAjkPFNvEQC4GJURyOKzVI/Li69Q9HVbmCR/1lpS3giBK47xyaLWu
 TpUw372/Wywosj3DLn+p46etzNp+T0id1Fk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fup37bgn2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 11:43:32 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 11:43:30 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
 id 297A53947B23; Wed,  4 May 2022 11:43:26 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: set dma alignment to 3
Date: Wed, 4 May 2022 11:43:25 -0700
Message-ID: <20220504184325.1439476-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ym8eAVAosTU6zIdmVkp6-nv2b-KzbLr2
X-Proofpoint-ORIG-GUID: ym8eAVAosTU6zIdmVkp6-nv2b-KzbLr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_05,2022-05-04_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_114333_360933_B3C014CC 
X-CRM114-Status: GOOD (  18.39  )
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

The nvme specification only requires qword alignment for segment
descriptors, and the driver already guarantees that. The spec has always
allowed user data to be dword aligned, which is what the queue's
attribute is for, so relax the alignment requirement to that value.

While we could allow byte alignment for some controllers when using
SGLs, we still need to support PRP, and that only allows dword.

Fixes: 3b2a1ebceba3 ("nvme: set dma alignment to qword")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bea054565eed..0a6fb515a339 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1771,7 +1771,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl =
*ctrl,
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, 7);
+	blk_queue_dma_alignment(q, 3);
 	blk_queue_write_cache(q, vwc, vwc);
 }
=20
--=20
2.30.2


