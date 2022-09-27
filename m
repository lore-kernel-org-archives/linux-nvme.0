Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD02AC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=F02RqUi91Xs9W8MmrMNt2z6zgFmvOLtj2FXBouj/9FI=; b=eCXSxDEY82vejCJrtZuU3MjBjr
	+OxGYkzqpuESFK8uiJRQuzN9BPKWtFuBwRghD6ya6dlzBdSrynJ0vS9UGED3eqpKjTYpRSEMEAOzu
	RsLPwEAs/E+DA8bfvl8F2igcjs1D/9wnL7t6HVOKygkoOFqzadcL1QQ0w80DdnaG/viUC+2DjFgGx
	nAjiq2LhN3Th8B/Z2cCm9KrC7NOVMP55cvoJn5sAp0A7E3Fil4SGBq/OvqOb2xXW4HmpTVkwfd7qt
	0vQGN/PALz5n2PNMp22p7BGNXhyGWzS7nO+oMxbzl4RObhv8baHpeZsv23iE+445Wd+4WsnE7uwOE
	myvd56oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEfK-00C1Xy-G5; Tue, 27 Sep 2022 17:46:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEfG-00C1NR-4m
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 17:46:41 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220927174627epoutp042a81824d109b79faa58df6bdb1122148~YyL_LYezq2348123481epoutp04P
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 17:46:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220927174627epoutp042a81824d109b79faa58df6bdb1122148~YyL_LYezq2348123481epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664300787;
	bh=F02RqUi91Xs9W8MmrMNt2z6zgFmvOLtj2FXBouj/9FI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=q7JOqAUbb4K7sL5nZ59wJPue95F2gI+F68ELmMLxRmQdBYAWo8qoF1EMs2qP4BS0m
	 LPVJrvYyG6HRy1LyVBPcJOU4CB3N6IfzbxOw8lqDbQk50ngm0fftYPq0dZ3G9bpCPo
	 N4/LQ2XKDs6NUIcbUO/cpLf1k9NDgBhDkjsNjyCY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220927174626epcas5p3fdfa4e26f043a5ae6e23ae245872fdce~YyL9u4lRN2603326033epcas5p3p;
	Tue, 27 Sep 2022 17:46:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4McRrH3KQ7z4x9Pv; Tue, 27 Sep
	2022 17:46:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.79.56352.FE633336; Wed, 28 Sep 2022 02:46:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00~YyL58rwCY3009630096epcas5p1m;
	Tue, 27 Sep 2022 17:46:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220927174622epsmtrp28e4c9b7b95bc0ac0df1c44504ad562e6~YyL577q4w3251332513epsmtrp2b;
	Tue, 27 Sep 2022 17:46:22 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-bf-633336efb273
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.1D.14392.EE633336; Wed, 28 Sep 2022 02:46:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220927174621epsmtip17e5659a63b0969f5d99a4b9df657aca3~YyL4tEtXT1930019300epsmtip1M;
	Tue, 27 Sep 2022 17:46:21 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Date: Tue, 27 Sep 2022 23:06:03 +0530
