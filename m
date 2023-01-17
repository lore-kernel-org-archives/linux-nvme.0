Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E3C63797
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oeDYEXVmmnImj5v8eZVFizkvI/O2OXXucvUr8qTHeSM=; b=PNQFrMj8NJhTYIDtp445E39DyF
	4bH6lWFVPTuIFTryHPeA+CeV5lynV6lE2ZjdAqMD4c2j29pDIOWvs4FlCALGR6JZ6+kse5druvmdy
	AlrXFOCYYWNP7Oyw+iKlFli9+TrzQls+MjroR+WJ1ev82cwNnwIzg32ggiuXPwE3Up143PLjgdXp+
	NqznXqb5x/FbaEd4WKxCIaTT3CRO5TEIU4zYCLwpGwgunpiLGSaxMfZh14GQwPDdJ/GYIGf0aE+p8
	yYP0RkupxVWpLiOSHOkRt+GHuCNfcSibyvpHclbItgL67R0ghrwZAlQHCi6C8LkVdtPKCQMUGqUW2
	tdfUG5Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHlP8-00EEGm-MI; Tue, 17 Jan 2023 12:49:30 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHlP1-00EEEM-Bx
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 12:49:24 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230117124916epoutp01d92ddb1644acf40f2ef2884250cd21cc~7GYeifwOq2685526855epoutp01M
	for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 12:49:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230117124916epoutp01d92ddb1644acf40f2ef2884250cd21cc~7GYeifwOq2685526855epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673959756;
	bh=oeDYEXVmmnImj5v8eZVFizkvI/O2OXXucvUr8qTHeSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhwMXsJXeNeCyjnpxaegb4uKsqIUcXj40a6u6IrsCJ192Mvh1NtAAYiJBdJn82n+p
	 xHmnqF7Y6i2uU7ct7DNCr6GskbkNSTVPbII5L0PRlfisA/qKmXYnKvA1ttRWDW8mw/
	 A+Sc7z0blTWhQYcHdfAI8K/AViW9BwQwDV0Re/n0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230117124916epcas5p197c494391b94798e953a12e2e176eb05~7GYeJvOyR1503115031epcas5p1i;
	Tue, 17 Jan 2023 12:49:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Nx7xk5VJlz4x9Pp; Tue, 17 Jan
	2023 12:49:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.64.02301.A4996C36; Tue, 17 Jan 2023 21:49:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f~7F0eF2U9-0962809628epcas5p4M;
	Tue, 17 Jan 2023 12:08:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230117120802epsmtrp254beb45c366894ef2ea6e58709d91fb9~7F0eFDBEJ0039100391epsmtrp2k;
	Tue, 17 Jan 2023 12:08:02 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-b8-63c6994a43c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.24.02211.2AF86C36; Tue, 17 Jan 2023 21:08:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230117120801epsmtip220b1f0d83333e54782a10fed688b1a83~7F0cxCsu_0720607206epsmtip2F;
	Tue, 17 Jan 2023 12:08:00 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v1 2/2] block: extend bio-cache for non-polled
 requests
