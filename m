Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC7CC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=HbN4gMExv76/ppxHx/cBwPErrbGg8HCnLmRXspUPFLE=; b=KhvMIBEHFIVzujXnzVkn0sQxT5
	UtBTgfCyZe5FnP1SAZksJjCbSnaKm5g9Nskt3arfAS2UOlfcwoq7he2MyGPvpZwwS+MYHAzwdur/8
	37osGunHjnj4/yqhCC78paRrsUBtfH0actBPSFOubp+M2tuUd14C2m249tpK1yJKDimseA8ACgpZE
	wXPoEEQZrnIyGxEeMeN1swUQDB2CDpHVs1N/GgcNINsirv0q9olsdeJRMaVYR+6Fb4e2HROafq16y
	lgaBVjx8xMqu4A7O2nhM03AeCcDOMyC9PGBToGNgPn2kDWoeTmUQcoO44qcbxOqq6mC0cn4k0m+HP
	Z1TErvXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sASNF-00000008i9k-3aQx;
	Fri, 24 May 2024 10:42:09 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sASNB-00000008i8l-1Nva
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 10:42:08 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240524104159epoutp0463d6f12b543671982a1d499037b7291a~SZrEqCSVc0335403354epoutp04U
	for <linux-nvme@lists.infradead.org>; Fri, 24 May 2024 10:41:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240524104159epoutp0463d6f12b543671982a1d499037b7291a~SZrEqCSVc0335403354epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716547319;
	bh=HbN4gMExv76/ppxHx/cBwPErrbGg8HCnLmRXspUPFLE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AkMoB6AFIzop3BH9RA1NcsS5xFVHwMMZh5YnS8Gkn9IF8iiji12UskJn8dk3QcUAl
	 5LmeMS/JRVFVQEZAWjKQ838ppZobr6b1uq96K7wWvZFzn04Gh0bVxkcJLkfGCqkshM
	 PH17L7b7Fprtro/bgwt0HsO/hTvDWAlFBQgCGa/A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240524104158epcas5p1839920adac0a5d3531daecd371977b23~SZrEa4mVs2904629046epcas5p1F;
	Fri, 24 May 2024 10:41:58 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vm1nK0c21z4x9Py; Fri, 24 May
	2024 10:41:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.5C.09688.4FE60566; Fri, 24 May 2024 19:41:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240524104156epcas5p1ed1d8c342a08a48958757bb00e44cb5f~SZrCLZsjD0626106261epcas5p1B;
	Fri, 24 May 2024 10:41:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240524104156epsmtrp243f8b9603af3cbe94417d05934dd941e~SZrCKJpi_1491814918epsmtrp2C;
	Fri, 24 May 2024 10:41:56 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-8d-66506ef475dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.24.08390.4FE60566; Fri, 24 May 2024 19:41:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240524104155epsmtip16a7adcd0090adcbd9df09f76b01e663b~SZrBMQ_Xa0932409324epsmtip1M;
	Fri, 24 May 2024 10:41:55 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2] nvme: remove sgs and sws
