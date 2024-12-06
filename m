Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970E0E77171
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53paUo/NtLhsF7pN8C+cqET+3d6cf3Dy8gzuWV/ss+Y=; b=wjg65EYh2enwKBAvW0Lhmubv8k
	s26XYty9u94JM4UCFPJRSmJNpuYJUAVf9zD5FqpCtQ08UBr4/9J+7vXvdXVr3Kh/vU63gCUpCGY1k
	5Nf0dGA68mp4m60HuOM1Iv1l2vvZliqdX8PV85W6oYMo0chTvlh3BlW53LKk2S2/00UiVdLZJwGFD
	y6jKP6fcnfuC1En50dx84AI6IDcnxjs0yumx6fqm7Iuj93wOWenGdVfv4MJULzQjgCgTVz2U4/vgh
	Ftmd7KxLHdL/Q1TM9Gh6zzN3/x8x1XZLlvRQv+Z3WopsdqYBLnARQOWQQTtVUAIFkQWsWylRbQ6wO
	nlEq2zLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNX9-00000000FGi-3Vdu;
	Fri, 06 Dec 2024 01:53:31 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNX6-00000000FD1-2M0o
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:53:30 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B603JgV014117
	for <linux-nvme@lists.infradead.org>; Thu, 5 Dec 2024 17:53:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=53paUo/NtLhsF7pN8C+cqET+3d6cf3Dy8gzuWV/ss+Y=; b=J5obIwmyGd33
	rMG4bodX1ku1bH1vXzNy1csP/LmXIAZcXNQLdGS4OhmxrcYHBZmChjzQ15AG8yjq
	TjWYmDQl1HFQapS21YYGuAPkQOdU4fEMJXCV0nBl/9nkPTjXx9QfkSy/uVNis+kJ
	PXTbkhyrvOqtEq2J5YODrCf36FAWHtNu12jJgKTZ+T9RgixjzMF7Wl6pmADPLnKx
	KBNcAUCbbNb+b5n8zgdlNKKsqdiCBrRBUYQaP1evEJJaQW3+M9IjeUkmncPlQ0H5
	Ge0nFqeFlrMDut2lycpYU7ZGEgcpiDTMGkCGoSLXOTZwYWlUZy6KnYYF64KtexxA
	pm82awKELg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bmru153e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Dec 2024 17:53:26 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:22 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0EB7F15B2114F; Thu,  5 Dec 2024 17:53:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 03/10] io_uring: add write stream attribute
Date: Thu, 5 Dec 2024 17:53:01 -0800
Message-ID: <20241206015308.3342386-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UhsIxSLOht9_xYi1-xlo5Zu6xQuMq3fE
X-Proofpoint-ORIG-GUID: UhsIxSLOht9_xYi1-xlo5Zu6xQuMq3fE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_175328_715658_B3144E80 
X-CRM114-Status: GOOD (  13.38  )
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

Adds a new attribute type to specify a write stream per-IO.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h |  9 ++++++++-
 io_uring/rw.c                 | 28 +++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 5fa38467d6070..263cd57aae72d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -123,7 +123,14 @@ struct io_uring_attr_pi {
 	__u64	rsvd;
 };
=20
-#define IORING_RW_ATTR_FLAGS_SUPPORTED (IORING_RW_ATTR_FLAG_PI)
+#define IORING_RW_ATTR_FLAG_WRITE_STREAM (1U << 1)
+struct io_uring_write_stream {
+	__u16	write_stream;
+	__u8	rsvd[6];
+};
+
+#define IORING_RW_ATTR_FLAGS_SUPPORTED (IORING_RW_ATTR_FLAG_PI | 	\
+					IORING_RW_ATTR_FLAG_WRITE_STREAM)
=20
 /*
  * If sqe->file_index is set to this for opcodes that instantiate a new
diff --git a/io_uring/rw.c b/io_uring/rw.c
index a2987aefb2cec..69b566e296f6d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -299,6 +299,22 @@ static int io_prep_rw_pi(struct io_kiocb *req, struc=
t io_rw *rw, int ddir,
 	return ret;
 }
=20
+static int io_prep_rw_write_stream(struct io_rw *rw, u64 *attr_ptr)
+{
+	struct io_uring_write_stream write_stream;
+
+	if (copy_from_user(&write_stream, u64_to_user_ptr(*attr_ptr),
+			   sizeof(write_stream)))
+		return -EFAULT;
+
+	if (!memchr_inv(write_stream.rsvd, 0, sizeof(write_stream.rsvd)))
+		return -EINVAL;
+
+	rw->kiocb.ki_write_stream =3D write_stream.write_stream;
+	*attr_ptr +=3D sizeof(write_stream);
+	return 0;
+}
+
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *s=
qe,
 		      int ddir, bool do_import)
 {
@@ -340,7 +356,17 @@ static int io_prep_rw(struct io_kiocb *req, const st=
ruct io_uring_sqe *sqe,
 			return -EINVAL;
=20
 		attr_ptr =3D READ_ONCE(sqe->attr_ptr);
-		ret =3D io_prep_rw_pi(req, rw, ddir, attr_ptr, attr_type_mask);
+		if (attr_type_mask & IORING_RW_ATTR_FLAG_PI) {
+			ret =3D io_prep_rw_pi(req, rw, ddir, &attr_ptr);
+			if (ret)
+				return ret;
+		}
+
+		if (attr_type_mask & IORING_RW_ATTR_FLAG_WRITE_STREAM) {
+			ret =3D io_prep_rw_write_stream(rw, &attr_ptr);
+			if (ret)
+				return ret;
+		}
 	}
 	return ret;
 }
--=20
2.43.5


