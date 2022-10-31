Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62521ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=EvGNVZESWqfzC+BgQtiiCZ8Et+S3x52Rcl0K3wugwNQ=; b=QJrsH2TkFuTL+9OsIp/6jw0L8E
	vo9mqYCU8SGfrwWvRcSsbhbowi+6uvp9taiOC0duAp/SdDHAJIFCwjMYvc05Cmkj8BaLBr1F9Xzfq
	XVEJLUBc4i6aRikcf7hY/JmusBXwlu627nY0CgPjqP3gotE/wheQwYj2OL4vagRVEIOghQPywwBeV
	ZR1Edn/74m95fPv15128v5j3lf/KQ5ZTeXC3/s3GAPieMg/A1M5bFFKBxncexWRvHnfS/XQoLaOZU
	KZrxqU1Y3YUI7KK6NxeYkjQQ+gNAwUrRnJido37+7kKpy+UTqCKVF4xtVjMTnkMdrycEurOJQ8Z8+
	Exkwtv1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opXlG-00D0eZ-Tf; Mon, 31 Oct 2022 16:35:42 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opXlD-00D0dE-Bm
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 16:35:42 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221031163526epoutp0224f7fd5ad5634204a580b27d359f1f28~jNJraLi3e1290112901epoutp026
	for <linux-nvme@lists.infradead.org>; Mon, 31 Oct 2022 16:35:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221031163526epoutp0224f7fd5ad5634204a580b27d359f1f28~jNJraLi3e1290112901epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667234126;
	bh=EvGNVZESWqfzC+BgQtiiCZ8Et+S3x52Rcl0K3wugwNQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gtyA5gOSfaqXcGtzJVj9CWm9U6Xwi2I18LPcrmg5F6M9EohMfvb1PIRsqJi0wTto2
	 hNMpz3LKKdrIC5XQks0gnd8/2zBtJLsh2eaoploTCw2xa8JYSFTIdjZBdHDs1djrVV
	 2BDhnNdJqtcNsaXFYYjHIKCfeQbmxnQS5XVM0HYs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221031163526epcas5p2200b70bcc687cc8b2b4a8171ff198031~jNJrJqY8z0269702697epcas5p2v;
	Mon, 31 Oct 2022 16:35:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4N1Jfh1RfBz4x9Pr; Mon, 31 Oct
	2022 16:35:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.9C.39477.C49FF536; Tue,  1 Nov 2022 01:35:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221031163523epcas5p327b516ddab691c02d2e3ad2a80a7bdce~jNJohpBzv0789807898epcas5p39;
	Mon, 31 Oct 2022 16:35:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221031163523epsmtrp1645d07092b36e2fab5c99d89590271e4~jNJogz-iW2363923639epsmtrp1N;
	Mon, 31 Oct 2022 16:35:23 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-12-635ff94c7b08
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.56.18644.B49FF536; Tue,  1 Nov 2022 01:35:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221031163522epsmtip28f466b13d00b59b5592b330b0fd70611~jNJnRExeP2982529825epsmtip2w;
	Mon, 31 Oct 2022 16:35:22 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v4 0/2] Granular CAP_SYS_ADMIN
