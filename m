Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85254ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Td3nOGtUnd1hhd2bTlp+oJLbxs/NYj90X1x9xLhjx4=; b=X3X6mxhk7ituLzaaKEeCEue7fD
	JT2oVN3s14tWuUB+QL7z4L4E/Y0NhimXGNlWz25ZxditJknCTShYd6QI/zHUo4YaUmHJuhl11mj23
	mxSngnbqoA/EYVDTwafyQX7bc8LeRiAqoUdxMsk66VM/401PXw+HIRTbPSH9w8IVgHD+O2WTvMBOk
	XrkUzqsoDKrnQjUGurcZ8EU0TuQsGUQuzNpVzwihfjrvq2WrHCaf0IHj2dackMZFHag67QhLPOVAb
	hbVo0RTvyp+DS1cIbj5tKvnnppBLWCFfCwg044pQYjpCg9dESMcYF/4oRkdk6P/jtGQNOIkegDMqf
	Gk/cud+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obf5o-003Nm0-JA; Fri, 23 Sep 2022 09:35:32 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obf5g-003Ngh-UN
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 09:35:28 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220923093510epoutp0304cb5b0e016695638a44d9c88f26907d~Xc55GP5CL2451324513epoutp031
	for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 09:35:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220923093510epoutp0304cb5b0e016695638a44d9c88f26907d~Xc55GP5CL2451324513epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663925710;
	bh=6Td3nOGtUnd1hhd2bTlp+oJLbxs/NYj90X1x9xLhjx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3M3PLI9YzdK3oqSz64uUdeneGgQNplxjUdwRwYyUwNCU5P1erR1aploW2x4+G5h9
	 /epOhI4bhcSbIwXDvDODE+PPStmlSx7KJGeoAw0Dzhj8NO3Ga2APoqTOSDnkSvlyIz
	 wzsp/c/ia1TrdBfoiU39D3ouTVeInQlGTrz7prDY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220923093510epcas5p24aea7a2d8cb1f335f8af5cb42087d3d8~Xc544i_Ie3214432144epcas5p2h;
	Fri, 23 Sep 2022 09:35:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MYn7F5Sv2z4x9Pt; Fri, 23 Sep
	2022 09:35:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.84.39477.5CD7D236; Fri, 23 Sep 2022 18:35:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220923093501epcas5p42abd5169083296546f80b3c217995439~Xc5wU3az_2455324553epcas5p4H;
	Fri, 23 Sep 2022 09:35:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220923093501epsmtrp12395ac6fdbe72125ebe747b7e450fc8e~Xc5wT6h7S0652806528epsmtrp16;
	Fri, 23 Sep 2022 09:35:01 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-8e-632d7dc52bed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.E6.18644.5CD7D236; Fri, 23 Sep 2022 18:35:01 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220923093459epsmtip18585c6cf9f473a06b9c4b69cbb147381~Xc5u3N7A72953229532epsmtip1Y;
	Fri, 23 Sep 2022 09:34:59 +0000 (GMT)
