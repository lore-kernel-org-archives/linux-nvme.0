Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC8C3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=EP95YAKMGmar4fGvEahN3sfxzyzUKGg4D2wnOZeDrg8=; b=BB+rcr6IXn8OjkByHcsJFZwgF9
	eNQ2K06l42bZHBW8H8PtcY1n0hBfWZB385fEOoYJaIYUNhpythFMdkd2ew3vmsrIevsUQ6YAUsHnB
	QY04tA5OWEfiyQj5RU1KhWokq+SSEssMFFwWwEP2dCGauNF/c4Vu89Pv8UwGeMp0ti+csme+cvTiQ
	Ye2Li/Wv9CtzLOwmjsx1hKSkdvfBqolCxWzfs2FvMcN+WGYRyMWY4xND0anOjR8q7XVFQqyJkPD/a
	Lrew9AncnFdwSQAQ8XHGLwr3/HpUS56415jpfoPXUMn4S9I1OHLWDAY1KG+ybVyNWOva7PSWCP56i
	xLLebX8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjE-0000000CaBL-35xC;
	Tue, 06 May 2025 16:01:08 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHNm-0000000Bu4z-1f4h
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:26:52 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250506122635epoutp025f4593a217700a4584ab686027e24162~878eNtjam0473504735epoutp02I
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250506122635epoutp025f4593a217700a4584ab686027e24162~878eNtjam0473504735epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534395;
	bh=EP95YAKMGmar4fGvEahN3sfxzyzUKGg4D2wnOZeDrg8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RYlFeZIR9TZzn217fG3cf1d3Xmj0VhvRPrThVZ7Wr4WNontVBmeL/T12y6OMG4Lrt
	 WfwzXVpf1iP0nc/8zKT+pQKLRhHRew6TWwUwxpAsa19wJOlnmSGbJ5CXsf3SxXUED3
	 Fs/KAPzADfBcliYI4WO6aq94mhm+vzQBofqmhLXs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250506122635epcas5p415c62b44a7a1d9d877a84bc1ae8ca4d4~878d-Huyq1362913629epcas5p48;
	Tue,  6 May 2025 12:26:35 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ZsHgs6YTBz2SSKX; Tue,  6 May
	2025 12:26:33 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122633epcas5p21d2c989313f38dea82162fff7b9856e7~878cBgr0K2629626296epcas5p2D;
	Tue,  6 May 2025 12:26:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506122633epsmtrp137c67cdfd15529befad5ce1ab710c2ba~878cA1-UT2524025240epsmtrp1f;
	Tue,  6 May 2025 12:26:33 +0000 (GMT)
X-AuditID: b6c32a2a-d63ff70000002265-4a-6819fff90a16
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.6E.08805.9FFF9186; Tue,  6 May 2025 21:26:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122632epsmtip2077afd01fb4311aaad9b024ee9ba4802~878an1Igm1679416794epsmtip2Y;
	Tue,  6 May 2025 12:26:31 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v16 00/11] Block write streams with nvme fdp
Date: Tue,  6 May 2025 17:47:21 +0530
Message-Id: <20250506121732.8211-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvO7P/5IZBj/6xC3mrNrGaLH6bj+b
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0rbYs/cki8X8ZU/ZHTg9ds66y+5x+Wypx6ZVnWwe
	m5fUe+y+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkT359iLngpWfHk9h2WBsY3Il2M
	HBwSAiYSHxbHdzFycQgJ7GaUmPj2AnMXIydQXFyi+doPdghbWGLlv+fsEEUfGSUuzDvGCNLM
	JqApcWFyKUiNiECAxMvFj5lBapgFljJKdCycCDZIWMBG4teN02CDWARUJTZsnMoIYvMKmEvM
	v/2LFWKBvMTMS9/ZIeKCEidnPmEBsZmB4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMC
	o7zUcr3ixNzi0rx0veT83E2M4DDW0trBuGfVB71DjEwcjIcYJTiYlUR479+XzBDiTUmsrEot
	yo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFMlomDU6qBSezZcS2JRfpH/7xpOaf0
	L/sSn7LJtB13dinIbTSsf9Y9MbVTd3tXw80J0VETN4SIcOsZqh/+oSRTqfKIleFv65zw0ud1
	AozspRdYhBzNvzSGaJ/RbVZsWGfy2+ii4u2SrXK/zG6bRYXr3J7Yk1IZya827WvFRi65ysWy
	T065snK7Jc2SPj+55eTzzMe3uZWnziu9sk7724pHWtJ7jl1MnDJvrbM6b/iuiaZqVpt3utUt
	r007vOda/pG0xusTJeynGVqcyqnMbj7a0WDTP9nTZuOUc3c3sCxO/nrw/5sipp4fKzg6MuZ5
	F3zzn79p1q3nxq+39H95vJpRNcOPP/LeliX1Sf+tbdbZvJ6+7m6ikBJLcUaioRZzUXEiALK5
	JHnSAgAA
