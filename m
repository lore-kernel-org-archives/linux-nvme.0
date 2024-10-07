Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE94BCFB43F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wrs5njHyhQsaY2qMFeXLDtqldIUMw8Cs3rLGXTGdDr0=; b=ncdGk74lRNMop/DvvTjwYpPNak
	yHJCXEkopBaJ1q+9GdsDR0F09VBAwvhQO8h+y2KfNHtEFYw1EfqAVu98WLUWptd+p828bqOigGYBG
	FQ4IsR68mGVRGMxfi/Rp8Fsoy1AVGUkRqomdtULZ9hRaSCTe9Lj8ED7zogg5bOh84SotrK5oAskyQ
	kW6Ym72bJAsIbDg7earOl5TxiQWVTidJU/PpIYNbc1XijFA0BMLF/OYRT2OZ7jVgNTFVpJnPILAOR
	RM/DYg2ZUKTRVeploeXKJ+g4f32E86g6tGUDJaljnfzvrAhpEaith9kW5p0HnsqNMQvXTdSi5rIfT
	h5M4YRbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkh4-000000020tl-0Oo4;
	Mon, 07 Oct 2024 10:10:22 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkgz-000000020t5-40ih
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:10:21 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241007101014euoutp0228ff379608774d797a0614e25a2a8efc~8I_LZbTFC2338923389euoutp02O
	for <linux-nvme@lists.infradead.org>; Mon,  7 Oct 2024 10:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241007101014euoutp0228ff379608774d797a0614e25a2a8efc~8I_LZbTFC2338923389euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728295814;
	bh=Wrs5njHyhQsaY2qMFeXLDtqldIUMw8Cs3rLGXTGdDr0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fttvgpktprywwOA+/0HlQCx5zxyylOxEABRZ9YUD3IhWKXU5yYU2eDkKER0RJM7pT
	 ey1PLMpk4QblRV/fzbUw4hTEBVVwayKRXKnbtN3Ez80dg7Fbyo1QBm0rnBdv+FbiFs
	 sJ7yDiDDDjYHQQotBbNXyjNfYX5/fqj9EhRtyKFw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241007101013eucas1p111022db7dfe721a110142c87b67de368~8I_LHGbUa1203412034eucas1p17;
	Mon,  7 Oct 2024 10:10:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 07.B8.09875.583B3076; Mon,  7
	Oct 2024 11:10:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241007101013eucas1p13db5988cea66fb961cbb06a99d2878c8~8I_Krfv4c1224012240eucas1p1R;
	Mon,  7 Oct 2024 10:10:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241007101013eusmtrp2e4e3882eb2a6277ce376cd99feffb5fa~8I_Kq0ipg2830128301eusmtrp2N;
	Mon,  7 Oct 2024 10:10:13 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-cd-6703b385af9f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.A1.14621.583B3076; Mon,  7
	Oct 2024 11:10:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241007101013eusmtip1593046fbf475df26d943c475dd73c5ad~8I_KYi01k0296502965eusmtip1Y;
	Mon,  7 Oct 2024 10:10:13 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 7 Oct 2024 11:10:12 +0100
