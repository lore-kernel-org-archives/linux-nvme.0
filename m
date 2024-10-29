Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBC9D3A67A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUxSD6cm/2/oRpjJQ/qX5pi0ZZMenTN0KcQUO7F+Cjs=; b=RDNVhO+hDez7rBApb5wERBuHxD
	pcWAqswQvwmXeyphRhgBYYgvIn+emymOwrzSjWlYcv6P/gTbl6DEuEYXqvT4Pk0BqQa3DBoEaFD4D
	gIyAYGpj0VhQZ7sRDh7Bi/+t/eN+WlUS5OaHXGUtR4p37EKl+EwWzX9+UigNKXRpUZ4BFow6KBGK1
	W2TO19/Wgdr77p5DK97hIxUc3Z4IELQQcNlNzOcsVJA6SQ49KKzR6bEpZlf8eS+wce8MlUJM1ZWPs
	GCaq6ETaedGrDcfagtPtc1DLPvTBjLvE3P4ehYFFi71s/8kgjG05MduCgZGgmSdpnr2iR/Ssi+MRa
	XS2OO0lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qPu-0000000FOnG-3c3S;
	Tue, 29 Oct 2024 17:54:06 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pwd-0000000FEta-02W9
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:23:52 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241029172348epoutp03dbcdbb469efa2f9f6c6eaacfdd36cbe4~C-FBVuOhX0223102231epoutp03Y
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 17:23:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241029172348epoutp03dbcdbb469efa2f9f6c6eaacfdd36cbe4~C-FBVuOhX0223102231epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730222628;
	bh=RUxSD6cm/2/oRpjJQ/qX5pi0ZZMenTN0KcQUO7F+Cjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUgFSPyuH99B16995/j89/QOEcBpc8oLvwV3dwk50KDnMdF7RncNZA9kwq18UZhOL
	 DNqu2vsljSlIxA83MkAD7yEvHdiD7dfoH4HPbXT4QHMuFYVgAEey/aMg53NfMnN6UO
	 6A/YQi7AHnJpYIwJfomeEKLLy4FS58sp9lDagdw0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241029172348epcas5p1ef1585b46b83aa08f29a5a73359ad0f3~C-FAy1jzA0899208992epcas5p1K;
	Tue, 29 Oct 2024 17:23:48 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XdHD31511z4x9Pt; Tue, 29 Oct
	2024 17:23:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.7A.18935.22A11276; Wed, 30 Oct 2024 02:23:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5~C_YEu6-ss0970309703epcas5p2B;
	Tue, 29 Oct 2024 16:32:20 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029163220epsmtrp184c6055921ab0b6389e5209895ed85f2~C_YEuC6yO0708307083epsmtrp1M;
	Tue, 29 Oct 2024 16:32:20 +0000 (GMT)
X-AuditID: b6c32a50-cb1f8700000049f7-bb-67211a22e017
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.4B.07371.31E01276; Wed, 30 Oct 2024 01:32:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163217epsmtip253344fee5699a83a61ae5feaa5096850~C_YCQ_AR70998409984epsmtip2X;
	Tue, 29 Oct 2024 16:32:17 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v5 04/10] fs, iov_iter: define meta io descriptor
