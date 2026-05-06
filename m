Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFFECD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s7mmEU5nlh9OE6vrATepLGMmvXXq1GG+E+msH05dN3I=; b=Hm6WDqGS3xBcwUJ0mpZ2FOCDZR
	HZbVKgA20VAXYP5zeYe6qNkxpbl07zV1cagTFhaDDUB56Ii2rXfMWjgo4YWMz0f8fEnTmuQPE66FW
	taHdUpnPsb6ApIGkxHxQN0LwvX0zjD/khLXqWS/4WGvck2Nc2NBtQ23UhI+2+HNRckBUNWEpeebcc
	6kcKotqdg9tXnGCg7Kq6gUt91k2Z1p92h6Rm+p4522X8PG0Jj9QRqt9GG0ab7MZvhXPTJ9FL09bwS
	ILbe5cXofZDNccdgP39Cpzt/labxUbXgV9CvCCryxclGBfTmc+2i7iPa+JSWqR+ci4reQ7YKPedZv
	SyRgxUPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKc9g-00000000sA8-26Un;
	Wed, 06 May 2026 13:19:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKc9f-00000000s9b-0m80
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 13:19:11 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6464GPOW937487
	for <linux-nvme@lists.infradead.org>; Wed, 6 May 2026 06:19:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=s7mmEU5nlh9OE6vrAT
	epLGMmvXXq1GG+E+msH05dN3I=; b=RZSn9sxFQ6YIk+PUT9Y4GTUd6s2i9JgAa/
	WLufc3DnHiSObOg5Zy1CMirYAA0aVbBjj1Ol7xmFubOYS7tpa+cShZRj67NYTqVf
	jUDticD+4kjvENwvpoj7J/RLib8qtZT/DfRlZjlzdi19YLm0c80iNQ320V7H3+0P
	0ICUPE6OzuqD4Hupx+rPeYKB5Zt5IUfyYl97Ma9r1mGsjH6npiTdY6tQbNqLbaBu
	UgcAu3rv91maDfCQYq9zSueW8gnBgqUlkbRfrPsDFcm/Sk/ben16Gf7mRFTZbKpR
	D1GtaCG5025VTEtegIuMWPkgroR46Nitx3sLjUCObsrEz4tdwEUA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwda0r93t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 May 2026 06:19:10 -0700 (PDT)
Received: from twshared2072.03.snb3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 6 May 2026 13:19:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 24D3E16D00165; Wed,  6 May 2026 06:19:01 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix bio leak on mapping failure
Date: Wed, 6 May 2026 06:19:00 -0700
Message-ID: <20260506131900.2367091-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _nz6485btf7ZOX7LG6G7LJi2VQ73x2Gt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzMSBTYWx0ZWRfX1ycWWHBDjeKE
 9KAkA/f7Pmhk1NazGxo3+pDi+VIawN5CFTdBWXEZ3mik/V5CH9cdAA5J6nDTtDMpUFdZtIPliP8
 fvhLocOmz0q5apcPEH2v7xm9Z5RtrMhDuLEB/wIZ8wXSKR1r11dplrKkhPavt9DMpj/X8SNABJd
 APH0+kvz7l/UnDgtKkzPY80PYXPKSXZ7XmzgQJ5XmTVaRfLHy1G83Xl4R9lko2K6eajMMVqlLK2
 Wvgg86ppaRSuuUe144T4dVAlZHLyFZla9bN1yZxUTRJmjdQelvEYxa/EzQrHk729HuSSXOS1Zme
 K0+djV6lhrbOGePT49u2CG7KH3gF2CXJJwbS0H0h8/TLiHWQ67oykn0gzoxjQufLfTn3wjbZ/ac
 u7bidvbN6eOWwwXZqGftcNgowZYG7jMoLTKju5X11tMwJ4owlwbZS7nAcc47Fnn8jBQU6tCGlJj
 ykBJVnBFvvDCvrsY6sQ==
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=69fb3fce cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8 a=VsPqTqfqlmuscwx6VwAA:9
X-Proofpoint-ORIG-GUID: _nz6485btf7ZOX7LG6G7LJi2VQ73x2Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_061911_231701_68BCBF4E 
X-CRM114-Status: GOOD (  12.13  )
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

From: Keith Busch <kbusch@kernel.org>

The local bio is always NULL, so we'd leak the bio if the integrity
mapping failed. Just get it directly from the request.

Fixes: d0d1d522316e91f ("blk-map: provide the bdev to bio if one exists")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 39d6e69cbbe72..df2b7a66f6310 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -122,7 +122,6 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 	bool supports_metadata =3D bdev && blk_get_integrity(bdev->bd_disk);
 	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
 	bool has_metadata =3D meta_buffer && meta_len;
-	struct bio *bio =3D NULL;
 	int ret;
=20
 	if (has_metadata && !supports_metadata)
@@ -146,8 +145,8 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 	return ret;
=20
 out_unmap:
-	if (bio)
-		blk_rq_unmap_user(bio);
+	if (req->bio)
+		blk_rq_unmap_user(req->bio);
 	return ret;
 }
=20
--=20
2.52.0


