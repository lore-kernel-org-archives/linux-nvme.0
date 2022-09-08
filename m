Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC4C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CAPPezBpRudgC2/iVSQKO5OZC1ekpekq3vqFH1gTUQ=; b=Gamh3/5xK4/NnHr8u1rNRQyrCb
	JPiiRI5plcMYtVPv2Zwce5d9jw4dOi6wxQSjah8x8F5WWlHFmF1Lh/CRgXoD6H+PgKowbmSVQqFWf
	7PFnL0/2g9o5/2EmV6CoSDIomJBiqvNosMHVzWXp1FsYe/IxbbrpCoJJm1pmi6BNtvEkOfHgXthkU
	aPWUg8GQJaRdHxEQoy5M9gI+TwCmkY80u+7KX/W0aBtMhnfYlYQQi2fTgdMo87FKudMD4aBnEjTBN
	4TEvOsAh2cCzxSsBwSQ2YW/KxtefkSo3lxxWmwKa9ic4RaQUvb3x7So+XKdWJWQjvDTEyEZa+dsa8
	0+ER1QDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWMX7-006uyZ-Tj; Thu, 08 Sep 2022 18:45:49 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWMWx-006uml-7t
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 18:45:41 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220908184533epoutp02efe511acc4a15e410b05a157a6c9e9ec~S9vKCpXwY0060300603epoutp02Q
	for <linux-nvme@lists.infradead.org>; Thu,  8 Sep 2022 18:45:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220908184533epoutp02efe511acc4a15e410b05a157a6c9e9ec~S9vKCpXwY0060300603epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662662733;
	bh=2CAPPezBpRudgC2/iVSQKO5OZC1ekpekq3vqFH1gTUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzFeyVgYqRg5n21X/YBZ7uRtc/LTcENTzIjKYd2yjLw1my/kdybNQ/o0cLfPP2ehM
	 8Yq+nX0WoDHX51IS4fhb5D09BwiECdZ4IzzD+sJJNRJhV4qFxvcQbIvX7K2e9kQpmk
	 Z1EXZK+aMBWBPh1bqlOnqP+eZUIq0JgLIh6qfuC4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220908184533epcas5p42a5b682da9ae518321d181d89bca18d4~S9vJQozPw1434814348epcas5p4z;
	Thu,  8 Sep 2022 18:45:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MNp3G65Sqz4x9Pq; Thu,  8 Sep
	2022 18:45:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.49.54060.A483A136; Fri,  9 Sep 2022 03:45:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220908184530epcas5p44d67b682ee86fabbb3f3912e8fde332b~S9vGgtBJn0530505305epcas5p4l;
	Thu,  8 Sep 2022 18:45:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220908184530epsmtrp17dfdb0d12ee939ecaccfc477c79c1801~S9vGf7pel3080730807epsmtrp1b;
	Thu,  8 Sep 2022 18:45:30 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-ce-631a384ac589
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.DD.14392.9483A136; Fri,  9 Sep 2022 03:45:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220908184528epsmtip25070875fc57a0e6c730b79be13990e6d~S9vFDM6w41574515745epsmtip2S;
	Thu,  8 Sep 2022 18:45:28 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v6 1/5] io_uring: add io_uring_cmd_import_fixed
