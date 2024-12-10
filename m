Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14342E77182
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tgwbSF9QFjMGQpEZMWEasW12koafo3RHOGft54iiIoU=; b=4WnVwF56GobB1vkpjs7i3KVLoe
	tjIOfNpDhg1wN5ES+/bkOEm3sL2zyhCWn+z9wC5bPAlsAo4aXq/Zfoz1icR6+drglCnn7rL9hy6sK
	kHTU428AxzBZXe0P05P/OeLb/3QC0hwcZC1/DO9vYUPBU/IR6Y1N/0WljAiCLylhmIQkjB2dE6MY7
	97qibINi03i+ePZMaKLk2N09x1O0+fawkVZ8HUwgV58t9EK6WU9rFpv8TbySxDK0HDQBk+OwUk+cC
	E0fM39TQFapKbr6hXT2tymk+4Q+ABmHr7apA4aHDYZYW1Hq6V1+tMlyld0qPSwy2zm8C8m412CFri
	iJ9+hO+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzOG-0000000BQpt-1qMG;
	Tue, 10 Dec 2024 12:31:00 +0000
Received: from [203.254.224.33] (helo=mailout3.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzOD-0000000BQnZ-3pMl
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 12:30:59 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241210123054epoutp0369f2526ca3123439bc9aefc52056cd79~P0LRLwj4O1639616396epoutp038
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:30:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241210123054epoutp0369f2526ca3123439bc9aefc52056cd79~P0LRLwj4O1639616396epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733833854;
	bh=tgwbSF9QFjMGQpEZMWEasW12koafo3RHOGft54iiIoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6aKwvgJdZ0Tb8qfySYvqN3e0cKtbWd/nkWC7eA3u6UFNvhCt3C162SZWz5P1QagW
	 QPq5nqfP8wUFVMku2SlJNfQxUBIudHDC9c98ENh5LQoo+ARmmu9D/i4zEoTiyUCzhW
	 nkqmDmNxN1u/6JKzlhkklbnhDGgHbKvrOu2C+MnE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241210123053epcas5p234c69c70c80cd127e9eab4f1ca495d51~P0LQzTOFS2586425864epcas5p2p;
	Tue, 10 Dec 2024 12:30:53 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6ykh5WKPz4x9Q1; Tue, 10 Dec
	2024 12:30:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.3C.29212.C7438576; Tue, 10 Dec 2024 21:30:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210122137epcas5p2e373baa1c99b78341928cc7bf0fe3bdf~P0DKd5MpJ0447704477epcas5p2B;
	Tue, 10 Dec 2024 12:21:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210122137epsmtrp2ceb522578b65cf639393b46cf3c9b10c~P0DKdJYqA3178431784epsmtrp2-;
	Tue, 10 Dec 2024 12:21:37 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-27-6758347ceb8f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.90.18949.15238576; Tue, 10 Dec 2024 21:21:37 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210122135epsmtip101a003220a0d842bf4b0204753c95d1c~P0DItg-sD1571615716epsmtip1a;
	Tue, 10 Dec 2024 12:21:35 +0000 (GMT)
Date: Tue, 10 Dec 2024 17:43:41 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 09/12] nvme: pass a void pointer to
 nvme_get/set_features for the result
