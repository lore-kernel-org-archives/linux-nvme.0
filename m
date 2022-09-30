Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B256C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrGN7gLKOrzQZiNkA25VZ8kKhcB7stJufxn/uiDuDos=; b=sbOdUHi8ppglDREseWxMtSaE2O
	eum1VR0uwdP+1KuQtBr9U7ZjZ9yH3cUBCSc74sqhKJ1o3ICJBmI23tDVwL6U3jrrt1yRJw6XQss67
	YfTNC3ghqfR3omgpkB+Hq2DGcxw5ZOQ271FHjXUQnZ9fOrLp3INgrIHiMyP1DHj/D9zlh6ik6Qdbq
	KkvBEiQ8uIRrO6HkdUv0SKL7Z1NQJ4uXRZjPcT8hHs2LQFtc9mVxuRck/uQ5S0QpRpnwccNgdauYl
	S2Zw6FXLCRzeY4Rmnf+GqJhnQyiT1ga8+t4rpyt1CiMxKQ3620fP+LXMGdTMjmAQO4M3dbCRCZii7
	NXcXfNLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9kQ-007ZuD-I9; Fri, 30 Sep 2022 06:43:46 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9kH-007Zok-Cl
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 06:43:39 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220930064334epoutp029dbd91c26ad36ed0983935e0d1aadb74~ZkFD8k3Sa0355103551epoutp02k
	for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 06:43:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220930064334epoutp029dbd91c26ad36ed0983935e0d1aadb74~ZkFD8k3Sa0355103551epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664520214;
	bh=RrGN7gLKOrzQZiNkA25VZ8kKhcB7stJufxn/uiDuDos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwLqaZVBHAtXU9BhbQrZiTHGrEPO4JTd4liPZa3dDbnfLStRSyDG8VULPXn+niM87
	 isesRFQtKm8w3WdlefIv0RtyhB+IQE/VfJmxfAzW5BfPMWJnaz3jdRYp6hgwtf1+yg
	 bhqnF+q8zUUk2ir6C/+uuaQ/1A57u4YYZwqMI7SM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220930064334epcas5p4d47b56ee27d1b6989a42bfeed7a7a331~ZkFDqPS742213522135epcas5p4z;
	Fri, 30 Sep 2022 06:43:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Mf1044B6Pz4x9QL; Fri, 30 Sep
	2022 06:43:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.4D.39477.41096336; Fri, 30 Sep 2022 15:43:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220930063815epcas5p1e056d6a2a53949296a7657de804fd2ec~ZkAaoOaJY0150801508epcas5p1Y;
	Fri, 30 Sep 2022 06:38:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220930063815epsmtrp1c42f33706405ad36c52c664215ba6c85~ZkAanSiKK2641426414epsmtrp1q;
	Fri, 30 Sep 2022 06:38:15 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-5b-633690140bda
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.42.18644.7DE86336; Fri, 30 Sep 2022 15:38:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220930063813epsmtip2d3d3f55932b7ca094ce0eb8ce5594c7c~ZkAYRv-iN1736317363epsmtip2U;
	Fri, 30 Sep 2022 06:38:12 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v12 04/12] scsi: Use blk_rq_map_user_io helper
Date: Fri, 30 Sep 2022 11:57:41 +0530
Message-Id: <20220930062749.152261-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930062749.152261-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmuq7IBLNkg2mfZCyaJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3aL7+g42B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
	tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
	rpeXWmJlaGBgZApUmJCd8X7OROaCN0IVzx7dZ2pg7OXvYuTkkBAwkbiwbD5jFyMXh5DAbkaJ
	iZ9eM0M4nxglFr/5zQbhfGaUuHnwHVAZB1hL4wceiPguRomGja9YQEaBFZ2YagZiswmoSxx5
	3soIYosIGEns/3SSFaSBWWATo8Sv68eYQBLCAu4SKy5tAxvKIqAqcbxXEyTMK2AlMXt3OyPE
	efISMy99Zwcp4RSwlmhelANRIihxcuYTsLXMQCXNW2eDHS0h8JNd4v+9DhaIXheJCde3skHY
	whKvjm9hh7ClJF72t0HZ6RI/Lj9lgrALJJqP7YPaay/ReqqfGWQvs4CmxPpd+hBhWYmpp9Yx
	Qezlk+j9/QSqlVdixzwYW0mifeUcKFtCYu+5BijbQ+Lr/lvQwO1jlJh39izTBEaFWUj+mYXk
	n1kIqxcwMq9ilEwtKM5NTy02LTDKSy2Hx3Fyfu4mRnAi1fLawfjwwQe9Q4xMHIyHGCU4mJVE
	eMULTJOFeFMSK6tSi/Lji0pzUosPMZoCg3sis5Rocj4wleeVxBuaWBqYmJmZmVgamxkqifMu
	nqGVLCSQnliSmp2aWpBaBNPHxMEp1cCUnffzPr+Ip+Yti5nvwoPtOXPE/wrsuZqXsmP/nS9F
	EXsfRk5aHtepxZ7uvnZi5OLtj47NfmlnyB33cYF6jN8Crn+3VkSXZ5iZN9csuMD09sGsR1Na
	PYK3+3RfiZnZ/TAswf+lie2Oguuf/llOOm2qEzXf411PHcMzzfUep0X5b13ctOHJjq4Vqf0v
	5wbySCW/nS0Y+246p2bA2inTTjDHiX6cvvtNDX+c2UZXJcFuZya2SkUdLQ2VfoZ0Oe9ZrJ88
	mJ9mTa3e+efGTrkpUsL8f73+Ki7+E6rx9rfNXtn9PO+2VHvtlpr6Q87/yr26Des0PBxeOIoo
	HNjUz14i8FnRPKFmNeve2pvqX03k171XYinOSDTUYi4qTgQAWkbi7i0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO71PrNkg4mfpS2aJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3aL7+g42B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mp4P2cic8EboYpnj+4zNTD28ncxcnBICJhI
	NH7g6WLk4hAS2MEocb3hHFsXIydQXELi1MtljBC2sMTKf8/ZIYo+Mkps6bsNVsQmoC5x5Hkr
	WJGIgJnE0sNrWECKmEEmrXu2GCwhLOAuseLSNkaQbSwCqhLHezVBwrwCVhKzd7dDLZCXmHnp
	OztICaeAtUTzohyQsBBQyec979khygUlTs58wgJiMwOVN2+dzTyBUWAWktQsJKkFjEyrGCVT
	C4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCQ11LawfjnlUf9A4xMnEwHmKU4GBWEuEVLzBN
	FuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoGp6Ps0RQVD
	+61fjU3S/8379HyD3qau9OaZ67W36xhd+vBge6+4/kq/I4L3r7+1mxbzetkT6XMPlxnkhpRO
	WrDjy+FvJ/NZJ58+LdScsaFdIrY4wSXKfMKiNoYaEzXbOtn6efoh8y8yJmqzfq84qfm4L/bs
	8WWslmufXa06k2yYY/Juw7q+YKunE59mrd21So9/lzrzYenUaZsKnXLn8bHazVqnuVXn6jaj
	W3Hv7p62PxWy2y14+66FXxal1LUsf3dFSnrGF9fbbFHKjfO2npeJTWNe8alBf2vP1OpFGpWW
	9VbcXsU/v3VcjEja4LRqfbHi761vmDVPBG/t/fXej+32Cx3HM8FG0+6LX8o+rjuRQYmlOCPR
	UIu5qDgRAAP5ZDTkAgAA
