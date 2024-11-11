Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A5D2E9CC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xiYjsTGGrXI0IR5ypi8tMrDyJTjM2ymp8YLvIRm9Dwo=; b=l1JJfdevGUFKX8YQcxrFnAVZsG
	Prj8u69NJItzCfRnTlWQPMjsvweLItgJ1ZBdPfuw+D7IgTO8Bah3JbPxqaaCj+rujAUhXKEV5U6t6
	a7CxHCUoj7GkcEScayFSVM/vY9fon5r4aZv31NyJ+tGJ87/naHjpYtFwLY3FdqMPn0Wl1q1sC3RkB
	i+Jy3fi2HfNmxiWj9DnZuAyOZgR8Yf+hDWeH9J5/8K2pJHaeT2G9VdraOA8DdH2Amqe02v7ZjS/h/
	qS9tsSeMHkklcAD+z8/KDtOpHwOhYATrd5FfaHNI/tNnlZ+QLlK+51ygiiO7D26ftlKOaR9RlkH2E
	NHBjZ0tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQx0-0000000H9Bg-2tFy;
	Mon, 11 Nov 2024 09:43:14 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQvS-0000000H8sB-2HO8
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 09:41:40 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241111094135euoutp0122da2b1ee18756b1c6662804812660ea~G4KKOOaJK1860418604euoutp01H
	for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 09:41:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241111094135euoutp0122da2b1ee18756b1c6662804812660ea~G4KKOOaJK1860418604euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731318095;
	bh=xiYjsTGGrXI0IR5ypi8tMrDyJTjM2ymp8YLvIRm9Dwo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eTa1kuf+2/0CWV6NSAZnVMXwKRceA0aPDfOCOxz/CponL4u+D0E3KoAtPsN6wcWv1
	 IA9oTBlu77N+/i5sfKiZF8j/5ocSUH/u80ejMa9Me+YLIE4aN72v5QNNC7rejKsiiu
	 fSr5LciadYqPhEDVJwbtH9Q1pSjS8TmhUPrycS54=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241111094135eucas1p2e7b83a15bf80250e769be0d6f07ecb74~G4KKDoKGS0251602516eucas1p20;
	Mon, 11 Nov 2024 09:41:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.14.20409.F41D1376; Mon, 11
	Nov 2024 09:41:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241111094134eucas1p1881fd0f669ff226fc9b75cbf1601cd0f~G4KJmIWYX2826128261eucas1p1f;
	Mon, 11 Nov 2024 09:41:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241111094134eusmtrp2cf90f4cb97e6b872e2957d781c3788bc~G4KJlAU9p1365413654eusmtrp2Z;
	Mon, 11 Nov 2024 09:41:34 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-fd-6731d14f4bd4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 74.5D.19654.E41D1376; Mon, 11
	Nov 2024 09:41:34 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241111094134eusmtip1fc36c5785a4c5ca5703820f449d7dec8~G4KJb7AN22553325533eusmtip1k;
	Mon, 11 Nov 2024 09:41:34 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 11 Nov 2024 09:41:33 +0000
