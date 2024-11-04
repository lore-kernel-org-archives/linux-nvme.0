Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DBAD111A1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Qev84oB/WNNKAORKgHjGWYS6Jca41BG3ZIzsvdmNNQ=; b=EzlYNDczIp88joBAvQib8iagI/
	oyopcEJ3Fp7abUlVMr0XthGbx3NwKID6knv8RxxdkzuxKzl3a8JJxXEjAYeGAZ2vx0HaBpmFc3Gfq
	LzhS99JxZQa0wrdy+JwYVWsi17U7L9ghkLfyMYacxdn60ipqA1VCKoQZxjAF0U5yISR4EjQFC7JEm
	sX64RRb+OrU/DwfEn8umJvUqMuQZmVmfdMNOiYZlVfXcTrJinMOlfadASos5ni3W+qr4HdDzWPePo
	iafu8AzkrRsbuRjxJrLCMkHXHVE9HMa3kVxKzaCUvasSfE6hsl4w1PBOdiWaDgemjNN36GxTW/PGW
	g8Ly4d7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zRE-0000000EHNe-0CpN;
	Mon, 04 Nov 2024 15:56:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zR8-0000000EHIH-2onJ
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 15:56:16 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241104155612epoutp038316620929e2572a51c0bdc0d24a121d~EzwPwqcNa1886218862epoutp03M
	for <linux-nvme@lists.infradead.org>; Mon,  4 Nov 2024 15:56:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241104155612epoutp038316620929e2572a51c0bdc0d24a121d~EzwPwqcNa1886218862epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730735772;
	bh=0Qev84oB/WNNKAORKgHjGWYS6Jca41BG3ZIzsvdmNNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ur0EzeqZ8s10zEmgkjwF3CDxrhCnmJ0jz/kQkGPt9Lp8TfTsPl4wUXgPrpV/BOzaE
	 vcyySZbnBodIOV90iFE7F/QprkNvZ9Ui8rmxQwLd15NxOu1xqx+Nl5jXa2iHw9jm8u
	 otXyxbYgmC8GolzyIrfAxcbJDEohimFP9q1+k6NY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241104155611epcas5p4f6ca1d9f35d73c18873bfb1b7cccfaec~EzwPDTMVt1901719017epcas5p4O;
	Mon,  4 Nov 2024 15:56:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xhx0B1y3hz4x9Pq; Mon,  4 Nov
	2024 15:56:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.DA.09800.A9EE8276; Tue,  5 Nov 2024 00:56:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241104141456epcas5p38fef2ccde087de84ffc6f479f50e8071~EyX0xLPPN2420824208epcas5p3A;
	Mon,  4 Nov 2024 14:14:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241104141456epsmtrp1f8075e736025a0e20cc83f1ed67e0f9d~EyX0wYXRY1340613406epsmtrp1K;
	Mon,  4 Nov 2024 14:14:56 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-39-6728ee9a70d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.68.35203.0E6D8276; Mon,  4 Nov 2024 23:14:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141453epsmtip2bc39da8da09bf780b329cc179e0ae39e~EyXydls4O3023030230epsmtip2v;
	Mon,  4 Nov 2024 14:14:53 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v7 05/10] fs: introduce IOCB_HAS_METADATA for metadata
