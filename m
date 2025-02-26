Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BA7C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhZprq/fhlitTeHklVfwoWYolzCx7OIds6d1dWBk5OU=; b=ZSm2owljRQ4SIwo86wjVcqM5tt
	oguFBkfBQBHPUf6T1+ViE5/GI5GpcBCc2kSf1DeTp2Z2Dvcj55Vfx34hD+BIEbFQICkE2xX2SxCEr
	CQpp1vwLkm5QJYmC3+P4mlioqzFATRQ00z6pBceAwAPWeD/yRhSx1VUaS/f4f+lSWtVUGmY74KRHd
	g1Wf9BPe9RoaU6jhbGuq6/458tSl0V1Z77kPAImD/AVpcGvhuIpe7NNluuaKjDz1c06IpDe+Ke5nQ
	Vz4ipHoQpFxqZUcWgnyvGPxC09Uv+GFDpY/u3DEZYI6gfK+DA3v0V7zQxPHqqVwzrmQt/JIHkW+QL
	e8dJw9nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLtE-00000004s9a-2f0W;
	Wed, 26 Feb 2025 18:12:12 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLrd-00000004r2x-1FRD
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:10:34 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51QF150C008877
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=rhZprq/fhlitTeHklVfwoWYolzCx7OIds6d1dWBk5OU=; b=JV3DJufDEZRv
	UcWxXaQHaNWMiLDtYRaHTSFAc6ZfTeoYUyYWjwi1XBpfT0D8ixAaWvyS5FIUY6Qn
	Bf3McKFkogAYa6aGmV/iKZv0oGlJRHcgQ0ollT/4VvBK6ijyyhBLO12nP82zq7VJ
	5W9knOntwf0TiO3OZBBGgzGle+BVcIkMaaWMND1APsp1VzM/HWuhqFk7BH2nfxQK
	HjlfO/sjUbPTj0rZh7+mbYhlvutXxvOkr74x1XXXwYux+lvpivRiJy3+h2vSTcJx
	jpvYPMKG3TUAhPGRBDqBYzDIIkv6UB/JLN/FLiEwS0JZCIronrCzlS6YIB23DGS4
	XkkauovyHg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45257r9fsh-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:32 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 18:10:05 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D3491187C4ADE; Wed, 26 Feb 2025 10:10:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        <linux-nvme@lists.infradead.org>,
        Xinyu Zhang <xizhang@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 3/6] nvme: map uring_cmd data even if address is 0
Date: Wed, 26 Feb 2025 10:09:56 -0800
Message-ID: <20250226181002.2574148-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226181002.2574148-1-kbusch@meta.com>
References: <20250226181002.2574148-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2MBKu3dmnsEDCmHuxabKrF0DCG_xQ7rG
X-Proofpoint-ORIG-GUID: 2MBKu3dmnsEDCmHuxabKrF0DCG_xQ7rG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_101033_471348_54BAC559 
X-CRM114-Status: GOOD (  14.25  )
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
index 5078d9aaf88fc..ecf136489044f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -516,7 +516,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
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


