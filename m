Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C82C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HR7pDfEWCQApaFHaY1z8P5ClzoEBjIEJhDVePj5Z8w=; b=VfAyAoFwFFfmd/LCc+Bqg/Jr0Z
	BTjGC+KrUfNKVgImi5FEac4W2pwgAL46oY6LPoqTCbFC5QgbQrdQovbY4jLJ3j7sWnbLi5mV3hLVX
	deJN1kIXH2U7xnqN0GeyuQ7pbwMTuvTGFOZQMUOGZK7w8o8T7ztDPME+LE8WoskwQYVSIpXCZ8LZq
	J6fqVWtZYkG5tff15s5VtOXAizPAeZ2/pkHtcMiGyIqwhByZ2EHGY4Y5bdmOW8rR2VNl7HxbhQwzr
	0+dyt3je3mJZ6x/Krsrq3f9mLQCngph3woadWZWYD3akXm1MuyzHrJoHF054r8Uxd0y/AimJUi3Ki
	B2O8YsNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEfQ-00C1aG-68; Tue, 27 Sep 2022 17:46:48 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEfI-00C1ST-DH
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 17:46:43 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220927174630epoutp026e7f4ce4699c61cb0d1662d181dd60da~YyMA6ScX60070100701epoutp02N
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 17:46:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220927174630epoutp026e7f4ce4699c61cb0d1662d181dd60da~YyMA6ScX60070100701epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664300790;
	bh=6HR7pDfEWCQApaFHaY1z8P5ClzoEBjIEJhDVePj5Z8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CW5MqZOWodT97RqQnmic7jU/P7GBKmZLoD6sAGTVqnxH2txWGpGc0FUmu3ELsT2y5
	 QxJKSNp27669gngyvOKE7AUydG0UVTeKVs6gBqWPtc2HiA4C416zYOkQ2+XUHHJL1U
	 brNxdJR2p833g5wrv4eEEK0WKjf5Lc5IIkwgf9vg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220927174629epcas5p2182427ae4915d3268c0b4714d7a73934~YyMAM1E-c1324413244epcas5p20;
	Tue, 27 Sep 2022 17:46:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4McRrM0PzFz4x9Pp; Tue, 27 Sep
	2022 17:46:27 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.08.26992.2F633336; Wed, 28 Sep 2022 02:46:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220927174626epcas5p4002acda6f0578ee314ee5e611b8d6662~YyL9OEkhy2946929469epcas5p44;
	Tue, 27 Sep 2022 17:46:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220927174626epsmtrp2a19f332ab991fa507a79f5882b473637~YyL9NQyCg3251332513epsmtrp2c;
	Tue, 27 Sep 2022 17:46:26 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-2e-633336f25396
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.86.18644.2F633336; Wed, 28 Sep 2022 02:46:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220927174624epsmtip1cd45388de89debfd4591b5c8da8f430e~YyL716u1W0699506995epsmtip1h;
	Tue, 27 Sep 2022 17:46:24 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v10 1/7] io_uring: add io_uring_cmd_import_fixed
