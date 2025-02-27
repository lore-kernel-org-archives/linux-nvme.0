Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412C5C197BF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=717Fucz3MwnGMkuf5ctouUv4BVsW93ozRQBD9opCJkQ=; b=oLosRZt/CSJZaLF1gCEn9fmtHq
	FuwAb5Siscp0zxVqOuo6ZLsz1xxPjPf3LAcvk1nc4qQzXr/0TKkQ0AqaHXKPIrcRUNf7Y7tHpSn/z
	m8EFtwrcrZmfKU+QS1mIpT2R1DOsOGV23qim0XZl3u/x0QhIzyfzwyJRWtCjH0+1fZuVSrz0h0bxY
	2QxPHyUNH5atZaClKg3G7l2pIxNdyn/TicpjoV3nBTIVDL8JIQwXjTEhadel9OPl172g1Refs4tHn
	OPbPxTCdio16JqZwj70j2wGdLuR7qMbD5oB6alqWbOP3vsq1w6J/4fmOChrplbusfr5vwn2Eqbruo
	opZP37qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmaZ-000000093pv-1HbT;
	Thu, 27 Feb 2025 22:42:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmaX-000000093pJ-4627
	for linux-nvme@bombadil.infradead.org;
	Thu, 27 Feb 2025 22:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=717Fucz3MwnGMkuf5ctouUv4BVsW93ozRQBD9opCJkQ=; b=VtXL+4bHxuOL+zTsaPhmT3EdWk
	JRc2etsrAGOXdWaY+MnhyH48ld2HDYdWUloy5c9KlwsoAgoFfKQqwdRGVxKrLQLHCp6yLMBS6B08R
	3Ahxe9+6BdR/y+V3SVKgcbGw/QH2FX1Om58jN6uLgUeNNYhP3l+h7HlA9m/kX6kFYy3DRxSmjbJul
	yS7uzyadSb9bwcSDtuRCnz/EI9BKvzDXvdgjjH9Ff9aDGYxla4ACqHB1ILvOvklQLzUVIIyh8JeET
	Hh766kSHti4QOWxBlY79oDJEmN2CMSbBvK46CZMsG94WjBDKJ+W22+rfCbA+R/E+CSsCzPA4xh35J
	QDn2ikug==;
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmXl-00000003qtw-1YGR
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 22:42:40 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMdi6P011870
	for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 14:39:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=717Fucz3MwnGMkuf5ctouUv4BVsW93ozRQBD9opCJkQ=; b=aIPfjGx1z/yV
	5TRQN8Qjk/WqZZSDDuNdIFzdWFk0Gy7NfDnXp9GMaB/r+bEgwPL5MvZPTBzCM5u5
	AoRF13MrFDX9FRaUygErP2dXgM0hf1DGj4f1d6pTClkFBhyUig4FjryZ50kUpBGU
	SQP1Sq4hakF3cfgWmmqOC+9Qa7/xd4TSfB2tf/OMmZZ37XMM5GzqqfzL1ezDr69O
	C4/n28L2+MzlNp8Z0ZwOGYochL6Si4+ZEp+L/qt7Q5lrtJhhwXhrHEfAwMqER90u
	fCFgdRTihblFGkkQfHcjzg9ZoT8ZYCcqqbdJng3L5ykKIgi4gQzTL6eBxJJoTsHo
	fx5nFy7gqQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 452wtb9ntv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 14:39:47 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 22:39:14 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6DE311888280C; Thu, 27 Feb 2025 14:39:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <axboe@kernel.dk>, <asml.silence@gmail.com>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-nvme@lists.infradead.org>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv8 1/6] io_uring/rw: move buffer_select outside generic prep
Date: Thu, 27 Feb 2025 14:39:11 -0800
Message-ID: <20250227223916.143006-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250227223916.143006-1-kbusch@meta.com>
References: <20250227223916.143006-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oTAJU6uCBkDmPDPmjFER3OlGOVeFxzVU
X-Proofpoint-ORIG-GUID: oTAJU6uCBkDmPDPmjFER3OlGOVeFxzVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_224039_530407_5CBA6A64 
X-CRM114-Status: GOOD (  12.66  )
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

