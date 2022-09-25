Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB77C54EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=i1x5/16vERyV9B+Qa5JO2XwnVEudUG9CRVgYMQHnaiM=; b=1YLD64acm3ynV5UT64Dfyi5JCD
	cm8HQccZYGFJIsbGsOhPEedQoVqp5Ms9YyYuA4cS7M910j1uqutEyO1UigjRsKU9KPEiuVMHoe/0K
	aPOYDNKgtwGD/cvHn/k5oEW5xn3P2kwbbVRUtQJnySLOc+gW1RQRxCsFMWZgvL1U8rDV7sWNDMBR0
	CBBdi8lX9de/ZK3cV3JkSa1kk4E3SylVK4JP1NZLGuMGpdilV0LhLjSjC2AQxdKax5m63QcoxE+zK
	DCCaHCzyDuUUX1f8Cr/R9v/pgwhRJ8PdH4QmXV10KHJ/4/aafIswNegZRjsfpYPfPG5sfRErM/+1M
	zWvarOoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocYJk-00GRnZ-CB; Sun, 25 Sep 2022 20:33:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocYJg-00GRim-GA
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 20:33:35 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220925203320epoutp033551a05cf6aa9c39fc71a12951621e14~YNLGtPj5R1368813688epoutp032
	for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 20:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220925203320epoutp033551a05cf6aa9c39fc71a12951621e14~YNLGtPj5R1368813688epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664138000;
	bh=i1x5/16vERyV9B+Qa5JO2XwnVEudUG9CRVgYMQHnaiM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uplTNAaINzCOxhc0rGA0O1cnbP5aMGu23GiM2fNISIbbGokVdUsjTFave3jYfC97O
	 oAgWK7MOEr0IY3rx7Xx4LxO0xcUkd6zys757VZ5AN5Np8byneTxFnoEsoqKTwCcKTo
	 YQHxKpL9AKJ2IQmRoVkHk9GtolkIJ/E5zi5yUap4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220925203318epcas5p439edf20fc33884b4be4ef83b0531438f~YNLFnExqg2831828318epcas5p4v;
	Sun, 25 Sep 2022 20:33:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MbHdm1D2Jz4x9Pt; Sun, 25 Sep
	2022 20:33:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.9F.26992.C0BB0336; Mon, 26 Sep 2022 05:33:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220925203314epcas5p2a075d1026db3a46df09a4b67108109b4~YNLB_M_L00635906359epcas5p2L;
	Sun, 25 Sep 2022 20:33:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220925203314epsmtrp15d85f148375096393914f9c3dbff2696~YNLB6jHeI1867318673epsmtrp1S;
	Sun, 25 Sep 2022 20:33:14 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-12-6330bb0c690e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.01.14392.A0BB0336; Mon, 26 Sep 2022 05:33:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220925203312epsmtip1cc0b26348eff6180701f5e423079ad0e~YNK-_lZv-3161131611epsmtip1V;
	Sun, 25 Sep 2022 20:33:12 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v9 0/7] fixed-buffer for uring-cmd/passthru
