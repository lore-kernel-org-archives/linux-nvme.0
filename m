Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C33D3B7E7
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 08:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPCiH7C8otAPeKBQxafGfpBc//4CVwTtOappMXTNYFs=; b=EAGxiArbTCABWh9HBsvIcU3k5O
	UXZ/JSEfpNHqk+Dh9GmfedhWzbitOcWzRujGpSgMrdxAf7RXYxjz4B8DgLf4D0XKFhVQjQXXd8t7/
	quhz/nRAsET044+WyOvhE1biN80dIZDUNFvh3ijuFbkp2uPLQyFer79Jw1aRYvVM8yU1eiBDVztgt
	I1DCZ/crzzaUuJwtHCMTmu/ZHNUKSGskcBxodYh/+xQbCikpngz1bSLgqpxXc4gx4dAHMaTI7PH5L
	Al/vzFZK9yGbf/ZKoISl/AIn2PqfGPtOZ2UM7Dhu72G/er2tjrdnmXoY/CE3YKRn9JfEMG32zGcXc
	LlGFlqqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFU8f-00000007Jfp-1sL4;
	Mon, 25 Nov 2024 08:08:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFU8c-00000007Jcm-3ylf
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 08:08:08 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241125080800epoutp03c9a48c74075470baed67bcfef34a433e~LJ6dAik5s0779507795epoutp03j
	for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 08:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241125080800epoutp03c9a48c74075470baed67bcfef34a433e~LJ6dAik5s0779507795epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732522080;
	bh=sPCiH7C8otAPeKBQxafGfpBc//4CVwTtOappMXTNYFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ru9C0F3d+Dy26aoNa98nsBCvTS8TU5C8wCuGirg5DOUAAXMm1BGUTIH/OniOEpHk1
	 zR3xoDmojCNirdNtI6Mevbwvs5JixZxMTo0GPN0hCjCt2rn+0ZXhCS9CSLwoF44+s9
	 mdTmhe5yIdSEhT22wC1dpwc8QqiUk77X3vU+qQbs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241125080800epcas5p412d9a5f2601abac0647e31defe6716bc~LJ6cX-_xj1833918339epcas5p43;
	Mon, 25 Nov 2024 08:08:00 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XxdcG48MDz4x9Q3; Mon, 25 Nov
	2024 08:07:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.66.29212.E5034476; Mon, 25 Nov 2024 17:07:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241125071457epcas5p498c0641542bed9057e23cfff9cfc5ff0~LJMH1hjqt1933019330epcas5p4R;
	Mon, 25 Nov 2024 07:14:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241125071457epsmtrp1eaefa71b882c902d9317ca201b91da3d~LJMH0gPoA0302303023epsmtrp1z;
	Mon, 25 Nov 2024 07:14:57 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-87-6744305e1ece
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.08.35203.0F324476; Mon, 25 Nov 2024 16:14:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241125071454epsmtip149999c09d59b464adb11470b42b63af9~LJMFUPWGQ0361403614epsmtip1c;
	Mon, 25 Nov 2024 07:14:54 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v10 04/10] fs, iov_iter: define meta io descriptor
