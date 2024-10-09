Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D87DCEE32D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aY3smltzT2+QB6bAt4NW22thzRqxBpoUiECX+vCKxPI=; b=hP0ilfENPGMSg3sYLzbQoqoSxw
	IWJKZaSSLsUdy/GxzW0x7JJB5PcUPvWOYYL3584e41sN/UtqWm61DayecDD4rJjWjYshGHYVn5xQR
	y5PG/TMWUqOz09OCZKZsoXRR74hWbC0jchh8aXhV0iyZKhaWGWapOTKKU73BTV45AKC/BQ8Uw3G0A
	qvu6vzhIXr0YxpaW+EdyFy0cerXhYo4bFsLa39OuR7GtmqAuwd7ydoQV4YFHY/WbnA/sr6KBaOWJQ
	VtNhk/YL7XynujRv6R3RNaWzl4hRoB8J7E/l+29v67tb9wqgpySsbssfHcGBd05S6GA7QUxi6/Gn2
	iulyFprg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syZsY-0000000A3ni-3ZZy;
	Wed, 09 Oct 2024 16:49:38 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syZgz-00000009zy0-45f8
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 16:37:44 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241009163734epoutp041e7c2cd73de8800bf79bb67e20c2dd5d~81i8UQcKp0740107401epoutp04A
	for <linux-nvme@lists.infradead.org>; Wed,  9 Oct 2024 16:37:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241009163734epoutp041e7c2cd73de8800bf79bb67e20c2dd5d~81i8UQcKp0740107401epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728491854;
	bh=aY3smltzT2+QB6bAt4NW22thzRqxBpoUiECX+vCKxPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+9tecziQwol1Q1/+E8psFWsXKWKMAgDy1UGHyhSFxN57i47bTbYjOBU7wqLIgnYu
	 +u5HCDGNPToNB6ZtqyYF3Bj8YyI/wtwk29qt6TKpRQni6X8oAhA0hyNSmFv8eennL0
	 dEZesUjDLMqysOkik7kXzrnfD84vMhJY3DCBHczc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241009163733epcas5p429d02e668ad0fa36e526a89694424be8~81i7AjyU21769017690epcas5p4o;
	Wed,  9 Oct 2024 16:37:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XNz7v4P6Yz4x9Pq; Wed,  9 Oct
	2024 16:37:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.68.09800.B41B6076; Thu, 10 Oct 2024 01:37:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241009163633epcas5p1720534b46ce90de022aec84f7ae70099~81iDtR_6y2300123001epcas5p1Z;
	Wed,  9 Oct 2024 16:36:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241009163633epsmtrp25ef6fd35eb6e0f7d15aa1687c124f70f~81iDsS4Sw0223302233epsmtrp2Z;
	Wed,  9 Oct 2024 16:36:33 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-5f-6706b14bac92
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2E.D0.08227.111B6076; Thu, 10 Oct 2024 01:36:33 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241009163630epsmtip2264d042ea2487ea6d5d95add84beb231~81iAjSaev1667016670epsmtip2y;
	Wed,  9 Oct 2024 16:36:30 +0000 (GMT)
