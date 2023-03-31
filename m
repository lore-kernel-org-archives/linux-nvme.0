Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D430DC77B60
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 03:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPspr9ySugJOAfoeYrk4zOdGco4LzsVeD1y4ToDhPlM=; b=QRuyEkYbXF1amioR68DbSqElmK
	Tg93o6UmyUVLLoynasUF6nA7aKZozrowL0Lnl9HUYKX77J0XYJuJ/iT/mPSXMraZ5ZBQ2hBzUdaqE
	Q1dwK2b/p3T/Fjs/toma/byxGJT7gs8VBS8/nB2fZnyDBWQ9l3GLWIcec23kYXKE99Z0dbzlrFIv+
	BVRvnS5y66FCWCD2Mmk6vQ4/MygGCwg2LGGmeiXbqMciPST7Hievi+SiiCjvvbj17CKJARkajrMq8
	UTZMWZjRU+kXPQI1ekiQanCorP82pyfr/YVFeXA8Z3z/meC6jRqy5e2juHKUkopEX+hyxjWUuoXFr
	8qzGGC1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5sM-005khg-1w;
	Fri, 31 Mar 2023 03:56:30 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5sI-005kfk-16
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 03:56:27 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230331035624epoutp01e0ee3606ba7c7440e1c09b3f9b836651~RZND6PrFB0044300443epoutp01g
	for <linux-nvme@lists.infradead.org>; Fri, 31 Mar 2023 03:56:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230331035624epoutp01e0ee3606ba7c7440e1c09b3f9b836651~RZND6PrFB0044300443epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680234984;
	bh=VPspr9ySugJOAfoeYrk4zOdGco4LzsVeD1y4ToDhPlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeC5MUbwK+wDcsCWEZPQ25xcbtKvMZ3n6iDfZlDXBgJMSlgIF8MPggcD16hMP+3MC
	 KdZyAWwZ+BLZWIBRkYsu+2/+ZeZzrQFRG33KZ4muKrfKaeyinydUelp/stlvN7ebBn
	 +pd2KKVIuKPRqWsRejYUJa8tSWqwyooL4cGHBmC0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230331035624epcas5p3d2ee7f7246789168bfb28b6a5a501085~RZNDUaV5q0953409534epcas5p3M;
	Fri, 31 Mar 2023 03:56:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4PnmgB1hQlz4x9Q0; Fri, 31 Mar
	2023 03:56:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.81.06765.1E956246; Fri, 31 Mar 2023 12:56:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230331035617epcas5p41ff3b2a1def95ba99abd16634b9e726f~RZM9VCRxp2719927199epcas5p4C;
	Fri, 31 Mar 2023 03:56:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230331035617epsmtrp28518278b94242ab34e6a30710e44efa8~RZM9Qv3Kf2276122761epsmtrp2X;
	Fri, 31 Mar 2023 03:56:17 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-c3-642659e1e46a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.A7.18071.1E956246; Fri, 31 Mar 2023 12:56:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230331035616epsmtip247a71e3bd11ea1fe471fd2ab8d3ef10b~RZM8k9gDC1412414124epsmtip2e;
	Fri, 31 Mar 2023 03:56:16 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, mcgrof@kernel.org, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH blktests v2 2/2] nvme/047: add test for uring-passthrough
