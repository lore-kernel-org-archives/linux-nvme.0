Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB29D64085
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 20:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZD1lyriaTdTAo7xj8F47G4Z4f/YwLOtay5hq6Zxzmo=; b=HWeQBDpLZoudoKqRpcXXvaSRhP
	A2ZTdgy1/+0D8xgsabjr7sY324k2ptq6axc742v01KRyI2xpY+ftHYw1jMPPL75Qkt2soWS6fcI9z
	93qMrm5SoBNqZljAp2nfgbDRYfN6A3GKI4A+vG2rh8EQb5r9lZVSsundvt0zqzIXUaaf9REApweLr
	bZPVze/pNffnxQC57kD04iISVnU+hbhEmzmGbf2cgkTYvjUJcKZP4QlkodxCbzGdWqlCZ5sNbBzBI
	0nHZptI06RkOtE7+96N3CZSnsRxjapWenDbzOGa9HcU27ZMmPDuo2/HQOLwQX7sf87XlUPEebThtf
	jjsS6JnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VEe-0000000BpJf-1vVe;
	Fri, 08 Nov 2024 20:05:36 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VEc-0000000BpI7-0L1K
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 20:05:35 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8HPehj008049
	for <linux-nvme@lists.infradead.org>; Fri, 8 Nov 2024 12:05:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=YZD1lyriaTdTAo7xj8F47G4Z4f/YwLOtay5hq6Zxzmo=; b=VPtbd3Y/0aGh
	ViYVeslDUPnLVOKyWrbgKeQXHnTtMB7tiSkymLTFgdB3/H3DKeh6mYsqovwbx4FG
	DkyFRT5s5zbmMjWVdOIBtE3+VsAKdWccOT9u3LsGyQk7jBiSfu3EPSiGbxgL9pET
	PfUSK5b/ZQ5+mmDkKP/XM8a85Epduu8i8BOt6MxTv6wPwNkvmFw46KbUuDRZMhhz
	qcu6ACU/VoTR2SX3XB4crF6sGeSMQb8EgDFGBb5sg4fRX7ME+y7FLqkaiOAg+Pgm
	cSwX4IWwB6kPqkJc5iwxzOjbdTzY3avQJOGhRwj2hTz+Sp45OiEaiy+4vlfek1yS
	8lnwhbvKCg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42sn4pt617-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 12:05:33 -0800 (PST)
Received: from twshared26967.08.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 8 Nov 2024 20:04:59 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A640814E3A03A; Fri,  8 Nov 2024 11:36:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <asml.silence@gmail.com>,
        <javier.gonz@samsung.com>, <joshi.k@samsung.com>,
        Nitesh Shetty
	<nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv11 6/9] io_uring: enable per-io hinting capability
Date: Fri, 8 Nov 2024 11:36:26 -0800
Message-ID: <20241108193629.3817619-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108193629.3817619-1-kbusch@meta.com>
References: <20241108193629.3817619-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: phWKMCf9J9tJ-vdX_zawNudN8vQz06v8
X-Proofpoint-GUID: phWKMCf9J9tJ-vdX_zawNudN8vQz06v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_120534_155515_5903531D 
X-CRM114-Status: GOOD (  15.16  )
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
can be limiting for block device as all the writes will be tagged with
only one lifetime hint value. Concurrent writes (with different hint
values) are hard to manage. Per-IO hinting solves that problem.

Allow userspace to pass additional metadata in the SQE.

	__u16 write_hint;

If the hint is provided, filesystems may optionally use it. A filesytem
may ignore this field if it does not support per-io hints, or if the
value is invalid for its backing storage. Just like the inode hints,
requesting values that are not supported by the hardware are not an
error.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/io_uring.c           | 2 ++
 io_uring/rw.c                 | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 56cf30b49ef5f..4a6c95c923eb4 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -98,6 +98,10 @@ struct io_uring_sqe {
 			__u64	addr3;
 			__u64	__pad2[1];
 		};
+		struct {
+			__u64	__pad4[1];
+			__u16	write_hint;
+		};
 		__u64	optval;
 		/*
 		 * If the ring is initialized with IORING_SETUP_SQE128, then
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 076171977d5e3..115af82b9151f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4169,6 +4169,8 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
+	BUILD_BUG_SQE_ELEM(48, __u64,  __pad4);
+	BUILD_BUG_SQE_ELEM(56, __u16,  write_hint);
 	BUILD_BUG_SQE_ELEM(56, __u64,  __pad2);
=20
 	BUILD_BUG_ON(sizeof(struct io_uring_files_update) !=3D
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 93526a64ccd60..fdab23424f386 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,7 +279,7 @@ static int io_prep_rw(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio =3D get_current_ioprio();
 	}
 	rw->kiocb.dio_complete =3D NULL;
-
+	rw->kiocb.ki_write_hint =3D READ_ONCE(sqe->write_hint);
 	rw->addr =3D READ_ONCE(sqe->addr);
 	rw->len =3D READ_ONCE(sqe->len);
 	rw->flags =3D READ_ONCE(sqe->rw_flags);
--=20
2.43.5


