Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FFC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCWU7Lc3U6Gf5GeFq7c4kfDiTYQheurIl1SgCCmRW2E=; b=ZSpCUjEjMJyKp/yTpe6gzBYpOh
	/MyaMrcwU/R8PNA/4Kow26mxqDRTkvBIXtKAhpwIXco86zpjiQOuL/AAdBZkaZwu+77OZlir5TZG5
	fpIX4w046gangpW4hStiz5hlH5B36Yqn+KlLnT3QAXM54YmX0N9L1qdDCuXHxxWMDRHnRo1Ulk7ze
	SDf6B8c8yD4d1tYTsFFMj0dwJcg4KomqkpSl+7LuM6GxyTNHzJIxsRji3F99MTyKgiKAB247G9kpz
	yrIOxnnomicnf2tBFdN79sjjzplNl4M8xUeJUFK9HAfv+bKKiaIRJF0OXJW/V7LYWfgglHG0lTwgW
	C/M6xL5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2jM-00000005JOu-1c1r;
	Thu, 23 May 2024 07:19:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2jG-00000005JJS-1R0j
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 07:19:13 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240523071856epoutp026ad7ab375218c54d07b59f59e515850d~SDQgIJS4L2713027130epoutp02C
	for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 07:18:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240523071856epoutp026ad7ab375218c54d07b59f59e515850d~SDQgIJS4L2713027130epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716448736;
	bh=bCWU7Lc3U6Gf5GeFq7c4kfDiTYQheurIl1SgCCmRW2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tf7+WlgLBawm/YVOH/7VyF+LvicAHD0h0EumnzsVsMKnmsCiKN2AkWy84PN9iJnKp
	 +RebvJV1T9GTPfAAmOZu4LW9sRvt0qIW48Lviixv5JtcgHibp4Uio+HXD9yWoCQMMo
	 LVATUhIpbuu6Zu2t+8LNCan3lF+j5b5MGS0tNRlU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240523071855epcas5p21aeec08c159e8d0f1adcdf6b64938e3f~SDQfodwgx1031010310epcas5p29;
	Thu, 23 May 2024 07:18:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VlKKV11Gxz4x9Q5; Thu, 23 May
	2024 07:18:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.17.09666.DDDEE466; Thu, 23 May 2024 16:18:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240523071219epcas5p2e8a92db80cd848b52d49715b1c010006~SDKu17ZOh2481924819epcas5p2x;
	Thu, 23 May 2024 07:12:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240523071219epsmtrp21c79b655e9d0043b667ac9556b156183~SDKu0vTEG1280012800epsmtrp2G;
	Thu, 23 May 2024 07:12:19 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-ba-664eedddf85d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.46.08924.35CEE466; Thu, 23 May 2024 16:12:19 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240523071215epsmtip14cb2b6df4b2fd21744f10ec306679a1d~SDKrOsSq10670606706epsmtip1T;
	Thu, 23 May 2024 07:12:15 +0000 (GMT)