Date: Fri, 31 Mar 2023 09:25:19 +0530
Message-Id: <20230331035519.42728-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331035519.42728-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmpu7DSLUUg6XbLC2O/n/LZjF/2VN2
	ixsTnjJa7Jvl6cDisWlVJ5vH5iX1Hn1bVjF6tB/oZgpgicq2yUhNTEktUkjNS85PycxLt1Xy
	Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzvj0P6tgDW9F75p3zA2MP7m6GDk5
	JARMJOYcusTcxcjFISSwm1Hiz542NpCEkMAnRokTTW4QiW+MEte+XGKE6eh9uZwFomgvo8Tx
	z9EQRZ8ZJZomfQYq4uBgE9CUuDC5FKRGREBeYuXsZlYQm1kgRmJCwxpmEFtYwFPiaOsKsDiL
	gKrE9q5n7CA2r4CFxMzrU6B2yUvMvPQdLM4pYCmx92cjVI2gxMmZT1ggZspLNG+dDfaBhMAx
	dokjRw6B3SAh4CIxf1sVxBxhiVfHt7BD2FISn9/tZYOwkyUuzTzHBGGXSDzecxDKtpdoPdXP
	DDKGGeiV9bv0IVbxSfT+fsIEMZ1XoqNNCKJaUeLepKesELa4xMMZS6BsD4lZE9+yQEKnh1Fi
	7uoXTBMY5Wch+WAWkg9mIWxbwMi8ilEytaA4Nz212LTAOC+1HB6pyfm5mxjBiU7Lewfjowcf
	9A4xMnEwHmKU4GBWEuEtNFZNEeJNSaysSi3Kjy8qzUktPsRoCgziicxSosn5wFSbVxJvaGJp
	YGJmZmZiaWxmqCTOq257MllIID2xJDU7NbUgtQimj4mDU6qBie2Xm4FiX+qqybrFF1M3G9gt
	CLx1KoD33bWiz8JXFovu6zHd9ufYu2bl4IMiztP4ObY1KF3fyF4nW+96fs3c+VLB345N/e58
	INt/A0OOUse3V1e/Ll7laqPmurVgnm9CSt8mgdaGzEtljrOnvWJW8pAQiMgIW24us1uM5U9S
	hO6LtsQ1Yp9uy3OZybpkL3+2y9tJXWF99rd1UzfGXD+jILT3Sc20Phu3d/fXPFzNvYFhXtVR
	78edxRJv6jrPeFodvjb57UP/TVcnuGVduPOI/3Ejx+/c9XeP7FuZEOLSb2eYEOSjXTOTaTn7
	dw2BRvPqlTnzr56KyGbfoOXCERPmn3Ni1pStM6dVXk99dL8gVImlOCPRUIu5qDgRAID9eSj9
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO7DSLUUg81P5C2O/n/LZjF/2VN2
	ixsTnjJa7Jvl6cDisWlVJ5vH5iX1Hn1bVjF6tB/oZgpgieKySUnNySxLLdK3S+DK+PQ/q2AN
	b0XvmnfMDYw/uboYOTkkBEwkel8uZwGxhQR2M0qs7BeAiItLNF/7wQ5hC0us/PccyOYCqvnI
	KHH5+Vy2LkYODjYBTYkLk0tBakQE5CVWzm5mBbGZBeIkjnZ/YgOxhQU8JY62rgCLswioSmzv
	egY2k1fAQmLm9SmMEPPlJWZe+g4W5xSwlNj7s5Ed4h4LiRdLL7FC1AtKnJz5hAVivrxE89bZ
	zBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4TLU0dzBuX/VB
	7xAjEwfjIUYJDmYlEd5CY9UUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
	FqQWwWSZODilGpg8DvXs2/f5RktikPHP//MXPuy1yb/nIfPix+OOPbzbn7O3CHsEXbtR3fzm
	/yNTqcr1evF+tZ8fNxw51p3Kb5BWqyxfJ/lm1uJN8V1+Qbbvj1Y/Yj9/ouT4YcHl9+x2+Jsa
	P7qUFHnb+kjg6z+8n7WWPdyoMGMVU9wZSd5lDWYS+5a9eHB7xv85nqyHQ6d2HJsptZ0hI82g
	ZJnRZ1/PPXFMfzxsfSZ7in9NjtR8wHzc8dvBJZlvbvP9Wan4P23u+adzs1muqDrNP7XlOCMD
	7wJZ/iv/9v20PfhGQ9XQYpbTGbUbHT5sn+v9IquS1+Qavy2Qi+PXepku2NfBxllcE5XrzeBU
	dkZzH/+zXL+zVySUWIozEg21mIuKEwGZdeq2wgIAAA==
X-CMS-MailID: 20230331035617epcas5p41ff3b2a1def95ba99abd16634b9e726f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331035617epcas5p41ff3b2a1def95ba99abd16634b9e726f
References: <20230331035519.42728-1-joshi.k@samsung.com>
	<CGME20230331035617epcas5p41ff3b2a1def95ba99abd16634b9e726f@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_205626_698922_DA4AB0C4 
X-CRM114-Status: GOOD (  18.80  )
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

User can communicate to NVMe char device (/dev/ngXnY) using the
uring-passthrough interface. This test exercises some of these
communication pathways, using the 'io_uring_cmd' ioengine of fio.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 tests/nvme/047     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 0000000..ea9b001
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
+# Test exercising uring passthrough IO on nvme char device
+
+. tests/nvme/rc
+
+DESCRIPTION="basic test for uring-passthrough I/O on /dev/ngX"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kver 6 1
+	_have_fio_ver 3 33
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local ngdev=${TEST_DEV/nvme/ng}
+	local common_args=(
+		--size=1M
+		--filename="$ngdev"
+		--bs=4k
+		--rw=randread
+		--numjobs=1
+		--iodepth=16
+		--name=randread
+		--ioengine=io_uring_cmd
+		--cmd_type=nvme
+		--time_based
+		--runtime=2
+	)
+	#plain read test
+	_run_fio "${common_args[@]}"
+
+	#read with iopoll
+	_run_fio "${common_args[@]}" --hipri
+
+	#read with fixedbufs
+	_run_fio "${common_args[@]}" --fixedbufs
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 0000000..915d0a2
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.25.1


