Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDFFC4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QuFIWVx/Ktuj76LdQDpBkEiGXW04RxutiAGtOtIsX8=; b=kdGhj/aWuIgKf4YIgVYyHlJWi4
	2JMUBOFj6CXV/DZoVkEg8DDHIocHumJT09J7VBMt57DoDdX+9o8XzfhmqRdzG4fkX1qKE1Bph86dB
	AfSYOtGUVzGDaYpku+hk/vG+UHDOW1cdx5AyQEysYoGle0kgxLz4+vAjDfbi6qlZ8xqJxqdeTkdTR
	uK1eUC/fCyH7cdBxjmu7aQHR3Ey4BlD6jUNUS7K2zlsbt/CYdv+rTSYH+7ITrmD7OCQ0hIMrL1tte
	MLQps8+/4C+1I6CSnEIxCSFywDwuC+gbCEYZ/ds2d7+3DU5W7AE61Nc0k9McE59XVaT4FqUMB6zim
	BH8G2oXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S3H-0000000C0k2-1BHM;
	Thu, 02 May 2024 08:44:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S3B-0000000C0iz-01Uz
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 08:44:25 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240502084416epoutp0440fe5bb590dfdf17881cb405a8a7fc79~Ln4BnA--90227702277epoutp04e
	for <linux-nvme@lists.infradead.org>; Thu,  2 May 2024 08:44:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240502084416epoutp0440fe5bb590dfdf17881cb405a8a7fc79~Ln4BnA--90227702277epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714639457;
	bh=8QuFIWVx/Ktuj76LdQDpBkEiGXW04RxutiAGtOtIsX8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hf7tNWmuxJ71uTp3CnKnju6rlhgGAj/WwE62wfS0yf7mBGaSUUXgEw2xWaxMkVSqk
	 cgW9DZiuHEmuaQIUeE1nwtdkQiOK61SfHikM952+CDqq9iL5OWM6mcmjSr7jlMSkj1
	 aa4jJjl2XCVqkUoZ6LKN9xyAnF4ho+F1iqLFU1sI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240502084416epcas5p13ac3ecf8f2de52fbfeb1ddb58cd5b340~Ln4BPCDeF1985819858epcas5p1k;
	Thu,  2 May 2024 08:44:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VVSCf5JwNz4x9Ps; Thu,  2 May
	2024 08:44:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.2E.09665.E5253366; Thu,  2 May 2024 17:44:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240502084414epcas5p4c3957daf78e3105a65353ba37fb850cd~Ln3-OUxwS1953819538epcas5p4c;
	Thu,  2 May 2024 08:44:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240502084414epsmtrp1d2805046bf5b69979d62c2eb8cef848f~Ln3-NxsiK1645116451epsmtrp1I;
	Thu,  2 May 2024 08:44:14 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-f5-6633525e4698
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.BF.07541.E5253366; Thu,  2 May 2024 17:44:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240502084413epsmtip2b835e327a0476735a47cbced83cf0a6f~Ln3_cubam2787427874epsmtip22;
	Thu,  2 May 2024 08:44:13 +0000 (GMT)
