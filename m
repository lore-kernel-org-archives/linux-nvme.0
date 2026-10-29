Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B17606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0fjK6xYg;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=F+eP7RZO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RX5ORDDX9+Z2RvSJipTBoht8fLHvT6CuKfszh+EDtaY=; b=0fjK6xYgmavJ11Kn+l8TNnV2ir
	MV2IEpcpormGkgDeZgzJolUJnb3Mjl58ov400yArQwlX8/Dprnjitm61hJDHrlTZ8pW4Oqc+LhH7+
	7kHBG/1XTG21GW50LfOH1Si0/P8STe/oFtvMVwb9+/xmGyDc6gpmDVXtijAdEPfOK3/wVc9svOgEM
	U2ZfbDzS4ht/MABWjxR4GqDEVCuQjRoGbrINP69aYjH6hBBHUA/8EO/xJeJc8WL5WUwXmvqVFjyRb
	DCFbohi8RER6zVkOhe6cjm80otBiTBXV8lSIbKQZga5mt0e6O77VTM/AzmTbzr5ogCHJ1B0bItCrc
	POg0W/lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRK-00000009g28-1OGc;
	Thu, 29 Oct 2026 15:53:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRG-00000009fvb-3wgz
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:16 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCd5cg2477664
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=RX5ORDDX9+Z2RvSJipTBoht8fLHvT6CuKfszh
	+EDtaY=; b=F+eP7RZOT3TaoBO5VltJhMoM7s2+T0j3fFUh87J3qtU9Z760Lvxys
	iS6Bxhu33fEjj2lpUVkg8vuj9z/Nc8vzqHHq/a6u6ZfzrtJglm6ueLCHyVy9j3cX
	7Y0WPPq++sRQ5pKzd2CAOnuLSFqFV7QEjIXQAf0C/841KvkTEDMQXyAliOHi5Uyv
	L3gCp7XHcAtf5itw/4MYNtDPP8zIqhcEVHWBp/XV1R0ergZU5+eSLGDdtkdjniGt
	RtJQAbcTHEqL/pqCJDTllwBUBbp+J7SK4VhBUt+mXDj8imHTT6mtoKnJfuUmdxl1
	fWvyrlo4xJpHq3DNtN6bHgrjibPeEkXwQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hm5yr9m9b-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:13 -0700 (PDT)
Received: from twshared13996.31.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1E9162E22CEDC; Thu, 29 Oct 2026 08:53:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 17/19] nvmet-rdma: don't run the wait list recursively
Date: Thu, 29 Oct 2026 08:52:50 -0700
Message-ID: <20261029155252.2332266-18-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S8NMU4sP c=1 sm=1 tr=0 ts=6ae36be9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=3Mfn_JQTHNHXCUR_PKIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX6ZuXsPr+UkyO
 MxPWiZ/b+g0ckrK+OB04EjyO8jv75YZFuomRJ5WwKdyuw3i3KQeCoQxMuXfzMky+Qfx7Qw4Ihr6
 IVZTzhYoFWcrYCZ6QcC65yzxjkWqPtg=
X-Proofpoint-ORIG-GUID: 6KpTVS0eeuLaIRNGDRevR-CpAGqHlOgI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfXw/NioJ+9y8ga
 CQ+60POSdQs6cF2FXrrznSEZ5znvM17UIIXzzUTcszdX5bcxkXa0WePF+PRrHlM6II30X91g5zv
 /Ep1ggF1AtRUB2SXaLxjF38acnGXrz4bB3teOZCj99bFLwX1mn+QtvhrMGV6F7QSfd+Pd7a4s6j
 eJovZTJK2AwuKT81YYbZSUTIOGL5O8sMq6UDYZ8nMUhw0QhC+YFVntrEigrnxqEhpaCe22v8Paz
 PiH59p41Bng5vieAPnMHn+gcmnLBMZ/53WNwJzCMhBkzb5CKdvwAt5H9oJoZESkuw+chAr4QcoR
 g2JAnGNGVO7FZYaDbBWKsr+WfEdZfJPmXEANNgFcEDoZIi0y65GfXGxRZCS+lquZxFy1KyMBS7i
 +horO8TOXD1X+rSyRrW6wDInhXSrma5zhGAy7mwNMkTrhZ8wsiR326qq0CFvP1GSZq1s+kZ+8uj
 IRb/JpCI2dnWYS+ysoQ==
