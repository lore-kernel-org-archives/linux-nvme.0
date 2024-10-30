Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFA4D5CCAF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTgYIo/ph95KYaS4AGg/KCiidRJKZvPlzVLAWb6L+dA=; b=aTbipU+5Oc5rePEJz3p6lUOffH
	a8rmDKQZUzA/22i+vKsyGuay8SwRHMVPc1spCTBlV8JH+wFlXaTiNzCgpzKIxo8xCrY3TTU6dIJlj
	df32DqvdGQ3a1BPZCyHePcQdSiUAOUiq/uidRrNlXbeNFA0V5Heiuh3F5lPdApC7AOEbfK6F+BuKB
	ICY6njho4K+GoSuP8NG6svH/b3GWOcF7+u1+Ml0airObVkWtTWkSly2C9wv8qpkMqPjmwMio3jyMP
	oxkitF8N+Oz7MzfXezXT5uwMg8mZwtD6HMOzOIkil1vlffCv7pflg70IOY98GL3vqwVdxo7klurLJ
	CDDeW0qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t696z-00000000Y8g-26Ph;
	Wed, 30 Oct 2024 13:51:49 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t68uI-00000000VKR-0wIk
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 13:38:44 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241030133830epoutp014b7a6de7ab883a11193d724c1fc01b0d~DPply6wcM0051500515epoutp01W
	for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 13:38:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241030133830epoutp014b7a6de7ab883a11193d724c1fc01b0d~DPply6wcM0051500515epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730295510;
	bh=zTgYIo/ph95KYaS4AGg/KCiidRJKZvPlzVLAWb6L+dA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dthvk/cYTQEkCGTtbBRpJrwGzPQ4y6Aq0ZtxjO8+ROBPa6F78JPDImWv7vgew/YUM
	 OoyO0iRBJKiYNUHhB3abGVYY+4u6O0Ghxmgp+Z+vwZNsBdeQG0xcNK0welgftggyEt
	 6jpl2MsX+WrVAFKk6XT+j1pmd/6/qOPSoyypvEXA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241030133830epcas5p1ddf2e7a7914c516d8e089455798b2ffc~DPplhwsqx2484524845epcas5p1t;
	Wed, 30 Oct 2024 13:38:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xdp9d176kz4x9Pp; Wed, 30 Oct
	2024 13:38:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.A1.09420.5D632276; Wed, 30 Oct 2024 22:38:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241030133828epcas5p3309db76a679c8cdf5c9becf738d8132a~DPpj9I0GL1177411774epcas5p3F;
	Wed, 30 Oct 2024 13:38:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030133828epsmtrp273d2749e8a99a5360c463a3f6a3db2c0~DPpj8guYt1231612316epsmtrp2U;
	Wed, 30 Oct 2024 13:38:28 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-c3-672236d5d5af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A5.00.07371.4D632276; Wed, 30 Oct 2024 22:38:28 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241030133827epsmtip148f9748681ac0d4487214a277e6a9802~DPpiwgHTl1312513125epsmtip1D;
	Wed, 30 Oct 2024 13:38:27 +0000 (GMT)
