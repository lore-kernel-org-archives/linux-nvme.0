Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20545606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UO3mn+bT;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aqG6fiRP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Mh82NzFKI3bwOzA2B7vLUbsMidURYGuuOv6lKjydM7U=; b=UO3mn+bT18BEZ9GkuLYYTHz298
	Gl0l/1efVaipztYE7Jvyep8y/1O/Qws6aMTWQNCTUwhOS54yiTbRbixO+cecDiR8O5b7ZHaIjK1f3
	G/CPTvpjJgmnvneEFzEU9p0bgiPHLyKcpDO8vd8iBiwqHTicOmu3RlBzmX6utHA6EcANgJ5WsjcA7
	QpIofg4bhnZjnQ5MKwEoIuwXeFpoWdIr4vACPHKLATPL+e4Qrk6irmR8cD9qQ7/OYu8TH+cl6CcJ+
	jx2dIdr2GyOIB4o+LbMWhCrtipEoLgP7AskBZ9RD95ftJJ2OcH9ZSf944UBHgTR/nrAWXNBwuvo7E
	lu9gFSdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRJ-00000009g05-2cNb;
	Thu, 29 Oct 2026 15:53:17 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRF-00000009fv4-1xYi
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:14 +0000
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCcZhG424247
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Mh82NzFKI3bwOzA2B7vLUbsMidURYGuuOv6lK
	jydM7U=; b=aqG6fiRPcJzqOSrsYkEcELPq4G2iu4AmCxnH9zYCCEC38nrb2yw2M
	hk+f8YqL5+wquEtmYW1hajftgX4e1/1wCc0OC/YThpba50qy5mhXAg6yYsJutjc0
	kWIiWHWVdBnqmsLnnBNdmMwW8qZXhPkRxrCh3xWpQ+vqa4NzcaPBkEHR8P/iEDKp
	45Fp4Vs8tYcOVKfvKiMWaugsY1XI7qFlf2o7qWCxtmFw88G52Tidxm5o9zQBscI7
	Ra9IlUbxbrnoD2LZ0bTnkU8LxDa81LfL9iN4hSFwJk/6t8ezvTwgq9PzkSjH7pVT
	40zJVFzLEVLnlJ2Z8FkHMuQKUuMb/EUsQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hk0bhqrxh-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:12 -0700 (PDT)
Received: from twshared36767.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:07 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1E94C2E22CEBA; Thu, 29 Oct 2026 08:52:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 11/19] nvmet-rdma: treat a failed connect as a disconnect
Date: Thu, 29 Oct 2026 08:52:44 -0700
Message-ID: <20261029155252.2332266-12-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfXzeck6fug4ztS
 mkMwHFzU0P/I/9dQPP6bFk+lTjMbz7s0LCGhyBECdCmJ0cSzO6rXLRvE1rrBVnzZWFYxQt/FPuV
 LptSqPIO31UN/hHbnmEH2HAzOGbD4J0ef4Bj/CIVS+xbTxueCPLejHq+SLT90HEdT5ZkI/7aNc9
 o/KxI6rIZI1G9ViUsSYxJeYJ+FnCAFah6gz+8aJAUYxGcg8X1K4Ptfw6EU3Xv4v41LY747AsisF
 cY3m6nIcnr5SxF2gsC5qn/rgIgXk8fe7PFSJNo1ne7B26b2shsBbVkoig2+snOtg2DJDM7e6ei+
 f4yNNAElcld7i0H2Dd8vZxKTX/plftk6xS3gRuEUwQEGy6/SqassNYUaIzbOlrSM76NESZCWeb4
 L3znodssJsUPyBbvmmZEBp27CNn0iZgRlajIEl1VNy8WJDBaajnFu+ANwEPjA7iyzLN9XoN6Ywu
 oflrD3jVnVOW9jMrqvA==
X-Authority-Analysis: v=2.4 cv=NrZE4MdJ c=1 sm=1 tr=0 ts=6ae36be8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=K3dlgnSc5Jz2A9q6JkoA:9
X-Proofpoint-ORIG-GUID: 0RJuRZJ2n7OlaI19uJp_yd45hunHBBJ8
X-Proofpoint-GUID: 0RJuRZJ2n7OlaI19uJp_yd45hunHBBJ8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX0F8tXL8cNmlY
 Mjxi01dsY+RKj7SnO+qZwsEi0gPJcA0l7oQkVyKlCRKBBjR9rr1GVFvr6xgV04fhqgfTrl1aVAd
 4OINre4HEC6FmNRW6TZaNn+mt10ht24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085313_561848_C093ADC3 
X-CRM114-Status: GOOD (  18.28  )
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

Once a connect request has been accepted, a queue is only freed by its
release_work, so that must be queued once. The disconnect paths take
the queue off nvmet_rdma_queue_list first and queue the work only if it
was still on it. nvmet_rdma_queue_connect_fail(), for REJECTED,
UNREACHABLE and CONNECT_ERROR, queues it unconditionally and only warns
if the queue isn't connecting. But the IB CM delivers a REJ from the
peer while the connection is established and even after we've sent a
DREQ, so a peer that causes a disconnect with a short capsule and then
sends a REJ while the release work is running queues it a second time
and the work runs on a freed queue. No credentials needed, just RoCE or
IB reachability, reproduced over rxe with a UDP socket.

Route connect failures through nvmet_rdma_queue_disconnect(), so only
the path that takes the queue off the list queues the work. A REJ on an
established connection still frees the queue, the RDMA CM reports no
disconnect after one.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target dri=
ver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b9e39d1657d29..fb20ba1b84e7f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1745,15 +1745,14 @@ static void nvmet_rdma_queue_disconnect(struct nv=
met_rdma_queue *queue)
 static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
 {
-	WARN_ON_ONCE(queue->state !=3D NVMET_RDMA_Q_CONNECTING);
-
-	mutex_lock(&nvmet_rdma_queue_mutex);
-	if (!list_empty(&queue->queue_list))
-		list_del_init(&queue->queue_list);
-	mutex_unlock(&nvmet_rdma_queue_mutex);
-
 	pr_err("failed to connect queue %d\n", queue->idx);
-	queue_work(nvmet_wq, &queue->release_work);
+
+	/*
+	 * The peer decides when these events arrive: a REJ is also delivered
+	 * for a connection that is established, or that we are disconnecting.
+	 * Whoever takes the queue off the list queues release_work, once.
+	 */
+	nvmet_rdma_queue_disconnect(queue);
 }
=20
 /**
--=20
2.52.0


