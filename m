Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8B6C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H818+13YpV9/u4Ci5ZQ7RF6G8btqqy4g1BY8TsFrLhM=; b=xEprOCEWg78Ry97l5uJVCKESNO
	RvMO8xqPI4C1uomzbdXrisCZcD+pcUl1RwNo5XpLJAPC5MZt2BoCInoVeXuVPXDs7kZSqXKmvIu+g
	tLFdqLkscxUYEyaH7eC4QTN1w9tRnEACHB/FzXKICeeP0+1QVaxkUTTp112wKpyBpEUNYsvl5M/xL
	Oqi7hinUpeR0SipVnyE8AyvnP6XuavNiC9WG89XjgSi87Yzz+QDE34QCCiCpBm2aeSl3P4FqcSZTb
	Fea2Z/4zghPdgYhDZQnN2eQKoLPL2cgOYnTaquTJg+AJsG5Kb7Ft/U6NURsh2dlQ7I2+A0JhiExgs
	bHfPMMQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZem-002i5i-UY; Wed, 13 Jul 2022 10:31:48 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZej-002i3w-Li
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:31:47 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220713103141epoutp01cc06176da85d1482b015fef42a006655~BXOrsrbHR3175631756epoutp01z
	for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 10:31:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220713103141epoutp01cc06176da85d1482b015fef42a006655~BXOrsrbHR3175631756epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1657708301;
	bh=H818+13YpV9/u4Ci5ZQ7RF6G8btqqy4g1BY8TsFrLhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8uHSJx2vF9FGpa9NR0OV0txjbOjTABjACTzxm7UUD8CR1aoDTuPOCMo7sIUk1hWZ
	 2EgjhWsetFR3zHs+6mqpWtPFpY3RGNN38quzOxDQg4JCZh8IfMQushlqORVOwMUdq6
	 M7B/Gey9a44Z3SrGpRi8sn4knQVcmAL4iGAOrv3A=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220713103141epcas5p48f65cb42790e2b518bcb9f2b57065adc~BXOrZqgXx0345603456epcas5p4G;
	Wed, 13 Jul 2022 10:31:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4LjYnk05WBz4x9Ps; Wed, 13 Jul
	2022 10:31:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.E7.09566.70F9EC26; Wed, 13 Jul 2022 19:31:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220713103135epcas5p32698549d71b371df1e92557e6c8aca5c~BXOlmH6FM1249812498epcas5p3P;
	Wed, 13 Jul 2022 10:31:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220713103135epsmtrp2d2ab660a0be6d80b1ab2ce9f48ba1ef3~BXOllOFKn2160621606epsmtrp2k;
	Wed, 13 Jul 2022 10:31:35 +0000 (GMT)
X-AuditID: b6c32a4a-b8dff7000000255e-f3-62ce9f07c1db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	68.C1.08905.70F9EC26; Wed, 13 Jul 2022 19:31:35 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220713103134epsmtip1eb995ee2a9e1cf7a2c2e17ceadc746d6~BXOkhscZB3078630786epsmtip1X;
	Wed, 13 Jul 2022 10:31:34 +0000 (GMT)
