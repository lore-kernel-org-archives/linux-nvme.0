Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C155DC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 06:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=r7PCZmejUBcjCEoMfP7XkOHhQcXW6TEz0PI/DuSOczU=; b=eirSB4ezzR1AsQ2ur4NL2Gdf0Z
	XYOuvTrqB2e+13LF+0ZLFWc0oBbgN2/r40AtwkEKOUepufiZfKPn4KLfCYFn834KexdviV/Im1AHJ
	Pb7swniPH0Q/vEsHkUjuUQim+hB/x4fmdPPzheYoDvUvdtjSaLoaCWwNAtRC5XTmyawyaEZegBNyE
	qBHuYWNzt8WXEOW//oC7c0PU5rQ/BILzJc3AJ/zGIvUnRXn93lYTtpOak30O623iy5R6mipQ7syRz
	YYUqJ9JClC4nptM/xqCbXDftju7WTIjeTliWzM2757tsJA3qa8PBJ5X5VcSfnpFsPfTL+NzWQ+Bel
	HGOiGUnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYfhX-0000000H61P-2s8G;
	Fri, 17 Jan 2025 06:19:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYfhP-0000000H60p-49HZ
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 06:19:22 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250117061910epoutp046c561acd0a79b0f413fa8df2e993b9c1~bZnjc4aBP0479804798epoutp04C
	for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 06:19:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250117061910epoutp046c561acd0a79b0f413fa8df2e993b9c1~bZnjc4aBP0479804798epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737094750;
	bh=r7PCZmejUBcjCEoMfP7XkOHhQcXW6TEz0PI/DuSOczU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=H9GTX5WtGR8D+P+CJlR8PQcNLGA+BSH2aNlSMVs5yylgYsTf+ozbL73fuD/AUu5Mx
	 ZwRTkd/f4OrAoi5KsoBEIeW68nW7y3WS3ef9qcJ529YP0mPVh5TL9X+wHTMfIt4HaL
	 CUhiovR6rsRG2xyQCXft1n0ZiW5fWT1eoPx51Ccc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250117061910epcas5p44437033e0daec2e2202230661ee69e56~bZnjHGkUL2470624706epcas5p4i;
	Fri, 17 Jan 2025 06:19:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YZ8hD1xmHz4x9QF; Fri, 17 Jan
	2025 06:19:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.C1.19956.C56F9876; Fri, 17 Jan 2025 15:19:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250117050925epcas5p1ef46267e6d7dc83ea9d0aa51af934921~bYqpd0xfy0839408394epcas5p1l;
	Fri, 17 Jan 2025 05:09:25 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250117050925epsmtrp248b1ff272b8677ba34f986e558533656~bYqpc5dFq1685316853epsmtrp2b;
	Fri, 17 Jan 2025 05:09:25 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-b0-6789f65c7639
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.65.33707.506E9876; Fri, 17 Jan 2025 14:09:25 +0900 (KST)
Received: from open-sourcing.samsungds.net (unknown [107.99.41.223]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250117050923epsmtip2314bb719717b80c23de12729188a96d6~bYqn7slaB0775307753epsmtip2d;
	Fri, 17 Jan 2025 05:09:23 +0000 (GMT)
From: francis.p@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com, d.palani@samsung.com,
	sathya.m@samsung.com, Francis Pravin <francis.p@samsung.com>
Subject: [PATCH] nvme-pci: remove redundant dma frees in hmb
Date: Fri, 17 Jan 2025 05:12:09 +0530
Message-ID: <20250116234209.51347-1-francis.p@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpm7Mt850g/NHeCx+T5/CavF/zzE2
	i7dfH7BZHFu0hdli5eqjTBZL5+tbTDp0jdFi/rKn7Bb3ZnSxW6x7/Z7FYuvlBewO3B4Tm9+x
	e5y/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7U
	zMBQ19DSwlxJIS8xN9VWycUnQNctMwfoPCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
	QUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsa6y1NZCpo4Kqa/4GtgPMXWxcjJISFgIvHx
	+3b2LkYuDiGB3YwS/2YtZIJwPjFKbHvdguBMOXiCFabl0flZUC07GSVa761lgXB+MkosWTob
	bDCbgLTEpiWfwWwRAUeJVyues4EUMQvsY5Q4tO05WEJYwEZiwsMudhCbRUBV4sPHd0wgNq+A
	lcTkRX+YINbJSyzesZwZIi4ocXLmExYQmxko3rx1NjPIUAmBt+wSO36/hLrPRWLZsR5GCFtY
	4tXxLewQtpTE53d7od7Ol3i1+znUggqJ7btuQ9n2Ehf3/AWyOYAWaEqs36UPEZaVmHpqHRPE
	Xj6J3t9PoMp5JXbMg7GVJTY9WQ91gqREc+MddpAxEgIeEv9XR4CEhQRiJba+v8UygVF+FpJv
	ZiH5ZhbC4gWMzKsYJVMLinPTU4tNC4zzUsvhEZucn7uJEZxKtbx3MD568EHvECMTB+MhRgkO
	ZiUR3rTfHelCvCmJlVWpRfnxRaU5qcWHGE2BQTyRWUo0OR+YzPNK4g1NLA1MzMzMTCyNzQyV
	xHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTA9ePT2mtDkdYdy93s+vN27IIsv/7F2tKPAt0ex
	Gp4fNr1qmGnGUBpx+oKhwf+SO5fr5ebYZ21R5JmqE8LJ/Fdw4sNe7eJtt+bGHlrRKviw+ejz
	0kd5z3hPCxZ+W+Y/N2pOHWPJ+bj5lgVLX4bfvzZp2QKO4FmrdOcc68oPWnmz7aPI9v1uMXIN
	xy1qpr29utAkriMn0vNHWNOsaZP9V+8oZxP50Llq6e7vSyM+CifIf1or4smmm3rjvgT/vA/l
	CuxHr518JPVE9eXrCt+WO2oqD9/V8C+SfsXF9vPapdZbq9nfuXwU4E/zuP7/yk8ei337U590
	B4pMPOmhUayzuc2tbYOkpGLQuRMTPy+23+mToMRSnJFoqMVcVJwIABHus+EuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvC7rs850g5nvmC1+T5/CavF/zzE2
	i7dfH7BZHFu0hdli5eqjTBZL5+tbTDp0jdFi/rKn7Bb3ZnSxW6x7/Z7FYuvlBewO3B4Tm9+x
	e5y/t5HFY9OqTjaPzUvqPXbfbGDz6NuyijGALYrLJiU1J7MstUjfLoErY93lqSwFTRwV01/w
	NTCeYuti5OSQEDCReHR+FnsXIxeHkMB2Rom725qZIRKSEsemLWKHsIUlVv57DlX0nVHi2OTj
	YN1sAtISm5Z8BrNFBNwljr5sYAIpYhY4xiixds1JJpCEsICNxISHXWCTWARUJT58fAcW5xWw
	kpi86A8TxAZ5icU7ljNDxAUlTs58wgJiMwPFm7fOZp7AyDcLSWoWktQCRqZVjKKpBcW56bnJ
	BYZ6xYm5xaV56XrJ+bmbGMHhrBW0g3HZ+r96hxiZOBgPMUpwMCuJ8Kb97kgX4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYKo4IyJVvFgp5kF4lE20w0u/
	rzonJLu1/ljyH9kRJzTtEM+U/bocn+b/Td8757tYxuyqVFtJEY6+ydujyi5oSp949WRb2YIV
	OlnK5ovnW3w9LNjAfvx5Y/v07hez9LXL501kU9nmcjlX5Wy73pOkeZvbEh16/CXsWE9LPV6j
	Leu2lWeyGcMDR7M1It3el35XFD94f66Ga6HZ1i8zHPz+Hv5Yr5zsPvFevG+Z+ULn7EOSO58Z
	TVrSaLbpX7WMbP9Ww6Bk62gH+2U6G1TWchjf9+1/3nXwxLuDim9n/PnFbt62ZuquG9JzDj8/
	kv6ofWfg95pLN8/WXTtukBL092RqWojlm3nMPAxRtwy4ZhpWTlZiKc5INNRiLipOBACeDZ+h
	1gIAAA==
X-CMS-MailID: 20250117050925epcas5p1ef46267e6d7dc83ea9d0aa51af934921
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250117050925epcas5p1ef46267e6d7dc83ea9d0aa51af934921
References: <CGME20250117050925epcas5p1ef46267e6d7dc83ea9d0aa51af934921@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_221920_484770_18F3E419 
X-CRM114-Status: GOOD (  13.48  )
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

The value of size is 0 when there is no dma buffer allocated. The value
of i also remains 0. So, no need to free the dma buffer in out_free_bufs.
Hence, remove the redundant dma frees.

Signed-off-by: Francis Pravin <francis.p@samsung.com>
---
 drivers/nvme/host/pci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e2634f437f33..924d88edfcd4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2154,14 +2154,6 @@ static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
 	return 0;
 
 out_free_bufs:
-	while (--i >= 0) {
-		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
-
-		dma_free_attrs(dev->dev, size, bufs[i],
-			       le64_to_cpu(descs[i].addr),
-			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
-	}
-
 	kfree(bufs);
 out_free_descs:
 	dma_free_coherent(dev->dev, descs_size, descs, descs_dma);
-- 
2.47.1


