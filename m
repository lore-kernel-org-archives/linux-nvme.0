Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D09C77B6F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=5vQso7TTbzkDsp5mkV1gnEM5QIvMyN6pqBfUnQfDJmg=; b=f0x/yznK89cY2phqFxpTy/uH7r
	Uj7TAM/+BsqJ6KtHrXAi/5TCcayA9VF6VGXZoq2Jhe/2paMQfj1GXWnLh3gdfS1yGMeGY8uWUkPby
	01kDGwfUZSQZusXTyXzx3TcQGq0R27Cw/neXHVEIzmEGDGgDtKGREVEc2vCtfRSXUSq5qvgQefLpy
	0i1dnbVwKPSJpR2W7LwzRWYlJ2pb0hVr1crT6nzAZdXXuggzQzLo2K+6zp3SZ4iirqe/VcCsVh8Q8
	GxzCm2GNN3oS59KrxhOyAbA4Qi098krq8w1lDa3wUzv3ePB4CajdvKQvcJQpYDhy6yeuHBO5M4zzv
	1L+HsZuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmsgB-005STs-2J;
	Thu, 13 Apr 2023 08:51:43 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmsg8-005SQf-0z
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 08:51:42 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230413085121epoutp030b99fb9b0fd8fd51e263a3028e4ac04c~VcnTKEohD2264922649epoutp03b
	for <linux-nvme@lists.infradead.org>; Thu, 13 Apr 2023 08:51:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230413085121epoutp030b99fb9b0fd8fd51e263a3028e4ac04c~VcnTKEohD2264922649epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681375881;
	bh=5vQso7TTbzkDsp5mkV1gnEM5QIvMyN6pqBfUnQfDJmg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GOd90X1GMT0cJlzk2GoTIyA19a3unD6RUtejxZPpFhB8sZE3XZXDe2M+mNHCTL1Ie
	 wbdMXe7eHFo7WTrbYApuAf/oqWs7atk4q9B7c+ps3DFAQFgX/ppeXsl/SbzJHGwZgW
	 uLfWhPpWodHOoSxFVwKyPXm/mOh8sppN7Y3XWZWo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230413085121epcas5p28739ba41f4c6af7aaf77f8cda3eba4bd~VcnS67DD72715627156epcas5p2j;
	Thu, 13 Apr 2023 08:51:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4PxtbW6fr7z4x9Q7; Thu, 13 Apr
	2023 08:51:19 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.BD.09961.482C7346; Thu, 13 Apr 2023 17:51:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230413085116epcas5p3ced7bf2b1b85bf59ff36e5440065a808~VcnOQpW453027130271epcas5p3v;
	Thu, 13 Apr 2023 08:51:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230413085116epsmtrp2268abbed401564f61806da6b852c82dd~VcnOP5GTN0438904389epsmtrp2X;
	Thu, 13 Apr 2023 08:51:16 +0000 (GMT)
X-AuditID: b6c32a49-52dfd700000026e9-52-6437c28467aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.6C.08279.482C7346; Thu, 13 Apr 2023 17:51:16 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230413085115epsmtip128fab5aba47bd3d13168121b31c575fb~VcnNlz5Gz1241212412epsmtip1B;
	Thu, 13 Apr 2023 08:51:15 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests v3 0/2] nvme uring-passthrough test
