Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392C6E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jf6RR1wyL7cSFxlP+gH0K4rrWGr5M9xsf5Xc2ZIQ/KM=; b=m1iSBiXt8YY+71MLc9py+zGVTO
	BJa87Qi1ZkDPRjtsBAH/Ao/xNCOqLeUcNTf1MmGlPgu6zD5A9/eutq+d0o4rPmCDguwEFWN+8a+92
	EPtzJKm9uI+/DzRq4Lj0E4+Ry2RyhC+PU69omIYbACPTw1kUaN/I4kV2vqB0iy+J2/8PqyXmuQcvf
	E7cV2Llg1q5hJCqgn+yn6QWiLe4ABsCwsQmjBFuzlrRGbMK4gtoSAqQn69LXXwI91npPJyyzB9S8M
	L5A3TUxa0tjliJ8WNPtcWfsWPWOVR+JaVeqTxccK7JyhMzQiLTGnVr3DFGKlRoNqwkxKvhBMz9QQd
	ftQKN+hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcOC-00000007aZz-45x6;
	Mon, 09 Dec 2024 11:57:24 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcKa-00000007ZZG-1Rfd
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 11:53:42 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241209115334epoutp04bbf30544270e7b3864aa68be3b2ebb3e~PgBY-MVGK1734017340epoutp04t
	for <linux-nvme@lists.infradead.org>; Mon,  9 Dec 2024 11:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241209115334epoutp04bbf30544270e7b3864aa68be3b2ebb3e~PgBY-MVGK1734017340epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733745214;
	bh=Jf6RR1wyL7cSFxlP+gH0K4rrWGr5M9xsf5Xc2ZIQ/KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAGYVSiwlPtK8kzY9cwDnTTYg97UXTGq0mTsToNdp/Lagm+5sOd3aKaZzy+iY1DSW
	 iBVPKib1PtZhJGB1+Z+WOE7+kfC9jq0/LYxul8+vF8Oh5aXzKzt1uHKIpmi8aQb48m
	 XlqX28rCeqUNkl7FsvcaWeO/bpFcyCrxKVih/Fqo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241209115333epcas5p40f448843a266ce02580fa5e010d649c9~PgBYaLeIm1606116061epcas5p47;
	Mon,  9 Dec 2024 11:53:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6Ky43hGGz4x9Pt; Mon,  9 Dec
	2024 11:53:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.CC.19956.C3AD6576; Mon,  9 Dec 2024 20:53:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241209115219epcas5p4cfc217e25d977cd87025a4284ba0436c~PgATXdfpK1570815708epcas5p4g;
	Mon,  9 Dec 2024 11:52:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241209115219epsmtrp27c6990355d5a9d97ad26f2b836f2b423~PgATWv7ia1354313543epsmtrp2N;
	Mon,  9 Dec 2024 11:52:19 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-0f-6756da3cb892
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.38.33707.3F9D6576; Mon,  9 Dec 2024 20:52:19 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241209115217epsmtip2f106b1cebc44bf6bc01e8626896f15c4~PgARi5_Ao1272312723epsmtip2j;
	Mon,  9 Dec 2024 11:52:17 +0000 (GMT)
