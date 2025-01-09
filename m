Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA11E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=VIiyIaP68HZn7W5QiHJl/z2lS2Z0MaPaUgyO96eZbSc=; b=cXJ9XKICFQQoUV+CzSwwiKARmH
	rYA4OcySVF/LmSxa1INluIfZF75BES2KMrVT2J4jmSqlfrvXKbxumKF9stObjcFPLofn05jiGApw7
	I5HYFk/+mt3RhmNvbK9QODVbuQqbvcqKnu+doZq7B80P+FP3wYJM72WddBQCVTCiLwj9xOD4pDgnJ
	6RXEsfp1P0d65FwTGHhE9i9gUOhYNsE+11mZ8qIUJP8ebwclbwAEfY2GDQlztq2hR9ZTWHDzyfuVq
	3SmvvWpUNTmCTCrjAcnEmIjcvu2g+u3O2VALMJAdczYFaMWViZfFcJlmLhs4JQxbOTc2jl5qEWvcE
	RWjr/LDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ZY-0000000EO6J-40QC;
	Fri, 10 Jan 2025 07:36:48 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ZV-0000000EO3q-1L0Z
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 07:36:48 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250110073634epoutp0490c743518c58e1c95bf735e14b616029~ZRKIGBrbd2664426644epoutp042
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 07:36:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250110073634epoutp0490c743518c58e1c95bf735e14b616029~ZRKIGBrbd2664426644epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736494594;
	bh=VIiyIaP68HZn7W5QiHJl/z2lS2Z0MaPaUgyO96eZbSc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=u9aIvj8+30uQzMJmFkeD9DyNGM7bv4+hBUOjJ7PDP2FYnzYnvQeAG3xzisgaQHdku
	 6pXtP9sz3iyiZaBZdInqZMkIH4h7lLO115ceAsqX+eWFaXUt9k7RgyJk9aSP35aR38
	 KFb3jGW5udNLLbMj8QznHEa5uQ21PRFz4AVued7g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250110073633epcas5p3d8b96512e5b6a6686bf6d90b47b32edd~ZRKHdESw61416914169epcas5p34;
	Fri, 10 Jan 2025 07:36:33 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YTtkk1vbhz4x9Pp; Fri, 10 Jan
	2025 07:36:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.A4.19710.EFDC0876; Fri, 10 Jan 2025 16:36:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6~ZPSBJDvjz1888518885epcas5p1i;
	Fri, 10 Jan 2025 05:19:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250110051900epsmtrp247755d3cf4637f1a5ee45bb653d47edf~ZPSBIN6mG0288602886epsmtrp2k;
	Fri, 10 Jan 2025 05:19:00 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-5d-6780cdfe7d68
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.7A.18729.4CDA0876; Fri, 10 Jan 2025 14:19:00 +0900 (KST)
Received: from open-sourcing.samsungds.net (unknown [107.99.41.223]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250110051858epsmtip1484f30b0d2805c099e0736635c2c1d49~ZPR-mvIWq0461604616epsmtip1J;
	Fri, 10 Jan 2025 05:18:58 +0000 (GMT)
From: francis.p@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com, d.palani@samsung.com,
	sathya.m@samsung.com, Francis Pravin <francis.p@samsung.com>
Subject: [PATCH] nvme-pci: use correct size to free the hmb buffer
Date: Fri, 10 Jan 2025 05:21:37 +0530
Message-ID: <20250109235137.8995-1-francis.p@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhu6/sw3pBo+e8lj8nj6F1eL/nmNs
	Fm+/PmCzOLZoC7PFytVHmSyWzte3mHToGqPF/GVP2S3uzehit1j3+j2LxdbLC9gduD0mNr9j
	9zh/byOLx6ZVnWwem5fUe+y+2cDm0bdlFWMAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
	mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
	gpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iyrx+axFyziqNg7bStTA+Mvti5GDg4JAROJ
	xYv1uxi5OIQEdjNKrO7awQbhfGKUmDjjFSuE841RYkVzO0sXIydYx9FNl9khEnsZJb5++MsC
	4fxklNj7cg8TSBWbgLTEpiWf2UBsEQFHiVcrnoPNZRbYxyhxaNtzsISwgJPE1n37wRpYBFQl
	HuxeAraCV8BSYlLnbEaIdfISi3csZ4aIC0qcnPkErIYZKN68dTYzyFAJga/sEn/fLGKDaHCR
	ePVvCSuELSzx6vgWdghbSuLzu71QNfkSr3Y/Z4KwKyS277oNZdtLXNzzlwkUMswCmhLrd+lD
	hGUlpp5axwSxl0+i9/cTqHJeiR3zYGxliU1P1kOtlZRobrwDtdZD4uHFBWA1QgKxEntbjzFO
	YJSfheSdWUjemYWweQEj8ypGydSC4tz01GTTAsO81HJ4zCbn525iBCdTLZcdjDfm/9M7xMjE
	wXiIUYKDWUmE11K2Nl2INyWxsiq1KD++qDQntfgQoykwjCcyS4km5wPTeV5JvKGJpYGJmZmZ
	iaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUx1jzcE/q1L9pR+aGWw+FJVf9ZzC9Pp
	+ryrFr1W/WwtNcds2jTr04vUu6JLmxj8QxvLV5bFWPeGzFh4LoG/QEUnY8Um4devK1N+Hzr0
	g/9YT1d1a7qdoLiyrJ/i32kxJ1P1XHmEygJClLmmuJ6dcfCGuPE+cZ9L/sWTuB7NvK0969X8
	1s2vVieyvpBezbVXxZh/1tprd04mn6lqTbrlZRVw/7ex8pmPKfxCsnz1X8UyW1ZenJEQHOf3
	bOZL252Gll0f6nQWXlyReuCDLO/qL2H5DH0/yi5UZ3YdKFrz9+ErOYnPJx/ne+/e2JUz81DQ
	B/2FSVbzirP+ztia8m/Xqt0H1wlqCqgIGbGdn1akLqjEUpyRaKjFXFScCAB/9oMdLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnO6RtQ3pBm0L2C1+T5/CavF/zzE2
	i7dfH7BZHFu0hdli5eqjTBZL5+tbTDp0jdFi/rKn7Bb3ZnSxW6x7/Z7FYuvlBewO3B4Tm9+x
	e5y/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGALYrLJiU1J7MstUjfLoEr4+qxeewFizgq9k7b
	ytTA+Iuti5GTQ0LAROLopsvsXYxcHEICuxkldm25yw6RkJQ4Nm0RlC0ssfLfczBbSOA7o8TM
	NVIgNpuAtMSmJZ/BBokIuEscfdnABDKIWeAYo8TaNSeZQBLCAk4SW/ftB7NZBFQlHuxewgJi
	8wpYSkzqnM0IsUBeYvGO5cwQcUGJkzOfgNUwA8Wbt85mnsDINwtJahaS1AJGplWMkqkFxbnp
	ucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFhraW5g3H7qg96hxiZOBgPMUpwMCuJ8FrK1qYL8aYk
	VlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYLqWdunK94nrdt23
	f/u/djrLiUaP+KPOufc9Ejycr1yU2ZSR7aG5S/kWO8tFid/ydWu6Kx4GlDQ+cJ055+RRA2Ov
	w48mh0VH1cSuil6hvu/BTtM3XbMufY90LT8/OdKzYV7wo/R5n513sYQc5Ig03in07Jll0fnY
	3/OCZzawaJiJPd/48GD8zqt+IdMOTkg31+L79N+dX835+/VNanfiQ2QPLFNa6H2ZraUz8k8k
	W9QKufIt94+3bFzLrWV8goHrihnna9/9bc5Rm13nFDpo/ZDccr93leFL9rMc0Ruyrn140HbB
	KU5ky7afpc07nu640Hk02thZcFVBdJjY96udC+ufaXKJ3loV+mX9+Z8MS+KUWIozEg21mIuK
	EwF+Mi6A2gIAAA==
X-CMS-MailID: 20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6
References: <CGME20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_233645_943423_E852494B 
X-CRM114-Status: GOOD (  15.53  )
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

From: Francis Pravin <francis.p@samsung.com>

dev->host_mem_size value is updated only after the successful buffer
allocation of hmb descriptor. Otherwise, it may have some undefined value.
So, use the correct size to free the hmb buffer when the hmb descriptor
buffer allocation failed.

Signed-off-by: Francis Pravin <francis.p@samsung.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e2634f437f33..6c119499c5db 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2086,8 +2086,8 @@ static int nvme_alloc_host_mem_single(struct nvme_dev *dev, u64 size)
 			sizeof(*dev->host_mem_descs), &dev->host_mem_descs_dma,
 			GFP_KERNEL);
 	if (!dev->host_mem_descs) {
-		dma_free_noncontiguous(dev->dev, dev->host_mem_size,
-				dev->hmb_sgt, DMA_BIDIRECTIONAL);
+		dma_free_noncontiguous(dev->dev, size, dev->hmb_sgt,
+				DMA_BIDIRECTIONAL);
 		dev->hmb_sgt = NULL;
 		return -ENOMEM;
 	}
-- 
2.43.5


