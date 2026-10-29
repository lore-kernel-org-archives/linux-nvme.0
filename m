Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80B606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=skZDjrg/;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Q0XER3ct
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tcqBYeIlCd2ckB4LxZaVSeLZ4/m7gRvyyTLSgnPssmk=; b=skZDjrg/C8fBiWzUVrtvFhd4cp
	iF8DPe7IFtAhvCORkK2pv+BIPA4SbZgI5skYX5wxzeCveydU1HXCBW9356wqWbzXVn01naQzfEHZM
	mFQhMDJYwq1mVWdjTSVhI4JNNTBJCmoRBHzM4l8APuGuDuNhU/cGbaiJSGY/ebRsR6hbxxadcpC2D
	w/S9c7MGnELAE3AQD8uxGwudEpWX595XGQgbJobQAMPAE8tiBOCx+UH3CGArYADpf6yGT86X+lENi
	Z554v9NCJs4UC8qpaQlDX72CtVzD1dQLvn077saMFdDLXt0dqkzQBi2WtbilUfwNbCtd5z0iNdIYo
	mSGvTjng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRk-00000009grz-0UoB;
	Thu, 29 Oct 2026 15:53:44 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRZ-00000009gZ4-3OcF
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:41 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCcsBW2894964
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=tcqBYeIlCd2ckB4LxZaVSeLZ4/m7gRvyyTLSg
	nPssmk=; b=Q0XER3ctR36QjewEjZcgco3a1JBdMhFY2SHkG3+1f9ld9gkPEaBFt
	o8rm893LBYBLYdMlotJLa6rmeNIRw8sappwsXqopxG7OulwwN0oCOEcIWwpgUsiq
	wi/JutusHJk7RQcZr0LRmEQ/Uuk1GlujdSBgvVGBdoeYZO3p3+TbsGEUIHV/eZ5i
	LWgv9jWW95TB+ET+jwyYGyiTFs34gzZFjrCBFCzib3l6BTnLAVKnZI4vWQ4GTi8g
	E3bjJEOAo7ycezxfL0rEQRrRhbLy++sLfUrB5DQtj6g5V9rjIrabYmd51FbZrHRS
	9PLRJg4Y52dmKMJGUhVpDC49P3eCmS64w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hjypur6e9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:32 -0700 (PDT)
Received: from twshared0305.01.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 59BB02E22CEC8; Thu, 29 Oct 2026 08:52:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 13/19] nvmet-rdma: take a device off the list last
Date: Thu, 29 Oct 2026 08:52:46 -0700
Message-ID: <20261029155252.2332266-14-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eI0-n46RczC0hFDwck8pN0p30LC6B9Dr
X-Proofpoint-GUID: eI0-n46RczC0hFDwck8pN0p30LC6B9Dr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX/QEIxymyxVTm
 OP4biYdlN0WaIlB6ddEvWZW5RR0YSGN/yFVCUcQdR4Ydot+ExTzcsXJdetIl3lL4umOKlWVDfJM
 y+rB5tGIGTTeMK2QqHjtSh1NzE/x+QI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfXzJqEKKzAobK1
 BIeN0Vj/IZMzD8aDdzAcy5m68HrPgm/nhr9B3a42Rs/pIuoWm1buW/AA4Yw4EDsrBhTjgqYdXlV
 dYLrC0jA/nJtzMFmcskHdFFbM8BDZHRIDxKParo65SfSo+NtSyKfsT5Wk9aNOuhbzSWSDRWHxBa
 EbWTBPSJs7a4AjecGqmQjywMXgKnAp4mRBmrlOXVOo4tfF3IzW1zkDXH2pjlKC+2paGVXeOEFXc
 +1Qh5ObcHUYqRmYrhKrdwCKgsHH/HfFFTVozrk6antFQZAukbIUF0+FJLjG8kfgCvM1uVWZwR5s
 NQzJMU+dsTT52Euwd9tc+EgDEcGK/II29j+ihtm2pvwi04SMJqOwapj4/w8peYA560+Vk+2M8KY
 pN4BDklRz0ZSAH+7qxJlOJjFjQIL7mJG5+Qhi/I0JCZgDAl/IXGZyOC8o2VaL3EAuyHGsNwhguM
 9HJwK/qN9ZhfnK7V1Bg==
X-Authority-Analysis: v=2.4 cv=bPmDs/+Z c=1 sm=1 tr=0 ts=6ae36bfc cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=-iJHC2yFU5qgFxQsWSsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085334_016672_CE6ABC25 
X-CRM114-Status: GOOD (  14.19  )
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

nvmet_rdma_remove_one() disconnects the queues of a device and flushes
nvmet-wq, but since commit a3dd7d0022c3 it returns right away if the
device isn't on device_list. nvmet_rdma_free_dev(), run by the release
work of the last queue, takes the device off that list first and frees
the SRQs and the PD afterwards. A device removal in between finds
nothing on the list, returns, and the RDMA core frees the device under
ib_dealloc_pd().

Free the SRQs and the PD first and unlist the device last, so the
remove callback finds it and its flush waits for the release work.

Fixes: a3dd7d0022c3 ("nvmet-rdma: Don't flush system_wq by default during=
 remove_one")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fc0c85076cee4..fe91df653e5cf 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1197,13 +1197,17 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	struct nvmet_rdma_device *ndev =3D
 		container_of(ref, struct nvmet_rdma_device, ref);
=20
+	nvmet_rdma_destroy_srqs(ndev);
+	ib_dealloc_pd(ndev->pd);
+
+	/*
+	 * Not earlier: nvmet_rdma_remove_one() waits for the release work that
+	 * got here only if it finds the device on the list.
+	 */
 	mutex_lock(&device_list_mutex);
 	list_del(&ndev->entry);
 	mutex_unlock(&device_list_mutex);
=20
-	nvmet_rdma_destroy_srqs(ndev);
-	ib_dealloc_pd(ndev->pd);
-
 	kfree(ndev);
 }
=20
--=20
2.52.0


