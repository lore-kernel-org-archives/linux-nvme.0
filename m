Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276C606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a/M+mkBH;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MiwxckSD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J0TvL8H9T+uTtFW+beF8rdUwQFe9n42/3KsqvAKu/ro=; b=a/M+mkBHL19r6R1z3/ivaEB7DZ
	zbgcYGmOo6bTu+spG4kf92GIJ68Li22jS0AcOkUNOqTJ+WRdVdf2vV5uUkuG3BzgiN7rsCJ/Sg3lO
	ukpUdfeMY4SLHoW9/+uSKML99wObyNugGZzCcKH8Sz2ue0/166+zjXv4TmJ14nDrjM2mlBEQPmcCK
	l6C/71OAI+QuRb0AsC0nFA/OAG88KMj5ggzGOhbsBPiz4J359JN+KROkvAP2r4NIVFnlWMfaaViQT
	GfRPWckADIlz2fBeBQic/bIFtqYyXxNmkSdTCyZvIboJUZyS+lKdhX/mSyQhPIo+8fXTTrTRl3S6X
	E7DSQtBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRi-00000009gpP-3MCl;
	Thu, 29 Oct 2026 15:53:42 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRY-00000009gWH-1SvI
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:41 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCcsBU2894964
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=J0TvL8H9T+uTtFW+beF8rdUwQFe9n42/3Ksqv
	AKu/ro=; b=MiwxckSDNQKhdtpZBu9ZpomHZMnDJ3N4/DluBHNkNMZkGXr8jYG94
	3Sr6VPtXdI2cm2CRW8GPFOUEYaHl2W0twCwFjMk3Wqyl2YEe4lasWZJpFpnsMhgE
	YDit4iZG9dTpft8LvxkcJSDMPbisXxAT4GenUZD33lOydmEWaVZFyPjGcKs0RP//
	lFWfIw2JHqlQNTjiV5D6+Gkx3RsIAv3ZpMGAVBWgcEW9/2gDubtOkG4Xx0gXfFdj
	dxxCU5tHV/wEdLrEciIInTrFReI9iqlYHqqtjjsNav7mUOtllOS/tfrgMs97DQYV
	796SM8gkHxnEpoMFmbCEhM/+IHR1QIwNA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hjypur6e9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:31 -0700 (PDT)
Received: from twshared0305.01.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6E2E02E22CEDE; Thu, 29 Oct 2026 08:53:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 18/19] nvmet-rdma: fix a lost run of the wait list
Date: Thu, 29 Oct 2026 08:52:51 -0700
Message-ID: <20261029155252.2332266-19-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: brJ0R06Bo3c4i3BObafSz_xemsorkZG5
X-Proofpoint-GUID: brJ0R06Bo3c4i3BObafSz_xemsorkZG5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfXzKSdtYAEkfCs
 7uKQ/dWBoQmpz6vQr8FcZqEL0o7IiJGbqT1ZLgqJYS8d97o6xZOxK3jqZblRt8DiYjj5oYxnukL
 gsSqbW7eABL55dCw/ykBFypkPSabJ74=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX2QSLJ90t7xI0
 n8BKwA/SWrDTNi3aleI9VvKmceucIS9tvW7ymzOyXdvQqmnTOhkzrC4YsHx6DDx9Mku2cyoPkwh
 nI427qdUmuWGSguVbAG10VMaJ3giNdxyVJEaoQB2gmdRpnZ0dgiX9ZFtbV6P6SKqR8K8H0cPg1+
 i2wJjpJAbCzwaQLvqnDy8ajm6TS2IRQJn6BO4f6740bh/ttLsscs/24umgfg5VNu/y4PUPGOSoA
 UiQpyMAaNJxJVnlIJwTZokm3cgiPVlqR1uX4JjU2oguuXfaT0k5ZJmn46rFXW9yauTE5yoveG6A
 MjrFMvYJjqf2Foo6RYZYMhdbwxRoTU+m1enDM3TB2dUXnUF1FotXviB3USXn/8TZeYOUt6MRfey
 9sN5gPKlFNSrappI6PC+pKMeYum9HsLAk/nSQZN1ceJtRLKHpaUotJR4tLepdJn043Gr2ydmLGb
 V99V97CgD2R27EZe/1w==
X-Authority-Analysis: v=2.4 cv=bPmDs/+Z c=1 sm=1 tr=0 ts=6ae36bfb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=34uP_JL4ZnNKygKq:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=v32LOu4B-TuHKX6jDSoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085332_542818_119C3F22 
X-CRM114-Status: GOOD (  23.18  )
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

A command is checked for free send queue slots before it's on the wait
list, in nvmet_rdma_handle_command() and when the processing loop takes
it off to retry, and nvmet_rdma_release_rsp() looks at the list without
a lock after giving slots back. The CQ worker and the CM thread (via
nvmet_rdma_queue_established()) can handle the commands of one queue
concurrently, so a release can see an empty list while the other side
is between the failed slot check and the list add:

    handle a command                  release a response
    too few free slots
                                      give the slots back
                                      wait list empty: return
    add the command to the list       /* nobody runs the list */

If that was the last response in flight the command stays on the list
forever. It holds sq->ref, so nvmet_sq_destroy() hangs at disconnect
and the queue's memory is never freed. A host hits it by sending more
Connects at once than the send queue has slots.

Look at the slots again after a command is on the list: the loop retries
after a put-back with a full barrier in between, nvmet_rdma_release_rsp()
has a matching barrier between returning the slots and looking at the
list, and nvmet_rdma_handle_command() runs the list once after adding
its command.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target dri=
ver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1e434cc451c28..7f22a2a1886dc 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -519,7 +519,7 @@ static void nvmet_rdma_process_wr_wait_list(struct nv=
met_rdma_queue *queue,
 	unsigned long flags;
=20
 	spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
-	if (done->wait_released) {
+	if (done && done->wait_released) {
 		/*
 		 * The loop below has not come back from this command yet. It is
 		 * further up this stack if the command completed in place and
@@ -551,6 +551,15 @@ static void nvmet_rdma_process_wr_wait_list(struct n=
vmet_rdma_queue *queue,
 			WRITE_ONCE(rsp->wait_released, NULL);
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
+			/*
+			 * A release that came while the command was off the
+			 * list can have seen an empty list, so look at the
+			 * room again.
+			 * Pairs with the barrier in nvmet_rdma_release_rsp().
+			 */
+			smp_mb();
+			if (atomic_read(&queue->sq_wr_avail) > rsp->n_rdma)
+				continue;
 			break;
 		}
 	}
@@ -698,6 +707,11 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma=
_rsp *rsp)
 	struct nvmet_rdma_queue *queue =3D rsp->queue;
=20
 	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
+	/*
+	 * Give the room back ahead of the look at the wait list below.
+	 * Pairs with the smp_mb() in nvmet_rdma_process_wr_wait_list().
+	 */
+	smp_mb__after_atomic();
=20
 	nvmet_rdma_free_rsp_resources(rsp);
=20
@@ -1025,6 +1039,8 @@ static void nvmet_rdma_handle_command(struct nvmet_=
rdma_queue *queue,
 		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 		list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
 		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
+		/* The last response may have been released in between. */
+		nvmet_rdma_process_wr_wait_list(queue, NULL);
 	}
=20
 	return;
--=20
2.52.0


