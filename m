Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE54C28D13
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Aug 2022 03:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=LYBfCmNEBDUP3UppdMbGtkjVR2WxW77Y7LC7GOlGc+Q=; b=BFnDLNW2MOUmtV1gRhdXU/f5u3
	XabEMHEJBGDPc/FNnzuSYIJirnKJdWjm6d5GBXUCnwDqUzfUCv0KwKltHLCSVAnyLVR5PaO6AsAOa
	W892ZXbBAg9wtomin9LWeYIa/xwzXXv81eZCGB/wuimfQbUZqW1FrJk6e1b39BvVBpMNnl6vPUqxP
	gvcwHZpCje3+UdloDwgOH9g5P14ALacLue0zzN+8NccLk2DRAsBouyKgv8u9NGf29hmcN2FAsXimD
	Xr9T58t4+Rgkk1z1V6nBj3CXmh+Rn4v6wNz7Rh1xHoLI/zclhdUsUkcmt6BGseAGnpZWsNqECOJWb
	fh/lgz2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPEzG-00FuyN-4N; Sat, 20 Aug 2022 03:17:26 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPEz5-00Fuln-5N
	for linux-nvme@lists.infradead.org; Sat, 20 Aug 2022 03:17:17 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220820031704epoutp02fc94345ce3589306a491c6637a4ec16e~M70DdpDV12644226442epoutp02J
	for <linux-nvme@lists.infradead.org>; Sat, 20 Aug 2022 03:17:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220820031704epoutp02fc94345ce3589306a491c6637a4ec16e~M70DdpDV12644226442epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660965424;
	bh=LYBfCmNEBDUP3UppdMbGtkjVR2WxW77Y7LC7GOlGc+Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AjsoaCHheqfZHquL17ks9m+Z2PMK7Slnlu4adFZkixGyIAHOr3QeSMEdsFCU1uKOw
	 ccAQd4t/iHN+SmxHJGbVKWNSHTdacdbuif75/cdVbHsxabOLcicmB1lks6XYsFemvF
	 lBD3q5sd1Yn2mtpr9XOkXZqthzn+CpQgOwxnvEHQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220820031704epcas5p4d0c5e9c896b337d6247af2444e8b4ae7~M70DGut4m0638706387epcas5p47;
	Sat, 20 Aug 2022 03:17:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4M8kLj2XTGz4x9Pv; Sat, 20 Aug
	2022 03:17:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.E8.49477.D2250036; Sat, 20 Aug 2022 12:17:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220820031700epcas5p3b9a08cb9d15344e5a5d978b1dac81da1~M70AMNU5A0596905969epcas5p3K;
	Sat, 20 Aug 2022 03:17:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220820031700epsmtrp164827e0e029d491ab1c95e1ac7b2d642~M70ALa5DO2284922849epsmtrp1l;
	Sat, 20 Aug 2022 03:17:00 +0000 (GMT)
X-AuditID: b6c32a49-82dff7000000c145-d7-6300522d6df7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.39.08905.C2250036; Sat, 20 Aug 2022 12:17:00 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220820031659epsmtip13542c61eff985ebd6339522951bc52a3~M7z_1KWrp1949119491epsmtip1U;
	Sat, 20 Aug 2022 03:16:59 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v2 0/4] fixed-buffer for uring-cmd/passthrough
