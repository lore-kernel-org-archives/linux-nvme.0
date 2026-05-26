Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E1CD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7v7SPpPFPV1yDP4KqRuB7xXNIKeDCvwI8hMe3fSdAY=; b=Ydfy6mm2V4uiXY5z3b4/cRdSaJ
	bfVXX0NKJLCeYHzW3Q0/hquRW4R4NJyNcXY2mH5T19o8Yx8cz906eZKENeJEimi5BahcZ1rbAhWJ4
	/yBd2tMYevLy4qedjsC+CZ7v5pP1C2nT6c3aJ+lS/fFjGtPsts8uyU3Www4THy+6pB60dq+9iSOSV
	gB+tDfMnh9QQYzx2ldRsM1yAcHfthRltztSOS18W6wjvMN5+7IuUatUAgrCe3K+4YdX/tsWCXHLBV
	fq9KciAQAnDHQ4o0YthM8mki+6Jh508Dkhl/wdqa5aujkIeNFtbax+lp6j2Kd6DKekysg7rO6d5M5
	qgj/JPoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtsY-00000002Ovd-0TAT;
	Tue, 26 May 2026 15:39:38 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRtsV-00000002Ou8-20en
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 15:39:36 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PKuCHn1978827
	for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 08:39:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=u7v7SPpPFPV1yDP4KqRuB7xXNIKeDCvwI8hMe3fSdAY=; b=liak0ri0qq4v
	FjM/Sf6SKBlU8oYlEHsCM4wcxMf2YBP0+qIr7946ZaW/2q+TXUNELQxDkIX/O5Fp
	SmKrPp8g9prsmFGUKh3SMtdLAJ00hTjz5tnG4RqqjEUjIeWIh2nwK36UZyCwEadv
	5+Y509kxdFI+c7Q+UDZ5liLxw3JffqP1N2ponmmV74hTeB8lMh4FnqCnqd9amiYb
	UekiX59nJ+1wqgIBqMAB0//4a4Xc5f7F54ionJICKFfknZe+zr8MJ+MWX4EV1qT3
	wwJmSAaZKQ+1ucFxEj850GrCC3EVILWDEz3xJN/mV/oMv+7vKhWW74i2H4DCOsHS
	maQCKatYtw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ec08tjvy1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 08:39:34 -0700 (PDT)
Received: from twshared10183.03.snb3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:39:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4EE7C1CA8D4B9; Tue, 26 May 2026 08:39:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Date: Tue, 26 May 2026 08:39:21 -0700
Message-ID: <20260526153921.2402015-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526153921.2402015-1-kbusch@meta.com>
References: <20260526153921.2402015-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNSBTYWx0ZWRfX91XBSvBZAMzf
 zTtr7I90Byigrhl/IJ7Mo2vEFsZ6cfqgdgDo5Z6XT4f82WImOCMY9Rf/m0RIapDYzFtUMmBNgzC
 x5mtJXSApG8rCNk1dMTN0zGu4OJURG2DyX4Fsh2vB9LBIshAxkJn/f1lsFJnBX3crruKWNtwYjA
 523GiLftu06Sa9UaSBVubEwz4fm7H2Wc5PqJ59odYDlf+pfXT29Kk6fjR7rBLJfa0WkWEJ0l98j
 0DKulJtMlVC86wdaKVtmoP7kRQgtnTZUrnT9OP0Cu+HYOLbh8pl31SlAnA64u9ebERl2wtlBq/p
 I18JdGuBjClsD3sYKbGqUljtHiY6CRx7qPvlNs8ab7+eVNpiat+eCbhr9AaEFHBY7N+ueLiAqHm
 1pX9dGqpXtZAnDiE6O/ABzkEPNWT+ACrcsgTgoc7qcVwDGaB+6H2poNLW/5Lajxyibr13GRjjA1
 sgaHe76YXvQKvRM9aYg==
X-Proofpoint-GUID: Mzff21RrVmg8XitWE3KJ8zAhPrNchfve
X-Proofpoint-ORIG-GUID: Mzff21RrVmg8XitWE3KJ8zAhPrNchfve
X-Authority-Analysis: v=2.4 cv=LvKiDHdc c=1 sm=1 tr=0 ts=6a15beb6 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=xT7lm6qD1slQ1dElJxQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_083935_524384_E37B9C9C 
X-CRM114-Status: GOOD (  13.00  )
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

Don't skip io accounting for passthrough commands if the user enabled
tracking these.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 4 ++++
 drivers/nvme/host/multipath.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 08889b20e5d8c..38ca04567406a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -102,8 +102,12 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
 		struct nvme_command *cmd, blk_opf_t rq_flags,
 		blk_mq_req_flags_t blk_flags)
 {
+	struct nvme_ns *ns =3D q->queuedata;
 	struct request *req;
=20
+	if (ns && nvme_ns_head_multipath(ns->head))
+		rq_flags |=3D REQ_NVME_MPATH;
+
 	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags)=
;
 	if (IS_ERR(req))
 		return req;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 263161cb8ac06..d0a95cde181c4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,9 +175,12 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
 	}
=20
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	if (!blk_queue_io_stat(disk->queue) ||
 	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+	if (blk_rq_is_passthrough(rq) &&
+	    !blk_rq_passthrough_stats(rq, disk->queue))
+		return;
=20
 	nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_op(rq)=
,
--=20
2.53.0-Meta


