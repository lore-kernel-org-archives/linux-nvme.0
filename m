Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF22C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 05:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=U2jvav5Skiycxae/ouOkyBtgQokzLt/NegKOjhGmbAI=; b=pqfF4Qu6qxvHJXTmTQJaWWjkvN
	9O+rJYj/x8dU4tNOUVGj1kaMxG7WA2hXez/GZGiJABTbQyajOxtpNfUwsH7mdJMCev9zMLXhAvYHL
	sgLs9xqK8Ys8BcPrtvvjeiyZ4DuJTBK1kY4/4SNBiPglEuA/cfnw2ef3l4/Aw0CeOg3eNMe47Lb9R
	PLVCfC4nsOPkemzQoFLRVbctDSyyeqkBxLW6XAGoJS1zReACdu/OTqjzXOBd6PMAF8Vh69ePNfSTF
	U6ESxW+4UMLZ1XnuwKYiJNi47bgfmpjordIHWTnLt7T0II69oCACyr/Qmx47+mqsa1SaQJUsMFj12
	ftEZdZAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrvAP-00AbNt-1W; Fri, 20 May 2022 05:27:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrvAJ-00AbLL-DZ
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 05:27:10 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220520052654epoutp042ff7d3827d649cd84f21afc7e3b84619~wuPJYU_H51364113641epoutp04W
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:26:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220520052654epoutp042ff7d3827d649cd84f21afc7e3b84619~wuPJYU_H51364113641epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653024414;
 bh=U2jvav5Skiycxae/ouOkyBtgQokzLt/NegKOjhGmbAI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=oGJfGxahBUVvjwSQgdjlaXybib9aQLwA6UkLZm4peLZPntBwcm9p5VKUWGtIRQVwE
 5+iaIdUfqDuFqiqtMJDpD0cEwyg84mObOY5KQUMb8KCgmjGAQcl0ST/jkDT4jAuSk5
 gIRJceeVCuyshjFSZ4VDf0C+2PYKieUrcqXvNZDI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220520052654epcas5p16ab9287119a1f86e24d9efa49f291beb~wuPJLRZ090594305943epcas5p19;
 Fri, 20 May 2022 05:26:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4L4FZx4XSTz4x9QC; Fri, 20 May
 2022 05:26:49 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B5.49.09827.29627826; Fri, 20 May 2022 14:26:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f~wt4y-olPV3182231822epcas5p1p;
 Fri, 20 May 2022 05:01:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220520050118epsmtrp23577ea0e1d4f41721836877aa535dfdf~wt4y_740G1228012280epsmtrp2h;
 Fri, 20 May 2022 05:01:18 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-ca-62872692f4ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 9C.33.08924.E9027826; Fri, 20 May 2022 14:01:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520050117epsmtip17d5524ded1e5a522843f039e008c2438~wt4yAvwi33013030130epsmtip1h;
 Fri, 20 May 2022 05:01:17 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH v2 0/2] uring-passthrough for admin commands