Date: Tue, 27 Sep 2022 23:06:04 +0530
Message-Id: <20220927173610.7794-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927173610.7794-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTQ/eTmXGywee91hZNE/4yW6y+289m
	cfPATiaLlauPMlm8az3HYnH0/1s2i0mHrjFa7L2lbTF/2VN2B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
	tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
	rpeXWmJlaGBgZApUmJCd8X/WTKaCVUIVL19/ZWpgnMvfxcjJISFgIvHx6CrmLkYuDiGB3YwS
	M/a8ZgJJCAl8YpT4f14XIvGZUWLjgd2sMB3/OnczQSR2MUqsm/OBGa7q9od+9i5GDg42AU2J
	C5NLQRpEBIwk9n86yQpSwwyy4u2NRnaQhLCAp0TPg1lg61gEVCU2rL3OBmLzCphLzFvWxQyx
	TV5i5qXvYDM5BSwkDn/MhCgRlDg58wkLiM0MVNK8dTbYDRICf9kl3l28C3Wpi8T13beYIGxh
	iVfHt7BD2FISn9/tZYOwkyUuzTwHVVMi8XjPQSjbXqL1VD8zyF5moF/W79KH2MUn0fv7CRNI
	WEKAV6KjTQiiWlHi3qSnUFvFJR7OWAJle0jMuryMHRI83YwSd36fZprAKD8LyQuzkLwwC2Hb
	AkbmVYySqQXFuempxaYFhnmp5fB4Tc7P3cQITphanjsY7z74oHeIkYmD8RCjBAezkgjv76OG
	yUK8KYmVValF+fFFpTmpxYcYTYFBPJFZSjQ5H5iy80riDU0sDUzMzMxMLI3NDJXEeRfP0EoW
	EkhPLEnNTk0tSC2C6WPi4JRqYHJ8I3mlbnbPgVOPlm/47jTRmWGJw41pe3mOasQtnfl1Mjev
	yvulxtf9Xhs5eio+bnJT8OvqFXmpyc7qXZj1adPb8HXrzkRXK+clbmLkPLGvz0zy9Ze769ca
	/lmxlSFud8ft7gsrXfPENpcodNyOM/u9KrllxUVhyQ2eUZ7yHm3qYb/n82Sf3WO/vHfG67A/
	jAd8XTcbNb6TKlZaH9/xpPqEz97XCxb+Ny8y9z1yucVh/p8XtwqmGzFNPFY08e+E7T1RW51v
	37pRv2Hd0xMuOjHpjw0aInXcttoL50zwO95dGPz7h3yG/M4vcx4tqc5iL5LQenPafG0Ji82X
	tylfrzzQuuO4cn+T5UOth1ZyM7iUWIozEg21mIuKEwEqu81JIQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnO4nM+Nkg2M/2S2aJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsDpwel8+Wemxa1cnmsXlJvcfu
	mw1sHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXxf9ZMpoJVQhUvX39lamCcy9/FyMkhIWAi
	8a9zN1MXIxeHkMAORonOVXvYIBLiEs3XfrBD2MISK/89Z4co+sgocfL3QcYuRg4ONgFNiQuT
	S0FqRATMJJYeXsMCUsMscJBR4vKzJywgCWEBT4meB7OYQGwWAVWJDWuvgy3gFTCXmLesixli
	gbzEzEvf2UFmcgpYSBz+mAkSFgIq2brpAwtEuaDEyZkQI5mBypu3zmaewCgwC0lqFpLUAkam
	VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwcGupbWDcc+qD3qHGJk4GA8xSnAwK4nw
	/j5qmCzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU4ts
	FPuKVe4c/IvSuOaeVrRmkvz+OYzZluFqzda8pJbkv/sqIm0P/9c6zjGlgSW1fc///dH60xUF
	L5RkRKyZpL/ixpe7d8NKpC5X2L86dcnETamp4rAXi68D9xwHwbDGUtHzDxv17630/lxi+vXR
	yX/6V7d86mqbGmhVceb92QtvCtdtfibCvuCe8sVahW9vjDS/RkTO3Zsl4cMrsjhUdJP5xHu7
	tXqneUhInHi/bdc107QVk647cZrkKV/KTvqfoKDwX7p+6y293W9PHristJjV9b355Olct7S9
	P7VGpdlxhKt5LG3k9upij85vOcHVdsK4VZy5YtKxzsuabf4sEWmhH78cWT5ZsM5Bw2W6Ektx
	RqKhFnNRcSIAHX7EsuUCAAA=
X-CMS-MailID: 20220927174626epcas5p4002acda6f0578ee314ee5e611b8d6662
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220927174626epcas5p4002acda6f0578ee314ee5e611b8d6662
References: <20220927173610.7794-1-joshi.k@samsung.com>
	<CGME20220927174626epcas5p4002acda6f0578ee314ee5e611b8d6662@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_104640_833613_4A1C2A56 
X-CRM114-Status: GOOD (  16.09  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

This is a new helper that callers can use to obtain a bvec iterator for
the previously mapped buffer. This is preparatory work to enable
fixed-buffer support for io_uring_cmd.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/io_uring.h |  8 ++++++++
 io_uring/uring_cmd.c     | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 58676c0a398f..1dbf51115c30 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/xarray.h>
+#include <uapi/linux/io_uring.h>
 
 enum io_uring_cmd_flags {
 	IO_URING_F_COMPLETE_DEFER	= 1,
@@ -32,6 +33,8 @@ struct io_uring_cmd {
 };
 
 #if defined(CONFIG_IO_URING)
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+			      struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *));
@@ -59,6 +62,11 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
+static int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+			      struct iov_iter *iter, void *ioucmd)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		ssize_t ret2)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index f3ed61e9bd0f..6a6d69523d75 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -8,6 +8,7 @@
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
+#include "rsrc.h"
 #include "uring_cmd.h"
 
 static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
@@ -129,3 +130,12 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	return IOU_ISSUE_SKIP_COMPLETE;
 }
+
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+			      struct iov_iter *iter, void *ioucmd)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_import_fixed(rw, iter, req->imu, ubuf, len);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
-- 
2.25.1