Message-ID: <3394a7a9-dda5-204e-dc5f-04a5512770a0@samsung.com>
Date: Thu, 2 May 2024 14:14:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] nvme: reduce a repeated ZNS check
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240502071338.GC31379@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTXTcuyDjN4MwVTYuVq48yWUw6dI3R
	Yv6yp+wW616/Z3Fg8Th/byOLx6ZVnWwem5fUe+y+2cAWwBKVbZORmpiSWqSQmpecn5KZl26r
	5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
	kV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ0xYfkV1oL5TBVPHyxgbGB8zNjF
	yMkhIWAisXTSVqYuRi4OIYHdjBI/j79lhnA+MUocmtHBCOF8Y5Tofb+RBaZl/fK7UIm9jBIz
	fp6Ect4ySix4/pUNpIpXwE7i8do5rCA2i4CKxKFtc5gh4oISJ2c+AZskKpAs8bPrAFi9sICV
	xM7Zn8BqmAXEJW49mc8EYosIKEk8fXWWESLuLrH02Cf2LkYODjYBTYkLk0tBwpwCOhKX/mxg
	giiRl9j+dg7YCxICL9kljnYsYIO42kVixqrFTBC2sMSr41vYIWwpiZf9bVB2ssSlmeegakok
	Hu85CGXbS7Se6mcG2csMtHf9Ln2IXXwSvb+fMIGEJQR4JTrahCCqFSXuTXrKCmGLSzycsQTK
	9pA4uuAC2EQhgfuMEo1vzCYwKsxCCpRZSJ6fheSbWQiLFzCyrGKUTC0ozk1PLTYtMM5LLYfH
	d3J+7iZGcILU8t7B+OjBB71DjEwcjIcYJTiYlUR4pyzUTxPiTUmsrEotyo8vKs1JLT7EaAqM
	nYnMUqLJ+cAUnVcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA5P/
	JwaN6b4i/P7F94pOrrIp3ln9pi2Q28z2o7Hjnxgd0YxCzYznZRc2iS3xuVmy2OKknLWA1MdN
	c1cq9ESrNrvYq3Uvddqmdil11cr0dGbj03n1ZvstmY1v9h6bJ6ig5Dv7uqnTBIO4i6J/Fue5
	Nf54vSTg4AmBk2+kWRW1as98OWJizyBnomTZevOjzjdGNierzzl3P6iITp1q+3Lt1eWePIeb
	yoyNLofM1My+wfKI60FVk5JRyoQ6tgPqe3ZqFMw5EHn7+/m5kyeV3lnQeuBwuuilnoeMXDde
	bs3PqtrlJ8Kn4bHt/3p3RwutoIvtltV65902Ff7mskpnM/3OW7p9lYiGW5LJs9sBRl9uKbEU
	ZyQaajEXFScCAClHHOMZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG5ckHGawdk1ghYrVx9lsph06Bqj
	xfxlT9kt1r1+z+LA4nH+3kYWj02rOtk8Ni+p99h9s4EtgCWKyyYlNSezLLVI3y6BK2PC8ius
	BfOZKp4+WMDYwPiYsYuRk0NCwERi/fK7QDYXh5DAbkaJDxu2skIkxCWar/1gh7CFJVb+e84O
	UfSaUeLfqi6wIl4BO4nHa+eA2SwCKhKHts1hhogLSpyc+YQFxBYVSJZ4+Wci2CBhASuJnbM/
	gdUwAy249WQ+E4gtIqAk8fTVWUaIuLvE0mOfoJbdZZR4t/gKUAMHB5uApsSFyaUgNZwCOhKX
	/mxggqg3k+ja2gXVKy+x/e0c5gmMQrOQnDELybpZSFpmIWlZwMiyilEytaA4Nz032bDAMC+1
	XK84Mbe4NC9dLzk/dxMjOB60NHYw3pv/T+8QIxMH4yFGCQ5mJRHeKQv104R4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgusAmfiTm0qqaA1st46/OyDq/
	9uPHOP1HxQLs/91jTzwVuH7MXFB23cMei+6JG9+q5U1ZyJy+9Wj612J+/ZVp4rNSjoqwxaSd
	dXBY+kmyR/JAVZJroZV2lVzLhTiHIlX22x7MU7dzJzLMW9v+JPTzt6wAwQ2agT8sWzyijuQp
	rjzYkXK3PLW8xHERu2N6Z9vRuFn9Eafv3JjLdHBXi9v/8w6/rGdkT3uk/qiwryVa4MeEzOLb
	E/qOqk4JFjMUbd2/aaXKV56E+ekXmXrdGeeWsPyufB/uvMty/5JDfnWy03cqLF/8zuFOEtPO
	T1a86md/5612+f3u9lYbnf1if4v9StKfHGd56qa0Pjq6/hGzEktxRqKhFnNRcSIAc2AnqPYC
	AAA=
X-CMS-MailID: 20240502084414epcas5p4c3957daf78e3105a65353ba37fb850cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0
References: <20240502063438.422046-1-joshi.k@samsung.com>
	<CGME20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0@epcas5p3.samsung.com>
	<20240502063438.422046-3-joshi.k@samsung.com>
	<20240502071338.GC31379@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_014423_404601_7A829E85 
X-CRM114-Status: GOOD (  11.16  )
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

On 5/2/2024 12:43 PM, Christoph Hellwig wrote:
> Not sure there is much of a point do de-duplicate two instances of
> compile time condition + trivial const comparison?
> 

I also don't see it as a [micro] optimization. But this if condition 
seemed too long to be present twice.

