Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC02BECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=WQiaXjoAxLwsbVRXHk8q1j932l/sJd1E66j7gQPnBbE=; b=lbwougsIM3wEH7VWeBFTOvGHcM
	NtlFNg2Tl9tBQGz8w1vyxAd3v+PLQEQEFUzJL0acVPeFI6zhbyzuNSXV+PqFKgp2kyv9RVPDVsmRa
	LxCppTYTN+aRAf6o1Vl13MsI8XAQsyO1B6cvnFDdx2N6ic9UP9Qr+qvJTF2ILEyOycaGfeav5TDmN
	wUB4yCmSyy8ykgXF31epyWbdbWCmcuQbNGFLt3AZoJtN222D3c+BU/FssRP56FEXhHh3DkoVdSPtz
	ItW1DrnCGnOeUkyW570GCr8oYJhduC6BQGJH99hHY4CfFurKkr5yzrYmvZ6UNPH397isbevjR6GO3
	73/x19tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFDT-0072Q9-9V; Mon, 05 Sep 2022 16:44:55 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCme-004B56-Lc
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 14:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
	bh=WQiaXjoAxLwsbVRXHk8q1j932l/sJd1E66j7gQPnBbE=; b=DbTI1WsH3Tv7HUMP51b2S7L9TU
	HSoWcFBFeviWz8aHk3n29hqYuwH0dzDrCjQwys81OX9BKdCwyBJmBdwLswL1vW5U+hycb7yJBoDvS
	RB4RAkBzNWzUgicG+q98on1XGw8X6mGRQ/N5iquT4k3gUvfPkAPBQIvc3gk08xtvjdW0o+ejaSh6v
	lVxCiYrdzb3qpVnsCXxahzk+jukSs+HUj2UtAimrGOoEbfF1L3FsnqV+TL1zf1fK74539ZXYB0nnr
	2fn31LwxuUlcG9Wc4qcDFySFiqqDYQ72PWosOihTCEWzoosi+hNPjkwTCw3BzJmalzBkALFnt2+WZ
	sh+XaMaA==;
Received: from mailout1.samsung.com ([203.254.224.24])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCct-009gK1-BZ
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 13:59:02 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220905135847epoutp01c01cfd80afc830ec4dea3fd52e84e75f~R_46k0Fl33020230202epoutp01n
	for <linux-nvme@lists.infradead.org>; Mon,  5 Sep 2022 13:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220905135847epoutp01c01cfd80afc830ec4dea3fd52e84e75f~R_46k0Fl33020230202epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662386327;
	bh=WQiaXjoAxLwsbVRXHk8q1j932l/sJd1E66j7gQPnBbE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mBPTYXIcJXwtCAv/q1J3U5cgQeUGS6iyG+8Eh2t5r3kIPE7GtXe8M6lykVDGHRaZS
	 6Fgml9b+ZpluRs37pWzMp5o2obHhfx8tCtccUeFTkqK70lqZnHk7rZKTXIgrU6a64W
	 uaxvhq7cl6atUjHWr7/YNTrcJQB4ZUgOvxtM0zyQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220905135846epcas5p2b3e3a6346235629a4687347748ac97a0~R_45bLhe_0915909159epcas5p2V;
	Mon,  5 Sep 2022 13:58:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MLqql5mJSz4x9Pp; Mon,  5 Sep
	2022 13:58:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.56.53458.39006136; Mon,  5 Sep 2022 22:58:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220905135842epcas5p4835d74beb091f5f50490714d93fc58f2~R_42VhUbJ0624606246epcas5p4f;
	Mon,  5 Sep 2022 13:58:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220905135842epsmtrp2ac063ff4e707fceebfe4e67b57019ca6~R_42U0aQJ0557505575epsmtrp2i;
	Mon,  5 Sep 2022 13:58:42 +0000 (GMT)
X-AuditID: b6c32a4a-a5bff7000000d0d2-96-63160093d40e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.39.14392.29006136; Mon,  5 Sep 2022 22:58:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220905135841epsmtip1af119d27e209f0d1d0ce2685d201d072~R_40-WnQg1139411394epsmtip1G;
	Mon,  5 Sep 2022 13:58:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v4 0/4] fixed-buffer for uring-cmd/passthru
