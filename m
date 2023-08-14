Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61D8EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zimQmN124b9hCHDFiSEFba5yy1zwRCykPczhvQAj1Nw=; b=ghBN6kNebRZI6uzilWD+BkGOJP
	XIO0c00NXrSkPdxiaa8UWy1jeznkxzM3VITqcFh0NP+5L4K+VofYNLHTiyU65mIRwrZrfX7NfXNI/
	H5XTjycuYdaG9y8Sf8meMD2pggrdJjDzUvCA5yWXRZTRFOfFcoxNW6e16ShfOLfPYvp2hBJGtzODB
	YomR5MLZL5Ng05lZvFKcpFbE3Z8IJwvTRI6gpgRtGwcBoIB12jWI3gXOCC7cRYuoLeJ4utare1Z5H
	PA9Ze2mZlrcQmVON9lYNW2N3+jXwZIj5HNIX8lRzL6H2w79zsu+f46GtlElqe4+tE2rmdDwgIRRng
	AE+s80Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVNS-00GtRm-1D;
	Mon, 14 Aug 2023 11:04:50 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVNN-00GtQn-1U
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 11:04:48 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230814110435epoutp03bd66f5908473397d535971ca1608fa62~7Oxveynl71335013350epoutp03o
	for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 11:04:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230814110435epoutp03bd66f5908473397d535971ca1608fa62~7Oxveynl71335013350epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1692011075;
	bh=zimQmN124b9hCHDFiSEFba5yy1zwRCykPczhvQAj1Nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C00AlRtovOAXiueM7XB/r5QvhL41Q1PTl1an8VavsEYr53HzxBnvYl9URITIbrneG
	 3vV+fk47e2AxixaP5RbmBJuTfofM51aqqfFiDMjTFNHFTqr9vHR6w+0Szbs/EzUs8C
	 N84F0lowhIx8YeX8axlhmzEUkstNcqMGOE8gA4b0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230814110435epcas5p439e065a790dea8509bce6fb988775511~7Oxu9c-JP2023920239epcas5p4V;
	Mon, 14 Aug 2023 11:04:35 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4RPWkS6hHXz4x9Pp; Mon, 14 Aug
	2023 11:04:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.7E.55173.04A0AD46; Mon, 14 Aug 2023 20:04:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230814103355epcas5p114de1c2977fe97f8281218a25ef3a6dd~7OW9zWzlA0591305913epcas5p1q;
	Mon, 14 Aug 2023 10:33:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230814103355epsmtrp2af3e2c51166a8e225642c7d02bb42bed~7OW9yaU--1787017870epsmtrp2j;
	Mon, 14 Aug 2023 10:33:55 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-c7-64da0a409dcb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BC.02.14748.3130AD46; Mon, 14 Aug 2023 19:33:55 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230814103352epsmtip1bfa9454f6fc7f53da273f13b70b179e0~7OW6ddTKg0808008080epsmtip1p;
	Mon, 14 Aug 2023 10:33:51 +0000 (GMT)