Date: Mon, 25 Nov 2024 12:36:27 +0530
Message-Id: <20241125070633.8042-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125070633.8042-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmlm6cgUu6wa818hYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJouj/9+yWUw6dI3RYu8tbYs9
	e0+yWMxf9pTdovv6DjaL5cf/MVmc/3uc1eL8rDnsDkIeO2fdZfe4fLbUY9OqTjaPzUvqPXbf
	bGDz+Pj0FotH35ZVjB5nFhxh9/i8Sc5j05O3TAFcUdk2GamJKalFCql5yfkpmXnptkrewfHO
	8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA/KSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
	lVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM5ZM0y24wlux+NpCtgbG2dxdjJwcEgIm
	Eiv2b2fvYuTiEBLYwyix7NwzKOcTo8SFD9/YIJxvjBJH3nazwLQsuzqZDcQWEtjLKNF8NQKi
	6DOjxKt9z5hAEmwC6hJHnrcygiREQOb2LjzNAuIwC0xgkmifOIcdpEpYwEli15kJYGNZBFQl
	Li77zwpi8wpYSByaepAJYp28xMxL38HqOQUsJd62HWCBqBGUODnzCZjNDFTTvHU2M8gCCYEb
	HBKf7i2DanaRuHz6NNTdwhKvjm9hh7ClJF72t0HZ6RI/Lj+Fqi+QaD62jxHCtpdoPdUPNJQD
	aIGmxPpd+hBhWYmpp9YxQezlk+j9/QSqlVdixzwYW0mifeUcKFtCYu+5BijbQ+LS72ZomPYA
	Q3viSuYJjAqzkPwzC8k/sxBWL2BkXsUolVpQnJuemmxaYKibl1oOj+fk/NxNjOCUrhWwg3H1
	hr96hxiZOBgPMUpwMCuJ8PKJO6cL8aYkVlalFuXHF5XmpBYfYjQFhvhEZinR5HxgVskriTc0
	sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoGpxaNxZ+PWPUqSS2fPn+t/
	/59YilJa+uan2U69KyNDmAW3/WZ/cnVS8lVjTqbVus/Y3NJqbZgn3LZ/WvH6wBTVhedKVy4V
	X7JBQbW1qLJRYXWxyMNvwpee1YQGtry4cHKuxKzPOeI3rutIN36onayV/G3t/oTlE6ZGCfP9
	Kk3YPl2uiTHWYq1qZdp3ti3JbZrSR76WRxlJdE77Pl/1yfvrO37Zbf//qXLHX1P75SphTCus
	P3VEeH44MDPr53FzfrMlbx3NHh/XZ3tkdPfcC6nZD54IyCYZaa7RXJQosdQryExw87uJD+Vl
	t0UaRMw8LOZe/Mj8+3v24juTO8+dYDqz8Ml13w9xerUCOWHbnoZuVmIpzkg01GIuKk4EAAUN
	tadyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO4HZZd0g9fnrSw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBZH/79ls5h06Bqjxd5b2hZ7
	9p5ksZi/7Cm7Rff1HWwWy4//Y7I4//c4q8X5WXPYHYQ8ds66y+5x+Wypx6ZVnWwem5fUe+y+
	2cDm8fHpLRaPvi2rGD3OLDjC7vF5k5zHpidvmQK4orhsUlJzMstSi/TtErgylkzTLbjCW7H4
	2kK2BsbZ3F2MnBwSAiYSy65OZuti5OIQEtjNKNH5rJ8NIiEhcerlMkYIW1hi5b/n7BBFHxkl
	Wqe8YwZJsAmoSxx53gpWJCJwglFi/kQ3kCJmgRlMEj2/VoBNEhZwkth1ZgILiM0ioCpxcdl/
	VhCbV8BC4tDUg0wQG+QlZl76zg5icwpYSrxtOwBWLwRUM6tzJVS9oMTJmU/A4sxA9c1bZzNP
	YBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4IjT0tzBuH3VB71D
	jEwcjIcYJTiYlUR4+cSd04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1I
	LYLJMnFwSjUwTeHhszZ0u35bxWvHoXC/TEdD7/BYxWXvd9jmrbk9nXnKSVWvxzaTth0w1c/6
	7RTW/v712/MOkpxHVyw40XbusPC77/1rZntGnL/1RoHT6izTNyu7U6bV934evveu9kDCSqXi
	7Q1dS8sVik9/4j42MbhHinmrq4VCmVP7LGtb/4MWWs8X5lz4cCBR5njTossnlzdP6eCepCVd
	oFetW5G4s9992U+DvU/0D0bdusVvWTM1QVzUj2/GRcfrAWaBySdfLI//3WztvPudCrv6Rf32
	Cf4H/F10M5ir2F5WpXBePrVav5ItISyXZ8cKCWGLBX6PeFpUg5k/R1fFaUYoSp63v/4/eNbS
	VzKWlXbGX9OUWIozEg21mIuKEwGNW3FuJwMAAA==
X-CMS-MailID: 20241125071457epcas5p498c0641542bed9057e23cfff9cfc5ff0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241125071457epcas5p498c0641542bed9057e23cfff9cfc5ff0
References: <20241125070633.8042-1-anuj20.g@samsung.com>
	<CGME20241125071457epcas5p498c0641542bed9057e23cfff9cfc5ff0@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_000807_314268_D6E401EC 
X-CRM114-Status: GOOD (  16.59  )
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

Add flags to describe checks for integrity meta buffer. Also, introduce
a  new 'uio_meta' structure that upper layer can use to pass the
meta/integrity information.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h     | 9 +++++++++
 include/uapi/linux/fs.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..8ada84e85447 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -82,6 +82,15 @@ struct iov_iter {
 	};
 };
 
+typedef __u16 uio_meta_flags_t;
+
+struct uio_meta {
+	uio_meta_flags_t	flags;
+	u16			app_tag;
+	u64			seed;
+	struct iov_iter		iter;
+};
+
 static inline const struct iovec *iter_iov(const struct iov_iter *iter)
 {
 	if (iter->iter_type == ITER_UBUF)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..9070ef19f0a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -40,6 +40,15 @@
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
+/* flags for integrity meta */
+#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
+#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
+#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */
+
+#define IO_INTEGRITY_VALID_FLAGS (IO_INTEGRITY_CHK_GUARD | \
+				  IO_INTEGRITY_CHK_REFTAG | \
+				  IO_INTEGRITY_CHK_APPTAG)
+
 #define SEEK_SET	0	/* seek relative to beginning of file */
 #define SEEK_CUR	1	/* seek relative to current file position */
 #define SEEK_END	2	/* seek relative to end of file */
-- 
2.25.1


