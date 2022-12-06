Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35004C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 06:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRkdxDKfaxTkF+MyXVmuWuX1mS3ATnAd+MKPKnTYZR0=; b=LeifFWyHrTg4mCh9CSwL0eiTOk
	xN4jP6o1t7hlGiU03U9340kN/JZ5B3+J8mV+Hjzk+X5L/tdVwdSsqlbXYF3VTEwiZjJ1/32CxcpoV
	kChKm4I7lAStU8YtPIxl5Z2X+EiFP3O9TXb1UzfNaDU6xZre6Os0HXSe2jsC1JZOI86megXO/2jbb
	nMOuz99BHbHCMZ00E4Jn0VIxqrZeZWVWxRDo5yjNxnGlaMCa4jS5ZAQoafcMRTprtS/mkxJWX9JG5
	lL5xxeSkIVBNZbLOINTL+2/vN2ksslt6TXb/90MpLVzC/ibxAw79uKSPSzYcn/ZCNVWPpIFk71xMl
	BD/LaI/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2RAY-001nNx-67; Tue, 06 Dec 2022 06:11:06 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2RAU-001nDf-5U
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 06:11:04 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221206061056epoutp04ebdebdaef13e49993234dec375d4d0d9~uH2sYMhX71690016900epoutp04g
	for <linux-nvme@lists.infradead.org>; Tue,  6 Dec 2022 06:10:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221206061056epoutp04ebdebdaef13e49993234dec375d4d0d9~uH2sYMhX71690016900epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670307056;
	bh=YRkdxDKfaxTkF+MyXVmuWuX1mS3ATnAd+MKPKnTYZR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtpSUKyBfp+Zres+geyV3LXQyPK7Ek+dbJaBSGU0wvcm1XBMimEOTEB7cD0uJ0opC
	 7fxsoEML8V32GYOAv2Fg4JqtNgOtDnWvCrdoCq3CwRWw3Fb8GHdwu92Ey24wT+4PL8
	 fUUc/5zBson5g089bZc8HW+EMTH+cSUTQrgW5fWk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20221206061056epcas5p3735ebef6999a44ae080d4d25dd843b1e~uH2r62DCc2381023810epcas5p3D;
	Tue,  6 Dec 2022 06:10:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4NR95V71Ctz4x9QC; Tue,  6 Dec
	2022 06:10:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.18.01710.DECDE836; Tue,  6 Dec 2022 15:10:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221206061052epcas5p307bc1fe7ac01651a113342f758d6d248~uH2op1Ab82634126341epcas5p35;
	Tue,  6 Dec 2022 06:10:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221206061052epsmtrp10586b33e59641aebc957d334dfd2e9d2~uH2ooyEOD1016110161epsmtrp1_;
	Tue,  6 Dec 2022 06:10:52 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-60-638edced2705
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.0E.18644.CECDE836; Tue,  6 Dec 2022 15:10:52 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221206061051epsmtip1e8e423e99f03478673032f0e614d3dec~uH2nW3VER0130401304epsmtip1C;
	Tue,  6 Dec 2022 06:10:51 +0000 (GMT)
