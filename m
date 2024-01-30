Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CDBC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=u8hkftLGAKfOaphmPbjcvpasYOesn4M0X2vR0auW9TY=; b=DMN0tcaX1+mK8LaIRU7kPsz1Go
	kIthIGVpirnzkxuOiC/4G8o04m329ASIribMPK4rCKDRppDuY8BMS0lmteosnH4Islz0pD6lr9VKk
	cbNy8ChxzN4U7Gby63IaXhiVX4+qMkFariwy6rshu4743RgmUAg6umF/WqbVsxd3gh35+fUo/tAge
	8F2YQ1bcL6C5lt5/DSXvpp+bCqOXOv/ZueLS7nJKetU1RV8SjXVRD/dY07UsZZKkjG1gz+6djojJ5
	q/u7aWYZHOCirEoIhe0qApBOKSWR9+m74xlXP5bXnyhSFKrpbC9mOi2CqjLaxlwTZlRcj0eCB3gmh
	Imj64Xfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUrlp-0000000HXGg-1DRD;
	Tue, 30 Jan 2024 17:19:37 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUrlj-0000000HXCY-0I8q
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 17:19:35 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240130171922epoutp0245657010b5ec6f83ff86e7e54ae26345~vL6NwlI7R0474904749epoutp02K
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 17:19:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240130171922epoutp0245657010b5ec6f83ff86e7e54ae26345~vL6NwlI7R0474904749epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706635162;
	bh=u8hkftLGAKfOaphmPbjcvpasYOesn4M0X2vR0auW9TY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=U1OZWVmNfVmThKGFmDe25omqCO9EMl6P4yJl3J6RvUKkA9VDri+DUrR2xTd2i/Jbz
	 hgB/OnhXBV3HxxaeJWTDrt7dQPxqwxEwlJ3yzAa0368sqHHIDgFYLWg/nyoWk7BrXc
	 fLyikotRdSzj1ZCb1ASxjG9oULEcMg3tYxSLJM0I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240130171922epcas5p16505a9a559c1300e8c7e78951ec8a52c~vL6NhQukD0856008560epcas5p1M;
	Tue, 30 Jan 2024 17:19:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TPX2v1ywCz4x9Pp; Tue, 30 Jan
	2024 17:19:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.58.09672.79F29B56; Wed, 31 Jan 2024 02:19:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea~vL6JavHos0961109611epcas5p3Q;
	Tue, 30 Jan 2024 17:19:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240130171918epsmtrp18e1f64daeaaa0c9c751e860c37a9e3dc~vL6JaGT5f2441824418epsmtrp19;
	Tue, 30 Jan 2024 17:19:18 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-a2-65b92f973f59
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.90.07368.59F29B56; Wed, 31 Jan 2024 02:19:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171916epsmtip22bb4438293fbdf3bf4ff64adb80cfb78~vL6H_ecil1888718887epsmtip2B;
	Tue, 30 Jan 2024 17:19:16 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/3] Block integrity with flexibile-offset PI
