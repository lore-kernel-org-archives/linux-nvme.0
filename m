Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0122ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HR7pDfEWCQApaFHaY1z8P5ClzoEBjIEJhDVePj5Z8w=; b=bppyJBvT0gPYsxWYSTLrjCfqkc
	vFoLVhLhl8En0ru/GC3n0+r9p3hTrOlW2sQIWdPCyGkS1uwh6sUz0i9AuBgeB6YYaBdaBL3IQ/N4C
	FdiL+oYZ8Xuso9OQ2KoPVqm1xYWE7s0n5N90BWyL1VAhSa53nq5Nxz6N6uLT5o5gwtMjF/Z0jiwL1
	EMounGSdRdqS3ekUvsjqVjOCTX0927kh2UfcHLMlMaTZqDNwtQXylcwyt3eqfoVsKXr6LP+eke1pJ
	Faqs2FikmeA52se4cPmJGzEV+TzNtZlArhh0829csgxgS8uuH3wdZyZAjMomEeZ/f93Anga3N7NXe
	Mk3ylcFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obfAm-003QIZ-W6; Fri, 23 Sep 2022 09:40:41 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obf9d-003PgZ-AA
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 09:39:32 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220923093919epoutp02912708b16413bec7177edf2da3be8616~Xc9gH2Q2h0967509675epoutp02e
	for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 09:39:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220923093919epoutp02912708b16413bec7177edf2da3be8616~Xc9gH2Q2h0967509675epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663925959;
	bh=6HR7pDfEWCQApaFHaY1z8P5ClzoEBjIEJhDVePj5Z8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mS9huhtF8Icv35QDt3bH4RcrAy0tWjp3Vc25t5r5NQoVzxTch7jz42CNIl5NoBU+H
	 qEER2AsvMVmFKXS0YKAwIIRcLbW8+TjY95QzMhfcvKoY6fQxG5axAnCoPfkC1YeQSf
	 pvJSRNB4/GuXtYOJ7Jv/6TiW9oxK97iSG6lYUDh0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220923093918epcas5p432ce7e34fc24a4e400b382e903067bad~Xc9fqoljb0959609596epcas5p4F;
	Fri, 23 Sep 2022 09:39:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MYnD32FSVz4x9Pq; Fri, 23 Sep
	2022 09:39:15 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.34.26992.FBE7D236; Fri, 23 Sep 2022 18:39:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220923093910epcas5p2624d93c6cb5caebb5f9203a1b8f4f5b1~Xc9YLx7H10642806428epcas5p2N;
	Fri, 23 Sep 2022 09:39:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220923093910epsmtrp2bae60d8f0d587a644ccb51b87a0ca903~Xc9YLBRyN1242312423epsmtrp2r;
	Fri, 23 Sep 2022 09:39:10 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-32-632d7ebf4c8e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.37.18644.EBE7D236; Fri, 23 Sep 2022 18:39:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220923093908epsmtip286d258d6baaf3a99162cb51a343e44c2~Xc9WiIe1N2720527205epsmtip26;
	Fri, 23 Sep 2022 09:39:08 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v8 1/5] io_uring: add io_uring_cmd_import_fixed
