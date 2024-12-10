Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A46E77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 20:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=924Fq1a7MqtuYjIm12r9i7+BviK2AxhmOrAIwHZ2dfo=; b=J0Zccylj1aZIu5PLeSCn/8DLqe
	g+dmJeTPaXbItW6lGKA9qjX7Z5jS+N0rhFQH6D2B98FTV30dyNGogzg/R3mDCVkjc+GnUQvbvCQsE
	E1kcIetyeREcDF3HCMPRXxyNd+QZaR+rA6tZyEKKOlOV+V/BdLYF/j9NL4O0V13V0T/goxMLOfXyI
	pKX24lxvIzwJEZkvtZ1lmO7Mk5MC+qdn/F2PNkejgUWgaJls6VkTmk7SoI2HCfAD/B5pmxh3as2CT
	ISedpvUtAlyciWjWnJAjHT/LI789G6Ng/cMkhO1+owL69CYgz9BPKqnA7qI+ZRHXXBaR1xpVGwnOp
	aCS+dG2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6nx-0000000Cfeb-21DM;
	Tue, 10 Dec 2024 20:26:01 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6nv-0000000CfeA-2mu9
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 20:26:00 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAHvRp4030100
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:25:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=924Fq1a7MqtuYjIm12r9i7+BviK2AxhmOrAIwHZ2dfo=; b=eWP60xGXAGym
	dxeGptt8caqa2+Ns4mCDH5t9b0UWGwXUeYZOPjoXvsISKt2yJRL10YPKaiyi33l4
	X2MwC37yktGh/iGjqkHQ0Hu6f3xZPRY3bdmrN3/PT9/QLN/gQMdAbxT5zyDy2ytF
	YKlZW+E3UkNIRe4w13kTsGF788lzTtzw+NEoVxWVHceX1naVDm0OARGz7DZCgwMR
	ZR/6mpyA1eNv68gXf/FlkoQxJHjwaHOcpcTPVxMDsc3nc9QDpOq7rYCGy1SEXAyc
	zH8m7GMtQKBQ4oOExjoAZej+NT83xJo/xgjwmsBMe/ANTho9/RPtqA27GuEUndM0
	nGTZZ8OSdQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43etg996xk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:25:58 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:25:39 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8DB2115D5C7CA; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv13 06/11] io_uring: enable per-io write streams
Date: Tue, 10 Dec 2024 11:47:17 -0800
Message-ID: <20241210194722.1905732-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f5KxtphkXYI-vZxlNxJt_OuacAJbVijH
X-Proofpoint-GUID: f5KxtphkXYI-vZxlNxJt_OuacAJbVijH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_122559_708165_864FF6CE 
X-CRM114-Status: UNSURE (   9.94  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
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