Date: Thu, 23 May 2024 07:05:12 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240523070512.kku7gtw5qanmsrjg@nj.shetty@samsung.com>
MIME-Version: 1.0
In-Reply-To: <174d4908-b81c-4775-9b99-b0941451cb0e@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcdxTH+7t39+6lo9kSyS9LRLbTNKTYTdAfsdIJ096OtEw7bVKZdm3s
	DYLdzT5KHjPWK8I0IkLMIi1qyKII247XtrKK0Kh0kJQpMkGnRdhEPFpFl0sn/33O95zvnPM7
	Z34kblvP4ZFRMjWtlEli+IQ16/s2F1e3kScfnBZktOKoprsDR0lZKziqHL5KoKm2ZwDdMP+N
	o/HWNICWe3pxZOgYAaio5CYLDbY2YqilJBtD+sp2DBXkJWOofe0JgbJNDwCaGMjHkHHoACq+
	VMpCLcYuFuprKiTQ12UTHFTeuYqha5cHMNQwnghQ9dQsC90dckC9K53stx2ovv4gqrsEUo35
	wxyqd+Q2i+rr0VB1FekEVV+aQP1ZrwNU86CWoL7JvM6mriTPEFRj6iibejoxxKJmfxggqExD
	BaDuFf3ECbELjfaLpCVSWulMy8Ll0ihZhIgf9JE4QOzlLRC6CX3QW3xnmSSWFvEDj4W4vRMV
	Y1kO3/kLSYzGIoVIVCq+h7+fUq5R086RcpVaxKcV0hiFp8JdJYlVaWQR7jJa7SsUCA56WQrD
	oiO1aX6K+1bxl2r7MS3QkRnAioRcT9j+eIyVAaxJW24zgJXfjhFM8AxAbfFlNhMsAFh2/yF7
	y1J1p23TYgTQmNnFYYI5S9W0jlivYnFfh0uGcQuTJME9AH9e2+i3nbsfLjwq3zDj3GIC/v7b
	Er6esONKYPmgEayzDTcA9k2ucBh+FXbpxlnrbMU9DKtzKsG6GXIfW8F/ZtY4zEiBsCknhWDY
	Dk52GjZ1HpybMW7qcVCfc4tgzCkA5j/MB0ziCEztvroxBc6NhObpUpzRd8Pc7mqM0V+BV5bH
	MUa3gQ1fbfFrsKqmaLPBLvhgMXGTKVgw0YYxa7mHwdxf04ks4JT/wovyX+jHsC9MNyexGd4D
	k78rsOikhR1g+SrJoAusafIoAkQF2EUrVLERtMpLIZTRcf+fPFweWwc2fo/rew1g+JHZ3QQw
	EpgAJHH+dpuT+vdP29pIJefO00q5WKmJoVUm4GW51jWcZx8ut3w/mVos9PQReHp7e3v6HPIW
	8nfaTKXelNpyIyRqOpqmFbRyy4eRVjwt5j8Y6lRd/lwT/HLyHm1hcp3RftJV3KfyiIclea6+
	d07u6DWHib60EtWrO2suOn4cP1W67XZz8DTreVz2ioveJ7bHPNaXYHpz22ghWebEu6Wyzuw/
	rDuR4BBqeKlg92rm2bN69qnPOcNuT/WJe/eFHSMzSlp+6aqN/XHcb3X+jL5n1NCY9Eb6DX9B
	3l+IPW+vCb4benRHV1Xg8v4jw4txF5onPgk8/wc4Xh8QdOK6QfrZh4lFS/OH3l0kNAOST2vM
	sIV3efb4mRQdXeeoa3YR4mmFeRPTWQu6HPe8Wrf+C+dE7AXfU3Le2EXhQb6jjs0XJE3Z7mWn
	mP6dE+/cF7jYkTvCZ6kiJUJXXKmS/AeyGZ60xgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJTjf4jV+awcF7UhbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW616/Z7E4cUva4vzf46wO0h6Xr3h7nFok4bFz1l12j/P3NrJ4XD5b6rFpVSeb
	x+Yl9R4vNs9k9Nh9s4HNY3HfZFaP3uZ3bB47W++zenx8eovF4/2+q2wefVtWMXqcWXCEPUA4
	issmJTUnsyy1SN8ugSvj6Pn9zAUP2SreXtrI3sB4nLWLkZNDQsBEYs3BwyxdjFwcQgK7GSVu
	PPrBBJGQlFj29wgzhC0ssfLfc3aIoo+MEv1z14IlWARUJX5secLWxcjBwSagLXH6PwdIWERA
	Q+Lbg+VgQ5kFlrJJXNz/mx0kISyQKLH85l5GEJtXwFni8qu/UEPPMEkcv9fDDJEQlDg58wkL
	iM0sYCYxb/NDZpAFzALSEsv/cUCE5SWat84GK+cUsJZYN2U14wRGwVlIumch6Z6F0D0LSfcC
	RpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBiURLcwfj9lUf9A4xMnEwHmKU4GBW
	EuGNXumbJsSbklhZlVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoGJ
	12jVtS5O83NXWjMCK4OfL/jV1f7rstbeyCmnPonvWNboZ7OCO/Nlp4v557eCcyZr7NV64t/i
	fuc/U752aQ/n0z6Dcxc6ttftKr9/VK+bXX/+Bk9pRvc5MZHTK/RsM9mVGd5uWsQW8yPs0xeH
	i08DTxl/OLWrcuOLLPGdWveWc4idWL46yeGO7mHHvPlRps3O658wqt04l9e3/94+tfp4ywOt
	rRPWft69+/HVyh2uv8Q2cjOvsP+ecEDKlH9ZulnstL1V0U71Qpt/lcVfq2afZvabebITf1SG
	v57o9YjKzIq4HbVnamL2G39wKWt8pRI882vndZ73+xd8kYh6fVj2p7rLf+2ezl0tny38tiso
	sRRnJBpqMRcVJwIAAu4TPpMDAAA=
X-CMS-MailID: 20240523071219epcas5p2e8a92db80cd848b52d49715b1c010006
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_1f672_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102830epcas5p27274901f3d0c2738c515709890b1dec4
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
	<20240520102033.9361-2-nj.shetty@samsung.com>
	<d47b55ac-b986-4bb0-84f4-e193479444e3@acm.org>
	<20240521142509.o7fu7gpxcvsrviav@green245>
	<174d4908-b81c-4775-9b99-b0941451cb0e@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_001910_966893_E0A83A47 
X-CRM114-Status: GOOD (  11.85  )
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

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_1f672_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 22/05/24 10:49AM, Bart Van Assche wrote:
>On 5/21/24 07:25, Nitesh Shetty wrote:
>>On 20/05/24 03:42PM, Bart Van Assche wrote:
>>>On 5/20/24 03:20, Nitesh Shetty wrote:
>>>>+    if (max_copy_bytes & (queue_logical_block_size(q) - 1))
>>>>+        return -EINVAL;
>>>
>>>Wouldn't it be more user-friendly if this check would be left out? Does any code
>>>depend on max_copy_bytes being a multiple of the logical block size?
>>>
>>In block layer, we use max_copy_bytes to split larger copy into
>>device supported copy size.
>>Simple copy spec requires length to be logical block size aligned.
>>Hence this check.
>
>Will blkdev_copy_sanity_check() reject invalid copy requests even if this
>check is left out?
>
Yes, you are right. We have checks both places.
We will remove checks in one of the places.

Thank you,
Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_1f672_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_1f672_--