Date: Mon, 7 Oct 2024 12:10:11 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Kanchan Joshi
	<joshi.k@samsung.com>, <hare@suse.de>, <sagi@grimberg.me>,
	<brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
	<jaegeuk@kernel.org>, <bcrl@kvack.org>, <dhowells@redhat.com>,
	<bvanassche@acm.org>, <asml.silence@gmail.com>,
	<linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<io-uring@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-aio@kvack.org>, <gost.dev@samsung.com>, <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241007101011.boufh3tipewgvuao@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004123027.GA19168@lst.de>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7djPc7qtm5nTDV68NbKYs2obo8Xqu/1s
	Fl3/trBYvD78idFi2oefzBbvmn6zWOxZNInJYuXqo0wW71rPsVjMnt7MZPFk/Sxmi0mHrjFa
	TJnWxGix95a2xZ69J1ks5i97ym6x/Pg/Jot1r9+zWJz/e5zVQdjj8hVvj52z7rJ7nL+3kcXj
	8tlSj02rOtk8Nn2axO6xeUm9x+6bDWweH5/eYvF4v+8qm8eZBUeA4qerPT5vkvPY9OQtUwBf
	FJdNSmpOZllqkb5dAlfGs6s7mQrOSFe83ZbTwPhXtIuRk0NCwERi+9sPLF2MXBxCAisYJZru
	NrJDOF8YJZ4/3cIK4XxmlOg58gUowwHWsuqsDER8OaNE45kVbCCjwIq+HxKDSGxmlDg65zM7
	SIJFQEXi58IPYEVsAvYSl5bdYgaxRQSUJJ6+OssI0sAscIhF4suB+WANwgIGEu+/97KBbOMV
	sJX4ddobJMwrIChxcuYTFhCbWcBKovNDEytICbOAtMTyfxwQYXmJ5q2zwcZzCuhIbL5zhhHi
	TSWJxy/eQtm1Eqe23GICWSsh0Mcl0ThxCztEwkWi91s/VJGwxKvjMHEZif875zNB2NUSDSdP
	QDW3MEq0dmxlhYSKtUTfmRyIGkeJV9N/QgOLT+LGW0GI2/gkJm2bzgwR5pXoaBOawKgyC8lj
	s5A8NgvhsVlIHlvAyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMI2e/nf8yw7G5a8+
	6h1iZOJgPMQowcGsJMIbsYYxXYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZq
	akFqEUyWiYNTqoHJw2pe+rcv03fFVURIC0/OnKQyT2v/EZv6ugff26RW/FSPSqvz1vc+V+Xn
	yr8h8Yvn9X8Xj7TkJSmahgX6TxWs9e1mVfm5+K3ljLu1lRdVcmR3K8kudxA8kqywf87M430i
	57RV9qSsV4/QnjDRSj5Vot8s9R9H2vXCu2nB3XOits+qdXD23BVRvTi3vOLKBU6vZeza/UJz
	fk/tkjDWsk3iKDaucVlfpl39aottwRb+8jjtei8r0+Jjid8WfjCRLXgkPH3Xpi13vNwk2ZQv
	zMrK9jxjf6Xop4P6yvO3rQV/aKvOTTbud2pgt7hjtb9f6MHPRROd3Wqntty/E33yh+/u5N/T
	HhXc+Zq+yu7fSSWW4oxEQy3mouJEAMwS+yASBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsVy+t/xu7qtm5nTDX5/FLGYs2obo8Xqu/1s
	Fl3/trBYvD78idFi2oefzBbvmn6zWOxZNInJYuXqo0wW71rPsVjMnt7MZPFk/Sxmi0mHrjFa
	TJnWxGix95a2xZ69J1ks5i97ym6x/Pg/Jot1r9+zWJz/e5zVQdjj8hVvj52z7rJ7nL+3kcXj
	8tlSj02rOtk8Nn2axO6xeUm9x+6bDWweH5/eYvF4v+8qm8eZBUeA4qerPT5vkvPY9OQtUwBf
	lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gs6s7
	mQrOSFe83ZbTwPhXtIuRg0NCwERi1VmZLkYuDiGBpYwSz/9eYuxi5ASKy0hs/HKVFcIWlvhz
	rYsNougjo8SM9feZIJzNjBLH151iBqliEVCR+LnwAxuIzSZgL3Fp2S2wuIiAksTTV2cZQRqY
	BQ6xSHw5MJ8dJCEsYCDx/nsvG8gZvAK2Er9Oe4OEhQROM0v8+S8MYvMKCEqcnPmEBcRmFrCQ
	mDn/PCNIObOAtMTyfxwQYXmJ5q2zwVZxCuhIbL5zBuoBJYnHL95C2bUSn/8+Y5zAKDILydRZ
	SKbOQpg6C8nUBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLTzLZjPzfvYJz36qPeIUYm
	DsZDjBIczEoivBFrGNOFeFMSK6tSi/Lji0pzUosPMZoCQ2gis5Rocj4w0eWVxBuaGZgamphZ
	GphamhkrifO6XT6fJiSQnliSmp2aWpBaBNPHxMEp1cC0gTPWO75AXqPGeadQe+v3U+a3m1ie
	lnMvPZDbkHx/2c6grGZXv825hlsjN/1+ntEjXnF618PUIpklfGedPM8+bMvfMPvJ3DVmJ0+c
	PqNqI//6utWT/yt7tz5XFGhav/XElHlVHoWq36sF5xjvPCsv8ezsq5z3MwLX/9q04cb+My/1
	ZU3OdG7wOyIf5X/MOPvWrfyVBfpMr+vvtz5sFG76GrMqMOLf7KREX0F/+7nFcRd3CFnIzp1f
	YDDLcJX/ou/rzRuPaIrcSuDbuHCi95zTkSJSeQusdD+Z8pz2TD7x4UVF7zrRHzwWtYWh3T5X
	2ha2cXusEH6x1XjWqyPn7nvN/mAvfOLBn5a2f9I7Lv0UU2Ipzkg01GIuKk4EAHcvjMe8AwAA
