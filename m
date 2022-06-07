Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E30CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=SJS1t1LVzXVNWqR8oKKroV9amLFZSosstjvu4MqUUos=; b=DwxcE3bpoYg/DVyLrFELD97Ntn
	bBIwHpVLsG2ZnlNqFKiD1seasF0M80hFChRSLzvP63S90UfGk+X8oeYA83BhKGlojM0uOEZ8BsEaY
	cfHcvDpJMRj42Cfy+4uI4cX2Q1QuLJo2i/zFbcTkYPgqmZrzxCoUzwVr0JFfXnGWzVJI4W8MAjdP2
	MZc7er09q19Z5hapbHc+i3v+NIzDfepcGndjK0KmxuUKyn1OsBdqgntQrfAAvk8b5uBlKLLHavuHK
	se1CQ2uiRET+lhQP0Qit7io+jvaNbVaWRVWK4NTT/yX/6FD6NAGpDxOKEcdnBUQSDuhwOX8W6tcOr
	pC3OrGbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZUU-007pAG-JP; Tue, 07 Jun 2022 13:43:26 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZUR-007p8X-GR
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 13:43:25 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220607134310euoutp01b761a4b93a43a577132027ed81bc473c~2Wnllg6jy0627206272euoutp01Y
	for <linux-nvme@lists.infradead.org>; Tue,  7 Jun 2022 13:43:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220607134310euoutp01b761a4b93a43a577132027ed81bc473c~2Wnllg6jy0627206272euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1654609390;
	bh=SJS1t1LVzXVNWqR8oKKroV9amLFZSosstjvu4MqUUos=;
	h=From:To:CC:Subject:Date:References:From;
	b=UUo6/clg5dRodAUMCO+dvKoZaTaANuS9sqXk7gHnBPwUl1Yqs+V5knKlqp+wDvToq
	 23TAtth2kGqI7gSRzPgV3sU5F9K876vU/YLMkZiZPMN4G/FbgSuR3M37K4l5fO/W2E
	 WaVec1R/nl8rMSMOXTsU47fgML5k/axSKagEamPg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220607134310eucas1p23994a7057647ab7e0c7561779908867e~2WnlXuBl72050920509eucas1p2h;
	Tue,  7 Jun 2022 13:43:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.AF.10067.EE55F926; Tue,  7
	Jun 2022 14:43:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220607134309eucas1p1724cee80a5bc116c652e91422d474ccd~2Wnk7eTbl0904109041eucas1p1N;
	Tue,  7 Jun 2022 13:43:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220607134309eusmtrp2c63a8b97aadc6906919997a1e799ba29~2Wnk65EA61062510625eusmtrp2T;
	Tue,  7 Jun 2022 13:43:09 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-23-629f55ee1ce2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.9A.09095.DE55F926; Tue,  7
	Jun 2022 14:43:09 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220607134309eusmtip192a46c82c2c85701867601a6ccb69815~2WnkvUMFc0952109521eusmtip1t;
	Tue,  7 Jun 2022 13:43:09 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 7 Jun 2022 14:43:08 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <joshi.k@samsung.com>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: [PATCH v2 0/2] nvme: Enable generic interface (/dev/ngX) for
 unknown command sets
