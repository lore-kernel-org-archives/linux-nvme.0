Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B293DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T7p11mktPd3ldv5kFR3YCNbHjkbt838d3Yrs/XxX9D4=; b=BAm5B8LOynOX2aaok3oRavJApr
	vH1W5q4+KQQBHi15od5KR+COvwJ5z4mkEOhaLIQFRvJ0aenaJWdQUoRBDH1dAiYarWenq4ihxDSwP
	aTbCooE6bwz2ExoFkT8saOFqTddO3KBAcMzxGg0ZBkm6UAhlTh80AS4/Awp+cFJvbohFFo491cz8W
	EVInDjz6csDvGNa9BeXdTCqaKyyRjjxv8ESFRjc/BG/QmNy/GE9dCSzJa1FhQttyK2AN/SHET/POC
	ffkO/+SDCszONJ5HzG5ZJG+Bkg5HtsT6GlYwldna93QXRhAKeaESlSwnCQQJD7sMHR4FO4+0/YS+P
	8ownXXHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7u6Y-00Bw3U-H8; Wed, 21 Dec 2022 08:05:34 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7u44-00BuFU-53
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:03:02 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221221080254epoutp02ec9f100e447aa24f3459aa999eade5c0~ywDvGXfdi1014210142epoutp02Z
	for <linux-nvme@lists.infradead.org>; Wed, 21 Dec 2022 08:02:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221221080254epoutp02ec9f100e447aa24f3459aa999eade5c0~ywDvGXfdi1014210142epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1671609774;
	bh=T7p11mktPd3ldv5kFR3YCNbHjkbt838d3Yrs/XxX9D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVAbv+tQn7Qws+kegGM51srovlAtq6N2oEtVfzTDnTSG2ZTMmtWeZzp8rmXYMRWQE
	 5MY0qBXMjixlm413+pAAWtBJl5YHvH94+cBHpjEd5PT45CiHC0m+6MjKrwT3s8pwPD
	 hN4GcdapkQlPTyjE2tw9JxyFeUZ/AJq09wPR7dpA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221221080254epcas5p4adf59b49d8ead5554db7edc808766ee0~ywDu5h4M71465614656epcas5p4O;
	Wed, 21 Dec 2022 08:02:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4NcQsn2tzgz4x9QH; Wed, 21 Dec
	2022 08:02:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.32.02301.DADB2A36; Wed, 21 Dec 2022 17:02:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221221080252epcas5p39a32e27068824fd8fe8fa18268515c41~ywDtbzITf0500105001epcas5p3Y;
	Wed, 21 Dec 2022 08:02:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221221080252epsmtrp17fa0104210fa233e9ccab73bdcac0b72~ywDtbAEz81141611416epsmtrp1i;
	Wed, 21 Dec 2022 08:02:52 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-30-63a2bdadddf3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.6A.02211.CADB2A36; Wed, 21 Dec 2022 17:02:52 +0900 (KST)
