Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9685EC021BC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VdThkb+RRcWXrvMKEbaOWgaU8H96LXHKVFz/+nZDMjc=; b=fbJtF3Lr0cVmoxoegxldRUpKvu
	b82cgEcHS/QC2IYBoqMldj3mHIx61DOMLzYiUJ9LxDo2EPLwuqoi6yXtjra/nd4+zeDYqgo/s57Ta
	dGoBCiNHWV37EugpwrJpoMhmALI2E/TWXESv9TmDTS1zB/UCwhdnWujAp4J0gTFt5dJdWSffdA4DX
	sTryaz/iR9vV8lD66pS8qnZM0IuzCrog1SOrZ6SZ8QY7O2PEIjgFRaETW+tMk/zFKIgHoeYuLm00b
	hzx37WEZB1+hNsSMJBxdw7JyFvi0ijue35YhrSwb0sqsCk+PHhVAtm67S0NVAvAcSJ8j56Ba/+C4w
	hVVQTsGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLtD-00000004s94-49ha;
	Wed, 26 Feb 2025 18:12:11 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLrc-00000004r2C-21F3
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:10:33 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51QF150B008877
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=VdThkb+RRcWXrvMKEbaOWgaU8H96LXHKVFz/+nZDMjc=; b=XvEfXI1TxAeb
	N+3sxhH8LDJOLYcou2LHonRe+QnUAq9OAkoHVojbq9CPCexNwW+dMR0JEoW0qAqI
	fM/YNQVHFmcv+fVfjvKPTbTtUP2jycC1nccX9PZrNGf+NW0amNW9Kpyd9BReCq8W
	i55GxgP2XhpVdLyszDj7UmrvtbU+K/KQek5DrxhEq+onfaLOgZDOHEGTfjo00ZJF
	Eh9AHeBBqpGiggCjVYsfhtu2MGJ9r9K2lLavwCnXNzoCUG1dAgsrVyMW09+ratFY
	GMgPvXML7aReC42ja/hieXbpuXiCpLu6GQyVyXUhunRjg74uq0rBJlvcaWCozAQ2
	GIiGKi8Z9w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45257r9fsh-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:31 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 18:10:05 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B0B7E187C4AD6; Wed, 26 Feb 2025 10:10:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 1/6] io_uring/rw: move fixed buffer import to issue path
Date: Wed, 26 Feb 2025 10:09:53 -0800
Message-ID: <20250226181002.2574148-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226181002.2574148-1-kbusch@meta.com>
References: <20250226181002.2574148-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gP6lzhXd7DFad5JFyWmOOpL8-UIkYQHk
X-Proofpoint-ORIG-GUID: gP6lzhXd7DFad5JFyWmOOpL8-UIkYQHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_101032_651128_AE22A846 
X-CRM114-Status: GOOD (  14.97  )
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

Registered buffers may depend on a linked command, which makes the prep
path too early to import. Move to the issue path when the node is
actually needed like all the other users of fixed buffers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 io_uring/opdef.c |  4 ++--
 io_uring/rw.c    | 39 ++++++++++++++++++++++++++++++---------
 io_uring/rw.h    |  2 ++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 9344534780a02..db77df513d55b 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -105,7 +105,7 @@ const struct io_issue_def io_issue_defs[] =3D {
 		.iopoll_queue		=3D 1,
 		.async_size		=3D sizeof(struct io_async_rw),
 		.prep			=3D io_prep_read_fixed,
-		.issue			=3D io_read,
+		.issue			=3D io_read_fixed,
 	},
 	[IORING_OP_WRITE_FIXED] =3D {
 		.needs_file		=3D 1,
@@ -119,7 +119,7 @@ const struct io_issue_def io_issue_defs[] =3D {
 		.iopoll_queue		=3D 1,
 		.async_size		=3D sizeof(struct io_async_rw),
 		.prep			=3D io_prep_write_fixed,
-		.issue			=3D io_write,
+		.issue			=3D io_write_fixed,
 	},
 	[IORING_OP_POLL_ADD] =3D {
 		.needs_file		=3D 1,
diff --git a/io_uring/rw.c b/io_uring/rw.c
index eb369142d64ad..728d695d2552a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -346,31 +346,30 @@ int io_prep_writev(struct io_kiocb *req, const stru=
ct io_uring_sqe *sqe)
 	return io_prep_rwv(req, sqe, ITER_SOURCE);
 }
=20
-static int io_prep_rw_fixed(struct io_kiocb *req, const struct io_uring_=
sqe *sqe,
+static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_fla=
gs,
 			    int ddir)
 {
 	struct io_rw *rw =3D io_kiocb_to_cmd(req, struct io_rw);
-	struct io_async_rw *io;
+	struct io_async_rw *io =3D req->async_data;
 	int ret;
=20
-	ret =3D io_prep_rw(req, sqe, ddir, false);
-	if (unlikely(ret))
-		return ret;
+	if (io->bytes_done)
+		return 0;
=20
-	io =3D req->async_data;
-	ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir, 0);
+	ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+				issue_flags);
 	iov_iter_save_state(&io->iter, &io->iter_state);
 	return ret;
 }
=20
 int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *=
sqe)
 {
-	return io_prep_rw_fixed(req, sqe, ITER_DEST);
+	return io_prep_rw(req, sqe, ITER_DEST, false);
 }
=20
 int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe =
*sqe)
 {
-	return io_prep_rw_fixed(req, sqe, ITER_SOURCE);
+	return io_prep_rw(req, sqe, ITER_SOURCE, false);
 }
=20
 /*
@@ -1136,6 +1135,28 @@ int io_write(struct io_kiocb *req, unsigned int is=
sue_flags)
 	}
 }
=20
+int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags)
+{
+	int ret;
+
+	ret =3D io_init_rw_fixed(req, issue_flags, ITER_DEST);
+	if (unlikely(ret))
+		return ret;
+
+	return io_read(req, issue_flags);
+}
+
+int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags)
+{
+	int ret;
+
+	ret =3D io_init_rw_fixed(req, issue_flags, ITER_SOURCE);
+	if (unlikely(ret))
+		return ret;
+
+	return io_write(req, issue_flags);
+}
+
 void io_rw_fail(struct io_kiocb *req)
 {
 	int res;
diff --git a/io_uring/rw.h b/io_uring/rw.h
index a45e0c71b59d6..bf121b81ebe84 100644
--- a/io_uring/rw.h
+++ b/io_uring/rw.h
@@ -38,6 +38,8 @@ int io_prep_read(struct io_kiocb *req, const struct io_=
uring_sqe *sqe);
 int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_read(struct io_kiocb *req, unsigned int issue_flags);
 int io_write(struct io_kiocb *req, unsigned int issue_flags);
+int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags);
+int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags);
 void io_readv_writev_cleanup(struct io_kiocb *req);
 void io_rw_fail(struct io_kiocb *req);
 void io_req_rw_complete(struct io_kiocb *req, io_tw_token_t tw);
--=20
2.43.5


