Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRKdI9FoLbuq0PeAQhfWVuhCemwnoLP4pZ0ot+Rsjdo=; b=IUsnUGvQoh4RFs7RKyl+Zv1KJq
	2bq4X1a2KXQxwLmMH+B3D0fLkNURQUYcu4cQh8kiq+W6r3MdxxJuEBnzlypT1h4+LrTcuDfw77o1s
	mi14/vPSkaB0U9qDLeqzfVCP0UN3kE8T+haGffaIa+BdlRIE3OvDYDneFAzGr2rtcFSHh6aTYBO0a
	Q1R4QksGBdLodkHlNSR0NTI8DloQdrLF2kd1/YaQvIC/Cj4Ik4wdZdjzAv8GzUfzjUsnACeAkrvkz
	C9ZN01ia5wO5cgKLR2WvXHF/BlPadHoJhg5jr9l53TBddXIK/lkFRQyF/6gYLA+fcudsYWS19RjvU
	Qh1dD5mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3R4-00ArXk-5q; Mon, 25 Apr 2022 18:27:46 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PU-00Aqik-S5
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:26:11 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23PHPMFD009884
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IRKdI9FoLbuq0PeAQhfWVuhCemwnoLP4pZ0ot+Rsjdo=;
 b=A7lFdRnSB9WUWrdVqQr9Z1qQRhRu9MGljwvCmGNlDn7Z9cK/DDHQQFv+yBoZD+DUoM+I
 w3aoj2qD0/yTe3TGBDX5wBqvW7SVNuS0WLneEkwmeP0SJzVIpJ3jMyWf7inLnohw3GoY
 5ZDmQnMnb9tN+9d/da6Faw1k2cXqXjB3i0g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by m0089730.ppops.net (PPS) with ESMTPS id 3fmcy4vb6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:07 -0700
Received: from twshared10896.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:26:06 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 65515E1F2A6B; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 12/12] io_uring: support CQE32 for nop operation
Date: Mon, 25 Apr 2022 11:25:30 -0700
Message-ID: <20220425182530.2442911-13-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x68F59GsJtqsztbw_osVrxXxuiTAJfVm
X-Proofpoint-GUID: x68F59GsJtqsztbw_osVrxXxuiTAJfVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112609_079681_C57D96B1 
X-CRM114-Status: GOOD (  20.43  )
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

This adds support for filling the extra1 and extra2 fields for large
CQE's.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index caeddcf8a61c..9e1fb8be9687 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -744,6 +744,12 @@ struct io_msg {
 	u32 len;
 };
=20
+struct io_nop {
+	struct file			*file;
+	u64				extra1;
+	u64				extra2;
+};
+
 struct io_async_connect {
 	struct sockaddr_storage		address;
 };
@@ -937,6 +943,7 @@ struct io_kiocb {
 		struct io_msg		msg;
 		struct io_xattr		xattr;
 		struct io_socket	sock;
+		struct io_nop		nop;
 	};
=20
 	u8				opcode;
@@ -4872,6 +4879,19 @@ static int io_splice(struct io_kiocb *req, unsigne=
d int issue_flags)
 	return 0;
 }
=20
+static int io_nop_prep(struct io_kiocb *req, const struct io_uring_sqe *=
sqe)
+{
+	/*
+	 * If the ring is setup with CQE32, relay back addr/addr
+	 */
+	if (req->ctx->flags & IORING_SETUP_CQE32) {
+		req->nop.extra1 =3D READ_ONCE(sqe->addr);
+		req->nop.extra2 =3D READ_ONCE(sqe->addr2);
+	}
+
+	return 0;
+}
+
 /*
  * IORING_OP_NOP just posts a completion event, nothing else.
  */
@@ -4882,7 +4902,11 @@ static int io_nop(struct io_kiocb *req, unsigned i=
nt issue_flags)
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
=20
-	__io_req_complete(req, issue_flags, 0, 0);
+	if (!(ctx->flags & IORING_SETUP_CQE32))
+		__io_req_complete(req, issue_flags, 0, 0);
+	else
+		__io_req_complete32(req, issue_flags, 0, 0, req->nop.extra1,
+					req->nop.extra2);
 	return 0;
 }
=20
@@ -7354,7 +7378,7 @@ static int io_req_prep(struct io_kiocb *req, const =
struct io_uring_sqe *sqe)
 {
 	switch (req->opcode) {
 	case IORING_OP_NOP:
-		return 0;
+		return io_nop_prep(req, sqe);
 	case IORING_OP_READV:
 	case IORING_OP_READ_FIXED:
 	case IORING_OP_READ:
--=20
2.30.2