Date: Wed, 13 Jul 2022 15:56:11 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Granados <j.granados@samsung.com>, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH 4/5] nvme: factor out a nvme_ns_is_readonly helper
Message-ID: <20220713102611.GC30733@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220713054914.1888305-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTU5d9/rkkg5MTLC1uHtjJZLFy9VEm
	i6X7HzJanGzcw2ox6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm0ffllWM
	AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
	KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEK
	E7IzdqyczVLQzlox738/UwPjLpYuRk4OCQETidZrm1i7GLk4hAR2M0r8v3qWCcL5xChxYsE2
	qMw3RonOR2/YYFpWTrrLDJHYyyhx7NJjdgjnGaPEhQurWUGqWARUJSb++g9kc3CwCWhKXJhc
	ChIWEVCSePrqLCNIPbPAfEaJj1cngh0iLOAm8ejhCTCbV0BXYumy60wQtqDEyZlPwOKcAkYS
	d/7PZgaxRQWUJQ5sO84EcVErh8Slm44QtotE65utrBC2sMSr41vYIWwpic/v9kJ9kCxxaeY5
	qN4Sicd7DkLZ9hKtp/qZQW5mFsiU+HfKCSTMLMAn0fv7CRNIWEKAV6KjTQiiWlHi3qSnUJvE
	JR7OWAJle0is/H4HGj5rGSV2frvEOIFRbhaSb2YhbJgFtsFKovNDEytEWFpi+T8OCFNTYv0u
	/QWMrKsYJVMLinPTU4tNC4zyUsvhUZycn7uJEZwutbx2MD588EHvECMTB+MhRgkOZiUR3j9n
	TyUJ8aYkVlalFuXHF5XmpBYfYjQFRs5EZinR5Hxgws4riTc0sTQwMTMzM7E0NjNUEuf1urop
	SUggPbEkNTs1tSC1CKaPiYNTqoGpJL7kqZ/3mnCpinf2c3OyTzZb+Hk92bd6mW+844QJWi5R
	2/fd85fvn3G2e+bOLTME86xlXrzWPbh34dVP35cKbqidMe8Iu/OFsGspS/0THn+6eSSl/of0
	ap9JVuo1ZzcVbNjnZfc19aPg4YqHi3OXW09akSiRaajBdujsje8bb/5UPrlz0ybRFTkm9Tfm
	KMkEFTGV+63pmMs7e4vA6uOGYoeEl6z+PEWKJfy+8b6Vx6P3Mwe81wqV+267I+igv1TLr5y5
	hpa7pjK/vH78YsYhwTQJo2ndGXyF88NtnidvnnVVPibO8lB9g9//yn8/FtTsWb9xmT7bBA1L
	JZX4Jm2XF0/UlHRqpruL5H7+2H27WImlOCPRUIu5qDgRAOKFhCAgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnC77/HNJBs/WCFjcPLCTyWLl6qNM
	Fkv3P2S0ONm4h9Vi0qFrjBbzlz1lt1j3+j2LA7vH+XsbWTw2repk89i8pN5j980GNo++LasY
	A1ijuGxSUnMyy1KL9O0SuDJ+n3jCWrCNqaJ/5UnmBsZmpi5GTg4JAROJlZPuMncxcnEICexm
	lHi74CFUQlyi+doPdghbWGLlv+fsEEVPGCXmXLvLBpJgEVCVmPjrP2sXIwcHm4CmxIXJpSBh
	EQEliaevzjKC1DMLzGeUOLFwPwtIQljATeLRwxNgNq+ArsTSZdeZIIauZZQ4cqWJHSIhKHFy
	5hOwImYBM4l5mx8ygyxgFpCWWP6PAyTMKWAkcef/bGYQW1RAWeLAtuNMExgFZyHpnoWkexZC
	9wJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFRoKW5g3H7qg96hxiZOBgPMUpw
	MCuJ8P45eypJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6p
	BiZ9sTmbwh793zbFetNft4MfErztstvTvEpff069GdrzTvF6zLOHrVkODXNC82y+hIdeuq0T
	/nDx+Tl1fsU+ZskcAXM31Oz/y39o1p2L1SUT/rN6v4ndfGkqk5Is44vnt4/2/f2msOq5NcOH
	M/M1IyRPtwqXH61YrBy7r/78htgN/m7zd0osm8J86YnI3scPPs56XMuc/0npxtTvAkcZbp71
	dBLo0WSrz1yati60uedHrNeb1rUL57970Sno3+llsELwBlfQZ6njnKz/1JbNu1TxNLzpfhLj
	6wSro9fb3NR4/x3J3T2j/nxHP+/MmsI9WbqW92ytXzlyfJvQN/vjDNGlfqoWR2w3TRS+1dm2
	7JSEEktxRqKhFnNRcSIAMFkrp/ECAAA=
X-CMS-MailID: 20220713103135epcas5p32698549d71b371df1e92557e6c8aca5c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----fdgKPeBBSv2AmZNwmNmcr-uT4EHTSQ452lPRzqrrVt0epNMO=_12839b_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713054933epcas5p25dfdca679fc3dd51d10ad825a687278a
References: <20220713054914.1888305-1-hch@lst.de>
	<CGME20220713054933epcas5p25dfdca679fc3dd51d10ad825a687278a@epcas5p2.samsung.com>
	<20220713054914.1888305-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_033146_071648_ED2D9D39 
X-CRM114-Status: GOOD (  13.75  )
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

------fdgKPeBBSv2AmZNwmNmcr-uT4EHTSQ452lPRzqrrVt0epNMO=_12839b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Jul 13, 2022 at 07:49:13AM +0200, Christoph Hellwig wrote:
>Add a little helper to check if a namespace should be marked read-only
>that uses a new is_readonly flag in the nvme_ns_info structure.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------fdgKPeBBSv2AmZNwmNmcr-uT4EHTSQ452lPRzqrrVt0epNMO=_12839b_
Content-Type: text/plain; charset="utf-8"


------fdgKPeBBSv2AmZNwmNmcr-uT4EHTSQ452lPRzqrrVt0epNMO=_12839b_--

