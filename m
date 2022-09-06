Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CDC6FA8B
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=F3EnbytOd4XDhzc1QhFKf1tJcM00xrrzImkoAe68mCk=; b=SqCM2dp6XpdYSQxVLiT5LgFOzy
	8KzMniVA2IxeySgnPIBRBTAG37JUiXo/8FRxG05AeHOeh1NeCfLvEvR/147hSV03tj5H0GYx2cfb6
	KwxLxLMAtUKFM+EQeCmu38zWVNNArgwv+dpo1oZs03esA3oxWRbK3L28iGWsBi5XlXPVuhJCJY19Z
	s8Rukwgp5rlzsYTzgls3nRAd9z9fzOxfojRsSgw5ZSMdW5LDd+qbrlzKj0zOwwtNmLDB42oDfV6Ct
	CDWDpHLfgrku4nIvyIdWjMTppZ9N7r4Mn2WSSWbrNhrGHAzHRA8IUfqfbZc4EeeC1JlFI12Gvhq1W
	0L4cWPsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSDF-00ASxg-VT; Tue, 06 Sep 2022 06:37:34 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSDD-00AStE-AQ
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:37:33 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220906063724epoutp04ac410f9c84bc0232b379fb00713714fe~SMg0sPw251049910499epoutp04T
	for <linux-nvme@lists.infradead.org>; Tue,  6 Sep 2022 06:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220906063724epoutp04ac410f9c84bc0232b379fb00713714fe~SMg0sPw251049910499epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662446244;
	bh=F3EnbytOd4XDhzc1QhFKf1tJcM00xrrzImkoAe68mCk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qLEF/61Lq1RNaTsFrztyM26NHExCGKo9M+3b/RFBPn4ASY4DiWqE9ID/vQgrgYLw1
	 JyTIVqVm0zObHXSLfFB2y90nNFngYup4kucoqYKw96Xy+/NP6SVU8x11jb3d/vsOE/
	 p0VNaKIQOx+sHFylbhOircNzqiBF8+L94ipFMxag=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220906063724epcas5p1ce549e3745baf6799d8027d3ed25120d~SMg0M8hbd2227522275epcas5p11;
	Tue,  6 Sep 2022 06:37:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MMG013zs8z4x9QB; Tue,  6 Sep
	2022 06:37:21 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.8B.54060.0AAE6136; Tue,  6 Sep 2022 15:37:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220906063719epcas5p3157e79583a5412a3be81f3d96f8aaadd~SMgwKp4CF2989229892epcas5p3e;
	Tue,  6 Sep 2022 06:37:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220906063719epsmtrp132a27c1e5a73c0f31c80d86ae91b15da~SMgwJongO2539325393epsmtrp13;
	Tue,  6 Sep 2022 06:37:19 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-a1-6316eaa0a6fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.45.14392.F9AE6136; Tue,  6 Sep 2022 15:37:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220906063718epsmtip294d84ed493330f801dcdf42840f35cdb~SMguyIVBy2902729027epsmtip2d;
	Tue,  6 Sep 2022 06:37:18 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v5 0/4] fixed-buffer for uring-cmd/passthru
