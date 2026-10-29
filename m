Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B66606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Q7aedzT;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GKoiA1ZT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TXFvoQdmbiz343GanTCv1XYa0ILtscIGFYzWRWYiZRo=; b=0Q7aedzTFKJIUCYNOXHe6/0gUw
	J/3VSNin0yleVEKqlXQxNGNW3E7owy5nM5EnqBfbeM1iG8CkK0xB/PDjovMMLl8U1ITGwmmPh4FJG
	pTkiwuGY0AjSBVxk8XAHaTuS5aQHXOAsrRH1fUpFD9/MgLStZuN2cZDmpsmEU1LwA2LnC5nRKGQbN
	RqFage6jV8V+plt36LyJ7W85q51oqLOUm0KJsLC0fniaYWktu6Uj52HCpt2lhWfqwYkZorpagR6Z0
	4Z4yW/wPYBuv+daRDZxLNWh9itNUDAP9WwgPmx0+pNz40dG7lVzQQwjyPpeBHkb3PNHYxyIC7nswq
	ghSvy6Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRE-00000009fut-37KV;
	Thu, 29 Oct 2026 15:53:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRC-00000009ftY-1ACu
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:11 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdNgf2670384
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=TXFvoQdmbiz343GanTCv1XYa0ILtscIGFYzWR
	WYiZRo=; b=GKoiA1ZT8bESudIwWu8JdNVyIBLbr3ANdXmmLxRmHaZK7NSqlo6KR
	zrG3mWLWGDmyayLQbREnjsp8s6BrPe3GMA9OGNRGHmX5L8cPB2CM/wVTIIvXs42a
	q49OBvVFKENAZHRBxLNEFhA24Ue7r5UV5A8cH5H+mtuL3E1Z1Oua1U/bV/t44YuE
	kDa1N8Z0Ba7zd/RAIgHt17tA/eqOV4rdod8LFdH0QLyzYjPE1Ipe9ES2EhxTfQBE
	Cp+2RG5Rt7RguJpCd8F2kFxj6lnyTUCfooxXRLC6x5RpwaLGP3TxMENxJCIMrsL9
	JD+vIMqN9+lwlBSJJLOyIp/3JSg99loJQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm28qjnp5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:08 -0700 (PDT)
Received: from twshared13996.31.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E28402E22CED7; Thu, 29 Oct 2026 08:52:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 15/19] nvmet-rdma: disconnect a queue on device removal
Date: Thu, 29 Oct 2026 08:52:48 -0700
Message-ID: <20261029155252.2332266-16-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX5yPvuMPj0n+W
 EZ8JDJ8UUAbQXO6/oKJRRrMRsaLBBIH0iIdCLofP8fVleThin3uqGljgDt5BztmF8hl/OH6GvAy
 zCMxiXvqCQ3F9FNbEhRiMUYkG4EFIhA=
X-Proofpoint-GUID: 4N9ffmlIwVigxUSuPDZ5FBUsoKBG_aGZ
X-Proofpoint-ORIG-GUID: 4N9ffmlIwVigxUSuPDZ5FBUsoKBG_aGZ
X-Authority-Analysis: v=2.4 cv=NudE4MdJ c=1 sm=1 tr=0 ts=6ae36be4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=gctbsQ8VDhFyPDCjFBQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX3WY2Szf11a9D
 j7itJXyjLq3x9qbAYrT3Jbo8OzOkNrHEu40sNdxwh5i8RHllfmU5uAGx5jqf4cRAhye8tHXD68m
 9w9gX49qCoBGMs1/Bt4wKBoP6NeYbfEdamH8uDjCd6nplpWrTVAUTs6wNueGq56nfUB594qQTiA
 N4GTK8wvOZ/RwPDU2nPyyYpke0LiTXyvyadnoWmCiDyfGSymbwJ48TWoWotwiD0bLWuDX7nFnkJ
 mmzIi7TuACtWos3+Uti5z/2MdVIzoB/bwXYctdx5bPImAgJKuuOmgoYCaSqCb+wyI/a735aTuXl
 yp8dJ0W6yI6gcyjIGM5E2Fj8wbuF1SalVh1TngN0HdCjujPEXpZOclYU8q0Ze0ozv8+z+puuEra
 UrObtrOCRGzWWfYCMhDiD9EVb9VqbkQPyqqeGgfukgALq6Ds1J77y+ORNNnLsmhK99Fb5nBoG1E
 K39yWD9wurdfpN8nlbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085310_349160_919BE321 
X-CRM114-Status: GOOD (  18.88  )
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

cma_remove_one() sends DEVICE_REMOVAL to the owner of every cm_id on
the device and then waits, without timeout, until they're all
destroyed. nvmet_rdma_device_removal() does nothing for a queue cm_id
and leaves the queues to nvmet_rdma_remove_one(), which only works if
that runs first. As a module it does, nvmet-rdma registers after
rdma_cm. Built in, both register at the same initcall level and
drivers/Makefile lists nvme/ ahead of infiniband/, so cma_remove_one()
runs first and waits for cm_ids that only the later callback would
destroy. Since the RDMA CM drops all later events for a cm_id once it
has sent DEVICE_REMOVAL, a peer closing its connection doesn't help
either. One connection from anyone who can reach the port hangs "rdma
link delete" until something else ends the queue.

Call nvmet_rdma_queue_disconnect() for the queue. It unlists the queue
and queues the release work, which destroys the cm_id. Don't wait for
it, rdma_destroy_id() waits for the handler to return, which was the
deadlock before commit f1d4ef7d8883.

Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in d=
evice removal")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 35fd3f3c35dc1..412d48fe7e26a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1780,10 +1780,13 @@ static void nvmet_rdma_queue_connect_fail(struct =
rdma_cm_id *cm_id,
  * queue cm_id and/or a device bound listener cm_id (where in this
  * case queue will be null).
  *
- * We registered an ib_client to handle device removal for queues,
- * so we only need to handle the listening port cm_ids. In this case
- * we nullify the priv to prevent double cm_id destruction and destroyin=
g
- * the cm_id implicitly by returning a non-zero rc to the callout.
+ * The RDMA CM waits until each cm_id of the device is destroyed, so a q=
ueue
+ * has to go now. Our ib_client also removes the queues, but it cannot b=
e
+ * relied on here: built in, it is called after the RDMA CM's client.
+ *
+ * For a listening port cm_id we nullify the priv to prevent double cm_i=
d
+ * destruction and destroying the cm_id implicitly by returning a non-ze=
ro
+ * rc to the callout.
  */
 static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
@@ -1791,11 +1794,7 @@ static int nvmet_rdma_device_removal(struct rdma_c=
m_id *cm_id,
 	struct nvmet_rdma_port *port;
=20
 	if (queue) {
-		/*
-		 * This is a queue cm_id. we have registered
-		 * an ib_client to handle queues removal
-		 * so don't interfere and just return.
-		 */
+		nvmet_rdma_queue_disconnect(queue);
 		return 0;
 	}
=20
--=20
2.52.0