X-CMS-MailID: 20220930063815epcas5p1e056d6a2a53949296a7657de804fd2ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220930063815epcas5p1e056d6a2a53949296a7657de804fd2ec
References: <20220930062749.152261-1-anuj20.g@samsung.com>
	<CGME20220930063815epcas5p1e056d6a2a53949296a7657de804fd2ec@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_234337_836599_5CA20F23 
X-CRM114-Status: GOOD (  17.43  )
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

Use the new blk_rq_map_user_io helper instead of duplicating code at
various places. Additionally this also takes advantage of the on-stack
iov fast path.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_ioctl.c | 22 +++-------------------
 drivers/scsi/sg.c         | 22 ++--------------------
 2 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 729e309e6034..2d20da55fb64 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -449,25 +449,9 @@ static int sg_io(struct scsi_device *sdev, struct sg_io_hdr *hdr, fmode_t mode)
 	if (ret < 0)
 		goto out_put_request;
 
-	ret = 0;
-	if (hdr->iovec_count && hdr->dxfer_len) {
-		struct iov_iter i;
-		struct iovec *iov = NULL;
-
-		ret = import_iovec(rq_data_dir(rq), hdr->dxferp,
-				   hdr->iovec_count, 0, &iov, &i);
-		if (ret < 0)
-			goto out_put_request;
-
-		/* SG_IO howto says that the shorter of the two wins */
-		iov_iter_truncate(&i, hdr->dxfer_len);
-
-		ret = blk_rq_map_user_iov(rq->q, rq, NULL, &i, GFP_KERNEL);
-		kfree(iov);
-	} else if (hdr->dxfer_len)
-		ret = blk_rq_map_user(rq->q, rq, NULL, hdr->dxferp,
-				      hdr->dxfer_len, GFP_KERNEL);
-
+	ret = blk_rq_map_user_io(rq, NULL, hdr->dxferp, hdr->dxfer_len,
+			GFP_KERNEL, hdr->iovec_count && hdr->dxfer_len,
+			hdr->iovec_count, 0, rq_data_dir(rq));
 	if (ret)
 		goto out_put_request;
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 94c5e9a9309c..ce34a8ad53b4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1804,26 +1804,8 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 			md->from_user = 0;
 	}
 
-	if (iov_count) {
-		struct iovec *iov = NULL;
-		struct iov_iter i;
-
-		res = import_iovec(rw, hp->dxferp, iov_count, 0, &iov, &i);
-		if (res < 0)
-			return res;
-
-		iov_iter_truncate(&i, hp->dxfer_len);
-		if (!iov_iter_count(&i)) {
-			kfree(iov);
-			return -EINVAL;
-		}
-
-		res = blk_rq_map_user_iov(q, rq, md, &i, GFP_ATOMIC);
-		kfree(iov);
-	} else
-		res = blk_rq_map_user(q, rq, md, hp->dxferp,
-				      hp->dxfer_len, GFP_ATOMIC);
-
+	res = blk_rq_map_user_io(rq, md, hp->dxferp, hp->dxfer_len,
+			GFP_ATOMIC, iov_count, iov_count, 1, rw);
 	if (!res) {
 		srp->bio = rq->bio;
 
-- 
2.25.1