Date: Fri, 20 May 2022 10:25:58 +0530
Message-Id: <20220520045600.3773-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmlu4ktfYkg/UfBCxW3+1ns7h5YCeT
 xcrVR5kszr89zGQx6dA1Rov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
 tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ
 2Rkr9+5iKpjGVnFyjW0D40eWLkZODgkBE4lHB04D2VwcQgK7GSXeTtnJCuF8YpT4ffU5I4Tz
 mVHiWdcBJpiWs2vamUFsIYFdjBIrPtvAFR3Z/QZoFgcHm4CmxIXJpSCmiICRxO23MSDlzAL+
 ElfW72MHsYUFbCSeTFvMBmKzCKhK9J//yApi8wqYS8yau4oRYpW8xMxL39kh4oISJ2c+YYGY
 Iy/RvHU2M8haCYFT7BKHdp0BWysh4CLxZwUvRK+wxKvjW9ghbCmJz+/2skHYyRKt2y+zQ5SX
 SCxZoA4Rtpe4uOcvE0iYGej49bv0IcKyElNPrWOC2Mon0fv7CTQQeCV2zIOxFSXuTXrKCmGL
 SzycsQTK9pBYeuYFM8hIIYFYiWNvdScwys9C8sssJL/MQli8gJF5FaNkakFxbnpqsWmBUV5q
 OTxKk/NzNzGCk6GW1w7Ghw8+6B1iZOJgPMQowcGsJMLLmNuSJMSbklhZlVqUH19UmpNafIjR
 FBjAE5mlRJPzgek4ryTe0MTSwMTMzMzE0tjMUEmcV+B/Y5KQQHpiSWp2ampBahFMHxMHp1QD
 08KwSs03x3bd7O1sjPRZrJGcwrJOQE7BIUnjzqRtgslHTeKLHZdtL/N3ea1UEbRtkm9W35Hl
 52LutBjf3cV2TSW/8tz2/4/jtgm7+aQcm3YtIyKr5vSBAvXbuxZ/2BnafetE1gWdlx9seGuz
 Fk00XVpndzdiSSfHymsOUZet5DZocrJtN0s7ovY/bMts6+kdny3Pb9qnYKeRzjadxXu5VL/q
 8jkVt44eaP76kMH/uFP1hnzO3fE5ygfmuTqJPb7dy6QS7rH73POKn7enNt48cWra4d0+W5Zx
 u8ccit751jidT0jdbdMTzbOe++/vcg6YFTLD+OUh5YLDeyrOadi6HbjVpnPd7rZOZJuBJP+1
 m0osxRmJhlrMRcWJAGgC7ewPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO48hfYkg85pwhar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxsq9u5gKprFVnFxj28D4kaWLkZNDQsBE4uyaduYuRi4OIYEdjBIL
 JrxihkiISzRf+8EOYQtLrPz3HMwWEvjIKHF7Z24XIwcHm4CmxIXJpSBhEQEziQUL5oHNZBYI
 lOjuuQ9mCwvYSDyZtpgNxGYRUJXoP/+RFcTmFTCXmDV3FSPEeHmJmZe+s0PEBSVOznwCNUde
 onnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHJ5aWjsY
 96z6oHeIkYmD8RCjBAezkggvY25LkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNL
 UrNTUwtSi2CyTBycUg1MRgmPzGKdejdZretOqlDoKlkUJrfmzyGdJWwiDn3vWr0Wi3wSMUh4
 pv6+eu3Nk3PkJrA1GbjMZF0V0/HyYa3enJOnFn5mjp52WeHg5gPvrPVUdP6HtsVxVGavmf5E
 kH/3I8v/UgaMEyaptnW7v9zL/C5Bp0qxL+j/pUarrLBAk3RWtfMxx5L3rsr1y0+5HXOpMKP9
 nMWpizOOBxis/WmruHXhqfO+nsE3J+qJTWZMPn7Z5/C71f9qjCzCj5xazP/zSMWBP1NNs2fI
 S7+dFuw18+KkKMfM2Zt2JR9Ou+Js7NfxLXPGbQuPe5MyfRjvFBv/vCmZsuzxxPQJJzVu5q3W
 /2S9kvdWqKtAfa32nUZRJZbijERDLeai4kQAfX7icr4CAAA=
X-CMS-MailID: 20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f
References: <CGME20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_222709_618981_5EDE70D4 
X-CRM114-Status: GOOD (  13.73  )
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

The series enables uring-passthrough for admin-commands.

Patch 1 is prep.
Patch 2 adds new opcode for admin uring-passthrough, and enables it on
nvme controller dev(/dev/nvmeX). It reuses the code of io-command
passthrough, with the only difference that commands are issued on admin
queue.

Changes since v1:
- drop the code that supports this op over ns char device
- apply reviewed-by tag

Kanchan Joshi (2):
  nvme: helper for uring-passthrough checks
  nvme: enable uring-passthrough for admin commands

 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/host/ioctl.c       | 44 +++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h        |  1 +
 include/uapi/linux/nvme_ioctl.h |  1 +
 4 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.25.1


