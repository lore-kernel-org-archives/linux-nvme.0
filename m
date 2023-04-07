Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183AEC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRUfXoo+zRRKwmGsi/Srk58rVRQNCgmkeDuGygd3+t8=; b=EIXLktbrxYnu9QXveNsmmiHxkX
	sSLElebHvVGI64Texn9j5wouiPEldQcj+NQLxGhJMYzGE0kbWjXXMQR7pt/NtS5KrfGgsRkyDXTfS
	bOrDARPhKt5aLbwq7ATM7M5l7Flx4Rkf3Z3tuMlAhzrY0WM7+ehjU12cfjnJ68ZdlSLNHAS/Rk5Zw
	B/bpfEtEdv8bPkU+o/cmZU6QoVSech9NgTsEOCgDHCJmIUOEOXz8ULyv+uPnJjX/yXibbzp8phAZr
	BQ2WBXOhVkXTZ1o6DLLtxNfhNo0zTZV9L/C4bUvrfdbRNFboHZR+4qDsmzabu/+uhj8xvaIjz48iF
	eVR0M1uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkrb4-00Axd9-2N;
	Fri, 07 Apr 2023 19:18:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkrb1-00AxcR-2f
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 19:18:05 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 337GiLut028093
	for <linux-nvme@lists.infradead.org>; Fri, 7 Apr 2023 12:18:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=NRUfXoo+zRRKwmGsi/Srk58rVRQNCgmkeDuGygd3+t8=;
 b=kDNSLrSU+tNp1M3FXO1PreRyCln4G5QB6Sj6SqR3C+Cj4Nsbq3yYRXcx8aLaiSBBh2UL
 7w8u196u3XX/d3ux9vqO/imUR9MVsXLPBzo8c0MGZH5VyxuX8TiabdH5yciAwDnzlxzY
 IlySIVX4TUaQEa01bhlScb6XLYxs58RiCF5a99SXsciGC4IdwMtDLwQvEj3QAR6mWM7C
 qu7dhG7xxthhNb9QTwtAY77KjbS1zA9XwaywdJsOa+cjZVff61PQFlRO74ei3C7ZbSRn
 YYPbANQj92DoRY4osLkD+vKOsmie/pDOLXlpfMOjlDgXdnVHHmkF6Gf2clGsJG/xGJ52 ug== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3pt9yhn2jf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 12:18:02 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 7 Apr 2023 12:17:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B210B157B5F82; Fri,  7 Apr 2023 12:16:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/5] nvme: simplify passthrough bio cleanup
Date: Fri, 7 Apr 2023 12:16:33 -0700
Message-ID: <20230407191636.2631046-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191636.2631046-1-kbusch@meta.com>
References: <20230407191636.2631046-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: s0dKJeO6UOXwTCchkWTQW3fWHeHIUUu0
X-Proofpoint-ORIG-GUID: s0dKJeO6UOXwTCchkWTQW3fWHeHIUUu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_121803_983572_E6909A79 
X-CRM114-Status: GOOD (  16.94  )
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

Set the bio's bi_end_io to handle the cleanup so that uring_cmd doesn't
need this complex pdu->{bio,req} switchero and restore.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e051564..278c57ee0db91 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -159,6 +159,11 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
 	return req;
 }
=20
+static void nvme_uring_bio_end_io(struct bio *bio)
+{
+	blk_rq_unmap_user(bio);
+}
+
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, void **metap, struct io_uring_cmd *ioucmd,
@@ -204,6 +209,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 		*metap =3D meta;
 	}
=20
+	bio->bi_end_io =3D nvme_uring_bio_end_io;
 	return ret;
=20
 out_unmap:
@@ -249,8 +255,6 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
 	if (meta)
 		ret =3D nvme_finish_user_metadata(req, meta_buffer, meta,
 						meta_len, ret);
-	if (bio)
-		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
=20
 	if (effects)
@@ -443,10 +447,7 @@ struct nvme_uring_data {
  * Expect build errors if this grows larger than that.
  */
 struct nvme_uring_cmd_pdu {
-	union {
-		struct bio *bio;
-		struct request *req;
-	};
+	struct request *req;
 	u32 meta_len;
 	u32 nvme_status;
 	union {
@@ -482,8 +483,6 @@ static void nvme_uring_task_meta_cb(struct io_uring_c=
md *ioucmd,
 	if (pdu->meta_len)
 		status =3D nvme_finish_user_metadata(req, pdu->u.meta_buffer,
 					pdu->u.meta, pdu->meta_len, status);
-	if (req->bio)
-		blk_rq_unmap_user(req->bio);
 	blk_mq_free_request(req);
=20
 	io_uring_cmd_done(ioucmd, status, result, issue_flags);
@@ -494,9 +493,6 @@ static void nvme_uring_task_cb(struct io_uring_cmd *i=
oucmd,
 {
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
=20
-	if (pdu->bio)
-		blk_rq_unmap_user(pdu->bio);
-
 	io_uring_cmd_done(ioucmd, pdu->nvme_status, pdu->u.result, issue_flags)=
;
 }
=20
@@ -507,7 +503,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struc=
t request *req,
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
 	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
-	req->bio =3D pdu->bio;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		pdu->nvme_status =3D -EINTR;
 	else
@@ -533,9 +528,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(=
struct request *req,
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
 	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
-	req->bio =3D pdu->bio;
-	pdu->req =3D req;
-
 	/*
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
@@ -624,8 +616,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 			req->bio->bi_opf |=3D REQ_POLLED;
 		}
 	}
-	/* to free bio on completion, as req->bio will be null at that time */
-	pdu->bio =3D req->bio;
+
+	pdu->req =3D req;
 	pdu->meta_len =3D d.metadata_len;
 	req->end_io_data =3D ioucmd;
 	if (pdu->meta_len) {
--=20
2.34.1


