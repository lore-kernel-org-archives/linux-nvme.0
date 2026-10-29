Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA6606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GmLJ4lgr;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=AKNY2+l2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ce0JTXP4G8TGdFZo5VXlI7MKnQFgWr4Sog2Z5Vu0eVg=; b=GmLJ4lgrCm+6Ky1qyG4maD8ld0
	Ak3YCt4amkEpcjyyWw1N5F+m9hnXLL1YEtiUARADOA8tFKto2pi3udiklIeD/6R9xL6XkxUpkPMPJ
	qz82M+kHUIRqKgST1aPvHgykKAF0yFrEV+T6yR7UEtkGBojh6je+qeN+EyCcQbMgfC8rG3yTho9Yt
	63/Y19A4QkPWEwbSNbW6HrRhhvHlmJCnkulofTVnZWTqDVHrD18F+C9rOtR518pJx30pkz9X96ZEn
	tdWi5ghB/t4OJO1FLSrvG+/h0/PDYy5rTiPS49DPmy9b2qkSizJD1+NqAXAc6tcZZFH3F668sLGKJ
	KhYqbBbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRO-00000009g8f-0aB3;
	Thu, 29 Oct 2026 15:53:22 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRM-00000009g4y-0lmq
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:21 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TEoUvD1324344
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=ce0JTXP4G8TGdFZo5VXlI7MKnQFgWr4Sog2Z5
	Vu0eVg=; b=AKNY2+l2oC1xoh0BucKY04my6dRkLemUvGi8gp8gH3oXKWKVpeksd
	Mwyet/jS+B35LpwjeMmcP/sMeHCsFKBxYr3m02ZfQbww7dTyBh/dzG33ZOCaQqWk
	qNh6CTR2HlNz5nowJlUoIfzSMt1GNEQQBvD9CQPNcBUceiDr0MOtrpkLmUDEDYal
	xfhEXisZ4R3vxB/XfTgXfKd/PStA/hSn9ZpTg9r+5oG7Uj85QnwAqUnV+f1o46FD
	iZjFZ+/QcjwcFp9tmwLphEgjbeXVQSamt+3I9kHR7oCft7A/v2JnACgg/gca2v1v
	zRx5YxFCw85ruOhtF8MMlYLTJm6M/jZgQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm88vrjr4-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:19 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 912F72E22CECA; Thu, 29 Oct 2026 08:52:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 14/19] nvmet-rdma: queue the release work under the mutex
Date: Thu, 29 Oct 2026 08:52:47 -0700
Message-ID: <20261029155252.2332266-15-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX7WyBuOdc99ng
 U/kZZatAXD7pYT0jafWWFSLAsoOKJ37RTB0Zyc4Z+cV4Ka4ktYFrkDKIrHLAnQFHjgCj7RFBQ1T
 MGMc5fHxXODlYv3IkguohLaU+5xpkT8=
X-Proofpoint-ORIG-GUID: lWkrtUoxLG5cYrgaqemww4csv3bjKzbF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX1r47aucRwvD+
 jvt8jyEu1sWAqm7sUi4an00yOHGeHqIOR/brS8quM3CPsMKofEnmAFCpwkbZyoqS5ZdTVMY2A7q
 pyU9xWb8H7mk/NfJO75Fm/GlMg6/sZbJUHvpSr+NdvLtKmhizQg6/rT2LrcYPeYkoKnphdD/tSL
 wt6GGsbL4hXliAgff2U/83utFsouMJ9FuqAeYa+PFK+lm9KUminMjj0/7NV/JhhlJe3UAWSGhPs
 9qvVZdvhMbf4y8D2SjJfzVN6NmTnVSdiBwMTGlJEq9kJlmLsfKT3Gyf0kVu9dqFPAAes30p9G+X
 fbbJWGS8yR8BtzERxq2dbB4VGyMdCum12wkpMKbY7Md14EJuf8q11Yzew/oWQdGOzaqLVmhWPaY
 aVxB4kgQhNysJFIvy3Tr17tkJRHB3COYBpLPFdDMDxYxf5L7xXTvrMu3R7JoQ1G2oGY1hUa5q/t
 QxEwnUi0q5+ilhzyDNQ==
X-Proofpoint-GUID: lWkrtUoxLG5cYrgaqemww4csv3bjKzbF
X-Authority-Analysis: v=2.4 cv=HKVWhYtv c=1 sm=1 tr=0 ts=6ae36bef cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=QZ8vGD8rgBD2_cZM0L4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085320_231419_60ADE44F 
X-CRM114-Status: GOOD (  15.95  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Mason <mason@kernel.org>

nvmet_rdma_remove_one() takes the queue mutex, unlists each queue of
the device and queues its release work, then flushes nvmet-wq. So a
queue that still holds objects on the device must either be on the
list or have its release work queued. nvmet_rdma_queue_disconnect()
breaks that: it unlists the queue under the mutex, drops it, and only
then calls __nvmet_rdma_queue_disconnect() to queue the work. A device
removal in that window finds nothing to wait for, and the release work
then destroys the QP and CQ share on a freed device.

Queue the work before dropping the mutex, as nvmet_rdma_remove_one()
itself does. That's safe now that rdma_disconnect() no longer sleeps on
an iWARP event that needs the same mutex.

Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in d=
evice removal")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fe91df653e5cf..35fd3f3c35dc1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1744,17 +1744,17 @@ static void __nvmet_rdma_queue_disconnect(struct =
nvmet_rdma_queue *queue)
=20
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 {
-	bool disconnect =3D false;
-
+	/*
+	 * The release work is queued with the mutex held, so that
+	 * nvmet_rdma_remove_one() finds the queue on the list or its work on
+	 * the workqueue.
+	 */
 	mutex_lock(&nvmet_rdma_queue_mutex);
 	if (!list_empty(&queue->queue_list)) {
 		list_del_init(&queue->queue_list);
-		disconnect =3D true;
+		__nvmet_rdma_queue_disconnect(queue);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
-
-	if (disconnect)
-		__nvmet_rdma_queue_disconnect(queue);
 }
=20
 static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
--=20
2.52.0