Date: Fri,  9 Sep 2022 00:05:07 +0530
Message-Id: <20220908183511.2253-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908183511.2253-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmuq6XhVSywf4eA4umCX+ZLeas2sZo
	sfpuP5vFzQM7mSxWrj7KZPGu9RyLxdH/b9ksJh26xmix95a2xfxlT9kduDx2zrrL7nH5bKnH
	plWdbB6bl9R77L7ZwObRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
	uoaWFuZKCnmJuam2Si4+AbpumTlAxykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
	CkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjO237zBXrBYqGLywvWsDYzT+bsYOTkkBEwk/k75
	y9jFyMUhJLCbUWLh989sEM4nRomTWz4wQTjfGCVuX5jDBtPSeX0DVMteRomfR3pZIZzPjBId
	07YAORwcbAKaEhcml4I0iAh4Sdy//R6shhlkx9sbjewgCWEBD4k5n06zgNgsAqoST9r3gMV5
	BcwlHtzfzQ6xTV5i5qXvYDangIXExS8P2SBqBCVOznwC1ssMVNO8dTYzyAIJgVYOiS8f70M1
	u0hsWfeACcIWlnh1fAtUXEriZX8blJ0scWnmOaiaEonHew5C2fYSraf6mUGeYQZ6Zv0ufYhd
	fBK9v58wgYQlBHglOtqEIKoVJe5NesoKYYtLPJyxBMr2kLh3fC00FLsZJRZdn8s0gVF+FpIX
	ZiF5YRbCtgWMzKsYJVMLinPTU4tNC4zzUsvhMZucn7uJEZxItbx3MD568EHvECMTB+MhRgkO
	ZiURXtG1EslCvCmJlVWpRfnxRaU5qcWHGE2BYTyRWUo0OR+YyvNK4g1NLA1MzMzMTCyNzQyV
	xHmnaDMmCwmkJ5akZqemFqQWwfQxcXBKNTBtO3fzw4EZfJ266yacVtE+d8F/2S5h2V9c+p2B
	86Z+OZdw60NK6fcCPYUKnuatoZw3cwv8twtz7ZddGbmifrfJizfMwel1Sh2XY3SfW+TePKoq
	O+fjzpfhRYt/39/Vtm/n+9/9fz4qPjkruyRRLDcx73jIB9Nde7zf8B7j4i5n+9yra/bir/f8
	c3eXXfg9PyblsUL+LQ3jQtHlX5oOHJq8w3pfO4PztLx4/pA/PNGpTT3Gj/+sNFv44KBEUJzQ
	x0mtE959qvu91tA6ZIX85k/m3N43jkh+Or89ZTrTU8G0ricOu2foCnZO2lp0InkLh4WQdlz9
	2dDNRb+aor4zs+5K/muYu3HvPGXVMxfy6pP8lViKMxINtZiLihMBa+wHry0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvK6nhVSyQd8HG4umCX+ZLeas2sZo
	sfpuP5vFzQM7mSxWrj7KZPGu9RyLxdH/b9ksJh26xmix95a2xfxlT9kduDx2zrrL7nH5bKnH
	plWdbB6bl9R77L7ZwObRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGdtv3mAvWCxUMXnhetYG
	xun8XYycHBICJhKd1zcwdjFycQgJ7GaUOLztCitEQlyi+doPdghbWGLlv+fsEEUfGSWmrlsG
	5HBwsAloSlyYXApSIyIQIHGw8TJYDbPAQUaJy8+esIAkhAU8JOZ8Og1mswioSjxp3wM2lFfA
	XOLB/d1QC+QlZl76DmZzClhIXPzykA3EFgKqufZnOjNEvaDEyZkQM5mB6pu3zmaewCgwC0lq
	FpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwTGgpbmDcfuqD3qHGJk4GA8x
	SnAwK4nwiq6VSBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
	U6qByTVexPeGvn2jsf1aG7FPUTb8X/I0OHUO++V9v+WjH8xaoyKTbvk8VlrgaFLD++X2E69s
	uWLw03tTAJfMi9+aPS8X9wr6pngcWOBRN9snpX+W8PmONW83Wp0KO/+1X37ytbmdR6w8smZ9
	PbfMYcPZy6zbTR4EsxtzWYfus3oce/DG+i+9j8MqFykocBf/cU66fNY2tVWcWcn3+9JMk4th
	Os0f8k4l/RHZ6XXFZ+Zn311eq1snZG9KLbvff0eVY/2tk1tlN139HJT2LIhr0+Mle+N39V3Q
	m5km+P1BxvNtjPzOzHVR0ts0Gj1XJvXs9sl2dFU62PL1SB4DN2ulT25Jy7aZuqYOH5fPud4h
	5nBbiaU4I9FQi7moOBEAWyGDxPACAAA=
X-CMS-MailID: 20220908184530epcas5p44d67b682ee86fabbb3f3912e8fde332b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220908184530epcas5p44d67b682ee86fabbb3f3912e8fde332b
References: <20220908183511.2253-1-joshi.k@samsung.com>
	<CGME20220908184530epcas5p44d67b682ee86fabbb3f3912e8fde332b@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_114539_660238_FB38F8DB 
X-CRM114-Status: GOOD (  15.97  )
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