Date: Tue, 7 Jun 2022 15:40:53 +0200
Message-ID: <20220607134055.1742162-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djP87rvQucnGfybLWCxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjuKySUnNySxLLdK3S+DKaJ+5iLlgPUfFjMN3WBsY
	X7B1MXJySAiYSKzY8o4FxBYSWMEoMfe3SRcjF5D9hVHi+Zw2VgjnM6NE1+5HcB1nN55ngUgs
	Z5TY2jWVGa5q55fjbBDOJkaJq9/mM4G0sAnoSJx/cweoioNDREBVYl+LLYjJLJArcWKeD0iF
	sECMxNd7q8AWsAioSOw8dogJpIRXwFbiUZ82xF55ibbr0xkhOjUl1u/SBwnzCghKnJz5BOwB
	ZqCS5q2zmSHKFSW2zPnOCmHXSqw9doYd5DAJgaUcErOXPoJKuEh87WmCahCWeHV8CzuELSPx
	fyfE8RIC2RI7p+yCqimQmHVyKhvIDRIC1hJ9Z3Igwo4SR7q3skCE+SRuvBWEOIdPYtK26cwQ
	YV6JjjYhiGo1iR1NWxknMCrPQvhlFpJfZiH5ZQEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS9
	5PzcTYzANHH63/EvOxiXv/qod4iRiYPxEKMEB7OSCK//5LlJQrwpiZVVqUX58UWlOanFhxil
	OViUxHmTMzckCgmkJ5akZqemFqQWwWSZODilGpgWFPNHHth++/Dug+yHot7EdK1PvaEhahT9
	8pPkt8k3Vv1/t+1ilFDQvsgpGR/5SiRjD+tNMklNujd7ixXjy9W+b+N/uqeEMSfxmtlnfuVu
	vVcWlj5f8Gj/Zdt7vxsKdc4t+3Eq9oHUpqrip/lJv9oM6mS7doiw6vt89jl3sd9Q+rmLu5tf
	nGT43PWJ0gHT2WdeydUvFneP67b9H2127EI4a/OuOSe3PaqXMY/gET6SID/936Hq33PDN0zI
	6nP9vvMN+79fmZPfFX2SeKta+dguR1wgVEtIzK6UZZX39PSyWveXXhwsWY9Lfuj6H1Ke/e//
	zwc2nAX8N//WJ74zLzw2f23vqyePij+FHHzyb4cSS3FGoqEWc1FxIgBX+2tVggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Xd23ofOTDGZe0bZYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehltM9cxFywnqNixuE7rA2ML9i6GDk5JARMJM5uPM/SxcjF
	ISSwlFHi1J65rBAJGYlPVz6yQ9jCEn+udbFBFH1klHj1/ByUs4lR4sPaG0wgVWwCOhLn39xh
	7mLk4BARUJXY12ILYjIL5EqcmOcDUiEsECWxaMkXFhCbRUBFYuexQ0wgJbwCthKP+rQhVslL
	tF2fzgjRqSmxfpc+SJhXQFDi5MwnYJ3MQCXNW2czQ5QrSmyZ8x3q4lqJV/d3M05gFJqF0D0L
	SfcsJN0LGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbGtmM/N+9gnPfqo94hRiYOxkOM
	EhzMSiK8/pPnJgnxpiRWVqUW5ccXleakFh9iNAV6ZiKzlGhyPjA280riDc0MTA1NzCwNTC3N
	jJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamJZsrjoTpJB0xbeb3XfOekPPgiXa55qnqK0P
	8y/lC/2j8f/azD1KTDevq6fp/nhwuKLqualq0xSft/Md1eJvHddtqDN+alffde3wgd+CcUf/
	3eDanSiscD6f0SxQcIXvHf6vRy2OiW54IjAr2iHzx5NnRrFz7zwoem/mW9MbYhK9SnvP+u4j
	F3iXrNu/KWhGy6mAeNXej6bz2SJNjzetEIrMm9P93f+97W3XZf9LrETtxMI4eyf634q53x00
	ifPm6RN3dXSkUvrPz7wd7zRLcvIVh4DGaAaLkxZWnsU2M14Vr4na/uZ0/cHwNMnIm9sDkmt+
	VOemM32VPPfCqOb271Xr+tmY5q+dtnDJ607zu0osxRmJhlrMRcWJACHDz4QVAwAA
X-CMS-MailID: 20220607134309eucas1p1724cee80a5bc116c652e91422d474ccd
X-Msg-Generator: CA
X-RootMTR: 20220607134309eucas1p1724cee80a5bc116c652e91422d474ccd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220607134309eucas1p1724cee80a5bc116c652e91422d474ccd
References: <CGME20220607134309eucas1p1724cee80a5bc116c652e91422d474ccd@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_064324_009013_DBC8E108 
X-CRM114-Status: GOOD (  11.97  )
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

Currently block and char interface do not show up for any command set other than
NVM and ZNS. This series enables char interface to come up for unknown command sets.

Patch 1: Is prep. It allows the re-use of nvme_mpath_add_disk for
supported as well as independent command sets.

Patch 2: The following functions become aware of whether the command set is
independent or not: nvme_alloc_ns and nvme_validate_ns. A boolean is
introduced in each of them to call the relevant helper to identify and
update the namespaces.  nvme_update_ns_info_cs_indep is added to update
command set independent devices.

Changes since v1:
- Use command-set independent id-ns to enable unknown command-sets

Joel Granados (2):
  nvme-multipath: refactor nvme_mpath_add_disk
  nvme: enable generic interface (/dev/ngXnY) for unknown command sets

 drivers/nvme/host/core.c      | 83 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/multipath.c |  7 +--
 drivers/nvme/host/nvme.h      |  5 +--
 3 files changed, 78 insertions(+), 17 deletions(-)

-- 
2.30.2


