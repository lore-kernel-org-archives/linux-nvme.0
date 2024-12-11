Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19938E77182
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7S0M711xSEKUyXi8i8LQTqNXUve97NSr/7xTA7oKMsw=; b=nd2kGD9xZFJhbrZFprv1zEWO+x
	4pZ2qAIpoMLDn2LyKbXeG+HPP0yn1V559ullR1r7l3P9p6x61Fi9UNkucssVI1ZG5Ic30rfN2x9VO
	xepXQXm1ZIKwj702jDkfSbVSEI1J02FILjjI04WIrAAu5iBylL1n3enowBLnwnYISK1JaAG0ZV4y8
	unJpi+X3wRUjxqFKQx0U7DLTmL0mqKdqeAY1TXMIGdIZ6gkXJZsEvXgMA5XV/ZNGhAQUlNo7iuDoh
	dzVWckH3W7jlXfjXJp3IwuDyxTc1Vvn4M80T8IBYOQUc5vVjKdO6cIWcpYbsSn1wSXMAHuVKuG8Lq
	dmmunxEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLRqJ-0000000FmZC-1Xr3;
	Wed, 11 Dec 2024 18:53:51 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLRnM-0000000Flhi-3OnJ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 18:50:49 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFIC2i011074
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 10:50:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=7S0M711xSEKUyXi8i8LQTqNXUve97NSr/7xTA7oKMsw=; b=a46wjWnXYFOd
	0bNg0EklCS/uCiw33n4Zq5UGW3RsS6LNs8cVWkJjwa6xiutjgx6uc0DSqVePYbgC
	LejnRNWQMqzz+pWM7ZtQUIB2ncDou2hfQ7BlpGWrk4jVEVug7DUNikmP9+vkuoog
	vxi9XQNArOol8R3KoiiHz671ndEdgZJKJE9lsbu9N8AWsr/wOrbtIpg9xm0fXBXi
	YmAlP/fReVyJco1N/YzZK9XlEglGNnsw06eLC+NNL9G1KTb3lrQyai0uL7J4nzmE
	QQMlhdpngVgUeAHXMhOA0fj2F7X4ky9bH918qP0XIu668AmJ7wCXOlTsAq6iWFCn
	XH9V5fGY0g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43fbg22k0v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 10:50:47 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 18:50:44 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7808915DE395D; Wed, 11 Dec 2024 10:35:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv14 06/11] io_uring: enable per-io write streams
Date: Wed, 11 Dec 2024 10:35:09 -0800
Message-ID: <20241211183514.64070-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211183514.64070-1-kbusch@meta.com>
References: <20241211183514.64070-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ALUAu9kYU4KYJSGRrRQS68cCbRYLGH6-
X-Proofpoint-ORIG-GUID: ALUAu9kYU4KYJSGRrRQS68cCbRYLGH6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_105048_962688_1A7FDDA7 
X-CRM114-Status: GOOD (  10.26  )
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

Allow userspace to pass a per-I/O write stream in the SQE:

      __u8 write_stream;

The __u8 type matches the size the filesystems and block layer support.

Application can query the supported values from the block devices
max_write_streams sysfs attribute. Unsupported values are ignored by
file operations that do not support write streams or rejected with an
error by those that support them.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/io_uring.c           | 2 ++
 io_uring/rw.c                 | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 38f0d6b10eaf7..986a480e3b9c2 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -92,6 +92,10 @@ struct io_uring_sqe {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u8	write_stream;
+			__u8	__pad4[3];
+		};
 	};
 	union {
 		struct {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ae36aa702f463..b561c5e8879ac 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3869,6 +3869,8 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
+	BUILD_BUG_SQE_ELEM(44, __u8,   write_stream);
+	BUILD_BUG_SQE_ELEM(45, __u8,   __pad4[0]);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 5b24fd8b69f62..416ccd89a77ed 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -316,6 +316,7 @@ static int io_prep_rw(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe,
 	}
 	rw->kiocb.dio_complete =3D NULL;
 	rw->kiocb.ki_flags =3D 0;
+	rw->kiocb.ki_write_stream =3D READ_ONCE(sqe->write_stream);
=20
 	rw->addr =3D READ_ONCE(sqe->addr);
 	rw->len =3D READ_ONCE(sqe->len);
--=20
2.43.5