Date: Thu, 13 Apr 2023 14:20:22 +0530
Message-Id: <20230413085024.49750-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7bCmhm7LIfMUg6V3DS2O/n/LZjF/2VN2
	i32zPB2YPTYvqffo27KK0aP9QDdTAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
	pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJ
	gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGkYk72AqOs1YsmTKFtYFxA0sXIyeHhICJxMF9zaxd
	jFwcQgK7GSXuN55lhHA+MUpMn/MOKvONUWLRu364llPX26Cq9jJKLH96ggXC+cwo0XJmGpDD
	wcEmoClxYXIpSIOIgLzEytkgOzg5mAXcJW4/6WECsYUFbCR+r1oLFmcRUJV4eX4NO0grr4CF
	xPqXlRC75CVmXvrODmLzCghKnJz5hAVijLxE89bZzBA1y9gldkx1hbBdJOa9OMAOYQtLvDq+
	BcqWkvj8bi8bhJ0scWnmOSYIu0Ti8Z6DULa9ROupfmaQE5iBrl+/Sx9iFZ9E7+8nTCBhCQFe
	iY42IYhqRYl7k56yQtjiEg9nLIGyPSTWHlkItklIIFbi2YX/TBMY5WYheWAWkgdmISxbwMi8
	ilEytaA4Nz212LTAMC+1HB6Tyfm5mxjB6UvLcwfj3Qcf9A4xMnEwHmKU4GBWEuH94WKaIsSb
	klhZlVqUH19UmpNafIjRFBioE5mlRJPzgQk0ryTe0MTSwMTMzMzE0tjMUEmcV932ZLKQQHpi
	SWp2ampBahFMHxMHp1QDU9qElrvapkdkNm5Z4aRx3GlyYpnzx4YG0dc59fa9HTIL5dZUTNm+
	6HBj2IvN3hvcg5etd7ht9eB23M7j04uqFSJSN4pH3hAW+OV2dbP5pNa0CZpM/zQ2Hz+tq1PG
	muR+NmaF9g7VJttiG8Hkauc1y2w3CzEExWZMeN28dYv1t0sFixvamKNnOoe266zZ2cV54w9/
	m4B3xD7L5UZndffV3e7ZelQt//adKuGFlz5vm+W443LZif0NRn1zRHwVFq++cflN0vusp3u0
	areks847macWrfHw1XqZykcRs+M8DDrfW6seDa7PuNeR+kBvb/fnpSXC6uqmBxJdHQzL5iSo
	LpvE6TJDZbFEg9YaqXlJSizFGYmGWsxFxYkA/v4BSOgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTrflkHmKwanvshZH/79ls5i/7Cm7
	xb5Zng7MHpuX1Hv0bVnF6NF+oJspgDmKyyYlNSezLLVI3y6BK+PIxB1sBcdZK5ZMmcLawLiB
	pYuRk0NCwETi1PU2xi5GLg4hgd2MEq/nrGeDSIhLNF/7wQ5hC0us/PecHaLoI6PEnPN3gIo4
	ONgENCUuTC4FqRERkJdYObuZFSTMLOApsX6iPEhYWMBG4veqtawgNouAqsTL82vYQUp4BSwk
	1r+shJguLzHz0newTbwCghInZz4BO40ZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYs
	MMxLLdcrTswtLs1L10vOz93ECA4xLc0djNtXfdA7xMjEwXiIUYKDWUmE94eLaYoQb0piZVVq
	UX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTJ31bwxiH4X+fRG5/ooO
	8zKHVRJrJTQYP6y23fZrzq/Fp9+7n/JVfKjvFzjXzur5kZmRMbJ5FszHahdPZBNvbvzJWmh+
	9azrtC+xB+olH6ecdLniW5PrZsy7ZYux1iaNl4m9OnEsbr8szJrk0+/079bSvVC8+3pd+pL/
	23/GP9PY+N3VzJKPl+/36bNls6NLNeZ0zJtru93G/MOpaq7VSYc/3rWZt/UL86GnU90MRRYl
	KV66bPl+7Xq5yNzF61/c8dp/OGn7WWORuD0/eOd+MO/b/rhuTfXB319vru30m897+NjNCO39
	G3T2Hj+beKaqaFvtXjnbyqeuEw8db7w/h6u11e/VvqN2627MvTfT8UyaEktxRqKhFnNRcSIA
	N5LHJaACAAA=
X-CMS-MailID: 20230413085116epcas5p3ced7bf2b1b85bf59ff36e5440065a808
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230413085116epcas5p3ced7bf2b1b85bf59ff36e5440065a808
References: <CGME20230413085116epcas5p3ced7bf2b1b85bf59ff36e5440065a808@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_015140_887454_11A6E04F 
X-CRM114-Status: GOOD (  12.08  )
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

Patch 1: contains a little helper for fio version check
Patch 2: contains few tests for uring-passthrough on NVMe device

Changes since v2:
- Renamed test# to 49
- Skip test if IO_URING is not configured
- Skip test if SELinux is configured to disallow uring-cmd

Changes since v1:
- Remove dead/commented lines in patch 2

Kanchan Joshi (2):
  common,fio: helper for version check
  nvme/049: add test for uring-passthrough

 common/fio         | 14 ++++++++++++
 tests/nvme/049     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/049.out |  2 ++
 3 files changed, 70 insertions(+)
 create mode 100755 tests/nvme/049
 create mode 100644 tests/nvme/049.out

-- 
2.25.1


