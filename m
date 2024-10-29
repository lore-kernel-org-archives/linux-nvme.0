Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15034D3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTdC5rR2uiEoWSlqFgEly23JIAf0RJlPvmvSok+NdlE=; b=RPZwMWVXPkDqRfp48gznM6GvS7
	Gr7i+BlYRWgvm7ZCAhmEB9rxijjARSkHaWraQFe4tFWVIV+HRNMK7RdfkTEp2Yp9B0ElX6M+gY6do
	sFVSAHklTfw8xvVHp+cnAueKuplJT/Ei1ZfpPjEi8swejsi0/JQ5bmcaD02iUTGwp9+CRLwZpRQtU
	waOyoXNjlHVvCsVal17XP9QUpCtzH5oUQx9aFrzEsXDh00JyVj2FHEmTbH6xHrutHHflHZLRxl7VL
	u0MJbky6JuoQOPD2mjKiUL5p2ZhuErRIyEJnaZrVnyAg8BhDwqEV3+UCrDZktS+sFN1rgwVIV8QAt
	WJl2pC4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o85-0000000EvKz-0wpn;
	Tue, 29 Oct 2024 15:27:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o3J-0000000EtTX-3ZtP
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:22:39 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49TD7E7Q021389
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:22:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=XTdC5rR2uiEoWSlqFgEly23JIAf0RJlPvmvSok+NdlE=; b=hcLQSWnOVHOI
	0qRKrNYi6oeZ0MEUslUgWB/VQcN7Dfo9RWgtsJbJLgVh4p1+J7FfzmXzyKZdKbFc
	jB3FjoYh5QJ3L5wwr2hY+ScSm1Xl9xqvltzrPvHSUoil8dByH6YrFzXLlSBSRz2M
	SchBlvcsTKzBC7BadT/zqK793ECEr+4emLrPQxLb7Jtv07LBgoNo/wLHHSWFMW60
	bA5keRS4PSyg6jK4GI/kINLciLVpnNaWz2A/PZ0FPi+ZVXh+g9OuRSwffYGNNkWo
	vxrrDzfP5HWlq3UNkY27aFy3Itsf+ObcRtbPy+DI5dX4zYMZLT+rXp+YdMAJBOp5
	rENyqe23aw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42k0af14pv-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:22:36 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:22:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 24BAC14920EA8; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Nitesh Shetty
	<nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv10 6/9] io_uring: enable per-io hinting capability
Date: Tue, 29 Oct 2024 08:19:19 -0700
Message-ID: <20241029151922.459139-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -IfILVIDk3VguWydDY7b_mWj2YFjhxlm
X-Proofpoint-ORIG-GUID: -IfILVIDk3VguWydDY7b_mWj2YFjhxlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_082238_018608_641FE521 
X-CRM114-Status: GOOD (  15.79  )
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
 io_uring/rw.c                 | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 0247452837830..6e1985d3b306c 100644
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
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4514644fdf52e..65b8e29b67ec7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3875,7 +3875,9 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
+	BUILD_BUG_SQE_ELEM(44, __u16,  write_hint);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
+	BUILD_BUG_SQE_ELEM(46, __u16,  __pad4[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
 	BUILD_BUG_SQE_ELEM(56, __u64,  __pad2);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 7ce1cbc048faf..b5dea58356d93 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio =3D get_current_ioprio();
 	}
 	rw->kiocb.dio_complete =3D NULL;
-
+	if (ddir =3D=3D ITER_SOURCE)
+		rw->kiocb.ki_write_hint =3D READ_ONCE(sqe->write_hint);
 	rw->addr =3D READ_ONCE(sqe->addr);
 	rw->len =3D READ_ONCE(sqe->len);
 	rw->flags =3D READ_ONCE(sqe->rw_flags);
--=20
2.43.5


