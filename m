Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2D2C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=cwzZKm5zx+2ilDUov07PX6hO9S
	NFieeeOiM8OGoCsIk9YPpk2nJrOVJGkcxsaiCj/KhOxdcIeLSMh5yPyKqe0NffmXhLemR5J4/w4OL
	FxESb/k7uBYxdNqo5VW7oJlbWgKrEoBNKUrWmZUr2iP7xlC+ICEAs1oM/kbnvpSm/D0h5uZTlQC2o
	5P3awjCqVca4GnlVFFDCiowBxvli8WISPAOCN7pWjogBB5Gl1JFk1iek8KfGKqkH3hdHtQHdGyw7U
	k+NrRVzO67O+D/KgasHb3C4VAhKEp7Sqzvd+011R6/nVa/wOfqVRBJSKntcurPfrU2CMiPeM8Sft7
	6QZ4yaNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqPk-0000000CaXq-0zFF;
	Tue, 13 May 2025 14:15:24 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqPh-0000000CaWa-0wlb
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 14:15:22 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250513141517epoutp04411af2f10867bf7327ead479976b17d8~-G8XnN-Qx0162701627epoutp04J
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:15:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250513141517epoutp04411af2f10867bf7327ead479976b17d8~-G8XnN-Qx0162701627epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747145717;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=YbNkpJi+TEMe1gszmPEJbZt4q1SW0Kqw8CDNQ6XcJE8B7J8UqKji2noezSqZDBkOP
	 sOYqq6NGzubhvqBbaVfiqXjUkiMCQQA18NA6Xo8DianF77wM7Gghq4lYMwguQTzQBK
	 +kCaY7MFU/zMKzn7hG6NqZK+ePXxKrJhmrXYBQ0E=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250513141516epcas5p2011233b980bdcf81bdca6e52bb160de3~-G8XFXEpW1296812968epcas5p2O
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:15:16 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4Zxdm400rWz2SSKY for
	<linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:15:16 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250513141515epcas5p2cff84c51b0c77d1e9b1bfd5247c68945~-G8V7dmRx2723327233epcas5p2Q
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:15:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250513141515epsmtrp28afdeafb8b306fd811af9ce1e0e72da5~-G8V66aRh2043520435epsmtrp2D
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:15:15 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-f1-682353f3c7d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.DF.08766.3F353286; Tue, 13 May 2025 23:15:15 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250513141515epsmtip193210d0f92c4abd79fe5369b6c6abab1~-G8VllSJU3209732097epsmtip1D
	for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 14:15:14 +0000 (GMT)
Message-ID: <4aca2aa4-3f94-49f8-9f69-b6e423abe1d8@samsung.com>
Date: Tue, 13 May 2025 19:45:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] nvme-pci: remove struct nvme_descriptor
To: linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250513070025.830930-4-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO7nYOUMg8bX4hbzlz1ld2D02Lyk
	PoAxissmJTUnsyy1SN8ugSvj1I6lTAVGFdfm9jE1MOp2MXJySAiYSHyd8Yi9i5GLQ0hgN6PE
	oUmX2CES4hLN135A2cISK/89hyqawCTx8u5tRpAEr4CdRO+snawgNouAqsSBd9fYIeKCEidn
	PmEBsUUF5CXu35oBFhcWcJBY3tMDFhcRUJL4u76JBWLoakaJOZNXgBUxA22+9WQ+E4jNJmAu
	sX3eGeYuRg4OTgFDiV/TQyBKzCS6tnYxQtjyEtvfzmGewCg4C8nqWUgmzULSMgtJywJGllWM
	kqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFhq6W5g3H7qg96hxiZOBgPMUpwMCuJ8DZu
	V8wQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwBTz/SxD
	+Hk1TwY+ceYj3qu82vYJezT/sX1sdm2xO1es3AodgT0cm42N/zDyT73xwTReh32fBscF5V/X
	Ta1XWTnd6fpZ/HnFzdRurts9z6Ysctx+J06I55HWo0tHNqkrnvxv3N85RYEl9e6M3LU3vyyc
	omN/qavkj+OVRssV02t6pgrt9RC9pyUYKvv107QNx0RuCSipS0Tyiauq2nVNKjmglHVpyTvj
	ehPPA+ckduR9PXdZuE0vyIvjmAbn3ct5odkLP+qemKuQq9fYruim8Ha2zaXUvjkSaz4nevSF
	ZR7RCdjwzbP8qlVFmdT+/18qvpgXftk9cXeIi5beE4O1IbtkzXcJ8f5/LJyWsmWRqxJLcUai
	oRZzUXEiAFJ9FFzKAgAA
X-CMS-MailID: 20250513141515epcas5p2cff84c51b0c77d1e9b1bfd5247c68945
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250513070153epcas5p15cfb0b9d1605c4e16077f7313cec13cd
References: <20250513070025.830930-1-hch@lst.de>
	<CGME20250513070153epcas5p15cfb0b9d1605c4e16077f7313cec13cd@epcas5p1.samsung.com>
	<20250513070025.830930-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_071521_579550_CC2EC6D5 
X-CRM114-Status: UNSURE (   7.13  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