X-Proofpoint-GUID: 6KpTVS0eeuLaIRNGDRevR-CpAGqHlOgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085315_155157_983C3AC7 
X-CRM114-Status: GOOD (  22.46  )
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

nvmet_rdma_release_rsp() returns the send queue slots of a response and
then runs the wait list, passing each waiting command to
nvmet_rdma_execute_command(). Many commands complete inside their
execute callback, and if the response can't be posted,
nvmet_rdma_queue_response() calls nvmet_rdma_release_rsp() right there,
which starts another run of the wait list inside the first:

    nvmet_rdma_process_wr_wait_list()
      nvmet_rdma_execute_command()
        nvmet_execute_admin_connect()
          nvmet_req_complete()
            nvmet_rdma_queue_response()
              ib_post_send() fails
              nvmet_rdma_release_rsp()
                nvmet_rdma_process_wr_wait_list()

Each waiting command adds a level while posts keep failing, and the host
decides how many commands wait: it sizes the receive queue, can fill
the send queue with commands that nvmet_req_init() rejects without
taking a slot, and over siw can make posts fail by holding back an
RDMA READ. 400 waiting Connects overflow the stack of the CQ worker.

Before the loop executes a command, point the response's new
wait_released at a flag on the loop's stack. A release that finds it
set means the loop hasn't returned from that command yet: it returns
the slots and releases the response, but sets the flag and leaves the
list to the loop instead of running it. The flag tells the loop not to
touch the response again.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target dri=
ver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fced200678853..1e434cc451c28 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -77,6 +77,8 @@ struct nvmet_rdma_rsp {
 	u32			invalidate_rkey;
=20
 	struct list_head	wait_list;
+	/* set under rsp_wr_wait_lock while the wait list's loop executes us */
+	bool			*wait_released;
 	int			tag;
 };
=20
@@ -511,23 +513,42 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_d=
evice *ndev,
 	return ret;
 }
=20
-static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *que=
ue)
+static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *que=
ue,
+					    struct nvmet_rdma_rsp *done)
 {
 	unsigned long flags;
=20
 	spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
+	if (done->wait_released) {
+		/*
+		 * The loop below has not come back from this command yet. It is
+		 * further up this stack if the command completed in place and
+		 * its response could not be posted. Otherwise it runs in
+		 * another context. It goes on with the list, so leave the list
+		 * to it.
+		 */
+		*done->wait_released =3D true;
+		WRITE_ONCE(done->wait_released, NULL);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
+		return;
+	}
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
+		bool released =3D false;
 		bool ret;
=20
 		rsp =3D list_entry(queue->rsp_wr_wait_list.next,
 				struct nvmet_rdma_rsp, wait_list);
 		list_del(&rsp->wait_list);
+		rsp->wait_released =3D &released;
=20
 		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 		ret =3D nvmet_rdma_execute_command(rsp);
 		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
=20
+		/* A released response can be freed, or in use again. */
+		if (!released)
+			WRITE_ONCE(rsp->wait_released, NULL);
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
 			break;
@@ -680,8 +701,9 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_=
rsp *rsp)
=20
 	nvmet_rdma_free_rsp_resources(rsp);
=20
-	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
-		nvmet_rdma_process_wr_wait_list(queue);
+	if (unlikely(READ_ONCE(rsp->wait_released) ||
+		     !list_empty_careful(&queue->rsp_wr_wait_list)))
+		nvmet_rdma_process_wr_wait_list(queue, rsp);
=20
 	nvmet_rdma_put_rsp(rsp);
 }
--=20
2.52.0


