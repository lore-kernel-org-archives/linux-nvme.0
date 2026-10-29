Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA035606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S0ZJj8qE;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=joSMz6qd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RTDiQUBKgzK3In0MsUcaXBTNULL9F+VMy5WtpD1WAz0=; b=S0ZJj8qEkQal+mbOwP4XWCyNpj
	a/TD7z3qUapC+SfOg5bHxrc89qCwjgVIgchl9M+VzEHShQ1DREquDQuHREglwuYO0JRTyFwPlaUVw
	CjVIcGt2HCkG6r1qnBd5QMWMAyK4FWzlbdHLR99gLcB3qeLSVE12xHeHtf6yzTNdSjsMhYmq2GlLj
	DheUHT+5Ol+YE4EhfEshQnxAxLu+KtZHmKjnicMM7rFCW7txOEYOAbyJFtUrbIQCWn2v8SRupOI9H
	0c0BSd/Pow1VbvawRicley2EnMTdG32bkFmefwgy/Va8DC1YUrCXKMBxx0wdrap5qBv60sFxEgHGC
	w7aQKQ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRU-00000009gNB-1Wdc;
	Thu, 29 Oct 2026 15:53:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRQ-00000009gDn-0cuf
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:25 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdk4P428233
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=RTDiQUBKgzK3In0MsUcaXBTNULL9F+VMy5Wtp
	D1WAz0=; b=joSMz6qdjxCurevcDu/pI5YaJVEvhxqo74adtJo8EqmReJhKR7cG6
	41DSvK1stdiOaumffBgwme9cZ58ebvhcSYck6N5fCpzKq1u1tjHrjJBP0WVyDR52
	qXtobA7IdDsGXNHHgctU+YSbuVyMUJpwgV5QWF2aePXcHR9KO5vwWQ1ATA4deEqk
	pFTJ6R/LndTFVgbSEP1Lg9RhLJCVlscNSO7WGayvqvmKuTzwWX8GRbuQeba1LIqv
	DWX7e9ggp+Im8azNT8YVCbNA26D93SgrZZA50+X1k3V3ItbSeVXp4EGL2PXOFmuY
	wpEbcY5wJpxQowHTu5VDr3w+EFm02qhQg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm5vk1jry-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:23 -0700 (PDT)
Received: from twshared8585.02.snb3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:13 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9B93C2E22CE9A; Thu, 29 Oct 2026 08:52:54 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes
 Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 05/19] nvmet: accept I/O queues on the controller's port only
Date: Thu, 29 Oct 2026 08:52:38 -0700
Message-ID: <20261029155252.2332266-6-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ccNHPXDM c=1 sm=1 tr=0 ts=6ae36bf3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=maIFttP_AAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8
 a=9HGJJ3zsGxjW7jOvuxoA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX91p0kYcJ7c9B
 Cfx2jsqXlX6TpdTFe5PbW+/07+sCrptyp9gxPlfrPWoyS5Pq8dlkpsuurLDTIGt8posb63zDTJx
 a4MNMTDMJUQfUfT72OhhaA5kAZzzHffRx9gHLChz5Vd36XEG/h2Z7HhQbFGDqYoxekAHN/5QcaG
 sOI8L8TLLqtzelGLDFaP9cy3KjlN5lJWfbWkcwSzRbdtIw+gdzhiuRWTfVye/ILyztFzdc+fi4q
 n1feEpz1s9h87j2ET0TIYgMLcLFL75z0kAf6gMOfiwfxVsRvCeql65k3lsvD7E5CtURyYGldHFE
 osAku92BPHxCogX+37pGbmxQV3aOCCW20sTlxd75nIeATNm+M9nwR7OoNjEAMdAUlIbsjeeTlme
 7TXsDlRbmyKEN+nPzroijYY2o65RPpPgYpKxbD/mXAuIXuldJJt4oRD0pO8wY8FHEqCkf3cAu/W
 uG5XLwzhYqyQAxM9E4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX25tSoPWFZ2KD
 +eSMDof0+BTQ6R691ZfDJWpur7opHyNuwspu/8fDRj/EDR+qPP7HwIepmc+PlkqJIVo8Pl49m0d
 xE6504ry4RwNGUviNTJyv6E7urHD008=
X-Proofpoint-ORIG-GUID: PAnEVVYqsiw8KxuBQTXKOIGsxTO6Iwd3
X-Proofpoint-GUID: PAnEVVYqsiw8KxuBQTXKOIGsxTO6Iwd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085324_203374_1CC16696 
X-CRM114-Status: GOOD (  15.25  )
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

From: Josef Bacik <josef@toxicpanda.com>

nvmet_ctrl_find_get() looks the subsystem up through the port of the
request, but then takes the controller from the subsystem list whatever
port it was created on. A controller belongs to one port and one
transport: ctrl->ops is that of the admin queue, and both
->install_queue() and ->delete_ctrl() assume the queues are their own.
So an I/O queue arriving on another port of the same subsystem, possibly
on another transport, is installed into a controller it has no part in,
nvmet_tcp_install_queue() writes to it as a TCP queue, and an error on
it deletes that controller. The Connect comes before any authentication.

Skip controllers of other ports, and compare the transport too since a
port's transport can be changed while it's disabled.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a8171b88035c5..27b27c83ff831 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1512,6 +1512,11 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char =
*subsysnqn,
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
+			/* All queues of a controller come in by its port. */
+			if (ctrl->port !=3D req->port || ctrl->ops !=3D req->ops) {
+				pr_warn("port mismatch.\n");
+				continue;
+			}
 			if (!kref_get_unless_zero(&ctrl->ref))
 				continue;
=20
--=20
2.52.0