Date: Tue, 6 Dec 2022 11:29:28 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: August Wikerfors <git@augustwikerfors.se>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
	<sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221206055928.GB24451@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221117031951.GB392@test-zns>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpu7bO33JBhueS1r833OMzWLCv0VM
	FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
	e+y+2cDm8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
	i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
	1BIrQwMDI1OgwoTsjE8b29gKLnJVvFz7n6mB8TNHFyMnh4SAicTOvxdZQGwhgd2MEvtvR3Qx
	cgHZnxgljq+5wQThfGaU2PD6KRtMx95dM1kgErsYJWbfncsO4TxjlFhz+DlYFYuAisTv8zdZ
	uxg5ONgENCUuTC4FCYsIKEk8fXWWEaSeWeA8o8TlZ8sZQRLCApESj1ZcZwKp5xXQlTj5Qx8k
	zCsgKHFy5hOw8zgFdCSa+pewgtiiAsoSB7YdZ4I4aCKHRMfMHAjbReLH4x6oQ4UlXh3fwg5h
	S0m87G+DspMlLs08B9VbIvF4z0Eo216i9VQ/M4jNLJAhMf/pfkYIm0+i9/cTsNMkBHglOtqE
	IMoVJe5NesoKYYtLPJyxBMr2kFj58iEbJEQvAMPnZ8YERrlZSL6ZhWQDhG0l0fmhiXUW0AZm
	AWmJ5f84IExNifW79Bcwsq5ilEwtKM5NTy02LTDMSy2Hx3Byfu4mRnD61PLcwXj3wQe9Q4xM
	HIyHGCU4mJVEeF9s7E0W4k1JrKxKLcqPLyrNSS0+xGgKjJyJzFKiyfnABJ5XEm9oYmlgYmZm
	ZmJpbGaoJM67dEpHspBAemJJanZqakFqEUwfEwenVAOT69SDO+Z+2Pj/YUjlPk72c9LmV2P0
	NjB/uFllW1B9guewQ4OlivXS/6oriiI9F3S8vdPI8f7yMemltx+bMvi/4rrHc+ttkL9JLH/h
	57UVz/iPBW8w/+adYH7jDfvPTUcPvORd/D2y45iykKzi6W8tUw4f+7lip+2hKzJ9i160PLSY
	M2XTzcWv4rQ+Tb0d+LP7trljUP7nlBCdG6zL/ZntO1leq6yWSAhYcyo3t+hWRdqWXx9eHnR4
	7NV27uMupTWXJ2VlPf85wU828/udZBX3PRfLejdnf+DY+JsnfJvg7aWHl9ptLtfamPRy9Vcv
	Wfs3X13eSaivujrHepWZ9ewa9seX/mWd65jlLXVCnfVNlocSS3FGoqEWc1FxIgBFzgsCKAQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO6bO33JBqeXK1v833OMzWLCv0VM
	FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
	e+y+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfGlLcrmQuaOSo6tjxka2Dcz9bFyMkhIWAisXfX
	TJYuRi4OIYEdjBJzdlxjhUiISzRf+8EOYQtLrPz3nB2i6AmjxPMVvWAJFgEVid/nbwI1cHCw
	CWhKXJhcChIWEVCSePrqLCNIPbPAeUaJm20rGUESwgKREo9WXGcCqecV0JU4+UMfYuYlRol9
	7yeDLeYVEJQ4OfMJC4jNLGAmMW/zQ2aQemYBaYnl/zhAwpwCOhJN/UvAykUFlCUObDvONIFR
	cBaS7llIumchdC9gZF7FKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcFVpaOxj3rPqg
	d4iRiYPxEKMEB7OSCO+Ljb3JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5N
	LUgtgskycXBKNTBdWfLO9qPM6ou20wJPsn1tbAjQXbmx/iDjP0/2hdIbHGImL1vwOOjnLtfv
	CpdtOT9qOISzy1+ueBnxYGJj5rbZ0k9+VG6+ejfk8zoXA5Eii7NH9t64Z8GtsfjmxWa1sA2B
	reH77ky9FDw7+cgdcbU3d2y+fV9/93E8m950mez8qzPO+/OnGb0+OP9mlPuFx3Y6S1P/nNLb
	8Xqv0vSyr6p1+y5dMnu/PHpnxapmc0YhP2V5+cyJJd9Ws3t7Sxj7bd3/+Zq7OGeGzxqteJF1
	nhe4nedGsOis+ND3SGPxzvylwkyr2Y8qtQeZ3SrdlJjHpxuY0/rAZM/E6MvBPnNd+cLKvi5x
	ChApKeyQYPsocnayEktxRqKhFnNRcSIALqB1gvkCAAA=
X-CMS-MailID: 20221206061052epcas5p307bc1fe7ac01651a113342f758d6d248
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vu1s6p.wgdQE3gZrnomxJkzeTvd9c8sIFt7LU8e8l4OokKPH=_1070a_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116172324epcas5p3d9877249797ac741ead5785cba27e00e
References: <20221116171727.4083-1-git@augustwikerfors.se>
	<CGME20221116172324epcas5p3d9877249797ac741ead5785cba27e00e@epcas5p3.samsung.com>
	<20221116171935.GA24524@lst.de> <20221117031951.GB392@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_221102_575281_385618EB 
X-CRM114-Status: GOOD (  14.80  )
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

------vu1s6p.wgdQE3gZrnomxJkzeTvd9c8sIFt7LU8e8l4OokKPH=_1070a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Nov 17, 2022 at 08:49:51AM +0530, Kanchan Joshi wrote:
>On Wed, Nov 16, 2022 at 06:19:35PM +0100, Christoph Hellwig wrote:
>>On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>>>The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
>>>reports eui as 0001000200030004 when resuming from s2idle, causing the
>>>device to be removed with this error in dmesg:
>>>
>>>nvme nvme0: identifiers changed for nsid 1
>>
>>What EUI did it report before? Is the identifier stable after
>>multiple resume cycles?
>>
>>Can some of the Samsung folks here reach out to the relevant firmware
>>team to see if they have any clues?
>
>I will check.

Took more time than I wanted. Firmware team mentioned that issue existed
in this firmware. This is fixed in new firmware, but bit of travel time
is involved when official release from OEM (Lenovo) comes out.

Hope the information is sufficient, and quirk can go in.

If required, 
Acked-by: Kanchan Joshi <joshi.k@samsung.com>

------vu1s6p.wgdQE3gZrnomxJkzeTvd9c8sIFt7LU8e8l4OokKPH=_1070a_
Content-Type: text/plain; charset="utf-8"


------vu1s6p.wgdQE3gZrnomxJkzeTvd9c8sIFt7LU8e8l4OokKPH=_1070a_--

