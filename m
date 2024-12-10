Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43392E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j69dy3M5ikTE//d6tI8ihqoDhVwaJ6AQXRqhtTcnqsQ=; b=GU+DiLm2TbtjME1oVb67xEtFs/
	XWMlLbZ+IBBnqRxUPPHjQe9Nr8mUkpVQAo1k271aipdCJaUJkyoIJSjomxoL/jDTJzTQcGuSpZMDA
	vTytlodYgKFnD/zUdkgMXzSuEqtfN9L1YpBWXzNHnkiHaHMGZXyjOb0iXne4qd0O5K+4wc+UstwGF
	l2zKcj+e/lOA0Y1PkfLQZ50URU10vFO6NGycHsVivXpG4MA2VxN8bFu2nYJPMloo2nBdaDw+0s4Pi
	Q/7JOTXiKipNVYQNAUqSIeF11i8AWfv8dzULWKo4V9BRGykHBLNS3k1r9kZzT4iejvQ88PoUke4Gi
	4UgVMhNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzOM-0000000BQta-2xlP;
	Tue, 10 Dec 2024 12:31:06 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzOK-0000000BQqM-10ZQ
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 12:31:05 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241210123059epoutp01c4cc7a010b14c69c05469c24f4aa0208~P0LV1_KzN2555925559epoutp01h
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241210123059epoutp01c4cc7a010b14c69c05469c24f4aa0208~P0LV1_KzN2555925559epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733833859;
	bh=j69dy3M5ikTE//d6tI8ihqoDhVwaJ6AQXRqhtTcnqsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gLNDgHMmw9JfCoMPDo9fkgnBhMM+wm9BS/3HDU3VTCxzbRMmnzfRqWvWN6wET3m8X
	 qio010gbu1hnGDXG2Rwv0p0NDJ4YD8DGqe1uZazm3L4mPrZm9Sniu7Nkrjc8FSKjFF
	 a4Xb/g8IBOe6AIOiFVezvCND80jhO5Fk9YKmoopk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241210123059epcas5p1f21325970a2e5f0ee46e634940a61eca~P0LVkgdrx2573525735epcas5p1y;
	Tue, 10 Dec 2024 12:30:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6ykn69RQz4x9Pw; Tue, 10 Dec
	2024 12:30:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.27.20052.18438576; Tue, 10 Dec 2024 21:30:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241210122702epcas5p4fe3ed43ad714c6b467a35d16135d07c5~P0H5MsXss2989829898epcas5p4r;
	Tue, 10 Dec 2024 12:27:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210122702epsmtrp117ac9d0e2713d79ac8e3a26246e38059~P0H5LddE30784007840epsmtrp1f;
	Tue, 10 Dec 2024 12:27:02 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-59-67583481f1ff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.E0.18949.69338576; Tue, 10 Dec 2024 21:27:02 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210122700epsmtip25f7adffc1f9808a8bc1fef9bc49f07ee~P0H3ZHAyj0608306083epsmtip2a;
	Tue, 10 Dec 2024 12:27:00 +0000 (GMT)