Date: Tue,  6 Sep 2022 11:57:17 +0530
Message-Id: <20220906062721.62630-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTXXfBK7FkgxX/pSzmrNrGaLH6bj+b
	xc0DO5ksVq4+ymTxrvUci8XR/2/ZLCYdusZosfeWtsX8ZU/ZHTg9ds66y+5x+Wypx6ZVnWwe
	m5fUe+y+2cDm0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
	Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
	E3OLS/PS9fJSS6wMDQyMTIEKE7Izpj3cwFSwkLti17SNrA2Mrzi6GDk4JARMJC7Plepi5OIQ
	EtjNKLF7515GCOcTo8S2eRuYIJxvQJkrx1m7GDnBOq5+XcsOkdjLKPH69G6oqs+MEg8aJjKC
	zGUT0JS4MLkUpEFEwEvi/u33rCA1zAIzGCVWd7xmB0kIC7hIHHp6kxnEZhFQlfg07QwbiM0r
	YCHxaOdcJoht8hIzL31nh4gLSpyc+YQFxGYGijdvnc0MMlRC4CW7xP5/5xghHnKRmPePB6JX
	WOLV8S3sELaUxMv+Nig7WeLSzHNQ80skHu85CGXbS7Se6mcGGcMMdP/6XfoQq/gken8/YYKY
	zivR0SYEUa0ocW/SU2iYiEs8nLEEyvaQ+NJ0COwYIYFYiXunkycwys1Ccv8sJPfPQti1gJF5
	FaNkakFxbnpqsWmBcV5qOTwmk/NzNzGC06OW9w7GRw8+6B1iZOJgPMQowcGsJMKbskMkWYg3
	JbGyKrUoP76oNCe1+BCjKTBQJzJLiSbnAxN0Xkm8oYmlgYmZmZmJpbGZoZI47xRtxmQhgfTE
	ktTs1NSC1CKYPiYOTqkGpkm6IYxL/CyLt6wpm8GwIJP/wq83QYlHVpTzGNuo3vLbqx5X/oFJ
	g0kz/0Y7M1/Z29zz1pEGvHuC1pWmRVi4rC0wcFs8ge/Jinm57hGcC2L2FH5JX/bD5YFawZkb
	S+Uqp81iO9M0z5/p52JNdqu1RwTmNMw3+Tr/2AGJF4sz1x/MULkazdD1R9je7c1PqZYJ5RMV
	zp689LJd0+rChWm7VG9w6qu6dTpzPjvhEPLZqVNC2J6nfN+CPpl9+kZ3GZe/LJdKDjq3y3f7
	s002e4umzPgmmqk/xSf9OKfCXeMrGtF1HnWbArwepzeKbIruuG45ia3JPVn3V3dd7GLmlO9n
	7v97UpTKd3mxlKMU/yM+JZbijERDLeai4kQAUebftxgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSvO78V2LJBq+3qljMWbWN0WL13X42
	i5sHdjJZrFx9lMniXes5Fouj/9+yWUw6dI3RYu8tbYv5y56yO3B67Jx1l93j8tlSj02rOtk8
	Ni+p99h9s4HNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDKmPdzAVLCQu2LXtI2sDYyvOLoY
	OTkkBEwkrn5dyw5iCwnsZpR43lwFEReXaL72gx3CFpZY+e85VM1HRomOXWVdjBwcbAKaEhcm
	l4KERQQCJA42XgYq4eJgFpjDKHH58h6wemEBF4lDT28yg9gsAqoSn6adYQOxeQUsJB7tnMsE
	MV9eYual7+wQcUGJkzOfsIDYzEDx5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5
	XnFibnFpXrpecn7uJkZwEGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrwpO0SShXhTEiurUovy44tK
	c1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDK38i/uWRZ7sS+ebG2yxsLum56
	bl5TbvNp325xvainG89/llp56VTzVL/8uJ0/ju5q+GNlM8FpdSVraYvfEc6FYdNMjTc83rLn
	nSH/u2cFzzeb3Xg+ievrtKk33ni0qO3qXfHeKUpx45GSshtxgT++7hUTN540af2sPwmeHTN2
	ln9i3Tzb480Wk/0r+asDzgSdCg1rexg3bdUufiYVCclanySTyuUaj+dxuj9S/2B/OPl5GNeO
	vzvzxZ4ftNhoMy3lZKrpObHbh2qOX+5+1j6/xknpjV9G77S9ByfPfFI1PfhWAyNDfFza2jPl
	8xg8/67NXKbL1PrnUG4AT/0bjTdaXstF4vYGBvy/lZL3NMnrixJLcUaioRZzUXEiAP91ej7R
	AgAA
X-CMS-MailID: 20220906063719epcas5p3157e79583a5412a3be81f3d96f8aaadd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220906063719epcas5p3157e79583a5412a3be81f3d96f8aaadd
References: <CGME20220906063719epcas5p3157e79583a5412a3be81f3d96f8aaadd@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_233731_859427_40F4FC91 
X-CRM114-Status: GOOD (  14.35  )
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
 io_uring/uring_cmd.c          | 28 ++++++++++-
 6 files changed, 157 insertions(+), 24 deletions(-)

-- 
2.25.1