X-CMS-MailID: 20250506122633epcas5p21d2c989313f38dea82162fff7b9856e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122633epcas5p21d2c989313f38dea82162fff7b9856e7
References: <CGME20250506122633epcas5p21d2c989313f38dea82162fff7b9856e7@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_052649_377260_CEF8A1A5 
X-CRM114-Status: GOOD (  13.25  )
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

The series enables FDP support for block IO.
The patches
- Add ki_write_stream in kiocb (patch 1), and bi_write_stream in bio (patch 2).
- Introduce two new queue limits - max_write_streams and
  write_stream_granularity (patch 3, 4)
- Pass write stream (either from kiocb, or from inode write hints)
  for block device (patch 5)
- Per I/O write stream interface in io_uring (patch 6)
- Register nvme fdp via write stream queue limits (patch 10, 11)

Changes since v15:
- Merged to latest for-next (Jens)

Previous discussions:
v15: https://lore.kernel.org/linux-nvme/20250203184129.1829324-1-kbusch@meta.com/T/#u
v14: https://lore.kernel.org/linux-nvme/20241211183514.64070-1-kbusch@meta.com/T/#u
v13: https://lore.kernel.org/linux-nvme/20241210194722.1905732-1-kbusch@meta.com/T/#u
v12: https://lore.kernel.org/linux-nvme/20241206221801.790690-1-kbusch@meta.com/T/#u
v11: https://lore.kernel.org/linux-nvme/20241206015308.3342386-1-kbusch@meta.com/T/#u
v10: https://lore.kernel.org/linux-nvme/20241029151922.459139-1-kbusch@meta.com/T/#u
v9: https://lore.kernel.org/linux-nvme/20241025213645.3464331-1-kbusch@meta.com/T/#u
v8: https://lore.kernel.org/linux-nvme/20241017160937.2283225-1-kbusch@meta.com/T/#u
v7: https://lore.kernel.org/linux-nvme/20240930181305.17286-1-joshi.k@samsung.com/T/#u
v6: https://lore.kernel.org/linux-nvme/20240924092457.7846-1-joshi.k@samsung.com/T/#u
v5: https://lore.kernel.org/linux-nvme/20240910150200.6589-1-joshi.k@samsung.com/T/#u
v4: https://lore.kernel.org/linux-nvme/20240826170606.255718-1-joshi.k@samsung.com/T/#u
v3: https://lore.kernel.org/linux-nvme/20240702102619.164170-1-joshi.k@samsung.com/T/#u
v2: https://lore.kernel.org/linux-nvme/20240528150233.55562-1-joshi.k@samsung.com/T/#u
v1: https://lore.kernel.org/linux-nvme/20240510134015.29717-1-joshi.k@samsung.com/T/#u


Christoph Hellwig (7):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper
  nvme: pass a void pointer to nvme_get/set_features for the result
  nvme: add FDP definitions

Keith Busch (4):
  block: introduce max_write_streams queue limit
  io_uring: enable per-io write streams
  nvme: register fdp parameters with the block layer
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 191 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   7 +-
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  10 ++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++
 include/uapi/linux/io_uring.h        |   4 +
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 15 files changed, 339 insertions(+), 6 deletions(-)


base-commit: e6d9dcfdc0c53b87cfe86163bfbd14f6457ef2b7
-- 
2.25.1