Date: Mon, 14 Aug 2023 16:00:29 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-doc@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
Message-ID: <20230814103029.mc5l4wt6y6dzf7db@green245>
MIME-Version: 1.0
In-Reply-To: <2e263977-0ee7-ae78-5a8a-2a67df43df76@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVRTdRjH+917t91RoxuC/QRRzqJSFNgM1uUt8ER1Cz1xjsc60UGc7MaI
	sa29iMAfEgkoCJJgySLAo4KOtyRCWixoCIt5kDrIcjPfatgJcIDg0DxQYxc6/vd5vuf5/n7P
	y3lw1KeM449nyjW0Si6W8dleWFf/5pDQBC+7RKC3C8h2yyBKFlYuomTzjWNscrL/PiC/mHmE
	ko6+EkDe7o0njc6vWKSt73uEPN88gJDHTVZAjo/pENJo30KeKj6DkT3GIYwcNdSyyfrGcQ7Z
	ZF5CyGuV44Bsm5zGyJ/tAeTIopmVsJYavZpEjdy8gFGjw1qqQ3+ETX175iD1g62ATZ2uqGJR
	5Z852dTsuB2jpn8cY1MVnXpAzXVsoDoc95BkXkpWrJQWS2hVEC1PV0gy5Rlx/KRdaa+nRYoE
	wlBhFPkqP0guzqbj+Ik7kkPfzJS5e+YH7RfLtG4pWaxW88Nfi1UptBo6SKpQa+L4tFIiU0Yo
	w9TibLVWnhEmpzXRQoFgW6Q7cW+WdMzYwVH+yjpg6Z3ACsAEVgq4OCQi4K3jerQUeOE+RA+A
	81MWNhPcB7DpWuNK4ALQ8tcsumpxlTdyltmHMAI48/tuJukugDeqznnexYgXYX1vm5txnE1s
	gZf/xZdlX2ITdN1uwpbzUaKGBbta6jyPriHehgbnsMfLI0TwutPAYfg5OFTj8OhcIgbWdPay
	l9mPWA9Pnn3gqRsSp7mwteEqi6kuEXbOWAHDa+CEuZPDsD+ccxrZDOfA89Xn2Iz5EIC633Qr
	hnhYZDnmqQglpLDa2rdiCIQnLG0Io3vD8scOhNF5sLtulV+ALe0NK/nroHXh0xWmYG2tE2FG
	NANgxZ8utBJs1D3Rne6J/xiOhkdmClk69/RQIgA2LeEMbobthvAGwNIDf1qpzs6g0yOVwlA5
	nfP/ztMV2R3AcxUhyd2g+ZvFMBNAcGACEEf5vjz7W1aJD08izs2jVYo0lVZGq00g0r2uz1F/
	v3SF+6zkmjRhRJQgQiQSRUS9IhLyn+dNFn0t8SEyxBo6i6aVtGrVh+Bc/wLkZb8N0bnTo9mD
	toCeFvE/e27h/Re2OQae0dxFjxIKE7VAZ3JyLpVyvQqP7p26+O5l1SXL9jvcra5oGYcaKUNK
	HLP27g8eCD+p/MWABZb1z1uulOQZDtlifJ9NLKiXid85HPNQO591k2JVh39n3aGPHfjj8MmB
	e5qzsx+y+INLPD9zcXDqvoS+2oSC0uiPh77MXxhoS+6Py3nv/U2NxVOaiq7uEz8N7bl+aue6
	lrXSkeDA7um6opSD+ovBxevr5raGUtur9uc3Xck/EDxi2vX3dMUdwfyw+Y2Up/a5WKnawbKd
	1t3hrTZRbS7CSlXXeH/0+OmXbI/8kmoemnvzWuNbvbzbRXxMLRULQ1CVWvwfmf2HcJ4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSnK4w860Ug4P/NSzWnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFg/221vsfTeb1eLmgZ1MFitXH2WymHToGqPF06uzmCz2
	3tK2WNi2hMViz96TLBaXd81hs5i/7Cm7xfLj/5gsbkx4ymix7vV7FosTt6Qtzv89zuog5nH5
	irfH+XsbWTwuny312LSqk81j85J6j903G9g8FvdNZvXobX7H5vHx6S0Wj/f7rrJ59G1Zxejx
	eZOcx6Ynb5kCeKO4bFJSczLLUov07RK4MjY0X2EqaGaueHftDVsD4zamLkZODgkBE4lvvcvY
	uxi5OIQEdjNKrLv2GCohKbHs7xFmCFtYYuW/51BFTxglVm99xAaSYBFQlZi/fx1LFyMHB5uA
	tsTp/xwgYREBDYlvD5azgNQzC8xllVj2+zw7SEJYwFNi17uzLCA2r4CZxO13u8DiQgIfGCWu
	PbeEiAtKnJz5BKyGGahm3uaHzCDzmQWkJZb/A5vPKWAtMXPLfrATRAVkJGYs/co8gVFwFpLu
	WUi6ZyF0L2BkXsUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERzdWho7GO/N/6d3iJGJ
	g/EQowQHs5II7y33aylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2C
	yTJxcEo1MN1YuOKnZ9yKdUyih3XvPQv0+JISmJL2u/O68ybNENZ/HrsXK+Zs3/Pf6tKXy4ab
	Zba5smxT32/6UkST4ejM/5Z3BRaUrS14kF1Vveqro/TUFZNTkkybPK4rRXzZ33xT5pty7M2y
	u2/cNz+6cklKNIe74MWS57ILzHO3NSdn/bj2xnhy29uZi9Ncwy5VbDw2QeD6xKP/e1V8W9/M
	9a+YsP3FhVObTgffvp+7lf3LHqez4SYmNcEzLt/Yf323I1NLhbHbCcXVoh9eVwj//OjBaM9e
	PatA8peP0MKrHrZPmj/d2286N0i4InB6HserhHP7j+Srd3Bxq0VN7m/bulRBQO2LqthX2Xzd
	yYJsSnXeM84osRRnJBpqMRcVJwIAvUnskl0DAAA=
X-CMS-MailID: 20230814103355epcas5p114de1c2977fe97f8281218a25ef3a6dd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_545fc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08
References: <20230811105300.15889-1-nj.shetty@samsung.com>
	<CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
	<20230811105300.15889-4-nj.shetty@samsung.com>
	<2e263977-0ee7-ae78-5a8a-2a67df43df76@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_040445_847397_49181392 
X-CRM114-Status: GOOD (  13.82  )
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

------2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_545fc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/08/11 03:06PM, Bart Van Assche wrote:
>On 8/11/23 03:52, Nitesh Shetty wrote:
>>+		if (rem != chunk)
>>+			atomic_inc(&cio->refcount);
>
>This code will be easier to read if the above if-test is left out
>and if the following code is added below the for-loop:
>
>	if (atomic_dec_and_test(&cio->refcount))
>		blkdev_copy_endio(cio);
>
Acked

Thank you,
Nitesh Shetty

------2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_545fc_
Content-Type: text/plain; charset="utf-8"


------2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_545fc_--