Date: Sat, 20 Aug 2022 08:36:16 +0530
Message-Id: <20220820030620.59003-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU1c3iCHZ4MQTQYvVd/vZLG4e2Mlk
	sXL1USaLd63nWCyO/n/LZjHp0DVGi723tC3mL3vKbnFocjOTA6fH5bOlHptWdbJ5bF5S77H7
	ZgObx/t9V9k8+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJc
	SSEvMTfVVsnFJ0DXLTMH6C4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5x
	Ym5xaV66Xl5qiZWhgYGRKVBhQnbGwpZTTAUP+Co691o0MN7k7mLk5JAQMJGY8uwXWxcjF4eQ
	wG5GiWkXLrNCOJ8YJXZ33GMFqRIS+MYo8exxNUzH3Cl7oTr2MkqsaTkB1fGZUeLtuoksXYwc
	HGwCmhIXJpeCNIgIGEns/3QSrIZZYC2jxOm9X5hAEsIC7hIvX6xlAbFZBFQlLk+bCxbnFbCQ
	WP/zHzPENnmJmZe+s0PEBSVOznwCVs8MFG/eOpsZZKiEwFt2ic+P1rFDNLhI/GyZyQhhC0u8
	Or4FKi4l8bK/DcpOlrg08xwThF0i8XjPQSjbXqL1VD8zyAPMQA+s36UPsYtPovf3EyaQsIQA
	r0RHmxBEtaLEvUlPWSFscYmHM5ZA2R4S/z8cYocEXKxEz9Uu5gmMcrOQfDALyQezEJYtYGRe
	xSiZWlCcm55abFpgmJdaDo/K5PzcTYzgBKnluYPx7oMPeocYmTgYDzFKcDArifDeuPMnSYg3
	JbGyKrUoP76oNCe1+BCjKTBYJzJLiSbnA1N0Xkm8oYmlgYmZmZmJpbGZoZI4r9fVTUlCAumJ
	JanZqakFqUUwfUwcnFINTBtfKjcLPXG3tI/48rBjm7bH4kVzl340vqTVtvrtsgb7nCeplWqa
	KWlSLqelPJYf8PI608psc7xh+/cdnO+YVR9a3V7eY/0+vXzte/EzE2furprm628dM6dcovtE
	2cJo9x3xyzcsyb/NyzW/Xp85zP7mq4u25Xv2rHyVGiIs3nLSfsI8xbDXlw/dXrLycrca04Rz
	/4XWVXqtc191/8i5xMfi5/uPzzwYdyBy60TL1pK0pXHHZs2uWirfwZNrcdClKMO3bOFGUVPD
	czoi3vWd/37tW2sx0daNf+EarVeGCh9Eo5/v+r3tzf3IU/Xq+baTu2bUZR6ZOFkn273lm9W1
	wxIPptn9Enfrt8gqrnLmMVJiKc5INNRiLipOBAAvhfSoGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnK5OEEOywf13xhar7/azWdw8sJPJ
	YuXqo0wW71rPsVgc/f+WzWLSoWuMFntvaVvMX/aU3eLQ5GYmB06Py2dLPTat6mTz2Lyk3mP3
	zQY2j/f7rrJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bCllNMBQ/4Kjr3WjQw3uTuYuTk
	kBAwkZg7ZS9bFyMXh5DAbkaJj/fXsEAkxCWar/1gh7CFJVb+e84OUfSRUeLs1AWMXYwcHGwC
	mhIXJpeC1IgImEksPQzSy8XBLLCZUeLT6WPMIAlhAXeJly/Wgg1lEVCVuDxtLhOIzStgIbH+
	5z9miAXyEjMvfWeHiAtKnJz5BKyeGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDM
	Sy3XK07MLS7NS9dLzs/dxAgOYy3NHYzbV33QO8TIxMF4iFGCg1lJhPfGnT9JQrwpiZVVqUX5
	8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDFr3bSnFI/Pcn9fen+4/0R
	CSwJ8ya0txbdmT1hs882669H7Pc1/1j9JXmXY6RarOKr/VcfvTJdYdVsrVX4/9wt683Kl0/u
	vlhreG9Xy70kzfiGO0/3L81cUZnD6bzzbe6ls3EWH/i4z8mlNKbMfsJ5nbWIW9A/Vyx83fFy
	+R+u5U6JF09ejJq28hVb2iXR6Puc0mZz9l06fvVVienbX8kHL2kJfu76ND17Euex+MNsaSLy
	+5fafBOcY1uWan3eaO2O6h32p9jjw5daPZL0in15NukzC8uljP9amyu41De6H3Kazanz/Utl
	+/TLn9eubFa53bcmhp0pO/wRM+MqK/0JMT9YbUKYTJafcrr0RPKeEktxRqKhFnNRcSIA9ppL
	BNICAAA=
X-CMS-MailID: 20220820031700epcas5p3b9a08cb9d15344e5a5d978b1dac81da1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220820031700epcas5p3b9a08cb9d15344e5a5d978b1dac81da1
References: <CGME20220820031700epcas5p3b9a08cb9d15344e5a5d978b1dac81da1@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_201716_109546_FA742020 
X-CRM114-Status: GOOD (  12.88  )
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
buffers. This series adds new fixed-buffer variant of uring command
IORING_OP_URING_CMD_FIXED, and plumbs nvme passthrough to work with
that.

Patch 1, 3 = prep/infrastructure
Patch 2 = expand io_uring command to use registered-buffers
Patch 4 = expand nvme passthrough to use registered-buffers

Using registered-buffers showed 9-12% IOPS gain in my setup.
QD   Without     With
8     853        928
32    1370       1528
128   1505       1631

This series is prepared on top of:
for-next + iopoll-passthru series [1] + passthru optimization series [2].
A unified branch with all that is present here:
https://github.com/OpenMPDK/linux/commits/feat/pt_fixedbufs_v1

Fio that can use IORING_OP_URING_CMD_FIXED (on specifying fixedbufs=1)
is here -
https://github.com/joshkan/fio/commit/300f1187f75aaf2c502c180041943c340670d0ac

Changes since v1:
- Fix a naming issue for an exported helper

[1] https://lore.kernel.org/linux-block/20220807183607.352351-1-joshi.k@samsung.com/
[2] https://lore.kernel.org/linux-block/20220806152004.382170-1-axboe@kernel.dk/

Anuj Gupta (2):
  io_uring: introduce io_uring_cmd_import_fixed
  io_uring: introduce fixed buffer support for io_uring_cmd

Kanchan Joshi (2):
  block: add helper to map bvec iterator for passthrough
  nvme: wire up fixed buffer support for nvme passthrough

 block/blk-map.c               | 71 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c     | 38 +++++++++++++------
 include/linux/blk-mq.h        |  1 +
 include/linux/io_uring.h      | 10 +++++
 include/uapi/linux/io_uring.h |  1 +
 io_uring/opdef.c              | 10 +++++
 io_uring/rw.c                 |  3 +-
 io_uring/uring_cmd.c          | 26 +++++++++++++
 8 files changed, 147 insertions(+), 13 deletions(-)

-- 
2.25.1


