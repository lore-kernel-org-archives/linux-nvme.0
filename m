Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10CD374BA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwIAJzKtghZAIEiijCWk0Jg1lUOZ2HiT8OKL2/Nxeyw=; b=AhEXjU9kkQiy3g/6ri21icLELP
	Y3MSy/992Sd+4JUtRj09E0IHSfNW3Je4ek6pe8OugobhHcb/e8/xlZrQUatkbaa3y26e1J7LubZUB
	phA8EtwGsT68W2dJCQinwSaRMk7c8DwsrpTPlPoCW4pu1fb0czgWg9CbOXqEByHvKjyim8PHsl5Fz
	3wA3rsNN5jM/vO3lK4go1e1P5Xzvh1j3z6eTvYMJ94Jb6R7DNCh8qf1wDEAVZPUqU8egpPDsHPSy4
	tFJ5KQBL45uFzQ7TWlSD4gUkfbqnBiJpsox28O9WWBVfgOFTgQALgxLkGmCBOE4whNsT1267WHSHN
	wQis5y2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T5m-0000000FQlg-1sfh;
	Thu, 17 Oct 2024 16:11:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T50-0000000FQTI-0Z2M
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:10:30 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HCh1EQ006877
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=OwIAJzKtghZAIEiijCWk0Jg1lUOZ2HiT8OKL2/Nxeyw=; b=FGgxopGSbfeG
	cR3367fdrM3pzFWzkCm0xyt1u49tMM6qW0Z7/6+5SCc461cyI2xXVGqi3uJM6fsG
	lMXxrZPwCdyde3JV5anhVfd8PMiy/R3VOcda2oPgpa1kO4zSYpXHBuCH8gjbhgU2
	FAvPafjsRyA/5Pd7GnVDojQJ5URdTvIaeZNhMzHoNfqffP3jAT/LX9EVNiP85was
	F4At58YRz8fjPmIfKdA4DyLWdq/8jvM8i329lYonUhjQRZW7kgAAuRoxxlRbZl/N
	XXZdNx9mYdOOFHcLBGChQW1PEjDvrwsXEHqqmmGKSfJeGWF36M+NxzKc9I8AxEib
	J4dHLplH2w==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ar0mn3pw-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:25 -0700 (PDT)
Received: from twshared29849.08.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 16:10:20 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id F0491143A4B14; Thu, 17 Oct 2024 09:10:18 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv8 5/6] io_uring: enable per-io hinting capability
Date: Thu, 17 Oct 2024 09:09:36 -0700
Message-ID: <20241017160937.2283225-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017160937.2283225-1-kbusch@meta.com>
References: <20241017160937.2283225-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -0Eri_3zV4q2AE3IsytVYt85pGJjsgt7
X-Proofpoint-GUID: -0Eri_3zV4q2AE3IsytVYt85pGJjsgt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_091026_211188_ED403F1D 
X-CRM114-Status: GOOD (  16.84  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

With F_SET_RW_HINT fcntl, user can set a hint on the file inode, and
all the subsequent writes on the file pass that hint value down. This
can be limiting for block device as all the writes can be tagged with
only one lifetime hint value. Concurrent writes (with different hint
values) are hard to manage. Per-IO hinting solves that problem.

Allow userspace to pass additional metadata in the SQE.

	__u16 write_hint;

This accepts all hint values that the file allows.

The write handlers (io_prep_rw, io_write) send the hint value to
lower-layer using kiocb. This is good for upporting direct IO, but not
when kiocb is not available (e.g., buffered IO).

When per-io hints are not passed, the per-inode hint values are set in
the kiocb (as before). Otherwise, per-io hints  take the precedence over
per-inode hints.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h |  4 ++++
 io_uring/rw.c                 | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 86cb385fe0b53..bd9acc0053318 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -92,6 +92,10 @@ struct io_uring_sqe {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u16	write_hint;
+			__u16	__pad4[1];
+		};
 	};
 	union {
 		struct {
diff --git a/io_uring/rw.c b/io_uring/rw.c
index ffd637ca0bd17..9a6d3ba76af4f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,7 +279,11 @@ static int io_prep_rw(struct io_kiocb *req, const st=
ruct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio =3D get_current_ioprio();
 	}
 	rw->kiocb.dio_complete =3D NULL;
-
+	if (ddir =3D=3D ITER_SOURCE &&
+	    req->file->f_op->fop_flags & FOP_PER_IO_HINTS)
+		rw->kiocb.ki_write_hint =3D READ_ONCE(sqe->write_hint);
+	else
+		rw->kiocb.ki_write_hint =3D WRITE_LIFE_NOT_SET;
 	rw->addr =3D READ_ONCE(sqe->addr);
 	rw->len =3D READ_ONCE(sqe->len);
 	rw->flags =3D READ_ONCE(sqe->rw_flags);
@@ -1027,7 +1031,10 @@ int io_write(struct io_kiocb *req, unsigned int is=
sue_flags)
 	if (unlikely(ret))
 		return ret;
 	req->cqe.res =3D iov_iter_count(&io->iter);
-	rw->kiocb.ki_write_hint =3D file_write_hint(rw->kiocb.ki_filp);
+
+	/* Use per-file hint only if per-io hint is not set. */
+	if (rw->kiocb.ki_write_hint =3D=3D WRITE_LIFE_NOT_SET)
+		rw->kiocb.ki_write_hint =3D file_write_hint(rw->kiocb.ki_filp);
=20
 	if (force_nonblock) {
 		/* If the file doesn't support async, just async punt */
--=20
2.43.5