Date: Wed, 9 Oct 2024 21:58:50 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>, Jens Axboe <axboe@kernel.dk>, "Martin K.
	Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>,
 hare@suse.de, sagi@grimberg.me, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241009162826.cpmb56rj4groafaq@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241009092828.GA18118@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjP6b29vZV03BWmhzKRFLYpCLRYyoGBMxkhN4NlZPyxxAxZAzfl
	Wbq2jKHZZMw67WA4Aigd46HLkMIkPGSI1ADCiAoSlVERMAxKhjwKwpQxHKzllsX/ft/vke98
	35dDYsICnohMVekYjUqRISZ24W03D+wPiGkilJKxUS9UYWoDqH6iiECGzVYczd9cAahseR1D
	tvwNHI12XeOgzovFHFRX38dBNv1dHP1w/msOsjYaMTQ9vspDfVuLBCruGQGopCwfIPMjf9Rp
	voWjqp9neKi2f5ODrswv4Wjo334uGjJW8I7soR8Mx9DXjBM8euhxE04/GMymm01nCbp5pZhH
	t/x0kr4+mkfQT2ce4fTSjd8J+rtWE6AHqnvt4p0T9GqzF91sXeTEuR5Nj0hhFMmMxptRJWUl
	p6qUkeKY+MR3E0PkEmmANAyFir1VikwmUhwVGxcQnZph34HY+zNFRradilNoteKgwxGarGwd
	452SpdVFihl1coZapg7UKjK12SploIrRhUslkuAQu/GT9JRywxxXfcrl816TNg9U8w2AT0JK
	Bpcsa5gB7CKF1HUAa7cauGyxAuD5yicctngO4GD7CrYTMcxW8ljBDODDvDOALawAlv/zt91F
	kjjlCycv7XZAgvKHd7ZIR9adEsOZucFtO0aN4XBkcAA4BDdKApfWCgmHX2Bv0H41zkELqFfh
	rXIr7sB86iDsu2QmHFlI1fOhzTrCYx8UBetvXCZY7Abn+ludvAiu2sxOPgfWlVx2hk8BaLQY
	ASu8A/W3i7Ynw6gUOFVXjLP8Xlh6+wqH5V+BhRtWDssLYHvlDvaBDY3VzgYecGTtKyem4dB4
	mXN13Ri0tOiJc8DL+NJExpf6sTgcnl3O5xrtC8AoT1i7SbLwAGzsCKoGXBPwYNTaTCWjDVEf
	UjE5/x85KSuzGWx/C7+YdjA1uRzYAzgk6AGQxMTugoAarlIoSFbkHmc0WYma7AxG2wNC7Pf5
	HhO9lpRl/1cqXaJUFiaRyeVyWdghuVS8RzCv/zFZSCkVOiadYdSMZifHIfmiPM63Itd94O3X
	Ozxyf4vy6U2Y8SoqsB27+MuU9a9NzzTcx2Tp2C30E/mkpl2dj20nLXeVvrqPultkCS79ZSgz
	bXHiTOQfFSVPCJlVPzpc+sWJ92yzVYlHsO5vZvvdUORjvQpY5ldSImDyvWHZwcXCXp3XdNf4
	r+sD5vfTT9csyITkB/y3gnQz9UNHuB013V2Sc4HrBe74/cPBb65PhCty9754w+3FqCu5v8ql
	IJraeDijuzB29Jn/6aep0S7Hn3u69oN78fuOyT9ekPqHFFF/mjXBOaYL90+WfprfRDbaPgyd
	i51sC6i1JIT6TjcsjD3zjy8ngXdwp9WwWhXBfCnKg2ViXJuikPphGq3iP82l/9qfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvK7gRrZ0gy97dSzmrNrGaLH6bj+b
	Rde/LSwWrw9/YrSY9uEns8W7pt8sFjcP7GSy2LNoEpPFytVHmSzetZ5jsZg9vZnJ4sn6WcwW
	j+98Zrc4+v8tm8WkQ9cYLaZMa2K02HtL22LP3pMsFvOXPWW3WH78H5PFutfvWSzO/z3OanF+
	1hx2B3GPy1e8PXbOusvucf7eRhaPy2dLPTat6mTz2PRpErvH5iX1HrtvNrB5fHx6i8Xj/b6r
	bB59W1YxepxZcAQoebra4/MmOY9NT94yBfBHcdmkpOZklqUW6dslcGX8b5nMXLCNo+LMo3a2
	BsY3bF2MnBwSAiYSXS/msXcxcnEICexmlPi7/zJUQlJi2d8jzBC2sMTKf8/ZQWwhgUeMEv1t
	OV2MHBwsAioSDxaLgZhsAtoSp/9zgFSICChJPH11lhFkJLPAfRaJt83TwcYICxhIvP/eywZS
	zwu0d8fWAIi1h5klPs6dATaeV0BQ4uTMJywgNrOAmcS8zQ+ZQeqZBaQllv8Dm88poCNxdPFe
	tgmMArOQdMxC0jELoWMBI/MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgCNfS2sG4
	Z9UHvUOMTByMhxglOJiVRHh1F7KmC/GmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEk
	NTs1tSC1CCbLxMEp1cAk9qlPMYg1+7xQj/Uk70MvrW14WxsF5scXcig4bj1zcY2nR53fo01M
	jL1px5hszbRXl68Jn+/AmO4XefbvuVjT5RNq1FnMPgkbnJhvdL75+LxPJwtydB8fM94mV9XP
	UsZ17nzg4na1wuDZXL27In7si9o+P3jyNEaTXuaz2b0rZ93cvMloQujW++J/c8/0PCy0Kmhe
	9MSpo33ZgTUuezrdDp+Ye+qd8g2xaBOXE6br0pVP3Pt6wEpU5oPr80ch5/P8+RT8nEPkPTSV
	3AX+/ZPYbPHJavrFsyzdPm03Bfa+67mRtjZgs+vX4H253FOMFI7POeNpsPTZuT339gs4OXGe
	LF+4s+ln74kbUvfz1R8rsRRnJBpqMRcVJwIABjvMN18DAAA=
X-CMS-MailID: 20241009163633epcas5p1720534b46ce90de022aec84f7ae70099
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_2bc10_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b
References: <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
	<20241004053121.GB14265@lst.de>
	<20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
	<20241004062733.GB14876@lst.de>
	<20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
	<20241004123027.GA19168@lst.de>
	<20241007101011.boufh3tipewgvuao@ArmHalley.local>
	<20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp>
	<20241009092828.GA18118@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_093742_615461_336F0441 
X-CRM114-Status: GOOD (  16.16  )
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

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_2bc10_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 09/10/24 11:28AM, Christoph Hellwig wrote:
>On Tue, Oct 08, 2024 at 08:44:28AM -0600, Keith Busch wrote:
>> Then let's just continue with patches 1 and 2. They introduce no new
>> user or kernel APIs, and people have already reported improvements using
>> it.
>
>They are still not any way actually exposing the FDP functionality
>in the standard though.  How is your application going to align
>anything to the reclaim unit?  Or is this another of the cases where
>as a hyperscaler you just "know" from the data sheet?

I think Keith already[1] mentioned a couple of times in previous replies,
this is an optional feature, if experiments doesn't give better
results, FDP hints can be disabled.

>
>But also given that the submitter completely disappeared and refuses
>to even discuss his patches I thing they are simply abandonware at
>this point anyway.

Kanchan is away due to personal reasons, he is expected to be back in a
week or so.

Regards,
Nitesh Shetty

[1] https://lore.kernel.org/all/ZmjSwfD1IqX-ADtL@kbusch-mbp.dhcp.thefacebook.com/

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_2bc10_
Content-Type: text/plain; charset="utf-8"


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_2bc10_--

