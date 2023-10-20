Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AE0C001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jejw9wtDoVLplLb+m/ZA6nO/eHIp9kv3ko9Om7pUWxE=; b=LVYio4nMdlu5UfgTLip2NP0DqM
	GgGhsmuAHWvwSzWF+jsnYkwtNlkEedPyhksbwW/GPaT1JoeDuH8ThUHjTP2nZ6qlq9VPJPGzXKZRJ
	qTcXJLEy2UpSfbGsF6tZb/M8SdCcfGDsUWhHj26cub11yqFirduJDT0MeVX+uQFTjU0U2rXbkCNwU
	hT4o5MOMnlZ9fUpIW/8zown8sS4eDLYVMhI2oRwJFCVKQ1U2Rqh6vmimDiQ0fSZY/iulWU37n7/aN
	84q9W0YL8hdyyYNaD7pT7oat7LANI8oaF7V/Jd71Mo6nMraA0H/UK6u+N4xEZQBKUXYpcG0k8v88a
	RbcEqrRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpen-002NkC-0U;
	Fri, 20 Oct 2023 13:35:17 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpei-002NiM-1g
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:35:15 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231020133505epoutp043b56d4ceefd84d9ee445eb07dae0f2c3~P1DRAyrF01086810868epoutp04n
	for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 13:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231020133505epoutp043b56d4ceefd84d9ee445eb07dae0f2c3~P1DRAyrF01086810868epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697808905;
	bh=Jejw9wtDoVLplLb+m/ZA6nO/eHIp9kv3ko9Om7pUWxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSwPPNmyLJ8Uf+I+rFwENnLgqpNtlqujhZ/asTr07/IeMyJjwmcP/0soM+skfQd6a
	 Lig/KFyC/I0QiLOD+6GtGoQfxigZ4UhATafMlAb0i3J3k7RrZ9HDy3n4kxZlZP5u6d
	 y094hfhdPaAekgq1IRIc25+TVNgq0KrF7SP3VC/k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231020133505epcas5p21345f83bf7ede0c7852b8946e01d0b0a~P1DQpgFMX2234922349epcas5p2v;
	Fri, 20 Oct 2023 13:35:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SBlvC3q1Nz4x9Pw; Fri, 20 Oct
	2023 13:35:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.27.09634.70282356; Fri, 20 Oct 2023 22:35:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231020133502epcas5p28066460555ccecce446e57f3578568d0~P1DODXmyF0543305433epcas5p2g;
	Fri, 20 Oct 2023 13:35:02 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231020133502epsmtrp261e7517c213cba3efcff683dc490eb30~P1DOCnuVJ0487504875epsmtrp27;
	Fri, 20 Oct 2023 13:35:02 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-f7-653282074997
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.40.07368.60282356; Fri, 20 Oct 2023 22:35:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231020133500epsmtip184a5fb56ffebf4fc456e98aea2e10de8~P1DMxdGYq2267622676epsmtip1h;
	Fri, 20 Oct 2023 13:35:00 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 1/3] nvme: flag to force SGL
