Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF41EE77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 06:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0Ds7is/PRD15Mta+Na2E4igKDBZuHKLd0eyDKuyE6c=; b=FAabe5fyx3ENIakiSwpG6wt3hG
	SLpzXtPYZiNOIE9vQ+QvedVmZCFN4RvyIo0QrVJwMq+DCGntV2xXM8n+3ri+vlVvD0E1eGOu+6N5n
	rva9GMR4u+3Y/1M9cgZxkPeDv0R+e3uEZun69jZEgpEL884YSvdY94VcZx7d4GtiUMslEFvtQz5mi
	WTu9VZdXJvD+W7Ok6dseav86nXBIgam2geH7xXmkeuOK8guQLlUI/HcNn8nGecXP77AFWks8qjgMr
	fWl26wOmSvlMfUnpkscvnF85IWIb9r/0oxNOGF1o1VnKxzoWVA5DY8y4a3nT3GfZHDwa4GofVI1ES
	hdEizhVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKtxh-0000000ASw7-0j7P;
	Tue, 10 Dec 2024 06:43:13 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKtYE-0000000AOEq-3Wmp
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 06:16:58 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241210061648epoutp02190ec8a6efa91358111784925912afb7~PvEpBzbVz2347423474epoutp02Z
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 06:16:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241210061648epoutp02190ec8a6efa91358111784925912afb7~PvEpBzbVz2347423474epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733811408;
	bh=E0Ds7is/PRD15Mta+Na2E4igKDBZuHKLd0eyDKuyE6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sPjGZioqV1em46uM0YFjZKmLIeaxTQervp8bWkviudxOneYXCqXGUZocJL0JyoZuk
	 DzEeifkHdla54mVc2ybhqmjMwIPaqaKVRn6XhCXUvfQszQLR+BVO6QkIsvMBY49Y7R
	 DgDKY2YPqBCf6kRAP2VlXGe1dQVVIstv4tyeyc7Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241210061648epcas5p18e93e2747f53434c1ae5d54c4d241dd9~PvEond7fF2959829598epcas5p1_;
	Tue, 10 Dec 2024 06:16:48 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y6pR23mN7z4x9Q8; Tue, 10 Dec
	2024 06:16:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.D5.19710.ECCD7576; Tue, 10 Dec 2024 15:16:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241209110649epcas5p41df7db0f7ea58f250da647106d25134b~PfYkGHV-L1052810528epcas5p4U;
	Mon,  9 Dec 2024 11:06:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241209110649epsmtrp2cf7b5119e46635b3d3157059bff59c36~PfYkFKM8Q1974719747epsmtrp2b;
	Mon,  9 Dec 2024 11:06:49 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-a8-6757dcceb44a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.03.18949.84FC6576; Mon,  9 Dec 2024 20:06:48 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241209110647epsmtip22855f77258d46586d09929b1447a8cd8~PfYiZTKgG1603516035epsmtip2J;
	Mon,  9 Dec 2024 11:06:47 +0000 (GMT)
Date: Mon, 9 Dec 2024 16:28:53 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 06/12] block: expose write streams for block device
 nodes
