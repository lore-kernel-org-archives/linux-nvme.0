Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173AAC19F32
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/rvD21U8zQ6S1LUw7Ft4KPhPGl3wO16d7e5rYdZ1sM=; b=Ak3G35up65NaTghdm2/fzSIYXu
	is8Yj9pj+c12Lz/+nvHhEeWMwaS2A9cmCHdmg8qNBDufNV41mJoZT9D45wLlibRBnXUd3T7vn7WDj
	fdfLNFsU4542tmoTXxZIqZi9EHwCRVbOvMOTGpZijXzPP1NQ6TJt8GLsj1859PT86e6Srzgp73T3n
	UxcR1oti1GhyJwNzbBiJHszTXIiL2k6tCjEWnCf4tVHQK/HE6NpZ7xjI6dHoi+fFTNsH5PZlCzWGT
	ZLWiNTCF8+vL+VuouTde7pX/3LuRCwvT5TzWPJzbfXts80ACXRfv74yJSs8dyodIYzW8E+tKz+2/a
	sRjyQx+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmY0-000000092xH-1dxx;
	Thu, 27 Feb 2025 22:40:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmXs-000000092rh-2kkW
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 22:40:02 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMdi6M011870
	for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 14:39:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=c/rvD21U8zQ6S1LUw7Ft4KPhPGl3wO16d7e5rYdZ1sM=; b=Akr2HU5EQlFn
	Ei4zV5oDaV2kKUYbt/L7XlG3V5JUGz6bI19UNQ3x6u7r8gms+h3VrQ8PqYWMazhR
	KQ9vCXFmfOjfJADjrvtLYaPyvy5k9/pUCrmSYBlPfDg21K4X+TfMFD+LV2IbXfFp
	YQVtdDQE1EJr17Qp0+7IaljDqwfPiEadsgK7yxbEEjPHAlCbi7QXScyvW1KidVId
	2n14Ixw8CYdhrlLw9b1/+a7um08H8Z4z5/261pWJwWF2GzZrclfHE5OR+L4rxGj0
	VYHaBUi0U8MO//xYYey57/2FHKVnfZWWtW64vi9B6i3bx/N0OWgDXoFJI5uzt7zY
	7VuHBm4uZA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 452wtb9ntv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 14:39:46 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 22:39:14 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C14AF18882811; Thu, 27 Feb 2025 14:39:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <axboe@kernel.dk>, <asml.silence@gmail.com>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-nvme@lists.infradead.org>, <csander@purestorage.com>,
        Xinyu Zhang
	<xizhang@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 3/6] nvme: map uring_cmd data even if address is 0
Date: Thu, 27 Feb 2025 14:39:13 -0800
Message-ID: <20250227223916.143006-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250227223916.143006-1-kbusch@meta.com>
References: <20250227223916.143006-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hGA1mPFNnO220ucXIUh3SCmF5ZVXQIJD
X-Proofpoint-ORIG-GUID: hGA1mPFNnO220ucXIUh3SCmF5ZVXQIJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_143957_245302_CEAF4FFD 
X-CRM114-Status: GOOD (  13.80  )
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

From: Xinyu Zhang <xizhang@purestorage.com>

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.

We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.

With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index fb266cf1f8c66..98a0750c0cda5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -512,7 +512,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout =3D d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
=20
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret =3D nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec, issue_flags);
--=20
2.43.5