Date: Fri, 24 May 2024 16:04:48 +0530
Message-Id: <20240524103448.785268-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmlu6XvIA0gxmfbSxW3+1ns1i5+iiT
	xdH/b9ksJh26xmgxf9lTdot1r9+zOLB5nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
	tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
	yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ
	2Rn7+98yF0xmq5i7rZO9gbGbtYuRk0NCwERi/6nHTF2MXBxCArsZJRZ0PmGGcD4xSny8+QIq
	841RYkPPeyaYlkvta6Gq9jJK7NpxgRHC+cwosWJNJ9BgDg42AU2JC5NLQUwRASOJzwvCQXqZ
	BbIl5n07ygZiCwvoSPya8p8RxGYRUJW4tX0b2Em8ApYSnfN6oXbJS8y89J0dIi4ocXLmExaI
	OfISzVtng90gIXCKXeLwgVY2iAYXia17bkDZwhKvjm9hh7ClJD6/2wsVT5a4NPMc1IISicd7
	DkLZ9hKtp/qZQW5mBjp//S59iF18Er2/nzCBhCUEeCU62oQgqhUl7k16Cg1FcYmHM5ZA2R4S
	G0/8BJsoJBArsXb7HdYJjHKzkHwwC8kHsxCWLWBkXsUomVpQnJueWmxaYJSXWg6PyuT83E2M
	4OSn5bWD8eGDD3qHGJk4GA8xSnAwK4nwRq/0TRPiTUmsrEotyo8vKs1JLT7EaAoM1onMUqLJ
	+cD0m1cSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA1NGyWlflgl9
	7z5YWz3//XJT4f7QZ9FHfNpPLCuucUh6KniVye1lIof10sD3lkveey4Otsy72vQ2xsnBY/7Z
	N0oBf66L6fu3hS9efzom9dnMTmb30pBvUxp/2TGwyZ7/H7FNb+5GI8bjzA/utW1vafXpTTOv
	d9uTenyW+GYlf6ed+2W6NlzI/vI9kY/hmICPr+nar7WXLR1n7991a/uCfy9iNctXnb5aXLU5
	PDD9WLXKYb2Oz6dsT7IlyZbNuvvh9bmzXwVtzgc7tmgpJy6eOanV58iR3r0lm700zDirGTS/
	6TYlfncUP5v/d59GbsVE8fA5T93Weruqls/jDdl2kmF+XmyywO63vj5HNrhGflFiKc5INNRi
	LipOBAAiMifKBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnO6XvIA0g/5pIhar7/azWaxcfZTJ
	4uj/t2wWkw5dY7SYv+wpu8W61+9ZHNg8zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
	WxSXTUpqTmZZapG+XQJXxv7+t8wFk9kq5m7rZG9g7GbtYuTkkBAwkbjUvpa5i5GLQ0hgN6PE
	gw0LGCES4hLN136wQ9jCEiv/PWeHKPrIKPHq20+gIg4ONgFNiQuTS0FqRATMJI6/fwfWyyyQ
	K3FpSgcbiC0soCPxa8p/sDiLgKrEre3bwBbzClhKdM7rZYKYLy8x89J3doi4oMTJmU9YIObI
	SzRvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgkNUS2sH
	455VH/QOMTJxMB5ilOBgVhLhjV7pmybEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTE
	ktTs1NSC1CKYLBMHp1QD0/SiVVp5q9ZVztbcp1MfYCCSWrrUgYP7surK1l+5Xyu9pSfrybRu
	PsEsejbj+bovCgLOp9udD7VWmGnv/TIp3Dgr1eEa05MZK2q7mVuum5z22bJkxrxNprPy5U/4
	eB+9fOL6/P/XvPJmTT2Y/T7vYGFLw8WLp7ZasAXcumuaKPd1ltfPBM09V/3DnW7GzNfdb3jd
	lTMr1lVeM43rQP8V9tsrboYlMrl4BCkaKP9vCW7LeP1BbvWG2zzT0/vUHBXb+RLYop4eW8yh
	tcP33zuTqY/yfrm/fL/48z49Tf3p9+Wvn/7Iv3zroou8TU18nz4KZ54XWPdY57SR8vXNZewz
	9L6zFvU9U9N8Vbkq5KSGuRJLcUaioRZzUXEiAMjc2OvAAgAA
X-CMS-MailID: 20240524104156epcas5p1ed1d8c342a08a48958757bb00e44cb5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240524104156epcas5p1ed1d8c342a08a48958757bb00e44cb5f
References: <CGME20240524104156epcas5p1ed1d8c342a08a48958757bb00e44cb5f@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_034206_139681_ACC822DD 
X-CRM114-Status: GOOD (  12.61  )
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

sgs/sws are unused, so remove these from nvme_ns_head structure.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
changes since v1:
- kill the other cleanup patch
https://lore.kernel.org/linux-nvme/20240502063438.422046-3-joshi.k@samsung.com/

 drivers/nvme/host/nvme.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cacc56f4bbf4..a51f7c0dcf33 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -471,8 +471,6 @@ struct nvme_ns_head {
 	u8			pi_type;
 	u8			pi_offset;
 	u8			guard_type;
-	u16			sgs;
-	u32			sws;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
-- 
2.25.1


