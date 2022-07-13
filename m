Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150D6C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRFvRRYetVP0tS443pv+qndkxTOzb+XOc8ft3uR1yZs=; b=Vf3re8m2iwsrFgmxD8rJYOqKAI
	N6ckfegfmXFoaHgaft6f8zuviUrzjGy8hrjnvFop3FY8KhD+w6Fv6X1CNEZMTPm1U9JusRZA9GrPa
	ISeiHFWoN5PY5Pvo5+INfQKgV4ZMQk6jLbek2jdhjpxgB0l+qkhr/cKNXImqHRt+efjhuDxWTSRBi
	jWt5a5WWDXNe+220M5lcCLCKE2pwWMDhMXRJygUTwFkGYy/t2XMblXwXLEkts8fn6UeAScVxz65Bn
	Bz2TzgZWShw3wwXaHsRzHjfCqy+J9LrX9JPfDOxmDB4F59qlcwHWnoj/WisZvFsOGur8JvF23n6Bc
	LzNW+HeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZc1-002hIU-Lw; Wed, 13 Jul 2022 10:28:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZby-002hHI-7i
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:28:56 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220713102849epoutp04140258df467f59df6dc2e3186b4152d6~BXMKrNs_g2400424004epoutp04d
	for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 10:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220713102849epoutp04140258df467f59df6dc2e3186b4152d6~BXMKrNs_g2400424004epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1657708129;
	bh=dRFvRRYetVP0tS443pv+qndkxTOzb+XOc8ft3uR1yZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1H6+R48E9TTp2CM1vZkDR0yvxMDwKj5/xhWSjL0AkyCJAD2hvwecBc0OaDJzS5ce
	 CNmm3BM6iF0GH/eJhTdOG8ds8Is1Cb66FtO/eFoYATHk6mtG3JbGDPspa1jnLbJ0dK
	 ukeHc8rjv/xonW4fZRYQtSDKtzaV5SSY6tnLeDPs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220713102848epcas5p262158f56acf394b4cdef3143d0578766~BXMKa10wa0090400904epcas5p2n;
	Wed, 13 Jul 2022 10:28:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4LjYkQ0wqjz4x9Q7; Wed, 13 Jul
	2022 10:28:46 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.94.09662.D5E9EC26; Wed, 13 Jul 2022 19:28:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220713102845epcas5p2e08cc1da7d55e81452826abda5afb2b6~BXMHRw6D50090400904epcas5p2g;
	Wed, 13 Jul 2022 10:28:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220713102845epsmtrp10f45b1fda516f2dde08dfad11e2e6501~BXMHQ4d5T0543605436epsmtrp1F;
	Wed, 13 Jul 2022 10:28:45 +0000 (GMT)
X-AuditID: b6c32a49-885ff700000025be-22-62ce9e5d441b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.81.08905.D5E9EC26; Wed, 13 Jul 2022 19:28:45 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220713102844epsmtip1330c6e825c3eb258582eaeb6e96cc248~BXMGHrOoM3079830798epsmtip1d;
	Wed, 13 Jul 2022 10:28:43 +0000 (GMT)
Date: Wed, 13 Jul 2022 15:53:21 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Granados <j.granados@samsung.com>, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH 1/5] nvme: rename nvme_validate_or_alloc_ns to
 nvme_scan_ns