X-CMS-MailID: 20241007101013eucas1p13db5988cea66fb961cbb06a99d2878c8
X-Msg-Generator: CA
X-RootMTR: 20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b
References: <20241002151949.GA20877@lst.de>
	<yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <20241003125400.GB17031@lst.de>
	<c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
	<CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
	<20241004053121.GB14265@lst.de>
	<20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
	<20241004062733.GB14876@lst.de>
	<20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
	<20241004123027.GA19168@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_031018_414238_9B6501FC 
X-CRM114-Status: GOOD (  27.06  )
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

On 04.10.2024 14:30, Christoph Hellwig wrote:
>On Fri, Oct 04, 2024 at 08:52:33AM +0200, Javier González wrote:
>> So, considerign that file system _are_ able to use temperature hints and
>> actually make them work, why don't we support FDP the same way we are
>> supporting zones so that people can use it in production?
>
>Because apparently no one has tried it.  It should be possible in theory,
>but for example unless you have power of 2 reclaim unit size size it
>won't work very well with XFS where the AGs/RTGs must be power of two
>aligned in the LBA space, except by overprovisioning the LBA space vs
>the capacity actually used.

This is good. I think we should have at least a FS POC with data
placement support to be able to drive conclusions on how the interface
and requirements should be. Until we have that, we can support the
use-cases that we know customers are asking for, i.e., block-level hints
through the existing temperature API.

>
>> I agree that down the road, an interface that allows hints (many more
>> than 5!) is needed. And in my opinion, this interface should not have
>> semintics attached to it, just a hint ID, #hints, and enough space to
>> put 100s of them to support storage node deployments. But this needs to
>> come from the users of the hints / zones / streams / etc,  not from
>> us vendors. We do not have neither details on how they deploy these
>> features at scale, nor the workloads to validate the results. Anything
>> else will probably just continue polluting the storage stack with more
>> interfaces that are not used and add to the problem of data placement
>> fragmentation.
>
>Please always mentioned what layer you are talking about.  At the syscall
>level the temperatur hints are doing quite ok.  A full stream separation
>would obviously be a lot better, as would be communicating the zone /
>reclaim unit / etc size.

I mean at the syscall level. But as mentioned above, we need to be very
sure that we have a clear use-case for that. If we continue seeing hints
being use in NVMe or other protocols, and the number increase
significantly, we can deal with it later on.

>
>As an interface to a driver that doesn't natively speak temperature
>hint on the other hand it doesn't work at all.
>
>> The issue is that the first series of this patch, which is as simple as
>> it gets, hit the list in May. Since then we are down paths that lead
>> nowhere. So the line between real technical feedback that leads to
>> a feature being merged, and technical misleading to make people be a
>> busy bee becomes very thin. In the whole data placement effort, we have
>> been down this path many times, unfortunately...
>
>Well, the previous round was the first one actually trying to address the
>fundamental issue after 4 month.  And then after a first round of feedback
>it gets shutdown somehow out of nowhere.  As a maintainer and review that
>is the kinda of contributors I have a hard time taking serious.

I am not sure I understand what you mean in the last sentece, so I will
not respond filling blanks with a bad interpretation.

In summary, what we are asking for is to take the patches that cover the
current use-case, and work together on what might be needed for better
FS support. For this, it seems you and Hans have a good idea of what you
want to have based on XFS. We can help review or do part of the work,
but trying to guess our way will only delay existing customers using
existing HW.