Message-ID: <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
Date: Wed, 30 Oct 2024 19:08:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
To: Keith Busch <kbusch@meta.com>, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhu5VM6V0g+09LBZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
	Ql5ibqqtkotPgK5bZg7QWUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE
	3OLSvHS9vNQSK0MDAyNToMKE7IxNCzcyFcxirFjZztnAWN/FyMkhIWAi8fLCB+YuRi4OIYHd
	jBL/9n5lgXA+MUqc6ZjABuF8Y5To+XuaDabl6KRtUFV7GSX+X7zLDuG8ZZRYsLcFrIpXwE7i
	ddMaMJtFQFXi2saXjBBxQYmTM5+wgNiiAvIS92/NYAexhQXcJZ6u7QCrFxGolfjb9IgJxGYW
	CJc42LMNyhaXuPVkPpDNwcEmoClxYXIpSJhTwFxi/srd7BAl8hLb385hhjh0LodE/7ZECNtF
	4t/3W1APCEu8Or6FHcKWkvj8bi9UPFviwaMHLBB2jcSOzX2sELa9RMOfG6wga5mB1q7fpQ+x
	ik+i9/cTsGskBHglOtqEIKoVJe5NegrVKS7xcMYSKNtDouXhH2iwdTFKfJr/k30Co8IspECZ
	heTJWUi+mYWweQEjyypGydSC4tz01GLTAsO81HJ4bCfn525iBCdZLc8djHcffNA7xMjEwXiI
	UYKDWUmE1zJIMV2INyWxsiq1KD++qDQntfgQoykwdiYyS4km5wPTfF5JvKGJpYGJmZmZiaWx
	maGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUx80cdLt9Z/OxzaP8EjfZOcpKpLvtOBc5Os
	9HMzdZ8FXzZv4dHJfH9JcOeqm+llc9dfNeJTW+p2WUpvo6ZD8bWoU3fMz+XcS1M7mG6nePb8
	D/MnbTu3qbS9sRA2ePxh/zVX9lAOucmma861WZRcV1thonwg5q7ndYZpz+Z319jfXX9ZRU9q
	SthPYYt7N38Z+NouyerX4DnJnPA/2OTbUwO+X9ytj86vVbvB80475OP6yEZP6+XvpURt8rYF
	cx/f3bD9RrRe587rMw53SWaIBAht9z3j/8ZBL5TXjXvXrred/O/t5hxZnfGfTXe5ZfGv4i2K
	q/uXWixefjDcbiWv4eusRx5z7k0J7dSxfZU+85ESS3FGoqEWc1FxIgDzo0YXOwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTveKmVK6wbSdShZNE/4yW6y+289m
	sXL1USaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXj0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxqaFG5kKZjFWrGznbGCs72Lk5JAQ
	MJE4OmkbSxcjF4eQwG5GiTtH+9ggEuISzdd+sEPYwhIr/z1nhyh6zSix8nEfC0iCV8BO4nXT
	GrAGFgFViWsbXzJCxAUlTs58AlYjKiAvcf/WDLBBwgLuEk/XdoDViwjUSkz5OocJxGYWCJf4
	8LsFLC4k0MUocflqKURcXOLWk/lANRwcbAKaEhcmg4U5Bcwl5q/czQ5RYibRtbWLEcKWl9j+
	dg7zBEahWUiumIVk0iwkLbOQtCxgZFnFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREc
	UVoaOxjvzf+nd4iRiYPxEKMEB7OSCK9lkGK6EG9KYmVValF+fFFpTmrxIUZpDhYlcV7DGbNT
	hATSE0tSs1NTC1KLYLJMHJxSDUwmJxe4Lj239PE35suJScEhe77EnsqU9NUSmdc8xUPwqpid
	6He+mi0hk9eenpucVXX0UNIXsb3FUXsF7S8sWvvAuPwV99Ss5o19Xw4Xty980BRR8J0vMDvZ
	kS/irEmJiMbsm9d3pzwVfmX9uX6lnJ6Sl/T0T7Nkv2ec+3qbZ92+AyXXIw7l1d06MbmdV7Lk
	jMmJ84sTvFbq9R/d/XCK8AXNBSdebgqeuUH+z9ZV2zi43724v/vNqbDwl+FHesS0TzSmGTHs
	bV1q/Z8z5dfJjzwzjn1O5JyUcWBz5PNfz2dn2+Zb90iJ/HVid/ETmRF98tX3VTo3H9qcunKA
	ReVe6E7uhewxh93092f9r+nkCH27WomlOCPRUIu5qDgRAEW4CiwXAwAA
X-CMS-MailID: 20241030133828epcas5p3309db76a679c8cdf5c9becf738d8132a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016201337epcas5p33625af2c67f92092078b0b43874d67bd
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
	<20241016201309.1090320-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_063842_758123_5BE6ECF8 
X-CRM114-Status: GOOD (  11.05  )
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

Jens,
Please see if this can be picked.
Helps to reduce a dependency for io_uring metadata series.

