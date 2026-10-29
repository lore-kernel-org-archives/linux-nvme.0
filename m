Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BD606A31D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E7W8u2ua;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Y2mfu4lM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1fA4L6vVwLUG9yuV8SiTz0PeavUphzjXyRL271kzcBY=; b=E7W8u2uanhy/VG+Fc8f0rAHgiR
	z7gcIcqRNHTiNsIInQPmkXq+/01YR8RQSEJAlNuZqL5ZxFgHNhCyqI+fSU3qiUPeDBcSh0qSKTNSN
	Y2OpykwAV7awVYdRTYA15oVQG4dWUUKUScJRwxZHAhTW2E7mKzaYvoDvJTwTzHz24Ua/ASV9OZWCK
	BkyyF7DEB2MLXS6gefx8PnM9CU5E73cu58V7e2iIcJ1Uu3s8O9NYl3CElEuzO1XkjGF8/tJXyxHcK
	my30QidBQyV0zl6UBjQ82sW4rOc+875VVaQ0o3eoqTYVPL97lySo3lKGfs+9pAg5izbarSHCy3GXF
	8p/h3USA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRR-00000009gGm-2cfW;
	Thu, 29 Oct 2026 15:53:25 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRO-00000009g82-1ihV
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:24 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCe3Pg2479599
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=1fA4L6vVwLUG9yuV8SiTz0PeavUphzjXyRL27
	1kzcBY=; b=Y2mfu4lM/AfXGYUENAh/M5XTWgjSDT0LDJZJlRDM5P1qE7hDttUb/
	/CwWAreDxTUtdJNyJ+Ms4LipFrm9RB7leSATrQlJbwJMTbenEsh+SYlamrEMVy0S
	9Wg8QJP6SJWLTw66OqvT34VolHZ24W1TDz5vH3bsQodJF+1ekM4C0rOX4/HiXaNR
	cTapELYs7sXbMvSQyDOuhi/GCj5Gaf7/xGlulC4YM8coNDpBrzo7/n0HQe+5Fykv
	/0sgyEfhqwtFV9eMzLKN4hCexKBmTIEFKHxNFVFXPvvb9Dmo6TxJ7OB02eKejrEl
	FBAIsZ/vWQTFtUNVch60ukbpw7GoqrSZg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hm5yr9mav-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:21 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0F9122E22CEDA; Thu, 29 Oct 2026 08:53:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 16/19] nvmet-rdma: reject queues larger than max_cqe
Date: Thu, 29 Oct 2026 08:52:49 -0700
Message-ID: <20261029155252.2332266-17-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S8NMU4sP c=1 sm=1 tr=0 ts=6ae36bf1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=EhnfFaKZJmXXlGDJ228A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX4S4kt5p3VMMo
 DVhQOyWUOFNEhQiM7PAWwwZpCOxqn7MkzzBoPQpxr2/HggvbTepzA4Cc3TIlD5emtykCr3NccXJ
 mYb7C/vDhHRNDZJ1q2BDyR83txNnuRo=
X-Proofpoint-ORIG-GUID: Jn9c92fmQJOH33-OR78bpJ6jxyywcA45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX8fj2246eWNPe
 ActTwi2/ko8sADPLAmOnvoWvONlHp/fNA6KKTv8WdoaefXaSMHf3JBGDbbf3hxeRvrdP90pFpyz
 lBYZpZHmkZMSAGqKjsJAQeLeVrWTV+2Xn6j8N2wW93M96iTuup7ufnU97h4lOOu9lHLpnW5fV7J
 rZ6YdpKFSGteFFGIXoVuEzO2Ig5BsDJ2vYbMeDeCn23d3rcVnQOUmcIvFpGfs2TnalU53/Yn7Is
 f/Jebyf74mNEaOKBZaXjyG9VSItdgKNaVB30mzSGi1vGNiqup7roSGFXj1lWR37Mw2coGt5TmRn
 08iDC6fAmZ3ktFjp2qNeYnHWPFCHSLbdmFPQ2G2C/AG5iSCMFuf4f07Bmn2FaELsXCac+y5inD5
 9DgUoVXBWRFTGE8BxczerMCe8WDaIQVrC8q9zfcQ7we+1H2CpkPlxUZ53oCr6TdlJvSIiPUCRIE
 OZ3d5LfbWe/yowee72Q==
X-Proofpoint-GUID: Jn9c92fmQJOH33-OR78bpJ6jxyywcA45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085322_688520_B79234FA 
X-CRM114-Status: GOOD (  16.70  )
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

The host picks hrqsize and hsqsize in its RDMA CM connect request, and
nvmet_rdma_create_queue_ib() asks ib_cq_pool_get() for
recv + 2 * send + 1 CQ entries, up to 196607 for an I/O queue. The
pool limits each CQ it allocates to the device's max_cqe, so if the
request exceeds that no CQ ever fits and ib_alloc_cqs() keeps adding
CQs until an allocation fails. Those CQs stay until the device is
removed. rxe has a max_cqe of 32767, and one connect request from an
unprivileged process OOMs a 1 GiB target in under a second, with
nothing to kill that frees the memory.

Refuse a queue that needs more than max_cqe entries before touching the
pool. The connect is rejected with NVME_RDMA_CM_NO_RSC like any other
queue creation failure.

Fixes: ca0f1a8055be ("nvmet-rdma: use new shared CQ mechanism")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 412d48fe7e26a..fced200678853 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1293,8 +1293,17 @@ static int nvmet_rdma_create_queue_ib(struct nvmet=
_rdma_queue *queue)
 	 */
 	nr_cqe =3D queue->recv_queue_size + 2 * queue->send_queue_size;
=20
-	queue->cq =3D ib_cq_pool_get(ndev->device, nr_cqe + 1,
-				   queue->comp_vector, IB_POLL_WORKQUEUE);
+	/*
+	 * The host picks both sizes. Never ask ib_cq_pool_get() for more
+	 * entries than one CQ of the device can have: no CQ would ever fit,
+	 * and it would allocate new CQs until an allocation fails.
+	 */
+	if (nr_cqe + 1 > ndev->device->attrs.max_cqe)
+		queue->cq =3D ERR_PTR(-EINVAL);
+	else
+		queue->cq =3D ib_cq_pool_get(ndev->device, nr_cqe + 1,
+					   queue->comp_vector,
+					   IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret =3D PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe=3D %d ret=3D %d\n",
--=20
2.52.0