Received: from green (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221221080251epsmtip2aaecb0e29dc12cecf63e9ed57ed672da~ywDsc23OK1344113441epsmtip2y;
	Wed, 21 Dec 2022 08:02:51 +0000 (GMT)
Date: Wed, 21 Dec 2022 13:32:49 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Keith
	Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: Fix mempool alloc size
Message-ID: <20221221080249.GA896@green>
MIME-Version: 1.0
In-Reply-To: <20221219185906.3595984-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXXft3kXJBq+f81usvtvPZrFy9VEm
	i0mHrjFanLm6kMVi/rKn7BbrXr9ncWDzOH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObx7mLFQFs
	Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKCmU
	JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
	M552r2AqWMpXsevbNKYGxn6eLkZODgkBE4mlTR3sXYxcHEICuxklmj6eZYNwPjFKbN17mxWk
	SkjgG6PErj+8MB3fPn5ngSjayyjx+N0GVgjnMaPEzKPtTCBVLAKqEps/tQPN5eBgE9CUuDC5
	FCQsIqAocR4YACD1zAKNjBJnVy8G2yAsYCrxfdlPRhCbV0BDYtL3rVC2oMTJmU9YQGxOAXOJ
	l6tXs4HYogLKEge2HWcCGSQh8JddYuPbdWwQ57lIvHt4ixXCFpZ4dXwLO4QtJfGyvw3KTpa4
	NPMcE4RdIvF4z0Eo216i9VQ/M4jNLJAh8W3GBzYIm0+i9/cTJpBnJAR4JTrahCDKFSXuTXoK
	tUpc4uGMJVC2h8Sid/+gwdjFKPHoyWbWCYxys5D8MwvJCgjbSqLzQxPrLKAVzALSEsv/cUCY
	mhLrd+kvYGRdxSiZWlCcm55abFpgmJdaDo/k5PzcTYzgdKnluYPx7oMPeocYmTgYDzFKcDAr
	ifBeOLIwWYg3JbGyKrUoP76oNCe1+BCjKTB+JjJLiSbnAxN2Xkm8oYmlgYmZmZmJpbGZoZI4
	b+rW+clCAumJJanZqakFqUUwfUwcnFINTC6awvLux0698lm0Y2G9GcsN7Uvr03oW3NsjlaCc
	O1UwPmW2s9mGzexG4hvSpCUYtO5Pav8Z++nUveYV3zKkS1q336tes0h5QUGkRmaYlXbBjI/d
	Dfmy5+ad8Lc4s1La8fFpzsUc+1xaviUdU3bcJMP6L2DRkiWP1Mrn/2hL6BaWKpgtoz3ReZ6W
	04pNkncfn5yvenNzfhGnZtQMZeY4n/Ll2/y7jh+b0MZz3OT68vu/Xq8wTc3+4Txtw+I3YZ+e
	6nwtjjKoTjnetYhzqmNUydJXL1pk1ZfwW1x86JDcVhf5ZcKp/SG/2Hcprbt1Rm5lpkzzjs0n
	m36dZFRxPWM37fMz2w1SqgkOm+8qBh5cVKnEUpyRaKjFXFScCAAa1iOrIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvO6avYuSDc4v07dYfbefzWLl6qNM
	FpMOXWO0OHN1IYvF/GVP2S3WvX7P4sDmcf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKwLY
	orhsUlJzMstSi/TtErgy7nReZCy4zl2xcWYDSwPjbc4uRk4OCQETiW8fv7N0MXJxCAnsZpR4
	tPkxM0RCXKL52g92CFtYYuW/5+wQRQ8ZJW5e6wJLsAioSmz+1A5kc3CwCWhKXJhcChIWEVCU
	OA90BYjNLNDIKHF4di6ILSxgKvF92U9GEJtXQENi0vetYLaQQBejxI1jIhBxQYmTM5+wQPSa
	Sczb/JAZZDyzgLTE8n8cIGFOAXOJl6tXg40XFVCWOLDtONMERsFZSLpnIemehdC9gJF5FaNk
	akFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcPBrae5g3L7qg94hRiYOxkOMEhzMSiK8F44s
	TBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSY41Y0oH
	g9jJdXbtCmVKCVOP/Xx/U23uhIMvTzSa+K/Ui/z8c/7F2i5FtRwLFaY55rmtl17qaTz6u+qI
	NPdkV+YvDy18HsxoFm6oztxzQdKoZWv8LUPV13dvGCl2LhVQuqvS8KXombDg/RkWWRsPXFH2
	Trfz01b6f1ng326BW9drxXdulY2+1GXM8yNAv7V47dffQht0PwW/3RG50Weyp+iRL/orH9kl
	Po7+uvLD48OLtDY3PJrGHXfh5HLGF3a/rYs/f/+keMnn96VZS7mWzHzWXrDowyfhQte7v+en
	pCu9czwUsfOw0x/+E6efTE/vYAo93Fm+b8Ji/761TYfWfv32ZusbEf1yzr2n/Vct89mvxFKc
	kWioxVxUnAgANfzeUu0CAAA=
X-CMS-MailID: 20221221080252epcas5p39a32e27068824fd8fe8fa18268515c41
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_4c540_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221219195515epcas5p200e1e1f3430ac6f494a66740bfb6a3b3
References: <CGME20221219195515epcas5p200e1e1f3430ac6f494a66740bfb6a3b3@epcas5p2.samsung.com>
	<20221219185906.3595984-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_000300_900946_C065459C 
X-CRM114-Status: GOOD (  16.81  )
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

------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_4c540_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Dec 19, 2022 at 10:59:06AM -0800, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Convert the max size to bytes to match the units of the divisor that
>calculates the worst-case number of PRP entries.
>
>The result is used to determine how many PRP Lists are required. The
>code was previously rounding this to 1 list, but we can require 2 in the
>worst case. In that scenario, the driver would corrupt memory beyond the
>size provided by the mempool.
>
>While unlikely to occur (you'd need a 4MB in exactly 127 phys segments
>on a queue that doesn't support SGLs), this memory corruption has been
>observed by kfence.
>
>Cc: Jens Axboe <axboe@kernel.dk>
>Fixes: 943e942e6266f ("nvme-pci: limit max IO size and segments to avoid high order allocations")
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/pci.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>index f0f8027644bbf..fa182fcd4c3e8 100644
>--- a/drivers/nvme/host/pci.c
>+++ b/drivers/nvme/host/pci.c
>@@ -380,8 +380,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>  */
> static int nvme_pci_npages_prp(void)
> {
>-	unsigned nprps = DIV_ROUND_UP(NVME_MAX_KB_SZ + NVME_CTRL_PAGE_SIZE,
>-				      NVME_CTRL_PAGE_SIZE);

Similar calculation is present in apple.c too.
Regardless, this looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_4c540_
Content-Type: text/plain; charset="utf-8"


------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_4c540_--

