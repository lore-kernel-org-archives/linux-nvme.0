Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F5606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dTy4zJ+C;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=iaQq92B9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Z7Xz+p3svCSWY9f8BmFKQ6FCusKWD2Cceq9sSXAodEc=; b=dTy4zJ+Cb8iSsWMtuy8azV3sjU
	BP8w1mceZXZMUIyaEkZlPjK7DKAtBoxKLKhoVl1GX14XGmJ0uMsotXqpH5PgW2QcLl4CgPDX0pedf
	JyDAimUwhXp/cSlhWXfA3tP18QbtcUl+HCE7xVMj1WFKA9OmLwF7qLRFuR86lvq5PcXd3eSmD9/C8
	vFpewRvjVsgf/0qH6ni8jKKZgEPa+4oe7vtbh2cKpi76Me88Hq2wx+/LHFEyhU0bxeAKEiqfQ+No3
	ksvdppEsSN5omsT9Xm/NbvFhOgg7OmsI9HhYJ4OaWd/WxtLBzWy4ThFk4775aGk7uvMoOxJunVCiP
	Cil4svkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRZ-00000009gZC-1RGy;
	Thu, 29 Oct 2026 15:53:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRS-00000009gI0-2Oph
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:31 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCe3Pn2479599
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Z7Xz+p3svCSWY9f8BmFKQ6FCusKWD2Cceq9sS
	XAodEc=; b=iaQq92B9qoY+OmiygnCRRNqXoWuQ2kicPb7dpFwlwZ6bhgdUQAdOS
	15mb1rK55I8UMHECimJmWyxEGxxoRv0Zu1XrSWELqDPNukaTh4VIMOk9Umsj4t1O
	0OMisazTYkqWKpvcDYbLDt0DkHc4On23/QIhNC0xLkQcNDfixyD9ZSHgulz+bIat
	23XSsrN6qiT5sEVG6qJpAxPXXtmAZxZgK3/yIcOxYwtJVmza5niHAJ9SRJg9CoI3
	qqO6f+7XRnZzBdMIMJL4Oy7v5HFsI8otFZRW6FOuIfullW2lh8K+MtOWFLV4t41f
	B5tN9RaalO63fILTg+aqXpDUcEhsrsveQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hm5yr9mav-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:25 -0700 (PDT)
Received: from twshared9449.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2A2EF2E22CE80; Thu, 29 Oct 2026 08:52:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 03/19] nvme-fabrics: reconnect if the association is gone
Date: Thu, 29 Oct 2026 08:52:36 -0700
Message-ID: <20261029155252.2332266-4-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S8NMU4sP c=1 sm=1 tr=0 ts=6ae36bf5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8
 a=66UzTaHhsia4Zur4bU0A:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX8fIdsLSHv5lD
 qPv3hJZe+K5+9YZ2J+ifkgUbqJqM1Pv+QXrI8HRN3kFQko8ZgbW8Uob3Hrm5GZZHBPds8/YbgZR
 q8QBzhmT8bJJ9dpk/b1aiumby6Joqkc=
X-Proofpoint-ORIG-GUID: sYSH6FSTfp2vygzKhFlkj7awQ7mBr6xg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX3+pJF4Tocz4C
 r0XM//7hwlPzeRKDqxq7A5bcmWEFYxHgIiYVqVkD4oHLuiffS1FN2otsMHbynHI0ReYsDwxpK44
 DnaH03LxplSf9km0Xr/f0fzOsF+fxpbacG8zwMKq6jAJ27ZqTyhKVo7Hrs+Q/nwUnUCqfwkXsXp
 lXrDoiSfuMOmGuM9CKAY7IUOCv5HJ+Jxs4I681G4uYH7nAQwcXChHK/vJNpAiN6MZ8Xm7/suXTr
 utp9IufHevHVf9SkuQTtr/yt2WLBLdpT8Ak5nyJkMfwG57pUfXAFzVpC/5+QQA1Now6JNzp9BPy
 ouVFkCA7+07l6MtjuybvAnAOuvBPnxbEUA4y3Y1Nq1SLpOhivIpBIRYi1q3LzXGyYiepYFgR2cy
 68MfP6QiILbB99lY0WgiHA496mZLSpEBhUNBMKn6SAYm9vv7YjBe28QjkFwJzF/h9WqJ9C7Wx7B
 uJ48JF9fIvQ1GEi5SSw==
X-Proofpoint-GUID: sYSH6FSTfp2vygzKhFlkj7awQ7mBr6xg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085326_763400_83AC24AC 
X-CRM114-Status: GOOD (  18.45  )
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

A reconnect connects the admin queue, gets a controller ID, and connects
the I/O queues with it. If the controller goes away in between, the
Connect of an I/O queue fails with Connect Invalid Parameters pointing
at the cntlid, with DNR set:

  nvme nvme0: Connect Invalid Data Parameter, cntlid: 1
  nvme nvme0: Failed reconnect attempt 1/600
  nvme nvme0: Removing controller (16770)...

nvmf_should_reconnect() honours DNR and the host deletes the controller
with 599 attempts to go. DNR is right in that resending that command is
pointless, but the next attempt would create a new association with a
new cntlid. This is not a verdict on the host like a failed admin
Connect is.

Treat it as a lost association and return -ENOTCONN, so the retries are
bounded by ctrl_loss_tmo like after any other loss.

Fixes: adfde7ed0b30 ("nvme-fabrics: short-circuit reconnect retries")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fabrics.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d7ad86c1955f..aeff98e16d6d5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -542,8 +542,19 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u1=
6 qid)
 			NVME_SUBMIT_RESERVED |
 			NVME_SUBMIT_NOWAIT);
 	if (ret) {
-		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
-				       &cmd, data);
+		result =3D le32_to_cpu(res.u32);
+		nvmf_log_connect_error(ctrl, ret, result, &cmd, data);
+		/*
+		 * The controller ID we got from the admin queue's Connect is
+		 * not known any more: the association has gone since. DNR is
+		 * right about this command and says nothing about the next
+		 * association. Don't let nvmf_should_reconnect() see it.
+		 */
+		if (ret > 0 &&
+		    (ret & NVME_SCT_SC_MASK) =3D=3D NVME_SC_CONNECT_INVALID_PARAM &&
+		    result >> 16 && (result & 0xffff) =3D=3D
+				offsetof(struct nvmf_connect_data, cntlid))
+			ret =3D -ENOTCONN;
 		goto out_free_data;
 	}
 	result =3D le32_to_cpu(res.u32);
--=20
2.52.0