Message-ID: <20241210121341.cvueso5g5uipg2le@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-10-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmum6NSUS6welzGhZNE/4yW8xZtY3R
	YvXdfjaLlauPMlm8az3HYnH0/1s2i0mHrjFanLm6kMVi7y1tiz17T7JYzF/2lN1i3ev3LA48
	Hjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObx7mLFR59W1YxenzeJBfAGZVtk5GamJJa
	pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0r5JCWWJOKVAoILG4
	WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pw2d/sBTdZ
	K/r7HjM3MDawdjFycEgImEhsXJ/ZxcjFISSwh1Hi+PN2NgjnE6PE/AUTGSGcb4wS3WuXMHcx
	coJ1rN/+Hiqxl1GiceU8dgjnCaPE1b0T2UGqWARUJba/u8IGsoNNQFvi9H8OkLCIgKLEeWBI
	gNQzC0xkkvh9qIkdpEZYIFFi29wYkBpeoAUNZ66zQ9iCEidnPmEBsTkFzCV2bVsD1ishsJZD
	Yv+5yWwQF7lIbDlyEcoWlnh1fAs7hC0l8fndXqh4ucTKKSugmlsYJWZdn8UIkbCXaD3VD/Ya
	s0CGxMMbq1gg4rISU0+tY4KI80n0/n7CBBHnldgxD8ZWllizfgHUAkmJa98boWwPiZa1W6AB
	uY1RYv/mp0wTGOVmIfloFpJ9ELaVROeHJtZZwMBgFpCWWP6PA8LUlFi/S38BI+sqRqnUguLc
	9NRk0wJD3bzUcng0J+fnbmIEJ2KtgB2Mqzf81TvEyMTBeIhRgoNZSYSXwzs0XYg3JbGyKrUo
	P76oNCe1+BCjKTCGJjJLiSbnA3NBXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakF
	qUUwfUwcnFINTOUfti88Hdr0fd399R+WB33ZtHlH94Xox5EmO8K4tRpneb9snvk5yVzLyEhh
	0cSVNi8lXLIuyc7S23LS0eB6QtbBp9/tjtfqnpS9qnnyn1r+n/BVc+esSVfSazWM+vrs99fr
	s2ZGF+y8Kc1yqMtd4EFCzr1PPEwiz7ttM1TuKDTPu3nly9OaZxwGh56JfzK/qCTEmSr/duuZ
	pTEa0TJ9Evekw35P3fHi8t/AOKU1XMeuSMu7MHm1ds2vq75+6VL2hcJZ9z19bkooS13OfMX/
	eWHisXxfsYBlz0wumJkJZMUv2Jep/H791mdvw+WLD/mUMxUauNRncu1dcyNy0pYrrc8cUuP/
	vje6KvzZK3jt4XIlluKMREMt5qLiRABdwUZsTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnG6gUUS6QdcuAYumCX+ZLeas2sZo
	sfpuP5vFytVHmSzetZ5jsTj6/y2bxaRD1xgtzlxdyGKx95a2xZ69J1ks5i97ym6x7vV7Fgce
	j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HN49zFCo++LasYPT5vkgvgjOKySUnNySxL
	LdK3S+DK+HLiHntBN3PF9vP7mRoYzzB1MXJySAiYSKzf/p6xi5GLQ0hgN6PElmfXoBKSEsv+
	HmGGsIUlVv57zg5R9IhRYkHjTxaQBIuAqsT2d1fYuhg5ONgEtCVO/+cACYsIKEqcBzoHpJ5Z
	YDKTxPOZx1hAaoQFEiW2zY0BqeEFWtxw5jo7iC0kkCRx8dBmZoi4oMTJmU/AxjMLmEnM2/yQ
	GaSVWUBaYvk/sPGcAuYSu7atYZvAKDALSccsJB2zEDoWMDKvYpRMLSjOTc8tNiwwykst1ytO
	zC0uzUvXS87P3cQIjh0trR2Me1Z90DvEyMTBeIhRgoNZSYSXwzs0XYg3JbGyKrUoP76oNCe1
	+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQYmjXcex7Q0Syeof0/LX7ppYS/XO8F6
	1qX/9e2yr4X0t+pJRP7VVPE2miQa4bzV0fDVgVLX9OBQxduLX/05+DPaj0v4xpS2zg1ragwO
	7Y3Zu7v6ulXgtH9F4koc9rbF6zYGfffd4RV/8FC0YtiDn4J3mZxWXRGZb/JWK3fBep+Jl3ta
	1c+uTruYqd+6P1B7etbGX1zpGzX6Uu+sfzpvCy//i5p1YW4MtslzrBZF7N7B2yS4LOZN/l3R
	D88Wmu0XXnWS5eiB+g4euffHP1tV5DXsut6QveGDUed6d87FpyI2Vf6YtJBJd9eSxqj/7QZn
	r8z6uyw6SHDOik1BVzU2qjrve6978mD8Cfkm6cKWE9wnlFiKMxINtZiLihMBpE4QwQwDAAA=
X-CMS-MailID: 20241210122137epcas5p2e373baa1c99b78341928cc7bf0fe3bdf
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726d4_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210122137epcas5p2e373baa1c99b78341928cc7bf0fe3bdf
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-10-kbusch@meta.com>
	<CGME20241210122137epcas5p2e373baa1c99b78341928cc7bf0fe3bdf@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_043058_283166_9FD5308D 
X-CRM114-Status: UNSURE (   8.27  )
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

------gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726d4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>That allows passing in structures instead of the u32 result, and thus
>reduce the amount of bit shifting and masking required to parse the
>result.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726d4_
Content-Type: text/plain; charset="utf-8"


------gzWopnPZ_Ctz0vx8ivNX8AC.S.UWijgAUb-gyMezoI7qaEzu=_726d4_--

