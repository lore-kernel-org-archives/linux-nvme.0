Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A21C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cal95robFJLQGJ8+m5/E4SeEhAYnouWNx2DVQA94dKo=; b=b3Pyxd4F/41xY367rML36OSvwc
	Aa49mOzZnVeCz+XZQcyn+FOngkfrGp8lE+rTENZM9FHvL/270Ox5asm8BrVHo0+8JTxBCxacewMTx
	5ukR/pcT66AfERoXjcf9OmpNUOnaeWZoYDd6k1rpo1rt/q81jHH7/PQTGUAeIMXY8dt/QGzI2MHGK
	fZthkj41ZK8EeFFXIj9YdRr2IKcOeUj11A2aeTxwY4NObJrggcWmLCXbYNaRb/Q4JHkfVsQQW16Rj
	UdIKh3LbKRONG81YZMgpfjnD4KsVg8svM2zN13EkFfmv6h4Hhg4Jj/PfFt45741GQtzcFHijrszyp
	iXQGaAnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSDK-00AT1E-Rq; Tue, 06 Sep 2022 06:37:38 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSDG-00ASwM-K5
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:37:36 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220906063729epoutp03f2185b63c857a5d9dc09570216745507~SMg41Xvty1401314013epoutp032
	for <linux-nvme@lists.infradead.org>; Tue,  6 Sep 2022 06:37:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220906063729epoutp03f2185b63c857a5d9dc09570216745507~SMg41Xvty1401314013epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662446249;
	bh=cal95robFJLQGJ8+m5/E4SeEhAYnouWNx2DVQA94dKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjCrnNAuaJ1wdFFJ2HMaWayjtYpy71qUTwiqICtbcCiWXxls4jfHDoIXbyFMzI22Y
	 CdwzYbKhTfqljKoRqOu5Ykw65QKY/RL4l0asMLywSWym+l7wW0MXzmltqRuONSHacs
	 6FHEZaj22EzVZU/bm7A+oauHzmSK8fdnfwTPzeAA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220906063728epcas5p21ce7253400629bf8bd19b61112328162~SMg4hoLWY0869908699epcas5p2I;
	Tue,  6 Sep 2022 06:37:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MMG041K02z4x9Py; Tue,  6 Sep
	2022 06:37:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.20.53458.4AAE6136; Tue,  6 Sep 2022 15:37:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220906063723epcas5p23946fd33031aee591210af1c3cd2d574~SMgz-cMBQ0869908699epcas5p20;
	Tue,  6 Sep 2022 06:37:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220906063723epsmtrp204c487db3d7785f5f41cba8c8d3998f1~SMgz_ifjL1360313603epsmtrp2D;
	Tue,  6 Sep 2022 06:37:23 +0000 (GMT)
X-AuditID: b6c32a4a-a5bff7000000d0d2-69-6316eaa41b8f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.45.14392.3AAE6136; Tue,  6 Sep 2022 15:37:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220906063722epsmtip2076ddaa86be9dd6173c3c3841b4c3def~SMgycrUnU2854328543epsmtip2w;
	Tue,  6 Sep 2022 06:37:22 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v5 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Date: Tue,  6 Sep 2022 11:57:18 +0530