Date: Mon, 9 Dec 2024 17:14:25 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 01/12] fs: add write stream information to statx
Message-ID: <20241209114425.7tvdnvfsn4h6jqeg@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-2-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhq7NrbB0g5kHJCyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AMyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbkK0/ZCtrY
	K/a+eMPYwPiXtYuRk0NCwERi5ranTCC2kMBuRok174Mh7E+MElfP1HUxckHYu65tYuxi5ABr
	OPeMHyK+k1Fi5uG5zBDOE0aJ/ccXMoJ0swioSFzds4EJpIFNQFvi9H8OkLCIgKLEeWA4gNQz
	C0xkkvh9qIkdJCEs4C6x58xjsIt4gRZ8mzsfyhaUODnzCQuIzSlgJrH+7DV2kGYJgaUcEic/
	LmCCeMFFovfCemYIW1ji1fEt7BC2lMTnd3vZIOxyiZVTVrBBNLcwSsy6PosRImEv0Xqqnxnk
	UmaBDIm9Z0ohwrISU0+tA5vPLMAn0fv7CdQuXokd82BsZYk16xdAzZeUuPa9Ecr2kGh51MsI
	CZWtjBILV29gncAoNwvJQ7MQ1s0CW2El0fmhiRUiLC2x/B8HhKkpsX6X/gJG1lWMkqkFxbnp
	qcWmBcZ5qeXwKE7Oz93ECE7AWt47GB89+KB3iJGJg/EQowQHs5IIL4d3aLoQb0piZVVqUX58
	UWlOavEhRlNg/ExklhJNzgfmgLySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KL
	YPqYODilGpguMT7dYWG1k6vifkPYkY27zB6YzVM7lzdHhOFcipyBdz2ryiSfMw1bpC+fWby0
	I9DdgUtyy9RnSy4t+pBTVB177l7FrB/uJ+UVXGWeifH0NLNdz3jwYtH5jvot+iL5cw9G9fP2
	rdVZ9S/YqP9hYEPhvbUyXz92MH2/rjarqoxj2qJdqtYmDDpc4bNk9ylp7jnbmnrVVnatROKp
	OWw6b431zkqXbJr5dG7zK43d/D8vM9mJ/XGL03qg1XVAPOZ5/Swe63fe7BMnaN3tjXZoXyn6
	6o5J85bQ9Wcu+KdoLPRzDdwdn3D9kqPah8VJKyIlT4oyT95XUdVeZ1eqpC8/403Eg7WbbSs3
	xUz3/S7Fdk+JpTgj0VCLuag4EQAHwUj+SQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7nm2HpBjcm6Fg0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZxSXTUpqTmZZ
	apG+XQJXxu+5r9gKdrBUHF8Q1cB4krmLkYNDQsBE4twz/i5GLg4hge2MEi+fHmXpYuQEiktK
	LPt7hBnCFpZY+e85O0TRI0aJfxsXs4MkWARUJK7u2cAEMohNQFvi9H8OkLCIgKLEeaBjQOqZ
	BSYzSTyfeQxsqLCAu8SeM49ZQWxeoMXf5s4Hs4UEEiX6+16wQMQFJU7OfAJmMwuYSczb/BDs
	UGYBaYnl/8DmcwKF15+9xj6BUWAWko5ZSDpmIXQsYGRexSiaWlCcm56bXGCoV5yYW1yal66X
	nJ+7iREcMVpBOxiXrf+rd4iRiYPxEKMEB7OSCC+Hd2i6EG9KYmVValF+fFFpTmrxIUZpDhYl
	cV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5Ouh9vcmt8ntHi7gm0FFKIsq1pecC+0FI5hXCDP
	X5vQr3TTt+OwqcnO2+ZbYw9fLt3GfdK+wNpidqpOwuQNP+XtfxeIV1h/2FqW/k1IvmntdP+q
	NmabMz3rtszc9mbuT5sLdW+cbgcezNozySLcXnTa1WnTfwe2p6y/bz5t30OjZp/7mx+xrNwU
	sWGj2paIuSyWC4UT2xtl/2uztfD2WC1ZL3X3yzpVy6wCw0nPlyp6vXc3ldbfO32C5JHTxyyb
	JO+ZWC4xknxvlHdeeofXooNvviReKfebpLGFbZGV0/HbS80/PDZUM3p7aqodM4PF3Jhy3l/q
	BisY/XYWv5zBq7NBONl9fVf6D9GnbDqztyqxFGckGmoxFxUnAgDPeE9GBwMAAA==
X-CMS-MailID: 20241209115219epcas5p4cfc217e25d977cd87025a4284ba0436c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_6d0ff_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209115219epcas5p4cfc217e25d977cd87025a4284ba0436c
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-2-kbusch@meta.com>
	<CGME20241209115219epcas5p4cfc217e25d977cd87025a4284ba0436c@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_035340_713367_CA5C451D 
X-CRM114-Status: GOOD (  11.66  )
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

------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_6d0ff_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Add new statx field to report the maximum number of write streams
>supported and the granularity for them.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>[hch: rename hint to stream, add granularity]
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> fs/stat.c                 | 2 ++
> include/linux/stat.h      | 2 ++
> include/uapi/linux/stat.h | 7 +++++--
> 3 files changed, 9 insertions(+), 2 deletions(-)
>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_6d0ff_
Content-Type: text/plain; charset="utf-8"


------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_6d0ff_--