Message-Id: <20220927173610.7794-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmuu57M+Nkg/0TRCxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
	6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2x
	MjQwMDIFKkzIztjz+SxTwSSJihe3TrI3MD4Q7mLk5JAQMJGY+eolSxcjF4eQwG5Gie4Vl5gh
	nE+MEs//nYPKfGOUWD59DitMy6eHLxkhEnsZJZpa7rOBJIQEPgM5t/K7GDk42AQ0JS5MLgUJ
	iwgYSez/dJIVpJ5ZYAajxOqO1+wgCWEBV4nPzy6zg9SzCKhKNDVzgoR5BcwlVk6/yAyxS15i
	5qXv7BBxQYmTM5+wgNjMQPHmrbPBLpUQuMUusbxjNdRxLhIdJ9ayQdjCEq+Ob2GHsKUkPr/b
	CxVPlrg08xwThF0i8XjPQSjbXqL1VD8zyD3MQPev36UPsYtPovf3EyaQsIQAr0RHmxBEtaLE
	vUlPobaKSzycsQTK9pC4tPcC2BQhgViJPYvlJjDKzULywCwkD8xC2LWAkXkVo2RqQXFuemqx
	aYFxXmo5PCaT83M3MYJToZb3DsZHDz7oHWJk4mA8xCjBwawkwvv7qGGyEG9KYmVValF+fFFp
	TmrxIUZTYKBOZJYSTc4HJuO8knhDE0sDEzMzMxNLYzNDJXHexTO0koUE0hNLUrNTUwtSi2D6
	mDg4pRqYAk7eqtl26fvChSECt75/n+7Z19s8l/Fu1db7j5b8vME2J09Sct3kY2rLuYJO/9i/
	400rc76AtvXcE9oNkZ+0rV4s7DCufVZ4iu+C3+QdnkmFfa5eAc8uNLzQWXyz3UdSZ9KNDsWp
	6wp4fBMsH1oe/y7104vr/mf9Vhn/34p6ml9bLc52LcsQyBIQjKjJfFY6b6vjLeljlZzHxK6d
	+9f0iH+TwZzFN+/9Dha+kvmO8XTcuTmmop2pZT/Ubu5fvu2hP//jE9wbeqYLGuQJvHmhcNah
	2CYunDto29V7P0S7KzQLK5/80e+J2rCt5uzrUtGijpe1/dYNcgsfT+H6cvFvdPsJZddGyzNh
	AsWv0pmmKLEUZyQaajEXFScCAETyqqsOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO47M+Nkg7k/1SxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRXHZpKTmZJalFunbJXBl7Pl8lqlgkkTFi1sn2RsYHwh3MXJySAiYSHx6+JKx
	i5GLQ0hgN6PEmbn3GCES4hLN136wQ9jCEiv/PWeHKPrIKNE45wRLFyMHB5uApsSFyaUgNSIC
	ZhJLD69hAalhFpjDKHH58h6wZmEBV4nPzy6zg9SzCKhKNDVzgoR5BcwlVk6/yAwxX15i5qXv
	7BBxQYmTM5+wgNjMQPHmrbOZJzDyzUKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWle
	ul5yfu4mRnDIamnuYNy+6oPeIUYmDsZDjBIczEoivL+PGiYL8aYkVlalFuXHF5XmpBYfYpTm
	YFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwJT+JuDmHTfhkBj3BV0XtKY9VZpdI2w9eRPj
	zE7/RUqTtS8qV3yxEev8c8VRtMDugrjIxF3n9dfWbdrbeuPY4lypLbcV08s7pojy/pvRprd9
	WUqId0/hVM9QrYendPzlGVUavqY3FB3XmGDTp5w7xVCTmfPfTs0AVbX/rgkiV/Yrf/2z9qdk
	V+WmHdXKogf/P5mu2a1rudVI9nfrz7gG3cVxB0rrapOnpKavyRSy8XwpfuFK8KFJpr/Pmafx
	NKTO+L10lVil6GabD7aHhT4fn7V55quQguwAPdeLy4y19A/Nroz5OFe28nfu7bRCNV3NMx7C
	WmUpRdddK8/2Skjtjtlayecuu/fo1Sc3v+/dqcRSnJFoqMVcVJwIAPoxT1DIAgAA
X-CMS-MailID: 20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_104639_562618_6CFDBBBB 
X-CRM114-Status: GOOD (  14.59  )
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

Using registered-buffers showed IOPS hike from 1.65M to 2.04M.
Without fixedbufs
*****************
# taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
submitter=0, tid=2178, file=/dev/ng0n1, node=-1
polled=1, fixedbufs=0/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=1.63M, BW=796MiB/s, IOS/call=32/31
IOPS=1.64M, BW=800MiB/s, IOS/call=32/32
IOPS=1.64M, BW=801MiB/s, IOS/call=32/32
IOPS=1.65M, BW=803MiB/s, IOS/call=32/31
^CExiting on signal
Maximum IOPS=1.65M

With fixedbufs
**************
# taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -O0 -n1 -u1 /dev/ng0n1
submitter=0, tid=2180, file=/dev/ng0n1, node=-1
polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=2.03M, BW=991MiB/s, IOS/call=32/31
IOPS=2.04M, BW=998MiB/s, IOS/call=32/32
IOPS=2.04M, BW=997MiB/s, IOS/call=32/31
^CExiting on signal
Maximum IOPS=2.04M

Changes since v9:
- Patch 6: Make blk_rq_map_user_iov() to operate on bvec iterator
  (Christoph)
- Patch 7: Change nvme to use the above

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
  block: extend functionality to map bvec iterator
  nvme: wire up fixed buffer support for nvme passthrough

 block/blk-map.c               | 108 ++++++++++++++++++++---
 drivers/nvme/host/ioctl.c     | 160 ++++++++++++++++++++--------------
 include/linux/io_uring.h      |  10 ++-
 include/uapi/linux/io_uring.h |   9 ++
 io_uring/uring_cmd.c          |  26 +++++-
 5 files changed, 237 insertions(+), 76 deletions(-)

-- 
2.25.1