Date: Mon, 31 Oct 2022 21:53:49 +0530
Message-Id: <20221031162351.31856-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTXdfnZ3yywb+7HBar7/azWbw/+JjV
	4uaBnUwWK1cfZbI4+v8tm8WkQ9cYLeYve8puse71exYHDo/z9zayeFw+W+qxaVUnm8fmJfUe
	u282sHn0Nr9j8+jbsooxgD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
	MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5x
	aV66Xl5qiZWhgYGRKVBhQnZGR0dSQRdnRfPCZSwNjCvYuxg5OSQETCRmL73L3MXIxSEksJtR
	4vXFPjaQhJDAJ0aJEysiIBKfGSXOLjjPDNOx7HETO0RiF6PEy2dTWOCqdm9fBNTOwcEmoClx
	YXIpSIOIQKzEpY1rwdYxC8RL3Py7GWyDsICexKx3d1lAbBYBVYnT07aALeAVsJB4P/c91DJ5
	iZmXvrNDxAUlTs58wgIxR16ieetssLMlBO6xSzzctJYVosFF4sPDVjYIW1ji1fEtUH9KSbzs
	b4OykyUuzTzHBGGXSDzecxDKtpdoPdXPDHI/M9D963fpQ+zik+j9/YQJJCwhwCvR0SYEUa0o
	cW/SU6it4hIPZyxhhSjxkGjdmwQJw1iJGX/msUxglJuF5IFZSB6YhbBrASPzKkbJ1ILi3PTU
	YtMCo7zUcnhEJufnbmIEp0Utrx2MDx980DvEyMTBeIhRgoNZSYS3/mx0shBvSmJlVWpRfnxR
	aU5q8SFGU2CoTmSWEk3OBybmvJJ4QxNLAxMzMzMTS2MzQyVx3sUztJKFBNITS1KzU1MLUotg
	+pg4OKUamIpXFt4/YpKUuoDX3GyLIc/vu+b3Jp3bNXV9q2PJMt/7tSVTxOXj0zJebH4utTaj
	Nmi5xuaKTwI/Kpw+ZGt6Z826tzfovAbvt7lTH+ZUpNxYVnpHPlQhaaqadnzx9ee3Dy7P0s9V
	3bXRQ37KrG6jX7OWT/1d1jmbi+mRv71tw/63yZ9UvA/uPFf6z7n6zzbpB+/KNk67Hfjquejx
	JUYyV28ozu7NlcvizzufLtjX0s+R9T4sblbPVndXHbcZLGbLpsYs1WLIbTXzuSbrfOTE+W8h
	hecimi6rq4fyTTFSlTwdYRFsUDgjV9pIL/Bnxc6F/47w/lqgGMTZulquIrV4UZuIlMiNRq0J
	L8rsit6zKrEUZyQaajEXFScCAMyUaskUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvK73z/hkgxNn5CxW3+1ns3h/8DGr
	xc0DO5ksVq4+ymRx9P9bNotJh64xWsxf9pTdYt3r9ywOHB7n721k8bh8ttRj06pONo/NS+o9
	dt9sYPPobX7H5tG3ZRVjAHsUl01Kak5mWWqRvl0CV0ZHR1JBF2dF88JlLA2MK9i7GDk5JARM
	JJY9bgKyuTiEBHYwStxafQUqIS7RfO0HlC0ssfLfc6iij4wSkx93MXUxcnCwCWhKXJhcClIj
	IpAscWr7JyYQm1kgUeL90cesILawgJ7ErHd3WUBsFgFVidPTtjCD2LwCFhLv575nhpgvLzHz
	0nd2iLigxMmZT1gg5shLNG+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
	89L1kvNzNzGCw1dLawfjnlUf9A4xMnEwHmKU4GBWEuGtPxudLMSbklhZlVqUH19UmpNafIhR
	moNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTiYwc2SL5SIMfLJNOfD5sE3DxrHCq36RE
	TnZvFru7kSlthR/LutZ655lt7Du13Yv/yWbptRku/tdao0KXZOT785Te2K1oPzekejpX6405
	LToLL/t2f9zy2l3q8XWJ/Wsi1+vp898K2ta419Akvm7tNpbHpSynNNcnR9V/Umc/9kctNWn9
	tgvTZqm5vvrPsjknwi62I3HGFKNdH90dg91lFscd2neY/3SIyb3MX9MnPK++ushV8fSttbIV
	txTnL7oUuuusQ0tYEGNXQsCSM6usC7p4VLnDChvu7rkgzv7Ibbec7U/JS0xJjtM8DxiyT9RV
	aZimGMHyXbg5kelw+mQOna70fsmtBY1+etvtNyqxFGckGmoxFxUnAgCsagyDzgIAAA==
X-CMS-MailID: 20221031163523epcas5p327b516ddab691c02d2e3ad2a80a7bdce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221031163523epcas5p327b516ddab691c02d2e3ad2a80a7bdce
References: <CGME20221031163523epcas5p327b516ddab691c02d2e3ad2a80a7bdce@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_093539_736786_BA748AC2 
X-CRM114-Status: GOOD (  11.77  )
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

The series enables general access for passthrough IO if sysadmin wants
so.

Patch 1: for io commands. It implements the shift to file-mode based
policy.
Patch 2: allows identify-namespace command (based on ALPSS feedback).

Changes since v3:
================
- Patch 2: remove two comments (Chaitanya)
- collect reviewed-by

Changes since v2:
================
- Add patch 2 that allows identify-ns
- Patch 1: Move nvme_cmd_allowed check further down, so that we can use CNS
  values for decision making in patch 2
- Patch 1: invert if condition (Sagi)

Changes since v1:
================
- Move nvme_cmd_allowed check at a place that allows using nvme_is_write
  helper (hch)
- Keep everything into single patch (chaitanya, hch)
- Comments cleanup (hch, chaitanya)
- Part of cover-letter moved to commit-description


Kanchan Joshi (2):
  nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
  nvme: identify-namespace without CAP_SYS_ADMIN

 drivers/nvme/host/ioctl.c | 105 ++++++++++++++++++++++++++------------
 include/linux/nvme.h      |   1 +
 2 files changed, 73 insertions(+), 33 deletions(-)

-- 
2.25.1


