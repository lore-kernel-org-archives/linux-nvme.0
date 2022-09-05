Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24476ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9eeh4RBJYaAco8jXNywjr3avubLO7fkkdnIseGNno0=; b=WLofgIp2iNSVBWIAlAYl7PBduj
	KxQWTw5Nf7aFHs8dxUzQURIfl/HUDz+J078pTEUDGEdYA/+Pj8ooeapgQHRk6HuyWttLA0n85P3i3
	rMszwjEjXHFpKT0PQJikH5rA4a4+/BX5SuVwegkaBdF9XFklwv22h4RgUGYHJGfyu/u4aqTJ0icXk
	dRbmDB7vfc/JWdgH7swIfcj9IU1Y+PMyKPkaHXy4TnoDVjGidyPbz+l+teuKvoyp6ZtgYx3kPXOFC
	qRlSD+/XnU2H6mhMWg0TGJNPxAidLtXywEymJlkB4Y9hVTmc/zeYfnAlpBSqXzIrt9g8fAtKqAPJt
	bTJ2bevA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVF8p-006z1y-47; Mon, 05 Sep 2022 16:40:07 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCcr-003wt4-9M
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 13:59:00 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220905135850epoutp026ac3fec0b896518e9d7c0f78ccbbb56a~R_483_rAW0325603256epoutp02h
	for <linux-nvme@lists.infradead.org>; Mon,  5 Sep 2022 13:58:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220905135850epoutp026ac3fec0b896518e9d7c0f78ccbbb56a~R_483_rAW0325603256epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662386330;
	bh=A9eeh4RBJYaAco8jXNywjr3avubLO7fkkdnIseGNno0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg2Qp9k0hp8Srs4dwQMd2wka4h2RGa/Qty/E5lOH2w5ZJkiEpNugwkD0cqT/Hv3FM
	 vguVF1FddpGBfdi5ScrCBCKBxJ8hgacj62r03NBL74djPHin8NeLuSpvZdlXrPyWcF
	 jXTy0R1QHLBuUHropAcLXghLe8JDFYZfdfa2mrBI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220905135849epcas5p3abd70f080e747db49ae86e3e2918c664~R_48jO_Ix2215922159epcas5p3k;
	Mon,  5 Sep 2022 13:58:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MLqqq20kRz4x9Pp; Mon,  5 Sep
	2022 13:58:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.7A.59633.79006136; Mon,  5 Sep 2022 22:58:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b~R_45maAVN2801128011epcas5p4E;
	Mon,  5 Sep 2022 13:58:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220905135846epsmtrp29d91e5e8e56425c813975213f2e5fe0f~R_45lpA6k0557505575epsmtrp2j;
	Mon,  5 Sep 2022 13:58:46 +0000 (GMT)
X-AuditID: b6c32a49-06ffe7000000e8f1-b8-631600973a15
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.39.14392.69006136; Mon,  5 Sep 2022 22:58:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220905135844epsmtip1dd3b2f2aa878ee1536f9a2b3798e33a6~R_44Iybrd1794817948epsmtip1R;
	Mon,  5 Sep 2022 13:58:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v4 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Date: Mon,  5 Sep 2022 19:18:30 +0530
