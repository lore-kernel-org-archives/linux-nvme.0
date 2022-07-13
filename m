Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1001C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jzw36Nw/GfhwaILv0wcJDmIBXK2NVUCmHvUd2fTy7WU=; b=saD8KZt1mH0/9avewIQF0yDzPN
	4yT/4jDWfdHH2lNo2Onve5eXGBt2ICbEMuoPMmp+OrmY3mve35VogFoJQAHgzul93zmhBsWmP5RBK
	xSzqmASdj7Zq0eqqO/yPTC9QedA7rebefyAsKA9lyRJU5SqErLF4+q22pehRp57YKxV+tXjYyrCMX
	t5V6wjG3VhKR9ZPsyCLSGuBx1SA/3KESzer1ISNMnLNMWm420s/kOLwn1szyMejDRfmX3QsEDY4LU
	zTClU+l/qaSoJGyR1mTIhZ3ag5e6I5abh0S27Faf6KHSSCjxL1tp0mwTgdfmBY+mZtfCEU0fi+EvG
	N8Myfpkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZdU-002hfj-TX; Wed, 13 Jul 2022 10:30:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZdS-002he9-7y
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 10:30:27 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220713103024epoutp0444217a409db1b530936a89775fe0d816~BXNjVlX6x2354923549epoutp04Z
	for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 10:30:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220713103024epoutp0444217a409db1b530936a89775fe0d816~BXNjVlX6x2354923549epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1657708224;
	bh=Jzw36Nw/GfhwaILv0wcJDmIBXK2NVUCmHvUd2fTy7WU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJGLeq4LUTYncEbpOIWscwylKPfYheXrBG8tx5DdpL0vHHhgBhTcVVJezHrdOrK4i
	 pSWxsxSX2khdGvl7hFWCNMYpjxMctbgEsmdRP67e6Gy+E+bDaSQTpJ91cv5PPD9uQn
	 T+GJcSse2g7MxlxNJPlZZT3YlbzC8iZcHAN5F2YY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220713103021epcas5p3370b6479fbb264ee23b73ff5078953fa~BXNg3mICt1264712647epcas5p3S;
	Wed, 13 Jul 2022 10:30:21 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4LjYmC0kxJz4x9Px; Wed, 13 Jul
	2022 10:30:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.71.09639.ABE9EC26; Wed, 13 Jul 2022 19:30:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220713103018epcas5p2090e59ac00c57dde13825ba2c4486d0c~BXNdvc6J52713827138epcas5p2K;
	Wed, 13 Jul 2022 10:30:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220713103018epsmtrp1cda48e08f726812c1d49b90425598647~BXNdujD5r0750607506epsmtrp1V;
	Wed, 13 Jul 2022 10:30:18 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-0f-62ce9eba6d6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.A1.08905.ABE9EC26; Wed, 13 Jul 2022 19:30:18 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220713103017epsmtip19661fc73c6645e3b0877027a38353a3a~BXNcrIufj3080130801epsmtip13;
	Wed, 13 Jul 2022 10:30:16 +0000 (GMT)
Date: Wed, 13 Jul 2022 15:54:54 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Granados <j.granados@samsung.com>, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH 2/5] nvme: generalize the nvme_multi_css check in
 nvme_scan_ns