Message-ID: <20241209105844.boc4k6oshthruyep@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-7-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmpu65O+HpBpseSVo0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZ1S2TUZqYkpq
	kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
	YiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzutY9YCvYK
	VRzd8JqlgfEcfxcjB4eEgInE/xbfLkYuDiGB3YwSi7+3skA4nxgl7r3czQrhfGOU6F+xEMjh
	BOu48Go+VGIvo8S6Jy1MEM4TRomzDXfZQKpYBFQkvq74ygSyg01AW+L0fw6QsIiAosR5YEiA
	1DMLTGSS+H2oiR0kISwQJNF99isLiM0LtOHq5p1MELagxMmZT8DinAJmEoc/tYE1Swis5JDY
	P/kC1EkuEreO3WCEsIUlXh3fwg5hS0l8freXDcIul1g5ZQVUcwujxKzrs6Aa7CVaT/Uzg9jM
	AhkSL3o2QTXLSkw9tY4JIs4n0fv7CRNEnFdixzwYW1lizfoFUAskJa59b4SyPSTWX1gBDaOt
	jBKtbXtZJjDKzULy0Swk+yBsK4nOD02ss4AhxiwgLbH8HweEqSmxfpf+AkbWVYySqQXFuemp
	yaYFhnmp5fBoTs7P3cQITsRaLjsYb8z/p3eIkYmD8RCjBAezkggvh3douhBvSmJlVWpRfnxR
	aU5q8SFGU2AMTWSWEk3OB+aCvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg
	+pg4OKUamHYwTY4R+q+1RaRh1czdB7mDpCXEHbZ1Bia5bJtXvHTLzwnC6adYy/0mK5c+mtie
	41DN3tr7KXHu8t+Z/9lit+/K+SbZ9T3wKX+kwYlmjsgD7IwLzO4zHntpsWb+hCSbb+V+a97U
	3nA5w2Bh/OvIIs29LeJPpHfpsu39bXtwU0fcWYlC09M/ApWPHjPVlPWee2yz+KT7drIsGzyf
	rZBh43w8I/OiqPD9OQbXX7qITJnkPuHdqjc6893Mr++Y1y90uTI96dQHW+XjWaFatRM+znnI
	JzVpZqVTuanvbv6C9w+2CngJlF5ly10bwpI8h3/9+tRlJgXd15vqJyf7d5mELHi/o7d9glGO
	Vn/azGlKq5VYijMSDbWYi4oTAf+3R7tNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvK7H+bB0g++LLCyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AM4rLJiU1J7Ms
	tUjfLoEr4+OZI2wF7/kr5vxaxtbAOIu3i5GTQ0LAROLCq/msXYxcHEICuxklfh+5ywKRkJRY
	9vcIM4QtLLHy33N2iKJHjBLH1p9hB0mwCKhIfF3xlamLkYODTUBb4vR/DpCwiICixHmgc0Dq
	mQUmM0k8n3kMbKiwQJBE99mvYDYv0Oarm3cygdhCAokSh1q3Q8UFJU7OfAJmMwuYSczb/JAZ
	ZD6zgLTE8n9g8zmBwoc/tbFNYBSYhaRjFpKOWQgdCxiZVzFKphYU56bnFhsWGOWllusVJ+YW
	l+al6yXn525iBEePltYOxj2rPugdYmTiYDzEKMHBrCTCy+Edmi7Em5JYWZValB9fVJqTWnyI
	UZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QDk+lNCd2O/vnf5jDdleXL4fi85mzeTo/5
	IsH3bNvPZN9beZoh7btVRc686rBuLqvPl9W8lv3ckii3vVvAWGXDQ8ZdC+M07bb2lx1QXcOg
	/jFc5dmXNUsy9/Rdkk/+l2u8ooSbITbgjTvPPtdThRKc91YcPRf+5bZ/YobQg0Mmsx1VrLqK
	byhs/vbe4kW6s3Lr8d3/jropPfavMzndsMjf0cfQ9lXuh7vbuxazKD3Rf1+f9EH3BesBnnXb
	v2pNdE9q6tg3r9xfmqUsesHPeSUi2/e/+5MQpfxPc8FWz6MtPOd6Hre4rm05pPqwXqR3VXuI
	m01J58qEVhGtXXtaDi5t3V9/ddrcrW9vrPWv37YjXYmlOCPRUIu5qDgRAM7C0f8NAwAA
X-CMS-MailID: 20241209110649epcas5p41df7db0f7ea58f250da647106d25134b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_6c9ae_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209110649epcas5p41df7db0f7ea58f250da647106d25134b
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-7-kbusch@meta.com>
	<CGME20241209110649epcas5p41df7db0f7ea58f250da647106d25134b@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_221656_356872_475E3808 
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

------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_6c9ae_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Export statx information about the number and granularity of write
>streams, use the per-kiocb write hint and map temperature hints
>to write streams (which is a bit questionable, but this shows how it is
>done).
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> block/bdev.c |  6 ++++++
> block/fops.c | 23 +++++++++++++++++++++++
> 2 files changed, 29 insertions(+)
>
>diff --git a/block/bdev.c b/block/bdev.c
>index 738e3c8457e7f..c23245f1fdfe3 100644
>--- a/block/bdev.c
>+++ b/block/bdev.c
>@@ -1296,6 +1296,12 @@ void bdev_statx(struct path *path, struct kstat *stat,
> 		stat->result_mask |= STATX_DIOALIGN;
> 	}
>
>+	if ((request_mask & STATX_WRITE_STREAM) &&
We may not reach this point, if user application doesn't set either of
STATX_DIOALIGN or STATX_WRITE_ATOMIC.

>+	    bdev_max_write_streams(bdev)) {
>+		stat->write_stream_max = bdev_max_write_streams(bdev);
>+		stat->result_mask |= STATX_WRITE_STREAM;
statx will show value of 0 for write_stream_granularity.

Below is the fix which might help you,

diff --git a/block/bdev.c b/block/bdev.c
index c23245f1fdfe..290577e20457 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1275,7 +1275,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
  	struct inode *backing_inode;
  	struct block_device *bdev;
  
-	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
+	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC |
+		STATX_WRITE_STREAM)))
  		return;
  
  	backing_inode = d_backing_inode(path->dentry);
@@ -1299,6 +1300,7 @@ void bdev_statx(struct path *path, struct kstat *stat,
  	if ((request_mask & STATX_WRITE_STREAM) &&
  	    bdev_max_write_streams(bdev)) {
  		stat->write_stream_max = bdev_max_write_streams(bdev);
+		stat->write_stream_granularity = bdev_write_stream_granularity(bdev);
  		stat->result_mask |= STATX_WRITE_STREAM;
  	}


------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_6c9ae_
Content-Type: text/plain; charset="utf-8"


------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_6c9ae_--