Date: Mon, 26 Sep 2022 01:52:57 +0530
Message-Id: <20220925202304.28097-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmui7PboNkg3nT2SxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
	6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2x
	MjQwMDIFKkzIztiw6CZ7wUKBiudL3BsY3/N0MXJySAiYSPz+s4q5i5GLQ0hgN6PEgSfzmCCc
	T4wS/54/ZYRwvjFKTNl7nB2mpWX3fqjEXkaJlbP2s0I4nxklpp/sZ+ti5OBgE9CUuDC5FKRB
	RMBIYv+nk2A1zAIzGCVWd7wGmyQs4CJx4+9dNhCbRUBVYtvTH6wgNq+AhcTHhY+ZILbJS8y8
	9J0dIi4ocXLmExYQmxko3rx1NtjhEgK32CUWHdvLCNHgItG09z/UqcISr45vgbKlJF72t0HZ
	yRKXZp6DWlAi8XjPQSjbXqL1VD8zyAPMQA+s36UPsYtPovf3EyaQsIQAr0RHmxBEtaLEvUlP
	WSFscYmHM5ZA2R4Sc6Y1MIPYQgKxEpeWXmGawCg3C8kHs5B8MAth2QJG5lWMkqkFxbnpqcWm
	BYZ5qeXwuEzOz93ECE6HWp47GO8++KB3iJGJg/EQowQHs5IIb8pF3WQh3pTEyqrUovz4otKc
	1OJDjKbAYJ3ILCWanA9MyHkl8YYmlgYmZmZmJpbGZoZK4ryLZ2glCwmkJ5akZqemFqQWwfQx
	cXBKNTBJXMnI4Uzz4VkYdl/wueymbfXt3h/N+z5Vfj9h7577W4Cl6FZBxNYKsYuf5m9vnNwx
	L6ElNsb19B1LvmovBZUrv9Z5xgZYO+zXLHwokfPJ89DcRQ58D17WTEr4dXixlIlp8yeOV9c1
	jFfdmJ1ywPLEvKU31iTbHCnWZuRf0BW4Sm+eVUWUnyL/t0SryZ2qMz78szng0H9eWPnPD27b
	D66a5m+LTD/b+hf5B+4QV/k/QWnvixk7wnadjnc3fciXrnDGekNmj/2TJIfL6ZJ1f5aLOt+s
	4eBjuLfi3oTiGq6jCb/aWRuylxvX/pSPM/i/oe2x3oLtO28yek/Jmcx4/1N31s6za2tXbjj/
	JlQlqFWJpTgj0VCLuag4EQAi0UQ6EAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnC7XboNkgzf3DCxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRXHZpKTmZJalFunbJXBlbFh0k71goUDF8yXuDYzveboYOTkkBEwkWnbvZ+xi
	5OIQEtjNKHF+xidmiIS4RPO1H+wQtrDEyn/P2SGKPjJKPGufB1TEwcEmoClxYXIpSI2IgJnE
	0sNrWEBqmAXmMEpcvrwHrFlYwEXixt+7bCA2i4CqxLanP1hBbF4BC4mPCx8zQSyQl5h56Ts7
	RFxQ4uTMJywgNjNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeu
	l5yfu4kRHLJamjsYt6/6oHeIkYmD8RCjBAezkghvykXdZCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYLCuv6XO95Xr4/ce0o8J30vTv/n7BuOWjAevX
	qJiMk0WeUrPM2Kc8y9H9+O7AcyYDdo6f7yuWNpmfLUwJ8PQ/8fnT1G11wke2Mm0znep9S6rp
	Cm/0vrs/fOIlWlWfOQrwbXjKUfnqXdoq3VRTLVX/unV9RRtPyGa/PpRtK+Qle8f38IpLU149
	3hekYM2f9OWlrcEL0U12Ft15HOorqlccmqd6clPvhdnvFJ/Jfljns0ZMra3d7fPSpWsa2Rq3
	T255sEbgfdjKywerP/o53blfdfmx0otKphUxSoouxnunStY6Rx678zsj5p6D1puGze7zYmdd
	ySs0ap71/GajVoEbQ7ZVeg531J3iBddvLa/KUGIpzkg01GIuKk4EAIipyCzIAgAA
X-CMS-MailID: 20220925203314epcas5p2a075d1026db3a46df09a4b67108109b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220925203314epcas5p2a075d1026db3a46df09a4b67108109b4
References: <CGME20220925203314epcas5p2a075d1026db3a46df09a4b67108109b4@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_133332_900423_23EC8BE1 
X-CRM114-Status: GOOD (  13.98  )
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

Hi

uring-cmd lacks the ability to leverage the pre-registered buffers.
This series adds that support in uring-cmd, and plumbs nvme passthrough
to work with it.

Patch 3 and 4 contains a bunch of general nvme cleanups, which got added
along the iterations.

Using registered-buffers showed 22-26% hike in peak IOPS (v8,in Jens setup).

Changes since v8:
- Split some patches further; now 7 patches rather than 5 (Christoph)
- Applied a bunch of other suggested cleanups (Christoph)

Changes since v7:
- Patch 3: added many cleanups/refactoring suggested by Christoph
- Patch 4: added copying-pages fallback for bounce-buffer/dma-alignment case
  (Christoph)

Changes since v6:
- Patch 1: fix warning for io_uring_cmd_import_fixed (robot)
-
Changes since v5:
- Patch 4: newly addd, to split a nvme function into two
- Patch 3: folded cleanups in bio_map_user_iov (Chaitanya, Pankaj)
- Rebase to latest for-next

Changes since v4:
- Patch 1, 2: folded all review comments of Jens

Changes since v3:
- uring_cmd_flags, change from u16 to u32 (Jens)
- patch 3, add another helper to reduce code-duplication (Jens)

Changes since v2:
- Kill the new opcode, add a flag instead (Pavel)
- Fix standalone build issue with patch 1 (Pavel)

Changes since v1:
- Fix a naming issue for an exported helper


Anuj Gupta (2):
  io_uring: add io_uring_cmd_import_fixed
  io_uring: introduce fixed buffer support for io_uring_cmd

Kanchan Joshi (5):
  nvme: refactor nvme_add_user_metadata
  nvme: refactor nvme_alloc_request
  block: factor out bio_map_get helper
  block: introduce helper to map bvec iterator
  nvme: wire up fixed buffer support for nvme passthrough

 block/blk-map.c               | 111 ++++++++++++++++++++---
 drivers/nvme/host/ioctl.c     | 160 ++++++++++++++++++++--------------
 include/linux/blk-mq.h        |   1 +
 include/linux/io_uring.h      |  10 ++-
 include/uapi/linux/io_uring.h |   9 ++
 io_uring/uring_cmd.c          |  26 +++++-
 6 files changed, 241 insertions(+), 76 deletions(-)

-- 
2.25.1