Date: Fri, 23 Sep 2022 14:55:12 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v7 3/5] nvme: refactor nvme_alloc_user_request
Message-ID: <20220923092512.GA20354@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220920120226.GB2809@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhu7RWt1kg51LrCzmrNrGaLH6bj+b
	xc0DO5ksVq4+ymTxrvUci8WkQ9cYLfbe0raYv+wpuwOHx85Zd9k9Lp8t9di0qpPNY/OSeo/d
	NxvYPPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2RtuH+SwFa3gqzvw5zdzA+JOzi5GTQ0LARGL+rsfMXYxcHEICuxkl
	Li//zAThfGKUeHj4JguE85lRYvKDPcwwLVdn9EMldjFKfP5xC6rlGaPE039P2UGqWARUJV5c
	ecjaxcjBwSagKXFhcilIWERASeLpq7OMIPXMAusZJWavnc8IUiMs4C1x9pAfSA2vgK7Egq13
	mSFsQYmTM5+wgNicAtoSG/tPs4LYogLKEge2HQfbKyEwlUPiw4FFLBDXuUgcv7SHDcIWlnh1
	fAs7hC0l8bK/DcpOlrg08xwThF0i8XjPQSjbXqL1VD/YYmaBdInznQfYIWw+id7fT5hA7pQQ
	4JXoaBOCKFeUuDfpKSuELS7xcMYSKNtDonHNO2gA3WCUOPTyOusERrlZSP6ZhWQFhG0l0fmh
	iXUW0ApmAWmJ5f84IExNifW79Bcwsq5ilEwtKM5NTy02LTDKSy2HR3Jyfu4mRnAq1fLawfjw
	wQe9Q4xMHIyHGCU4mJVEeGff0UwW4k1JrKxKLcqPLyrNSS0+xGgKjJ6JzFKiyfnAZJ5XEm9o
	YmlgYmZmZmJpbGaoJM67eIZWspBAemJJanZqakFqEUwfEwenVANT8mG5+4VXHc2qjScriThN
	duW7+0HfLeX35N7DL6stzpzn+V26Sry9J9Gz7sHrn0eSzLguXX/9pXvKiUJm1foLYQ2yhsUn
	Ax4HWNxtritI2RLneVeFzbHd4H4Ub5pbQctl6Z/r1EtNS+tFt2S/1anw3Tyj6Xvhh8ba9fEL
	5N8v23z/bfehqnWhKY8d5efdvuLVGLA3vvN27Ivd5z9znTo30eht38XG/xMvb4hVdzSdJ2Kh
	zS2ux1n/odyC31ouuTbqg3WJAvcF9l/aHya9X/btqdvOt3MqH3JL3Gad/9Go6fDj1voLApP6
	xbi53ffNndCtsjXo3pIDJV7fmhizLeNlLl94ZW28NjJz1d0HE/SVWIozEg21mIuKEwGlc5Pq
	LgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO7RWt1kg/XfpC3mrNrGaLH6bj+b
	xc0DO5ksVq4+ymTxrvUci8WkQ9cYLfbe0raYv+wpuwOHx85Zd9k9Lp8t9di0qpPNY/OSeo/d
	NxvYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugStj5ozFrAUPOSuO3rvP2MB4gr2LkZNDQsBE
	4uqMfpYuRi4OIYEdjBJfNjxhhUiISzRf+wFVJCyx8t9zdoiiJ4wSnyc+YwRJsAioSry48hCo
	gYODTUBT4sLkUpCwiICSxNNXZxlB6pkF1jNKzF47nxGkRljAW+LsIT+QGl4BXYkFW+8yQ8y8
	xShxdOIadoiEoMTJmU9YQGxmATOJeZsfMoP0MgtISyz/xwES5hTQltjYfxrsTlEBZYkD244z
	TWAUnIWkexaS7lkI3QsYmVcxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHhpbWDsY9
	qz7oHWJk4mA8xCjBwawkwjv7jmayEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
	s1NTC1KLYLJMHJxSDUwc50wOMqVO3FvP8/8ns0ip8zy5J+ZbrixbKVXi8YXrapXt0X1Lv//v
	e/rQ2yNwcpPurV/nAq2LeY/skpAXDWHxL69807JxdSRrQ0m3/z61czf3CfLIKTfsnbWrKpDv
	9MmcB84qs+bc3aioqXTrjU/Pf9f7r695lHtOeLlm0sp53D/rl9w0/5OQNfGNXsG6QovlW9aF
	+Ff3LvDRX+M725C3X9joGMfSyoKk9/ZHMwxXTQnPOrni24cgX0GFutLyBbre16cXTFjoVSK3
	bONvO1V+qadOyYU6axv6b+rlL5/U69sYvLvBI7W194LwuayLErOao66Xpd+dJaVxu5Xn6usf
	5rnKfQWVf5zSD4TP71ZiKc5INNRiLipOBACfItsr/AIAAA==
X-CMS-MailID: 20220923093501epcas5p42abd5169083296546f80b3c217995439
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MqMoGWHj7w70ixSxIQQUJpQDpxeWNW7xlUV_NBkU4rXoYOVD=_5407_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909103143epcas5p2eda60190cd23b79fb8f48596af3e1524
References: <20220909102136.3020-1-joshi.k@samsung.com>
	<CGME20220909103143epcas5p2eda60190cd23b79fb8f48596af3e1524@epcas5p2.samsung.com>
	<20220909102136.3020-4-joshi.k@samsung.com> <20220920120226.GB2809@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_023526_305114_563A0D76 
X-CRM114-Status: GOOD (  18.37  )
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

------MqMoGWHj7w70ixSxIQQUJpQDpxeWNW7xlUV_NBkU4rXoYOVD=_5407_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>> +
>> +	if (!vec)
>> +		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
>> +			GFP_KERNEL);
>> +	else {
>> +		struct iovec fast_iov[UIO_FASTIOV];
>> +		struct iovec *iov = fast_iov;
>> +		struct iov_iter iter;
>> +
>> +		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
>> +				UIO_FASTIOV, &iov, &iter);
>> +		if (ret < 0)
>>  			goto out;
>> +		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
>> +		kfree(iov);
>
>To me some of this almost screams like lifting the vectored vs
>not to the block layer into a separate helper.
>
So I skipped doing this, as cleanup is effective when we have the
elephant; only a part is visible here. The last patch (nvme fixedbufs
support) also changes this region. 
I can post a cleanup when all these moving pieces get settled.

>> +	}
>> +	bio = req->bio;
>> +	if (ret)
>> +		goto out_unmap;
>
>This seems incorrect, we don't need to unmap if blk_rq_map_user*
>failed.
>
>> +	if (bdev)
>> +		bio_set_dev(bio, bdev);
>
>I think we can actually drop this now - bi_bdev should only be used
>by the non-passthrough path these days.
Not sure if I am missing something, but this seemed necessary. bi_bdev was
null otherwise.

Did all other changes.


------MqMoGWHj7w70ixSxIQQUJpQDpxeWNW7xlUV_NBkU4rXoYOVD=_5407_
Content-Type: text/plain; charset="utf-8"


------MqMoGWHj7w70ixSxIQQUJpQDpxeWNW7xlUV_NBkU4rXoYOVD=_5407_--