Date: Mon,  5 Sep 2022 19:18:29 +0530
Message-Id: <20220905134833.6387-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU3cyg1iywb/buhZzVm1jtFh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsDpweO2fdZfe4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZe7+VFtzgqthxeDNbA+MWji5GTg4JAROJY7OvMHYxcnEI
	CexmlDj+5zcThPOJUWLHtYWsEM43RombKw8ww7S8vf6DBSKxl1Hix/KLzBDOZ0aJjftuAw3j
	4GAT0JS4MLkUpEFEwEvi/u33YJOYBWYwSqzueM0OUiMs4CLxdZ4cSA2LgKrEhkUNjCA2r4C5
	xMQ9J9kglslLzLz0nR0iLihxcuYTFhCbGSjevHU22F4JgbfsEvv+T2WHaHCRuLT3N5QtLPHq
	+BYoW0ri87u9UEOTJS7NPMcEYZdIPN5zEMq2l2g91c8Mchsz0P3rd+lD7OKT6P39hAkkLCHA
	K9HRJgRRrShxb9JTVghbXOLhjCVQtofE6p39YJuEBGIlJt1exjqBUW4Wkg9mIflgFsKyBYzM
	qxglUwuKc9NTi00LjPJSy+FRmZyfu4kRnCC1vHYwPnzwQe8QIxMH4yFGCQ5mJRHelB0iyUK8
	KYmVValF+fFFpTmpxYcYTYHBOpFZSjQ5H5ii80riDU0sDUzMzMxMLI3NDJXEeadoMyYLCaQn
	lqRmp6YWpBbB9DFxcEo1MPleXfNetLdA4Yxf7bMq/i2aWq3/ux49/u5UsrNhlmaj2Wuli4v3
	rTCYG7tB10Xg1JHinZoJL67PzXhqN/3YS1bWfRePSHq7abXckvGKDRNaECP54mxDf/GEzz/D
	v/vM/3XuUvnH1qv6zdlFPe/TNPTmus6Y8sE6P5xD9PLhhTPd5kWlFV74xn747dx9YvMe5gbo
	n/v/hktg16005rab5V/93EuebubtXiLJJ7rawkLg3EyPBOm7LFZJiYoix9VXWJ2J5WI+906/
	NPlWvujVoi+sC22OhN3iWG7wffFZ3XMtoVbySU4ymabSnIXPOdS4P3C8W8aZGCkbUz5x5+y/
	E/QDPD2cZ6/4u6VHjveBpBJLcUaioRZzUXEiAM8VlN0ZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnO4kBrFkg1dPTSzmrNrGaLH6bj+b
	xc0DO5ksVq4+ymTxrvUci8XR/2/ZLCYdusZosfeWtsX8ZU/ZHTg9ds66y+5x+Wypx6ZVnWwe
	m5fUe+y+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBl7v5UW3OCq2HF4M1sD4xaOLkZO
	DgkBE4m313+wdDFycQgJ7GaUOH7/CRtEQlyi+doPdghbWGLlv+fsEEUfGSXWPexj7WLk4GAT
	0JS4MLkUpEZEIEDiYONlsBpmgTmMEpcv72EHqREWcJH4Ok8OpIZFQFViw6IGRhCbV8BcYuKe
	k1C75CVmXvrODhEXlDg58wkLiM0MFG/eOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnFhsWGOal
	lusVJ+YWl+al6yXn525iBAexluYOxu2rPugdYmTiYDzEKMHBrCTCm7JDJFmINyWxsiq1KD++
	qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJqVz3zT3fBGdesDtBkeVzrJ/
	IbPf/srY//tbTifLy5WZ8wzajv5c8I3v0r7CX7Hm+elLen2/aCVu0NEtkPv9rerUtdPyjb+u
	T350907OJbVu49cTtvD9apj7/NLL7q+n69Ymamwz7u/bI+RbeW4W14sL5wXPstXvTb7cxeQy
	99gfpgb//Y0ShzJidrx8eHTOLcGYNF7/oilPV5uWMXGd/Lam8l7D+YZjHr/UYnpuh/dKKk+Z
	l++WvH/2hbbV5xe/2iegUcDT2Hdz9iGBFoP/G6ZO/cR1y/rRBi9ZhY5vhVsefgnk7092C9t2
	wfUea5AT47z4CQ+DltgmLGz5s2/9ZgZRLt/5U/+vup+kWb7VxrZViaU4I9FQi7moOBEAJmlR
	5NECAAA=
X-CMS-MailID: 20220905135842epcas5p4835d74beb091f5f50490714d93fc58f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220905135842epcas5p4835d74beb091f5f50490714d93fc58f2
References: <CGME20220905135842epcas5p4835d74beb091f5f50490714d93fc58f2@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_145900_120131_31A5B69E 
X-CRM114-Status: GOOD (  16.32  )
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

Hi,

Currently uring-cmd lacks the ability to leverage the pre-registered
buffers. This series adds that support in uring-cmd, and plumbs
nvme passthrough to work with it.

Using registered-buffers showed IOPS hike from 1.9M to 2.2M to me.

Patch 1, 3 = prep/infrastructure
Patch 2 = expand io_uring command to use registered-buffers
Patch 4 = expand nvme passthrough to use registered-buffers

Changes since v3:
- uring_cmd_flags, change from u16 to u32 (Jens)
- patch 3, add another helper to reduce code-duplication (Jens)

Changes since v2:
- Kill the new opcode, add a flag instead (Pavel)
- Fix standalone build issue with patch 1 (Pavel)

Changes since v1:
- Fix a naming issue for an exported helper

Anuj Gupta (2):
  io_uring: introduce io_uring_cmd_import_fixed
  io_uring: introduce fixed buffer support for io_uring_cmd

Kanchan Joshi (2):
  block: add helper to map bvec iterator for passthrough
  nvme: wire up fixed buffer support for nvme passthrough

 block/blk-map.c               | 94 +++++++++++++++++++++++++++++++----
 drivers/nvme/host/ioctl.c     | 38 +++++++++-----
 include/linux/blk-mq.h        |  1 +
 include/linux/io_uring.h      | 11 +++-
 include/uapi/linux/io_uring.h |  9 ++++
 io_uring/uring_cmd.c          | 29 ++++++++++-
 6 files changed, 158 insertions(+), 24 deletions(-)

-- 
2.25.1


