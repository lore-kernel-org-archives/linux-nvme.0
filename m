Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D44E7717B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R9M24a6ylRLzXnir6ciiUs6+m+tvkucIQYlBzr9gqaU=; b=xcuuQlpU1pvnt03IMznn2ch4+r
	CF+KRK95KZgtltV4b93rqHu+F91/rNo5nOr7FkP0OzciJcAWBDHOhHPRMXMzIJSbrHBn0HmQeuHb5
	xA5K4vuSxf+j3NB+fTJUhhdJ/YiIc5Q1mjlfYmIKN1hlUJNppRvllJL9FfDp8SuBK8ka7Ealbhnte
	DbnAcQeZieuZy8gtCbgvLyi7c9cpACyRstSLkrR/2sePj/D70PqVsLFnqAWsQZfTB3pSG+DoDxHyF
	mBTPvuHWgb5cvaAuFVsEfkEq0KLq2WFi50sBMufcBVx1t+Fqqqy8H1eQdKfVl7pBJ/iQu+S2GbFcm
	6CSQmTCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgpr-00000002v7S-3U4m;
	Fri, 06 Dec 2024 22:30:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgpo-00000002v4q-2Iv9
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 22:30:05 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4B6Lh0CD021619
	for <linux-nvme@lists.infradead.org>; Fri, 6 Dec 2024 14:30:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=R9M24a6ylRLzXnir6ciiUs6+m+tvkucIQYlBzr9gqaU=; b=M+EE+KShOfku
	JfkC7f/NloEFOPkHP7tJELbCox8qTlakVfbc278w65KOW30+ojsqvz6uT8v27G0J
	qq701yzAHnwvTFOUa3+BYJpmf2klPnDsd164LJTCyBlY04xXtusYMAJ76+VwVYjF
	vYO22fQ3Y0uVdbCDB9EQwPsRRvTrR8/CiZ+9Dw8ZnYkpRcs82jCfUHCCvX3rsRCa
	NoQr6TBxAlj3BigunL1FxA6y+gfgy5p+mCbyd8ig1KIR25qM7Tk1pkRvXLk8lWpm
	3GDfkEIzeA+crYIMgaSi3mzWma9LRvWjDSLJhiYKNavUJLPTW/Ld99rHocHKYGe2
	OF0uB11I9g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43c7neh2ax-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 14:30:03 -0800 (PST)
Received: from twshared8234.09.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:30:00 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4113F15B8CB82; Fri,  6 Dec 2024 14:18:27 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 07/12] io_uring: enable per-io write streams
Date: Fri, 6 Dec 2024 14:17:56 -0800
Message-ID: <20241206221801.790690-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
References: <20241206221801.790690-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MXdgfYIwkUXvMn2EsUSZALYpNzgNR9wQ
X-Proofpoint-ORIG-GUID: MXdgfYIwkUXvMn2EsUSZALYpNzgNR9wQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_143004_733945_DF2B9C2F 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

Application can query the supported values from the statx
max_write_streams field. Unsupported values are ignored by file
operations that do not support write streams or rejected with an error
by those that support them.

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
index a8cbe674e5d63..978d0617d7af8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3868,6 +3868,8 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
+	BUILD_BUG_SQE_ELEM(44, __u8,   write_stream);
+	BUILD_BUG_SQE_ELEM(45, __u8,   __pad4[0]);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 04e4467ab0ee8..b8aa2dfcbf48c 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -322,6 +322,7 @@ static int io_prep_rw(struct io_kiocb *req, const str=
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