Message-Id: <20220905134833.6387-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905134833.6387-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmuu50BrFkg5+buCyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWV34PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5tH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7omjKHpWC1UMXWoz0sDYxr+bsYOTkkBEwkJu45
	zdjFyMUhJLCbUeLMnsXsIAkhgU+MEpNOJ0AkvjFKvGyewgjTsWXlMXaIxF5GiefPzrJBOJ8Z
	Jdq+nGLtYuTgYBPQlLgwuRSkQUTAS+L+7fesIDXMICve3mgEWyEsECCxe8kMsKksAqoSV7c/
	YwGxeQXMJe6c2MoMsU1eYual72D1nAIWEpO67rNB1AhKnJz5BKyeGaimeetsZpAFEgKtHBJb
	py5mhWh2kbi1+ycbhC0s8er4FnYIW0ri87u9UPFkiUszzzFB2CUSj/cchLLtJVpP9TODPMMM
	9Mz6XfoQu/gken8/YQIJSwjwSnS0CUFUK0rcm/QUaqu4xMMZS6BsD4kfcz8wQ8Knm1Fi+fJ9
	zBMY5WcheWEWkhdmIWxbwMi8ilEytaA4Nz212LTAMC+1HB6xyfm5mxjBaVTLcwfj3Qcf9A4x
	MnEwHmKU4GBWEuFN2SGSLMSbklhZlVqUH19UmpNafIjRFBjGE5mlRJPzgYk8ryTe0MTSwMTM
	zMzE0tjMUEmcd4o2Y7KQQHpiSWp2ampBahFMHxMHp1QD05JPbX974v775q/5sk/wXaLSGvaN
	W57Y1IQbyZ7ak7Z/e86yOdXBUdPjnmfIHng714c51Ev5HatiWzBPeP62t5vWeOctzuwQYDN0
	3m2S0rW+9Xf+k5c/OC6L6pgfDlPrm7vdV8XBOt/Q9X3T7qrAxZ8LmCcXN0/W9Ytl8v/8Oz4x
	5cjPaTu2SyYdO1j7rJOVYZbGo4QVxts8njWG35oUXNDDK6mfkdHIHzhplV2Ur/Cn+1cePpJ8
	IPJ2V27gFh3lrpvsHi/N9P+kLw1esffthqNNrWdOluU+WLyT70z7P+Uw71ObZr9MOzJ7E//2
	ILFbDVzXMuwelMj2COWcl+pzuZH+dT/jibUlrzK3nOX8o8RSnJFoqMVcVJwIALWPwOosBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO40BrFkg/1zxSyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWV34PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5tH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZXRNmcNSsFqoYuvRHpYG
	xrX8XYycHBICJhJbVh5j72Lk4hAS2M0osXFbFxtEQlyi+doPdghbWGLlv+dQRR8ZJeb8mQ3k
	cHCwCWhKXJhcClIjIhAgcbDxMlgNs8BBRonLz56wgCSEBfwkJu24AzaIRUBV4ur2Z2BxXgFz
	iTsntjJDLJCXmHnpO1gNp4CFxKSu+2BHCAHV7JnxlBGiXlDi5EyImcxA9c1bZzNPYBSYhSQ1
	C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4BjQ0tzBuH3VB71DjEwcjIcY
	JTiYlUR4U3aIJAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
	KdXAdLqHzav6/b32R2XLisLyrDwj15z982jalvMca1znsE8QzShfzT83dNqy50lzfewrA2av
	/viX9+nVk+849aP0NabZBGdbBt50cvvx0Kbri/t03dLrOmK+hf0LK7ffmad/wHiidQzLRt3/
	YltuVHq1KavPepRzMdj2zq6vN6ducrq0L+a5ybaJswUsHupOrP9UGm5TJfKbaan78mcs1Y3P
	dO6YdZ7uVLx3VEzNeWFp7MvLR3wlT33lyv5yQpT17Ovum6ZGc/t7Nv08mlkW6mH2danMrXzR
	y4qH+JZXJft4XAph3P1vbePSJT7eZzZxNO8Qb4sPEWqTq968UIB5r82i+XPWHI6olmO68Plm
	4rVTPkosxRmJhlrMRcWJANT3bt/wAgAA
X-CMS-MailID: 20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b
References: <20220905134833.6387-1-joshi.k@samsung.com>
	<CGME20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_065859_054785_54E4508D 
X-CRM114-Status: GOOD (  15.91  )
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
 io_uring/uring_cmd.c     | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 58676c0a398f..dba6fb47aa6c 100644
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
+		struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *));
@@ -59,6 +62,11 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+		struct iov_iter *iter, void *ioucmd)
+{
+	return -1;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		ssize_t ret2)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 6f99dbd5d550..8cddd18ad10b 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -7,6 +7,7 @@
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
+#include "rsrc.h"
 #include "uring_cmd.h"
 
 static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
@@ -124,3 +125,13 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	return IOU_ISSUE_SKIP_COMPLETE;
 }
+
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
+		int rw, struct iov_iter *iter, void *ioucmd)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct io_mapped_ubuf *imu = req->imu;
+
+	return io_import_fixed(rw, iter, imu, ubuf, len);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
-- 
2.25.1