Message-ID: <20220713102321.GA30733@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220713054914.1888305-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTQzdu3rkkgxPvWSxuHtjJZLFy9VEm
	i6X7HzJanGzcw2ox6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm0ffllWM
	AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
	KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEK
	E7IzLsyxKrjCUjFlwlamBsYJLF2MnBwSAiYS785MZe9i5OIQEtjNKNGy4AMjhPOJUeLfugZm
	COcbo8TbmU/YYFr+vvsF1bKXUeLC3ktQLc8YJb73NzN1MXJwsAioShz/XglisgloSlyYXArS
	KyKgJPH01VmwcmaB+YwSH69OZAGpERYIlNh+QR+khldAV2JO/102CFtQ4uTMJ2CncgoYSUyf
	epgdxBYVUJY4sO04E8gcCYFGDolJj54yQhznIvFv5RooW1ji1fEt7BC2lMTL/jYoO1ni0sxz
	TBB2icTjPQehbHuJ1lP9zCA2s0CmxOubN1ghbD6J3t9PwN6SEOCV6GgTgihXlLg36SkrhC0u
	8XDGElaIEg+JzR2hkBBZyyhx5etLtgmMcrOQvDMLyQYI20qi80MTkM0BZEtLLP/HAWFqSqzf
	pb+AkXUVo2RqQXFuemqxaYFhXmo5PIaT83M3MYKTpZbnDsa7Dz7oHWJk4mA8xCjBwawkwvvn
	7KkkId6UxMqq1KL8+KLSnNTiQ4ymwMiZyCwlmpwPTNd5JfGGJpYGJmZmZiaWxmaGSuK8Xlc3
	JQkJpCeWpGanphakFsH0MXFwSjUwtS40P/w58eL+TRtqngY3BFw157iXXNkh57fop/mnSrk1
	4asVrmvF7S8ynbc8w3DZXnGF3vYjK4PUGB3YVeO+PlG3mblvUrj1KdEfNSseppbOqOotiA6S
	+1jS9mXSvuUc8Sw/vzN/mfk0MNdD/1tT6KGJ0lFa3Atepe/sXJSXfun9K79VYcwWAro/dL+e
	v83j84bhj5f3x0vqZUefKYovXp9pmXUhX1LM/4fm5Kz8mqLqH4y/z3uf4U7O4ra/89JqksBX
	uVnrw1dnL07msRZOSjjldEdIrN5SW6mm2T6xNem56WomjxI3da9er/vLYy+3KNndOePQHR2y
	+tWLl9wbaz69Xbk5KXWKwZuuVQ+UWIozEg21mIuKEwEwPl0CHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnG7svHNJBlsfC1rcPLCTyWLl6qNM
	Fkv3P2S0ONm4h9Vi0qFrjBbzlz1lt1j3+j2LA7vH+XsbWTw2repk89i8pN5j980GNo++LasY
	A1ijuGxSUnMyy1KL9O0SuDLmb/jBWtDMVDGx4y9rA+NNxi5GTg4JAROJv+9+sXcxcnEICexm
	lJh58gpUQlyi+doPdghbWGLlv+dQRU8YJS7MuMTSxcjBwSKgKnH8eyWIySagKXFhcilIuYiA
	ksTTV2cZQcqZBeYzSpxYuB+sXFggUGL7BX2QGl4BXYk5/XfZIEauZZR4v+Q5O0RCUOLkzCcs
	IDazgJnEvM0PmUF6mQWkJZb/4wAJcwoYSUyfehisXFRAWeLAtuNMExgFZyHpnoWkexZC9wJG
	5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMERoKW5g3H7qg96hxiZOBgPMUpwMCuJ
	8P45eypJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqa5
	H9l4Z775sOqEg7LFpqX709VzE/znLFKriA1oaj3AGV/+bvs82Zybj3+dN+rqM22Kusz0Zvoj
	1tvJx9d07N4SyMcvf67Bc2lj4zrZfq+czE9hDYETjeUExab+8ij4IWt4/cS5F5sj7oZVPbMW
	nOXvlrvpU2tUmEnWzLvrP7zyfr9iNkv0oYsmy9incRx4bRDbpa/CnPGY4bHEiuMZ/kY6Vyvv
	X+GOnHXjEUfkPjt9dQk1iaYFh77evf2S+e4VzmZ7CQGlztelOu273pu/El9rObPtBecM23ld
	kVyt2Ws9v9pMncL5V55ZIGX/npO2hnp5pjZbJQyUTLXmfHb/KrHy/ZyEpn3tt5wnMAgm7Vdi
	Kc5INNRiLipOBAADdC1Y7wIAAA==
X-CMS-MailID: 20220713102845epcas5p2e08cc1da7d55e81452826abda5afb2b6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----gI3CjneswbLFDBMWjC7-zxaVNh_2D3qTNvt6SJynUi.wTNsa=_127c51_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713054924eucas1p1f86ea1ddce488c834f552add554cbc8e
References: <20220713054914.1888305-1-hch@lst.de>
	<CGME20220713054924eucas1p1f86ea1ddce488c834f552add554cbc8e@eucas1p1.samsung.com>
	<20220713054914.1888305-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_032854_766953_741AF84B 
X-CRM114-Status: GOOD (  11.74  )
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

------gI3CjneswbLFDBMWjC7-zxaVNh_2D3qTNvt6SJynUi.wTNsa=_127c51_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Jul 13, 2022 at 07:49:10AM +0200, Christoph Hellwig wrote:
>This shorter name much better fits what this function does in
>the scanning process.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------gI3CjneswbLFDBMWjC7-zxaVNh_2D3qTNvt6SJynUi.wTNsa=_127c51_
Content-Type: text/plain; charset="utf-8"


------gI3CjneswbLFDBMWjC7-zxaVNh_2D3qTNvt6SJynUi.wTNsa=_127c51_--