Date: Tue, 17 Jan 2023 17:36:38 +0530
Message-Id: <20230117120638.72254-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmlq7XzGPJBjubNS2aJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8XR/2/ZLCYdusZosfeWtsX8ZU/ZHTg9ds66y+5x+Wypx6ZVnWwe
	m5fUe+y+2cDm0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
	Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
	E3OLS/PS9fJSS6wMDQyMTIEKE7Izfn85zl5wjq2id5FNA+Mm1i5GTg4JAROJHx+6mLsYuTiE
	BHYzStw68ZMRwvnEKLFs9W82kCohgW+MEv2bpLoYOcA6jlySg6jZyyhxpasPqvszo8SnZfvB
	GtgE1CWOPG9lBLFFBLwk7t9+zwpSxCywkFFi0vI3YEXCAkESa84fZQGZyiKgKrHoIhdImFfA
	UmLq85lQ58lLzLz0nR3E5hSwkvh4fjYrRI2gxMmZT1hAbGagmuats8GOkBBo5JCYdXoRC8Sl
	LhKtJwMg5ghLvDq+hR3ClpL4/G4vG4SdLvHj8lMmCLtAovnYPkYI216i9VQ/M8gYZgFNifW7
	9CHCshJTT61jgljLJ9H7+wlUK6/EjnkwtpJE+8o5ULaExN5zDVC2h8SEVW3skLDqZZS4ceU6
	4wRGhVlI3pmF5J1ZCKsXMDKvYpRMLSjOTU8tNi0wzEsth0dxcn7uJkZwQtXy3MF498EHvUOM
	TByMhxglOJiVRHj9dh1OFuJNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5wJSeVxJvaGJpYGJm
	ZmZiaWxmqCTOm7p1frKQQHpiSWp2ampBahFMHxMHp1QDU4G169o/OkIJE3/o8d8/trVF/7SM
	TqWRbUPopZYnweHu+en2Ui7SHfuF7CXs9O7O0X3hIdmd+7piGvfxyybefs5nry6PN+pZKH7Z
	YK57tAPLgVS2uYFys59svPfwaKuWFG+K0hXfazlbjLdGX3/0xXCBzgoBJkO9i1XMu1tZXe5N
	OXdkd5/nnFcKia6LHh9y3PhmW2/FyVsZHFM9y/a8XHUrY4vrUo3bqfOnaCZvtXddf2H36yzH
	CW1PUr/Gh8/j/JO3JdLlRUHsE1bGkqUlf5/+El1p0qvbcJnnoHd5F7fxwdAEU900Xa3Th0xM
	Z4fz7NzjeoXrYnbYkg9rkj1M171dyn9HLvfxQamMTX7flFiKMxINtZiLihMBHS+y3TEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO6i/mPJBj8XiFk0TfjLbDFn1TZG
	i9V3+9ksbh7YyWSxcvVRJouj/9+yWUw6dI3RYu8tbYv5y56yO3B67Jx1l93j8tlSj02rOtk8
	Ni+p99h9s4HNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDJ+fznOXnCOraJ3kU0D4ybWLkYO
	DgkBE4kjl+S6GLk4hAR2M0pc/nSdsYuREyguIXHq5TIoW1hi5b/n7BBFHxklTm3cyg6SYBNQ
	lzjyvBWsSEQgQOJg42WwImaBpYwSk7e3gyWEgRJT198C28YioCqx6CIXSJhXwFJi6vOZrBAL
	5CVmXvoONpNTwEri4/nZYHEhoJoFH9oYIeoFJU7OfMICYjMD1Tdvnc08gVFgFpLULCSpBYxM
	qxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNeS3MH4/ZVH/QOMTJxMB5ilOBgVhLh
	9dt1OFmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpm5V
	5XOpM9rX3FP7dI7/2QO51u8Tsnlkt86SlXka1sMdW/jtl/uTksNi+7Pmd0z+qzJ5Z3nmhakJ
	S64bJS0x3L47SvUnk89tseDYhoWWTqFOCmc/qJgd6p6UY+pyrFJCzbcprX373s2HX7PP1D4c
	phP/iOEoj23q1lsPdmcYpmx/Wvwj5EuD1/rgJdbSR80uVN85L7fG7MzBHTvPNc8/u8eBvSun
	X2WGrLpx/AahhfHfF0yLDPdtbUr43Xf3TewS42lvi258fXn+3hPNhs1qfkHfX60UkD1UunqG
	0lujp6Xr6l7eYos1np+w88uKF0e3HyvXfCkW7SvPxPs6j6c8u9JuJpfRVxWPl82ak6czSCux
	FGckGmoxFxUnAgCchTDT6QIAAA==
X-CMS-MailID: 20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f
References: <20230117120638.72254-1-anuj20.g@samsung.com>
	<CGME20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_044923_777894_60615C28 
X-CRM114-Status: GOOD (  17.51  )
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

This patch modifies the present check, so that bio-cache is not limited
to iopoll.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-map.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index f2135e6ee8f6..9ee4be4ba2f1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -247,10 +247,8 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 {
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_POLLED) {
-		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
-
-		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
+	if (rq->cmd_flags & REQ_ALLOC_CACHE) {
+		bio = bio_alloc_bioset(NULL, nr_vecs, rq->cmd_flags, gfp_mask,
 					&fs_bio_set);
 		if (!bio)
 			return NULL;
-- 
2.25.1