Date: Tue, 30 Jan 2024 22:42:03 +0530
Message-Id: <20240130171206.4845-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTU3e6/s5Ug69ruC1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rou9t7Qt5i97ym6x/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN4+PTWywefVtWMXp83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
	p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjyZeggpWcFd8a2lgaGOezdzFyckgImEi8/raW
	qYuRi0NIYDejxPRzq5ghnE+MEpcPTYHKfGOUeHx1JTNMy/djv1ghEnsZJX5+2s8EkhAS+Mwo
	cfeiQxcjBwebgKbEhcmlIGERgSSJbW8+s4HYzAI1EpfvngYrFxawlbh1uYcRxGYRUJWYtW4a
	WJxXwFyipf85C8QueYmZl76zQ8QFJU7OfMICMUdeonnrbLBLJQQ+sku82f2VFaLBRWLpz8VQ
	vwlLvDq+BcqWknjZ3wZlJ0tcmnmOCcIukXi85yCUbS/ReqqfGeR+ZqD71+/Sh9jFJ9H7+wkT
	SFhCgFeio00IolpR4t6kp1BbxSUezlgCZXtI3N+7lxUSIrES87c2s0xglJuF5INZSD6YhbBs
	ASPzKkbJ1ILi3PTUYtMC47zUcnhMJufnbmIEJ0ot7x2Mjx580DvEyMTBeIhRgoNZSYR3pdzO
	VCHelMTKqtSi/Pii0pzU4kOMpsBgncgsJZqcD0zVeSXxhiaWBiZmZmYmlsZmhkrivK9b56YI
	CaQnlqRmp6YWpBbB9DFxcEo1MCWGh7ClyLC8Opq+lsmNNUU1ehqD7kvPxtliD/8vt7RU5k54
	m7TI4O3Th8H1y79dbjH77NZ9Tv2+z4u6rG+3JV8lKN88Xcj6ic3C9vsM31OHppjP5nsgtsnf
	pq6TT0LUTn5569YLGreqdYNYg9pUK1fP8A+Z65Den8uu6Lnu/t7XS9sXBk6YY9o28W3f/+uh
	r0SFMk7c275P0/zUeanX7ffvP02sMkp8JHyp8+GLi2dmPzD5OX1RrdKjo1qxxxW+T70brqGb
	uXf6/1S2R6l3v4s+Z5XJc+ZwSW6V+rP25OTeP7VrohftvbdfarK29eM5lVfWTF8z/cz7Lxtd
	3CIl5xyo8NIK8G5w+Ci8sojjV7ESS3FGoqEWc1FxIgAH0hNMHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvO5U/Z2pBs97bCxW3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rou9t7Qt5i97ym6x/Pg/Jot1r9+zOHB6nL+3kcXj8tlSj02rOtk8
	Ni+p99h9s4HN4+PTWywefVtWMXp83iQXwBHFZZOSmpNZllqkb5fAlbHkS1DBSs6Kbw1tLA2M
	89m7GDk5JARMJL4f+8XaxcjFISSwm1Fi9tkvjBAJcYnmaz+gioQlVv57zg5R9JFRYmXrfeYu
	Rg4ONgFNiQuTS0FqRAQyJGav/gZWwyzQwCix7vUuJpCEsICtxK3LPWBDWQRUJWatmwYW5xUw
	l2jpf84CsUBeYual7+wQcUGJkzOfgMWZgeLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GTD
	AsO81HK94sTc4tK8dL3k/NxNjOCA1tLYwXhv/j+9Q4xMHIyHGCU4mJVEeFfK7UwV4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgelguvS676IbfnpL7Xwv
	cPJgGPvql3md/2L4uieLHXPN/Pn2CC+3k+yt2/Gz4yYyPNnD5xR734M3cfp1p9VBd55NXu6z
	78upulelCTb8s3TefpwzReuMXfbKvvD11m/NQyx2b/JUPDn9fZuw8G3ffUWXZlrMdpWPneNe
	KmZTVjVn176ts+yzmO5M2t8udU40VHTbbinfx5yZj7YfZ26KEhY8dSls2+b7Pz+c28wq4+F7
	U4t11txLuzQufwg5276z7rTId+4tvxq6Dvzh0BG+XF4mbtu28ev6dwVKPzM2bCqrnbn20NXm
	z8xZhw+U/Izccob3zhVlvuxlDd/Ne40C2UP3VE2eu79kyfN3Gpox143ElFiKMxINtZiLihMB
	d2weaNcCAAA=
X-CMS-MailID: 20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea
References: <CGME20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_091932_624683_524C1FF0 
X-CRM114-Status: GOOD (  13.52  )
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

The block integrity subsystem can only work with PI placed in the first
bytes of the metadata buffer.

The series makes block-integrity support the flexible placement of PI.
And changes NVMe driver to make use of the new capability.

This helps to
(i) enable the more common case for NVMe (PI in last bytes is the norm)
(ii) reduce nop profile users (tried by Jens recently [1]).

/* For NS 4K+16b, 8b PI, last bytes */
Before:
# cat /sys/block/nvme0n1/integrity/format
nop

After:
# cat /sys/block/nvme0n1/integrity/format
T10-DIF-TYPE1-CRC

[1] https://lore.kernel.org/linux-block/20240111160226.1936351-1-axboe@kernel.dk/

Kanchan Joshi (3):
  block: refactor guard helpers
  block: support PI at non-zero offset within metadata
  nvme: allow integrity when PI is not in first bytes

 block/bio-integrity.c         |  1 +
 block/blk-integrity.c         |  1 +
 block/t10-pi.c                | 72 +++++++++++++++++++++++------------
 drivers/nvme/host/core.c      |  8 +++-
 drivers/nvme/host/nvme.h      |  1 +
 include/linux/blk-integrity.h |  1 +
 include/linux/blkdev.h        |  1 +
 7 files changed, 60 insertions(+), 25 deletions(-)

-- 
2.25.1


