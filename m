Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01BE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8FdxvAnVCoTsbvPQpMPefyTPpGdl2dJ4Fn/6YllbVU=; b=o+ISWPQyx0QZCoG+xH3UlAk8Hr
	ZGNN3kHHIF4czTF1QCbjWmGZhkZFUq0/DclNX9iAIyDt/VoAOeCVvgBkrYy1ooChqV4ibaOlW+Mxr
	W8gh7pHh7420IJyDoq2im9cP54DsPyXQM5gjTNqLMUyX607d7/sGNZpdiETeM0wp2o+rAPtNQe9wq
	RVu6QEBpe8Z67MCGsEk1cUOf2HnCJShgoiIDtbhSIuKCMFw/Er3HDwawJ0g++P+paBhHINHtYVrMD
	9mje15ukd4Y0PxH4VmlvRamYNHjJbOHo5cQRXR89JhnuYiY6fYk4DvOqgpsR3EbB4rugGE/25MYW9
	gSnREQDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLc6c-0000000Gyyg-0do1;
	Thu, 12 Dec 2024 05:51:22 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLc6Z-0000000Gyxv-10Ul
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 05:51:21 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241212055112epoutp04ebd222a637d5528d32a5ec0b4f7ec39f~QWA3Hha7S3077430774epoutp04Q
	for <linux-nvme@lists.infradead.org>; Thu, 12 Dec 2024 05:51:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241212055112epoutp04ebd222a637d5528d32a5ec0b4f7ec39f~QWA3Hha7S3077430774epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733982672;
	bh=p8FdxvAnVCoTsbvPQpMPefyTPpGdl2dJ4Fn/6YllbVU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bL5W2UMHvy0k/Rr8+s2BlpRyslLODYgIE8o3w5/6U6jNDsCROgxQUl4P87IFQEcUl
	 i5EsGo+OPZlCd2bsqp21iKVnDASKD+DScvVK4SIkcBt80SiXx3RoFNgRpwcI9Ywbl6
	 jnvpiBnW7j0uN9E5EkpBr7NMetYW2ZY4aoOXYfps=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241212055112epcas5p1f377e76c320b78bf1032641977bbdfd9~QWA21HdPw1655716557epcas5p1h;
	Thu, 12 Dec 2024 05:51:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y81mZ5lNQz4x9Q3; Thu, 12 Dec
	2024 05:51:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.CD.19956.EC97A576; Thu, 12 Dec 2024 14:51:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241212055110epcas5p38922aeebb4d21c91145e4ee52a777f43~QWA0ym_tX1274812748epcas5p3T;
	Thu, 12 Dec 2024 05:51:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241212055110epsmtrp2a9fbc5d3d29181e464f1b3af093a021a~QWA0xIZsh1021910219epsmtrp28;
	Thu, 12 Dec 2024 05:51:10 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-18-675a79ce1bc7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.F0.18949.EC97A576; Thu, 12 Dec 2024 14:51:10 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241212055108epsmtip2a0160900fd5580eaaff1883f85a49577~QWAzIVXEM2353323533epsmtip2a;
	Thu, 12 Dec 2024 05:51:08 +0000 (GMT)