Message-Id: <20220906062721.62630-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906062721.62630-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhu6SV2LJBpf/sFo0TfjLbDFn1TZG
	i9V3+9ksbh7YyWSxcvVRJot3redYLI7+f8tmMenQNUaLvbe0LeYve8ruwOWxc9Zddo/LZ0s9
	Nq3qZPPYvKTeY/fNBjaPvi2rGD0+b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
	1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
	U2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3R176WvWCxUMWZy0+ZGxin83cxcnJICJhIbHx8
	laWLkYtDSGA3o0TPnRusEM4nRonf92exQTjfGCU+vpnB2MXIAdby7r8zRHwvo8SfOd1Q7Z8Z
	Jc7MWcIGUsQmoClxYXIpyAoRAS+J+7ffg01lBlnx9kYjO0hCWCBA4uG+s+wg9SwCqhI9jUYg
	YV4BC4k9656xQpwnLzHz0newck4BS4kJJ7+wQdQISpyc+YQFxGYGqmneOpsZZL6EQC+HxMoJ
	b9khml0kjs7fzAJhC0u8Or4FKi4l8fndXjYIO1ni0sxzTBB2icTjPQehbHuJ1lP9zCC3MQP9
	sn6XPsQuPone30+YIOHAK9HRJgRRrShxb9JTqJPFJR7OWMIKUeIh8a21ABI6PYwSf2/MZpvA
	KD8LyQezkHwwC2HZAkbmVYySqQXFuempxaYFRnmp5fBoTc7P3cQITqFaXjsYHz74oHeIkYmD
	8RCjBAezkghvyg6RZCHelMTKqtSi/Pii0pzU4kOMpsAQnsgsJZqcD0zieSXxhiaWBiZmZmYm
	lsZmhkrivFO0GZOFBNITS1KzU1MLUotg+pg4OKUamBgV8m1fMM+ye12hd2NZfN/p57JGU9s3
	MrE89DlntyfwI9eZn2vXVq2Y9DhbuN3dVvKqi2cHg+7K9Y6Sgbc7Z94QYRN80M9zvE9Zluma
	R/g6lby6fb97Q3tW5lqxhW6wvLBye/3RmuiDPXnNnadmbxE1n1v8ZTHHLTuPg/8aFz932qZ2
	47dkVZS5BbvfMUE1jQK37DUvz3765Ma0TmXn+4rn1/dd+RX5k+EqzyOGDFYNZT/r0Bn3NDcv
	4Ig9tWnbqW2JqqlTa7bZtKQt+bRob/IfcUmJg7yxjdp5kXFq51ItebqyuOKO/n8c/uJ1m39C
	OkuisqltdOAXdrkwfVGlvkmVc96bncgPuSYXkv5eiaU4I9FQi7moOBEADrgQtCoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO7iV2LJBg2zdC2aJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWV34PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5tH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZfS1r2UvWCxUcebyU+YG
	xun8XYwcHBICJhLv/jt3MXJxCAnsZpRYf24BcxcjJ1BcXKL52g92CFtYYuW/5+wQRR8ZJbZ/
	X8YG0swmoClxYXIpSI2IQIDEwcbLYDXMAgcZJS4/e8ICkhAW8JOYdPMTK0g9i4CqRE+jEUiY
	V8BCYs+6Z6wQ8+UlZl76DraLU8BSYsLJL2wgthBQzZ0Vd5kg6gUlTs6EGMkMVN+8dTbzBEaB
	WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5/Lc0djNtXfdA7xMjE
	wXiIUYKDWUmEN2WHSLIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
	skwcnFINTOJJS66zz/+VzB0yr2p9/QQFOyaWPL+lW448/Sr6o+6J8+zzc1LnJ72KOc2RfDzc
	TLFWxNU3cMVajo/BeeEOFw9+W/JW6sO5+FiRvo6d94SsJ+vzSB2TivjIN+FWModPoXy/92kP
	94T98ryL0v5l3g5J0zu896aj17xPXH5Ljz3Pk3l/6JjK1INPGJ+mOnRotmzeGqhu2jSfk7vs
	0awD0Y5Jq8X3mP+YUMFy3G3i8inNi6t7y9q77SYoFr8/mHewf/mzr1K3X5TM3PHsdFBJVneo
	xm7hvuS56WUWzOvKr9xSOXrJ74qtwO2vD3puW6xLnNU33ZR1MZfC0hc39Rb9nVO8U+7n0s/3
	0q1aHHfznVViKc5INNRiLipOBACLad1Q7gIAAA==
X-CMS-MailID: 20220906063723epcas5p23946fd33031aee591210af1c3cd2d574
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220906063723epcas5p23946fd33031aee591210af1c3cd2d574
References: <20220906062721.62630-1-joshi.k@samsung.com>
	<CGME20220906063723epcas5p23946fd33031aee591210af1c3cd2d574@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_233735_028252_C3DAAAAB 
X-CRM114-Status: GOOD (  15.99  )
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
index 58676c0a398f..202d90bc2c88 100644
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
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+			      struct iov_iter *iter, void *ioucmd)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		ssize_t ret2)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 6f99dbd5d550..b8f4dc84c403 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -7,6 +7,7 @@
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
+#include "rsrc.h"
 #include "uring_cmd.h"
 
 static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
@@ -124,3 +125,12 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
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