Date: Tue, 10 Dec 2024 17:49:06 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 10/12] nvme.h: add FDP definitions
Message-ID: <20241210121857.tbrbg4cucape5cja@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-11-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmlm6jSUS6QctPHYumCX+ZLeas2sZo
	sfpuP5vFytVHmSzetZ5jsTj6/y2bxaRD1xgtzlxdyGKx95a2xZ69J1ks5i97ym6x7vV7Fgce
	j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HN49zFCo++LasYPT5vkgvgjMq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6V0mhLDGnFCgUkFhc
	rKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfFm7UfWgrls
	FS37T7M2MO5m7WLk4JAQMJG48d6ji5GLQ0hgN6PEuUf/WSGcT4wSD/+sZOxi5ARyvjFKrJpo
	BmKDNMz+sYAdIr6XUeLtEimIhieMEk033rGBTGURUJU4faQCxGQT0JY4/Z8DpFxEQFHiPDAY
	QMqZBSYySfw+1MQOUiMsYCnR1FUPUsMLNH7Jo7PsELagxMmZT1hAbE4Bc4mzt6eA9UoIrOWQ
	+HxrGiPEPS4Sc9etZYewhSVeHd8CZUtJvOxvg7LLJVZOWQHV3MIoMev6LKhme4nWU/3MIDaz
	QIbEil9TmSDishJTT61jgojzSfT+fgIV55XYMQ/GVpZYs34BG4QtKXHteyOU7SHR33qbBRIo
	2xgl9l38xzaBUW4Wko9mIdkHYVtJdH5oYp0FDAxmAWmJ5f84IExNifW79Bcwsq5ilEwtKM5N
	Ty02LTDMSy2HR3Fyfu4mRnAC1vLcwXj3wQe9Q4xMHIyHGCU4mJVEeDm8Q9OFeFMSK6tSi/Lj
	i0pzUosPMZoC42cis5Rocj4wB+SVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBa
	BNPHxMEp1cC0ae8tPsVTlSwrF53VcCu+nhX66fm65GMZ970cDdjsxGodfc4faTo9J5L3M6f1
	e7dl/o9+FvbffHV7V4SIaZlQ9g7Hy12ylctflH/uLjrR3TtF/mEMp9qcIF1/rgqtR7tezb+k
	dVk7M3CR2cyJmd5hOwu5tW5o7/1uHHdC7e6qyktRc7wP77I0KnvzfnXCjwvKr/ZMPVq3ZAWX
	wLLM2EuKFzc+X/gmkfdHQtLqJfESr1479uvV8PEJqthdu8tw0iqe6dCdwCd7cye8XXNcX8X7
	b6HK7BTH81Gmpnp3VGZ5dLFv5o5Qlfnxnz/wuUPYkzuFdZkLA6/0ajtFl4idC827ovF+Gbd9
	Kpu64oQzfBZKLMUZiYZazEXFiQAXCRY7SQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO4044h0g5nbRC2aJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AM4rLJiU1J7Ms
	tUjfLoEr4/T1XvaC88wVd79fZ2xgbGfuYuTkkBAwkZj9YwF7FyMXh5DAbkaJxf8OsEEkJCWW
	/T0CVSQssfLfc6iiR4wSB/Z9Y+1i5OBgEVCVOH2kAsRkE9CWOP2fA6RcREBR4jzQNSDlzAKT
	mSSezzzGAlIjLGAp0dRVD1LDC7R3yaOz7CC2kECSxNrVBxgh4oISJ2c+YQGxmQXMJOZtfsgM
	0sosIC2x/B/YeE4Bc4mzt6ewTWAUmIWkYxaSjlkIHQsYmVcxSqYWFOem5xYbFhjlpZbrFSfm
	Fpfmpesl5+duYgRHjpbWDsY9qz7oHWJk4mA8xCjBwawkwsvhHZouxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUAxOPePDaQ3xr3/ObbSwvOenIsDXz5F/F
	I69Wti3yeus3/03xkqgjidwfrf5vs5jrLKMRH7n/ZPA/9Y9/f36/Yc660+VeqPwu5+Q17C/u
	8W6SD2TdJvhmZV/TjUdrp7MfP+nN1+GSN19YhldkcqhNz7I39Rnmc+68E9+syP5ZVnGdWn72
	qbef5s+coLdBcI/tyRa/FQwbt2XLiQekbV9/k5nHfnqFYqRtQZZqvM01B0/JT64p+w6734wN
	LLc2NGz6GpJmoHT3zYHVEq6XVLfmt1i3+PRLnv27XyS/yq3utN/BiSVLK8/Fd3OcVN4RzS2f
	WjZl1+NT6+/zFy5T/3bzUpPw7/yPe9N2L5t/U5+L6YYSS3FGoqEWc1FxIgCHbpTeCwMAAA==
X-CMS-MailID: 20241210122702epcas5p4fe3ed43ad714c6b467a35d16135d07c5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_72894_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210122702epcas5p4fe3ed43ad714c6b467a35d16135d07c5
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-11-kbusch@meta.com>
	<CGME20241210122702epcas5p4fe3ed43ad714c6b467a35d16135d07c5@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_043104_614979_3EFD433B 
X-CRM114-Status: GOOD (  12.00  )
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

------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_72894_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Add the config feature result, config log page, and management receive
>commands needed for FDP.
>
>Partially based on a patch from Kanchan Joshi <joshi.k@samsung.com>.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>[kbusch: renamed some fields to match spec]
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_72894_
Content-Type: text/plain; charset="utf-8"


------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_72894_--