Date: Mon,  4 Nov 2024 19:35:56 +0530
Message-Id: <20241104140601.12239-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104140601.12239-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmuu6sdxrpBvN+clh8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSwmHbrGaLH3lrbFnr0nWSzm
	L3vKbtF9fQebxfLj/5gszv89zmpxftYcdgdBj52z7rJ7XD5b6rFpVSebx+Yl9R67bzaweXx8
	eovFo2/LKkaPMwuOsHt83iTnsenJW6YArqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
	XUNLC3MlhbzE3FRbJRefAF23zBygd5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
	BSYFesWJucWleel6eaklVoYGBkamQIUJ2RlrT69hLLjCWrH+VgtjA+M1li5GTg4JAROJLUsX
	sHcxcnEICexmlGj8+pYJwvnEKDHlwhsmkCohgW+MEp8+SMF0vOr6BdWxl1Fi5dS5UM5nRomN
	F1+zg1SxCahLHHneygiSEBHYwyjRu/A0C4jDLPCSUWLpqkVg24UF3CRmzjgNZrMIqEpcm76F
	GcTmFbCUuLK1kQlin7zEzEvfwaZyClhJzPl7lwWiRlDi5MwnYDYzUE3z1tnMIAskBC5wSFxb
	v5EdotlFYlp7P9QgYYlXx7dAxaUkXva3QdnpEj8uP4WqKZBoPraPEcK2l2g91Q80lANogabE
	+l36EGFZiamn1jFB7OWT6P39BKqVV2LHPBhbSaJ95RwoW0Ji77kGKNtD4unab9Dg6mWUmHCy
	g3kCo8IsJP/MQvLPLITVCxiZVzFKphYU56anFpsWGOellsPjOTk/dxMjOJFree9gfPTgg94h
	RiYOxkOMEhzMSiK881LV04V4UxIrq1KL8uOLSnNSiw8xmgIDfCKzlGhyPjCX5JXEG5pYGpiY
	mZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwHQin9OUzUH3+q2pa++cintw2O3o
	N72w9gCXiXdfKIWcNgqW3ffA6M0a99kmrznvf7l4dfvZ5Y27sr6ayQayPXgxxyHYxa5C3u6c
	7t51/lkzxZxXt3/M5s7dzLLgT89q71OT9ThX6bS27tkQPpv7uIjPuWnTbk9TCbC9nBP/STgy
	M83+cuQ927des7SFwzl/l3Joc+Vsst96/oVF4Z37E4rqVP5d1t/xwHmDS4H7c9azjpLSxRH5
	f5/sXGK+antY5p0lsjdUD+uvWC/Urbuh84x455QrevODuW7+UVFUO3O1K4c3JT7xV84CL28N
	7gu2LXvPXGB6LBP442/zXt7XqY/bZ9SEt5xccWS7w76X6Q1KLMUZiYZazEXFiQDhTTLIbQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvfBNY10gxPr+Sw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXxtrTaxgLrrBWrL/VwtjA
	eI2li5GTQ0LAROJV1y92EFtIYDejxJ75UhBxCYlTL5cxQtjCEiv/PQeq4QKq+cgosevUNCaQ
	BJuAusSR561gRSICJxgl5k90AyliBima8GU22AZhATeJmTNOg9ksAqoS16ZvYQaxeQUsJa5s
	bWSC2CAvMfPSd7ArOAWsJOb8vcsCcZGlxKamSywQ9YISJ2c+AbOZgeqbt85mnsAoMAtJahaS
	1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFxpqW5g3H7qg96hxiZOBgPMUpw
	MCuJ8M5LVU8X4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnV
	wMRU69RmeOdYzsbnt7yq+SP/TNiybNLqWzOcTPf9KNBKFXhwab/mqS/PP/2LOC+76ReLxuZw
	rrSZ9vvWsVif/PM04eBvplvOJ7g+FMS2v1xvwXNurl1p7nLl60stNq9/qC35L1nI9d/VSZ1q
	89YeV1n80+r0p2vu/Jdjl/ZNXtB43J2Z073rreLd3eJfpnaevOjYssmJc17H+0y/aXHRASyt
	U+ILruZd4JZ91Cag1Plv2/zbja+FPacs+p7Ul7bo1c4+NmW5/3O2uzw9dKfMm7N8aXTLt+LV
	7GXaqwWtfxQpLW+f8XzhDO3D0yQ+erj0VAt5HBBMmbCgrOPv1XMy11e0bXd2qTxjJj8rJW3m
	ulolJZbijERDLeai4kQA1JajCSIDAAA=
X-CMS-MailID: 20241104141456epcas5p38fef2ccde087de84ffc6f479f50e8071
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104141456epcas5p38fef2ccde087de84ffc6f479f50e8071
References: <20241104140601.12239-1-anuj20.g@samsung.com>
	<CGME20241104141456epcas5p38fef2ccde087de84ffc6f479f50e8071@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_075615_077437_B415B132 
X-CRM114-Status: GOOD (  14.21  )
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

Introduce an IOCB_HAS_METADATA flag for the kiocb struct, for handling
requests containing meta payload.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4b5cad44a126..7f14675b02df 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,6 +346,7 @@ struct readahead_control;
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 23)
+#define IOCB_HAS_METADATA	(1 << 24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
-- 
2.25.1