Message-ID: <20220713102454.GB30733@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220713054914.1888305-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTS3fXvHNJBk87pSxuHtjJZLFy9VEm
	i6X7HzJanGzcw2ox6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm0ffllWM
	AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
	KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEK
	E7Izjq49x1ZwmLWi49lvlgbG1yxdjJwcEgImEiu2HmbsYuTiEBLYzSix59lJsISQwCdGiSPL
	yiES3xglvh6byA7T8fHUGnaIxF5GiX9rNkI5zxgltt78zgZSxSKgKvF06j+gBAcHm4CmxIXJ
	pSBhEQEliaevzoKtYxaYzyjx8epEsHXCAiESu7dsZwWxeQV0JVYve8QIYQtKnJz5BKyGU8BI
	om/ZOyYQW1RAWeLAtuNMIIMkBBo5JM7cXcwGcZ6LxM4bU5kgbGGJV8e3QJ0tJfGyvw3KTpa4
	NPMcVE2JxOM9B6Fse4nWU/3MIDazQIbEwamXWSFsPone30+YQJ6REOCV6GgTgihXlLg36Skr
	hC0u8XDGEijbQ2Lag0ZmSKCsZZR4828q0wRGuVlI/pmFZAWEbSXR+aEJyOYAsqUllv/jgDA1
	Jdbv0l/AyLqKUTK1oDg3PbXYtMA4L7UcHsnJ+bmbGMEpU8t7B+OjBx/0DjEycTAeYpTgYFYS
	4f1z9lSSEG9KYmVValF+fFFpTmrxIUZTYPxMZJYSTc4HJu28knhDE0sDEzMzMxNLYzNDJXFe
	r6ubkoQE0hNLUrNTUwtSi2D6mDg4pRqYcl6xW/+8mRe5dF3JS95jXeYPivNYJ+Y7+xxlLVXb
	x7TbMmZx8zvBHScf7NnAnvPkwg+Dhv0PJn1Pdf/PFZ++YMGzozeuBAvvu+C27einHob3Cstf
	OFkIrHUKkI504HHarmV65e3ZX3zl5xfaWUpsSZtzOOXjq3l8/+Q4nb8s6u+ozbz4l7ftSIpc
	0G79rlVrvLk66vad+eCWIfFvnmuT8lf/Vwc8cp6X7hEO49wy+0mDfUb1zZovb3NY8m2YDSPd
	Ev0P2YXlbXvBpLKx/UP82aoFQlxrSn60ZTZKlmRvEvLtSIrQCMmX+Zpx/JG+xaG0ej8x5lOH
	RZoEl2zYsCldJikzJE52Ed8Nv4vvE84rsRRnJBpqMRcVJwIAudQaFSIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO6ueeeSDFauZLe4eWAnk8XK1UeZ
	LJbuf8hocbJxD6vFpEPXGC3mL3vKbrHu9XsWB3aP8/c2snhsWtXJ5rF5Sb3H7psNbB59W1Yx
	BrBGcdmkpOZklqUW6dslcGX8XBtb8JWpYsfBK8wNjNuZuhg5OSQETCQ+nlrD3sXIxSEksJtR
	Ys3qNWwQCXGJ5ms/2CFsYYmV/55DFT1hlLi8/AMrSIJFQFXi6dR/QAkODjYBTYkLk0tBwiIC
	ShJPX51lBKlnFpjPKHFi4X4WkISwQIjE7i3bwXp5BXQlVi97xAgxdC2jxM6lt5ghEoISJ2c+
	AWtgFjCTmLf5ITPIAmYBaYnl/zhAwpwCRhJ9y96BfSAqoCxxYNtxpgmMgrOQdM9C0j0LoXsB
	I/MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgGNDS3MG4fdUHvUOMTByMhxglOJiV
	RHj/nD2VJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANT
	/SzbfWZfp8o9NTpY72noskLD/PGk07M71l82/rYh/d1dHRMpmbm5Br+bTxku4tjx/sYC5jc9
	Qo4B3Q/YGPX97iy0SF2q9HXKbLvAmr3yHul1X774WksbrjHhvxP2Ys+m5/cvCm5rvDxVWv+X
	9TY7oXWPbYR8HyxcFq2iKsOkftFvd5jmNG6B24u39B7fMdf17+fXge9j1i6dWyAzb7PN4d9t
	ioVaHD8D4wrX/LlgprqPe4VYtp7JcYGqmB75F/OvLJvHfukk0xdXre9dJnt5Lxr/yuGYfaR0
	25qPCr2npH429+33dQs5XJcSbHQt5lznZMMnDDkHt6vc+jzRZ/bRdT/a7k6+b6w+Zfqfy7Zz
	opVYijMSDbWYi4oTAX2vnqfwAgAA
X-CMS-MailID: 20220713103018epcas5p2090e59ac00c57dde13825ba2c4486d0c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_87eca_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713054927epcas5p2cdc76a0ef0c1a746560fdce7b9a40c72
References: <20220713054914.1888305-1-hch@lst.de>
	<CGME20220713054927epcas5p2cdc76a0ef0c1a746560fdce7b9a40c72@epcas5p2.samsung.com>
	<20220713054914.1888305-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_033026_631276_6F05B400 
X-CRM114-Status: GOOD (  12.05  )
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

------OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_87eca_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Jul 13, 2022 at 07:49:11AM +0200, Christoph Hellwig wrote:
>Check for multiple command set support early on an error out if is
>not supported when a !NVM command set namespace is found.  This
>prepares for adding command set independent passthrough support.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_87eca_
Content-Type: text/plain; charset="utf-8"


------OEEzMZle2oafIX2psGkTvPl59BrXC3apHO-sLjJPJT1qP5Pe=_87eca_--