Date: Tue, 29 Oct 2024 21:53:56 +0530
Message-Id: <20241029162402.21400-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029162402.21400-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc+69tBdczbV7nTWC5caJsJVRRrsDwjbDolddIovGZLrZVbgp
	taWtfQxnRDpIV8HQls1ltnTIJo5H4zQdEBgghmfGVhgiGghkL1pxWJUR3SsMW1p0/33P73y/
	v09+50Hi/GscAanUGFm9Rq6mOXFEW19ykogWJCrSekdfQAt/PyRQmWMJR+7mNoA8M3YOmu+7
	A9DkDx0YavIMYOgPywiBak6VY2hgOchBx3t/Bqh7agvq6r5EoC/P+bnos1/aOahh6BGGRpeG
	YtCoy83dzWc6XDNcZtxnYrzNFRzmQn0p0zlp5jAL/imCsbU0A+ZKXT+XWfQmMN7ZIJYX97Yq
	u5CVF7B6IavJ1xYoNYoc+rU3ZLkyiTRNLBJnoh20UCMvYnPoPXvzRC8p1aGZaOFhudoUKuXJ
	DQZ6285svdZkZIWFWoMxh2Z1BWpdhi7VIC8ymDSKVA1rzBKnpaVLQsZDqsLLJ1oJ3QTvw5+q
	xzAz+OKJShBLQioD+s+PEZUgjuRTXQC6l+dAZHEHQE/NNTzs4lP/AGhrTFhNTFTORevdAPZ/
	9XQksAhga1mACG9wqCTY/6tlpdO6cNuqM5dXGDjlwKC12s0Nu9ZSL8KpQE9MWBPUZvj59QAI
	ax6VCasuerEI7hno/PHuij+WyoKDA11YxPMUvOScXaHhIU95aw0eBkBqmoRz/g4QCe+BrqZv
	onotvD3Uwo1oAfzNfiyqFfDeuD8K08Hywe+j/l3QMmwPNSVDgGT47cVtkXI8PDl8Hotwn4RV
	D2ejUR5sr13VNLQ2uaMawu4Rc1Qz8EbPDCdyXFUATi+Mch1A6HpsHtdj87j+R9cBvBkIWJ2h
	SMHmS3RikYYt/u+e87VFXrDy0lPy2oHnu6XUXoCRoBdAEqfX8TwH4xV8XoH8yEesXivTm9Ss
	oRdIQidejQvW52tDX0VjlIkzMtMypFJpRuZ2qZjeyJu3nC7gUwq5kVWxrI7Vr+YwMlZgxtx2
	6813ZysUZP3h3BJKZ+GdO+QPzm3d3rezZXQaezCw660EH7c2S708ss9zgdd0tp36K/H1pIoP
	rksSGyeuvJey28ZL3vCJ1eqc4G4ti+n3HsiqLN28b/nVhufe9N484OTd2mu1+I4E23xs2TvS
	QBAfuXvS13P/Nna1mCuK18piKfLPCdF+eAOd6jxx/PT7jaZ0WwldnHPw0Zra6hItbg4Kj85f
	XXOmxKZHZysdDYlfxwWXGzb9/rFd1pTtGEwKTOYmDycSPqcPLI4/27kl/Xmbaqa03nxfuWHj
	JtUth/Ll/XVW2K8cs/H7Opa6fcbUozsC9z594C065pJoXqlZTxOGQrk4Bdcb5P8CboJ1uHIE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvK4wn2K6weKLlhYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJouj/9+yWUw6dI3RYu8tbYs9
	e0+yWMxf9pTdovv6DjaL5cf/MVmc/3uc1eL8rDnsDkIeO2fdZfe4fLbUY9OqTjaPzUvqPXbf
	bGDz+Pj0FotH35ZVjB5nFhxh9/i8Sc5j05O3TAFcUVw2Kak5mWWpRfp2CVwZpydvZSm4yltx
	ZeJFpgbGGdxdjJwcEgImEle7XjB3MXJxCAnsZpRY/vw3K0RCQuLUy2WMELawxMp/z9khij4y
	SmxdcACsiE1AXeLI81awIhGBE4wS8ye6gRQxC8xgkuj5tYINJCEs4Chx69l+sAYWAVWJKQ+e
	gTXwClhK9O7axASxQV5i5qXv7CA2p4CVxLGje4DiHEDbLCVOTnKDKBeUODnzCQuIzQxU3rx1
	NvMERoFZSFKzkKQWMDKtYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQIjjgtjR2M9+b/
	0zvEyMTBeIhRgoNZSYR3daxsuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE0hNLUrNT
	UwtSi2CyTBycUg1MRxat5TaWNblx/WQKe9CJRwwFpgeLo8PE1px0j7DfF/nwynUTj+ZTze9m
	H22ukhZV+L/lsOIv9ll6/vxVpUFvEqWXiB2xTTsqvch92tIzs+T7+6Nu/Mq2Pzc9ff6Gno8r
	GO89E/VSjP+nZh/Z/73MsXDHHpEefqX1z3V2tafdW7RdfPf3236Tz39L2t9+irkgxfxBbZ1T
	Ud+CN0kJ3Ud2HsyY2CVlE29sGXDh6DWpTtV2NsP5ioFbpj+dt/qXymaJss0XU81l7gfPvzat
	52j4oeVyr9q/RmgnaqmbH94n12LMXrDlZopgTXTp3nU7ntlwvWr10bcpFDofelf2jcnH6bIy
	TDutZvw+lta/j/eiEktxRqKhFnNRcSIAyLvsDCcDAAA=
X-CMS-MailID: 20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_102351_407932_A5166727 
X-CRM114-Status: GOOD (  15.73  )
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
---
 include/linux/uio.h     | 10 ++++++++++
 include/uapi/linux/fs.h |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..eb3eee957a7d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -82,6 +82,16 @@ struct iov_iter {
 	};
 };
 
+/* flags for integrity meta */
+typedef __u16 __bitwise uio_meta_flags_t;
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