Date: Mon, 11 Nov 2024 10:41:33 +0100
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: hch <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, Keith Busch
	<kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241111094133.5qvumcbquxzv7bzu@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <81a00117-f2bd-401c-b71e-1c35a4459f9a@wdc.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7r+Fw3TDZZe4LOY9uEns8XK1UeZ
	LN61nmOx+Nt1j8li0qFrjBZnri5ksdh7S9tiz96TLBbzlz1lt+i+voPN4vePOWwO3B6Xr3h7
	bF6h5bFpVSebx+Yl9R67bzaweZy7WOHxeZOcR/uBbqYAjigum5TUnMyy1CJ9uwSujLtrdrAV
	rOKpWH6/i6mB8TlnFyMnh4SAicSp/q1MXYxcHEICKxglOqZMh3K+MErc2bKEBcL5zCjRsnMG
	K0zLzVeLWSESyxklujdcYoSral+0kBnC2cIoMeHuCxaQFhYBVYnJ/0GqODnYBPQlVm0/BWRz
	cIgIGEv8XGcNUs8sMJVF4vqrNWA1wgLOEj1z74LZvAK2Eif3HoSyBSVOznwCNpNZwEqi80MT
	K8gcZgFpieX/OEBMTgFriTOfsyEOVZJ4/OItI4RdK3Fqyy2w1yQEJnNKPDt7FuobF4lpV6ay
	Q9jCEq+Ob4GyZST+75zPBGFXSzScPAHV3MIo0dqxFWyvBNCyvjM5EDWOEvffTWSBCPNJ3Hgr
	CHEln8SkbdOZIcK8Eh1tQhDVahKr771hmcCoPAvJX7OQ/DUL4a8FjMyrGMVTS4tz01OLjfJS
	y/WKE3OLS/PS9ZLzczcxAtPU6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8Gv766UK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MAXPT7+w9Y63h5nr52yJ7
	Dh9tq/R5k/c5Xyg83/rKaOkjkxnTbaOn/zNqYxQ8Ex8249bTZ3cbNocfvbjhf3nU9V19jZvS
	Tl52aNueeCfyTJjE6pZ7BnNmzPdcuSH5pEFvr675cnGGL6semwe83u4Wn7x4cel9z4tMHdUr
	xP22b38RGu79K6u3YL4X7+RDFaze77e4W0ypOZ4vtWGf7uIE34lGnDONhHQuJfYLfz7ix7ch
	5HWnx4OghPCzU7uCPzZqdF3Zuu3TEinFw6ZxSgKX9Lg3Lmb0iFyy+07h1G6+GVclpTxXK9lG
	mR/Nn8ofGHddK8EvWapT8lf5KYlQqRYX9Suda492L7z4Z8GTe/znlViKMxINtZiLihMB2nrr
	O8IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7p+Fw3TDTbsN7SY9uEns8XK1UeZ
	LN61nmOx+Nt1j8li0qFrjBZnri5ksdh7S9tiz96TLBbzlz1lt+i+voPN4vePOWwO3B6Xr3h7
	bF6h5bFpVSebx+Yl9R67bzaweZy7WOHxeZOcR/uBbqYAjig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jLtrdrAVrOKpWH6/i6mB8TlnFyMnh4SA
	icTNV4tZuxi5OIQEljJKbL+9jxUiISOx8ctVKFtY4s+1LjaIoo+MEqd+T2eBcLYwSrw9t4gF
	pIpFQFVi8v9LjCA2m4C+xKrtp4BsDg4RAWOJn+usQeqZBaaySFx/tQasRljAWaJn7l0wm1fA
	VuLk3oNgtpDAGWaJd4/SIOKCEidnPgGbzyxgITFz/nmwmcwC0hLL/3GAmJwC1hJnPmdD3Kkk
	8fjFW0YIu1bi899njBMYhWchGTQLyaBZCIMWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93E
	CIzWbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4Nfz104V4UxIrq1KL8uOLSnNSiw8xmgIDYiKz
	lGhyPjBd5JXEG5oZmBqamFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnVwOQw1T59
	FgP79FOr62JWVM9UMNBsstH/uv7Hyk1Lb2pPPOH025aBl0HdprWg+toR9VmrjSy7Isqs2OXi
	j71eoLaz6lvKYzNm58oAwTmtZp2LJOwKeh6Jvim84H9otX73UemfYky69o+ni6+84tdT83NK
	5MtNv3wSts5cZrqmMiBm/6Uv7+yL0mbd3ir7PyuG++B8AxPPpwcEX719mRfPH2f0TS39cNHM
	ZQ8CA6VuPuGc0VPdtGL5zj33422nrFT+eVNnBsuL76WKU+Zv9GlacSdrh6lr/8YHfUX8XbNv
	XD8ibKdVOEv8/K33LWZyDzZqrZ+9icnaZnXShr+yH/6ov1/X+3Apf1VOtdKpmEqr2jlKLMUZ
	iYZazEXFiQDKMB0NXwMAAA==
X-CMS-MailID: 20241111094134eucas1p1881fd0f669ff226fc9b75cbf1601cd0f
X-Msg-Generator: CA
X-RootMTR: 20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a
References: <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
	<20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
	<CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
	<Zy5CSgNJtgUgBH3H@casper.infradead.org>
	<d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
	<20241111065148.GC24107@lst.de>
	<20241111093038.zk4e7nhpd7ifl7ap@ArmHalley.local>
	<81a00117-f2bd-401c-b71e-1c35a4459f9a@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_014138_885223_90B73B08 
X-CRM114-Status: GOOD (  17.47  )
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

On 11.11.2024 09:37, Johannes Thumshirn wrote:
>On 11.11.24 10:31, Javier Gonzalez wrote:
>> On 11.11.2024 07:51, Christoph Hellwig wrote:
>>> On Fri, Nov 08, 2024 at 05:43:44PM +0000, Javier Gonzalez wrote:
>>>> We have been iterating in the patches for years, but it is unfortunately
>>>> one of these series that go in circles forever. I don't think it is due
>>>> to any specific problem, but mostly due to unaligned requests form
>>>> different folks reviewing. Last time I talked to Damien he asked me to
>>>> send the patches again; we have not followed through due to bandwidth.
>>>
>>> A big problem is that it actually lacks a killer use case.  If you'd
>>> actually manage to plug it into an in-kernel user and show a real
>>> speedup people might actually be interested in it and help optimizing
>>> for it.
>>>
>>
>> Agree. Initially it was all about ZNS. Seems ZUFS can use it.
>>
>> Then we saw good results in offload to target on NVMe-OF, similar to
>> copy_file_range, but that does not seem to be enough. You seem to
>> indicacte too that XFS can use it for GC.
>>
>> We can try putting a new series out to see where we are...
>
>I don't want to sound like a broken record, but I've said more than
>once, that btrfs (regardless of zoned or non-zoned) would be very
>interested in that as well and I'd be willing to help with the code or
>even do it myself once the block bits are in.
>
>But apparently my voice doesn't count here

You are right. Sorry I forgot.

Would this be through copy_file_range or something different?

