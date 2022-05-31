Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6544C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2rItl/F1NMKgVGyD79/zU2Yaz+xj0L1y7TsYse4R1IE=; b=JkaX1XhCgoJP/UuWZ2VmIZB6+t
	4QiErEu1+Garc9oUrIBWRW2Xl0Zx45bI/I18Oc+KJiBJCtrp8EEyU85vN/JrdYK3j/tyZedWTs7tA
	i/NaFwrvArj+6TdZV6I011SI2EXWJ3NqMVsQ6hJJTIaY4d+KMdiEQ0Vmo/CqFLvfQvDutkmXe3gi/
	N74uOZtncfpNuVptOuF/WXVmgZwwz7L2BQmGPV+0cNPtg+jpLfVpIn3/rgT0DUKwOcPho5meLR9Z+
	t7b+Y17TzrvuU7hDuc/kRlu0jaQJAq56zrGwK67vDSsNlu44bnc8baGtjRaX2jtmLtyMaXfJGAmQ4
	vJM63lzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7MP-00CIMj-No; Tue, 31 May 2022 19:16:57 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7MN-00CILx-5N
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 19:16:56 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFii1h007242
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2rItl/F1NMKgVGyD79/zU2Yaz+xj0L1y7TsYse4R1IE=;
 b=Y35NhUmzuImRzok8zRj01WmrxFeE40NiIWGBZ2L9BoUQae6h0UdcTqiuUsflBFgtrFYK
 8ZOJBEUMGqmdc2cNb3dx1hNQdnmjfg0+cRSGb0R2mUXVCCaBLNEUwrl/fS6usvKRlYWY
 n7Wt569rco0qj1WFm2WrRGr/zBIMEVmy3qI= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gcu788jha-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:16:54 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:16:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 0BAF34924B19; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 09/11] block: introduce bdev_iter_is_aligned helper
Date: Tue, 31 May 2022 12:11:35 -0700
Message-ID: <20220531191137.2291467-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ieCBh40YIrprBRyyagFOMwqdKu2rre07
X-Proofpoint-ORIG-GUID: ieCBh40YIrprBRyyagFOMwqdKu2rre07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_121655_252803_D9827720 
X-CRM114-Status: GOOD (  13.64  )
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

Provide a convenient function for this repeatable coding pattern.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 834b981ef01b..583cdeb8895d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
+static inline bool bvev_iter_is_aligned(struct block_device *bdev,
+					struct iov_iter *iter)
+{
+	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
+				   bdev_logical_block_size(bdev) - 1);
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2