Message-ID: <bd53dbed-f6a9-4322-88b5-460f8e9885a0@samsung.com>
Date: Thu, 12 Dec 2024 11:21:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv13 00/11] block write streams with nvme fdp
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241211071350.GA14002@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmuu65yqh0g8VHdS2aJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxWLSoWuMFmeuLmSx2HtL22LP3pMsFvOXPWW3WPf6PYsDt8fOWXfZ
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5nHuYoVH35ZVjB6fN8kFcEZl22SkJqakFimk5iXn
	p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaqkUJaYUwoUCkgsLlbSt7Mp
	yi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM441GNRsIepYtmzI8wN
	jN8Zuxg5OSQETCRub3nA3sXIxSEksJtR4lzHIzYI5xOjxLQJPWwgVUIC3xglLixmhuk4vW4H
	I0TRXkaJHRMvMEE4bxklzn/cCTaXV8BO4ui5FUwgNouAqsTbNWuZIeKCEidnPmEBsUUF5CXu
	35rBDmILC9hLbJ13C6xXRMBR4uuGJWAbmAU+MEr8XdEL1sAsIC5x68l8oKEcHGwCmhIXJpeC
	hDkFdCRWrTjBClEiL7H97RxmkF4JgQMcEj9OPYF61EXi+O9dLBC2sMSr41vYIWwpic/v9rJB
	2NkSDx49gKqpkdixuY8VwraXaPhzgxVkLzPQ3vW79CF28Un0/n4Cdo6EAK9ER5sQRLWixL1J
	T6E6xSUezlgCZXtIPJ69ERpwaxglFracY5vAqDALKVhmIflyFpJ3ZiFsXsDIsopRMrWgODc9
	tdi0wDgvtRwe38n5uZsYwQlZy3sH46MHH/QOMTJxMB5ilOBgVhLhvWEfmS7Em5JYWZValB9f
	VJqTWnyI0RQYPxOZpUST84E5Ia8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQi
	mD4mDk6pBia97yZZ9s8evNol8qVxDfMFTdNT2XumzXV74b1xzkeuZKvV7+Y3LXRf8squYPbx
	2UZzSyv3dfUlfdxwMv89j1NYzeNzYUxve2eZ8aXpGAaFJz88naiS2Cu6XNtA9fCxiro5nPt8
	uOdy/T53LqKt/1rK3hMzDA0+Obh/22m1V+lWoMGVuIknE426v6S5v8/dtHZ9Zs6FfX2HXffs
	W76it+DJlkPVbbY3rznuXXsp2uqIsP7m2UyXle4vWuz2sejSnc0ModGlvYc4LwT+ulHo5/w7
	6P0nkz2LH7QmPDupJKX8bY5AWm5oVsBz9qXpEwsXn07Jd7B5XN8poJdtr7X089lJNWfnuZz0
	/HVjbf2hRt0dSizFGYmGWsxFxYkA1KKE+VEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO65yqh0g4uXWCyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxWLSoWuMFmeuLmSx2HtL22LP3pMsFvOXPWW3WPf6PYsDt8fOWXfZ
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5nHuYoVH35ZVjB6fN8kFcEZx2aSk5mSWpRbp2yVw
	ZRzqsSjYw1Sx7NkR5gbG74xdjJwcEgImEqfX7QCzhQR2M0ocmVEPEReXaL72gx3CFpZY+e85
	kM0FVPOaUeL62bVMIAleATuJo+dWgNksAqoSb9esZYaIC0qcnPmEBcQWFZCXuH9rBtggYQF7
	ia3zboEtExFwlPi6YQkjyFBmgQ+MEk8OTGeBuGINo0RTRwaIzQx0xa0n84EWcHCwCWhKXJhc
	ChLmFNCRWLXiBCtEiZlE19YuRghbXmL72znMExiFZiE5YxaSSbOQtMxC0rKAkWUVo2RqQXFu
	em6xYYFRXmq5XnFibnFpXrpecn7uJkZw7Glp7WDcs+qD3iFGJg7GQ4wSHMxKIrw37CPThXhT
	EiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamASU/C7GzlHmuPj
	ft2me+cK5E6qblg65fWyMys5wrkscreXpJyZfipi0eO+D/eW9lr9yXm3xLr6lVv0kez2TZfl
	/bbGSv18uzXQ/Myh5FVvTh0S5+9t4C98uvJN1KN1bH/aZ38Q2fVYUa//5Zm51WGyzSFJ/Pck
	D7qyeZa6Hbumaa9oNGvexQkWWq8FNHftcH+a8uXppGsbtt2b8zF1veSHlw+ZNW7PiuQJ/fpd
	zHxOyPSn2yVv5Eae7F5Y1840b3HwsTy57X2332yZf9RntrHQb+e6sI9/lkjcX+avPMVYRvrl
	9ukXohUWGr73kJvWtt/FNInhrzczj8yT7+xTjgac7ArfZy3/g0/fbm/i092VIUosxRmJhlrM
	RcWJABLEDKssAwAA
X-CMS-MailID: 20241212055110epcas5p38922aeebb4d21c91145e4ee52a777f43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241211071358epcas5p11c75e89d15c153ea3a41c82a5171d9de
References: <20241210194722.1905732-1-kbusch@meta.com>
	<CGME20241211071358epcas5p11c75e89d15c153ea3a41c82a5171d9de@epcas5p1.samsung.com>
	<20241211071350.GA14002@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_215119_738130_517C57A8 
X-CRM114-Status: GOOD (  11.30  )
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

On 12/11/2024 12:43 PM, Christoph Hellwig wrote:
> The changes looks good to me.  I'll ty to send out an API for querying
> the paramters in the next so that we don't merge the granularity as dead
> code

What do you have in mind for this API. New fcntl or ioctl?
With ability limited to querying only or....