Cleans up the generic rw prep to not require the do_import flag. Use a
different prep function for callers that might need buffer select.

Based-on-a-patch-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 io_uring/rw.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 788f06fbd7db1..b21b423b3cf8f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -248,8 +248,8 @@ static int io_prep_rw_pi(struct io_kiocb *req, struct=
 io_rw *rw, int ddir,
 	return ret;
 }
=20
-static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *s=
qe,
-		      int ddir, bool do_import)
+static int __io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe =
*sqe,
+			int ddir)
 {
 	struct io_rw *rw =3D io_kiocb_to_cmd(req, struct io_rw);
 	unsigned ioprio;
@@ -285,14 +285,6 @@ static int io_prep_rw(struct io_kiocb *req, const st=
ruct io_uring_sqe *sqe,
 	rw->len =3D READ_ONCE(sqe->len);
 	rw->flags =3D READ_ONCE(sqe->rw_flags);
=20
-	if (do_import && !io_do_buffer_select(req)) {
-		struct io_async_rw *io =3D req->async_data;
-
-		ret =3D io_import_rw_buffer(ddir, req, io, 0);
-		if (unlikely(ret))
-			return ret;
-	}
-
 	attr_type_mask =3D READ_ONCE(sqe->attr_type_mask);
 	if (attr_type_mask) {
 		u64 attr_ptr;
@@ -307,26 +299,45 @@ static int io_prep_rw(struct io_kiocb *req, const s=
truct io_uring_sqe *sqe,
 	return 0;
 }
=20
+static int io_rw_do_import(struct io_kiocb *req, int ddir)
+{
+	if (io_do_buffer_select(req))
+		return 0;
+
+	return io_import_rw_buffer(ddir, req, req->async_data, 0);
+}
+
+static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *s=
qe,
+		      int ddir)
+{
+	int ret;
+
+	ret =3D __io_prep_rw(req, sqe, ddir);
+	if (unlikely(ret))
+		return ret;
+
+	return io_rw_do_import(req, ddir);
+}
+
 int io_prep_read(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_DEST, true);
+	return io_prep_rw(req, sqe, ITER_DEST);
 }
=20
 int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_SOURCE, true);
+	return io_prep_rw(req, sqe, ITER_SOURCE);
 }
=20
 static int io_prep_rwv(struct io_kiocb *req, const struct io_uring_sqe *=
sqe,
 		       int ddir)
 {
-	const bool do_import =3D !(req->flags & REQ_F_BUFFER_SELECT);
 	int ret;
=20
-	ret =3D io_prep_rw(req, sqe, ddir, do_import);
+	ret =3D io_prep_rw(req, sqe, ddir);
 	if (unlikely(ret))
 		return ret;
-	if (do_import)
+	if (!(req->flags & REQ_F_BUFFER_SELECT))
 		return 0;
=20
 	/*
@@ -353,7 +364,7 @@ static int io_prep_rw_fixed(struct io_kiocb *req, con=
st struct io_uring_sqe *sqe
 	struct io_async_rw *io;
 	int ret;
=20
-	ret =3D io_prep_rw(req, sqe, ddir, false);
+	ret =3D __io_prep_rw(req, sqe, ddir);
 	if (unlikely(ret))
 		return ret;
=20
@@ -386,7 +397,7 @@ int io_read_mshot_prep(struct io_kiocb *req, const st=
ruct io_uring_sqe *sqe)
 	if (!(req->flags & REQ_F_BUFFER_SELECT))
 		return -EINVAL;
=20
-	ret =3D io_prep_rw(req, sqe, ITER_DEST, false);
+	ret =3D __io_prep_rw(req, sqe, ITER_DEST);
 	if (unlikely(ret))
 		return ret;
=20
--=20
2.43.5