Date: Fri, 23 Sep 2022 14:58:50 +0530
Message-Id: <20220923092854.5116-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923092854.5116-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU3d/nW6ywaItshZNE/4yW6y+289m
	cfPATiaLlauPMlm8az3HYnH0/1s2i0mHrjFa7L2lbTF/2VN2B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
	tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
	rpeXWmJlaGBgZApUmJCd8X/WTKaCVUIVL19/ZWpgnMvfxcjJISFgIvGl9xgriC0ksJtRYusX
	7S5GLiD7E6PEy+7fzBDOZ0aJlrsvGWE6Dp5cDpXYxShxd+ZBVriq//c2snUxcnCwCWhKXJhc
	CtIgImAksf/TSbAaZpAVb280soPUCAt4SHxYaQdSwyKgKrGwZSIziM0rYC6x988tZohl8hIz
	L31nB7E5BSwkFm2+xQRRIyhxcuYTFhCbGaimeetssIMkBP6yS3w7MA+q2UVi950uNghbWOLV
	8S3sELaUxOd3e6HiyRKXZp5jgrBLJB7vOQhl20u0nupnBrmTGeiX9bv0IXbxSfT+fsIEEpYQ
	4JXoaBOCqFaUuDfpKSuELS7xcMYSKNtD4nbnWTZI8HQzSqz4/ZFpAqP8LCQvzELywiyEbQsY
	mVcxSqYWFOempxabFhjmpZbD4zU5P3cTIzhhannuYLz74IPeIUYmDsZDjBIczEoivLPvaCYL
	8aYkVlalFuXHF5XmpBYfYjQFhvFEZinR5Hxgys4riTc0sTQwMTMzM7E0NjNUEuddPEMrWUgg
	PbEkNTs1tSC1CKaPiYNTqoHJ5tVBnyrRd9kbdC02CG9o8dIsjq946reh+kFbVMtF1Tm9CV2f
	1+XGnL78Rmtaq2D+i8UdTU969BZOq1z8vuf+TW4X0QPMJnUsn91VeGsnbbHebZHDeaDW+7Fh
	TPkTAwclOWVRrqo6OcX+Hf/jOQo41/WvNJD6MEPrj940FUn+7gmc6XaGJiU7vx/hXfpQ+dv+
	7KhPb/hYX/e2pF1m2WzuzsgYvskmvDeHf/WN2/yWgbHL93L3rZtvVdZiOvNrGc/ZOJ2th9q2
	dnA/zZ17ImXawzXGkfITRTo+mzTJNbtr8Z7RyMkOcshzNBFnaGjUZ1XuE+Z9f/e2uBuvoPr+
	BVsLtF17leLbr6k38FQpsRRnJBpqMRcVJwIAZQAabiEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO6+Ot1kg53vRC2aJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsDpwel8+Wemxa1cnmsXlJvcfu
	mw1sHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXxf9ZMpoJVQhUvX39lamCcy9/FyMkhIWAi
	cfDkcuYuRi4OIYEdjBJbdz1mh0iISzRf+wFlC0us/PecHaLoI6PEjuXvgRwODjYBTYkLk0tB
	akQEzCSWHl7DAlLDLHCQUeLysycsIDXCAh4SH1bagdSwCKhKLGyZyAxi8wqYS+z9c4sZYr68
	xMxL38F2cQpYSCzafIsJxBYCqvlx6QUjRL2gxMmZICM5gebLSzRvnc08gVFgFpLULCSpBYxM
	qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgoNdS2sH455VH/QOMTJxMB5ilOBgVhLh
	nX1HM1mINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJkkl
	/rDf/33Xvbpeuf0R/8b2RqNK6Ye8je1dyzbIZ1w6d2ae5bqgja+THadvz+jq5G6/aRGefL74
	4h+B+K54/907lKX/Fn/WuSGRx3hgdrXThg17Ly132PXMI5GdOVApNvHHmsAClarpvCoZuR3J
	KfKR7np8Bm5mM1sTMt6GrFa8rrwg5rj5v+lb3l1Wu+igqhRx3XJ2b89eqYzFqU1pEx7P6nO9
	tKtlfgSXBpNtrERQZ/vcV4x7JzAnrtyUYbXxbdCFP/M8vFZdyLjxreVMwHbFUsXkR1ZlfxN8
	xR+Jb/h62SDU+m+GVhWn/cLHqQbmb2NPHCl5t2DmF543Aa5771csirl49twevVPdU67eVGIp
	zkg01GIuKk4EABl4Gh/lAgAA
X-CMS-MailID: 20220923093910epcas5p2624d93c6cb5caebb5f9203a1b8f4f5b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220923093910epcas5p2624d93c6cb5caebb5f9203a1b8f4f5b1
References: <20220923092854.5116-1-joshi.k@samsung.com>
	<CGME20220923093910epcas5p2624d93c6cb5caebb5f9203a1b8f4f5b1@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_023929_744027_6623CFB3 
X-CRM114-Status: GOOD (  15.84  )
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