Date: Fri, 20 Oct 2023 18:58:35 +0530
Message-Id: <20231020132837.151037-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020132837.151037-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhi57k1GqwdxJkhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
	xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnF
	pXnpenmpJVaGBgZGpkCFCdkZ2+c+ZylYzFox5+sn9gbGZSxdjJwcEgImEusuvWTsYuTiEBLY
	zSixbOtTVgjnE6PEk8sNUJlvjBLbFtxjhGn5v/MkVGIvo8TVjfuYIJzPjBJn/j5n72Lk4GAT
	0JS4MLkUpEFEwEWi4d8bsGZmgRKJA7MmsoLYwgL6Eq2fpoDdwSKgKnHg7UuwGl4BS4nPF7dB
	LZOXmHnpO9hITgErieXvSiFKBCVOznzCAjFSXqJ562xmkBMkBH6yS8z+MZ8JotdFYuX2a+wQ
	trDEq+NboGwpic/v9rJB2MkSl2aeg6ovkXi85yCUbS/ReqqfGWQvM9Ar63fpQ+zik+j9/YQJ
	JCwhwCvR0SYEUa0ocW/SU1YIW1zi4YwlULaHxNzuLdDQ6WWU+P30OdsERvlZSF6YheSFWQjb
	FjAyr2KUTC0ozk1PLTYtMMxLLYfHa3J+7iZGcNLU8tzBePfBB71DjEwcjIcYJTiYlUR4VT0M
	UoV4UxIrq1KL8uOLSnNSiw8xmgKDeCKzlGhyPjBt55XEG5pYGpiYmZmZWBqbGSqJ875unZsi
	JJCeWJKanZpakFoE08fEwSnVwDSRT7FqSVVo8if9NQvOHrSREf2877fCl5w9a7VTvjL9mvKR
	u/HozrC21hfTNZMK9wfJuClE5K+eZWHsz8v24sziSUdM3yRe2MxlfSvvRtkhR+eQfA+3mc1b
	DxcfvHNR+WTH16P5i17Kiv+LTNGpOr3GNn2Svv7syKMmFns1jS0PPwnZdDJp49alVw5odWZv
	m11R+4hF7tKf8nDW+Vn365U5WZlOKYkHTJxooWb8wudv8+3CjVfmn9v7JLhdNbf4RtrB5LiE
	Lsagx2+Y195N8dh6fWLetV16Evd9r1/yO5fiZTV1oneeyibLkD1Tvi79tr7mSe/2v8nKO+Xu
	Gafq7JvPWtjxtOqPQfv9LwIaQg+VWIozEg21mIuKEwEWCS+CIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnC5bk1GqwcSPrBar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPYoLpuU1JzMstQifbsEroztc5+zFCxmrZjz9RN7A+Myli5GTg4J
	AROJ/ztPMnYxcnEICexmlOhu3sYKkRCXaL72gx3CFpZY+e85O0TRR0aJF3MuA3VwcLAJaEpc
	mFwKUiMi4CUxb/YCsKHMAhUS/1+/ZASxhQX0JVo/TQGLswioShx4CxHnFbCU+HxxGyPEfHmJ
	mZe+s4OM5BSwklj+DmykEFBJ4/25bBDlghInZz6BGi8v0bx1NvMERoFZSFKzkKQWMDKtYpRM
	LSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQIDnctjR2M9+b/0zvEyMTBeIhRgoNZSYRX1cMg
	VYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5OqQYmXrcPXHMc
	ytY9TORdu4Ml3IXzdlTVzYTrFsXVX17KM27PKdedc6r05fxFhtdkdN8E5KQpKD7cn8BhFXjk
	UKlJW77R9Y9TtdhWmNy6v8Qh+spesxap4H33tr029NTMib38h/fuSv4Nhq352akPi80eBvqZ
	pb+19Hpi2JB2/GZELeeJAp9dmYuOuGX/PFc1x/7o8oCphdNMPYVMdyie/brQ/ugmbcei04Ec
	X8tmdwnlz3BbtXuD1OHUvIn7Vmp57egMVOC6vPvy99idv040Kn20D6q57jtJ959g64+ZHVMj
	uWTPzY7fdbJcYp6CZ0P4sjaFsJN7qqVTNu6Tkflv2pr0li08pfTSBumzWlP0PjEqsRRnJBpq
	MRcVJwIANKwZVeYCAAA=
X-CMS-MailID: 20231020133502epcas5p28066460555ccecce446e57f3578568d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231020133502epcas5p28066460555ccecce446e57f3578568d0
References: <20231020132837.151037-1-joshi.k@samsung.com>
	<CGME20231020133502epcas5p28066460555ccecce446e57f3578568d0@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_063512_882288_9E1C9895 
X-CRM114-Status: GOOD (  12.53  )
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

Add a nvme request flag 'NVME_REQ_FORCE_SGL' that mandates both
data and meta transfer via sgl. This is a prep patch.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb125..141e1b1a897a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -184,6 +184,7 @@ enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
+	NVME_REQ_FORCE_SGL		= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
-- 
2.25.1


