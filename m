Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B520EE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 07:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cej4R47hwsUoLrP3kMO4xkB8phBdyh7ScwQgbs9zXgI=; b=ER1dhm6n5n7nDZDNss23MPGxy8
	x1KMXwGAC2NWJdMvxepqZ2QA9Jh+tvK09RkpCB+ygjx5UfNCzfp9uH4M9ocU9aR50Ig6jgW86dX+N
	17q/5xGu0pkQv6dlkqX3IyY6/CARkUIUL66A60VDjyCxi5+OeJe+0Pv3mzid5yWvB1lRkDnTF+DED
	2NfZYxfJ06YVoc1ZupHYdGHe68cP56nuPx4SjKWnfXHVF7alkparC6+EdqoSb5zXbh531WtArPWvR
	9R8xlXAHSbR8RNKm7ue3iDJ3BCTDlJilqCSMGGytnsuHihZJzXl4ElPrgSTMe8M1/MgFlyXOgYbjk
	Dz4eztEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbLM-00HPR1-0x;
	Mon, 11 Sep 2023 07:28:24 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbLJ-00HPP4-1t
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 07:28:23 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230911072811epoutp0375652b1d596d685fdebb011577c2fa86~Dx4yV4Xua3179931799epoutp03i
	for <linux-nvme@lists.infradead.org>; Mon, 11 Sep 2023 07:28:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230911072811epoutp0375652b1d596d685fdebb011577c2fa86~Dx4yV4Xua3179931799epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1694417291;
	bh=cej4R47hwsUoLrP3kMO4xkB8phBdyh7ScwQgbs9zXgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GbR8WTq31VsWy1GM/Yio3YcnbQ+mefmCIi5CMrI386+akMsNcDTkOgKWI4JcXrkwP
	 3tM9Muhcf2K2dLepVat1/noXEDIwIDJWn7aJLGmf+yr8U6mUH7bpZcVcbmaHRCeiBd
	 UvM5VbfvwfRdCnftjwQXZIbHtBgyJF3i5ATbWLT8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230911072810epcas5p1d562705d89cfbb6478ca8b261932bcdc~Dx4x02aCc0929309293epcas5p1H;
	Mon, 11 Sep 2023 07:28:10 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Rkdbs5Kl4z4x9Q2; Mon, 11 Sep
	2023 07:28:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.82.19094.981CEF46; Mon, 11 Sep 2023 16:28:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230911071326epcas5p3600b9cef197147920fe1e3b4ab2779eb~Dxr5xvs_B1633516335epcas5p3e;
	Mon, 11 Sep 2023 07:13:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230911071326epsmtrp14b58900234d6bef91d34adefe1eac313~Dxr5wxixP1320513205epsmtrp1d;
	Mon, 11 Sep 2023 07:13:26 +0000 (GMT)
X-AuditID: b6c32a50-39fff70000004a96-19-64fec189d7e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.B4.08788.51EBEF46; Mon, 11 Sep 2023 16:13:25 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230911071323epsmtip1e24502945ef6ea5aa939e28947e74d3d~Dxr3KQ5gg0358803588epsmtip1M;
	Mon, 11 Sep 2023 07:13:23 +0000 (GMT)
Date: Mon, 11 Sep 2023 12:37:24 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, martin.petersen@oracle.com, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 09/12] dm: Add support for copy offload
Message-ID: <20230911070724.GA28177@green245>
MIME-Version: 1.0
In-Reply-To: <cb767dc9-1732-4e31-bcc6-51c187750d66@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH/d3bXi5snZcK4wdMJdds4bEC1bZeHMwpzF0jMsYiCSamdPSO
	EqBt+hjilsDmgOCDhyCZ5SGCgMACoyUElQ4sShUkBpUWms1XAANkMJiIi4Ot5cLif59zzvf8
	zjm/k4Oj/FXMD09T6hiNUpZBYh6crv6gQEHhjVV5eK41kGofHECp1t+LMWq2fxFQE30FgDLP
	VXKp8b6rCNVTdw6hmltvIdQ5iw1Qk6MGhDI7QqhL+Zc5VI/5Dod6cK0Koy42TrpRTdZVhBor
	mQRU2+w8h7rt8KfurVi5n3jR9x51cOgHw3ra2FKI0abLOfT18VyMri8q49JnT85h9MKkg0PP
	/zqK0UWdLYA2DX1L/2XcRhsn/kDieUfTIxWMTM5oAhhlikqepkyNIg99KY2WiiXhQoEwgtpN
	BihlmUwUGRMbLziQluEclQz4Rpahd7riZVotGfZxpEal1zEBCpVWF0UyanmGWqQO1coytXpl
	aqiS0e0RhofvFDuFyemK0vt2VF3ucXykdBzLBVfxU8Adh4QIzt9aRk4BD5xP9AA4/eonwBqL
	AM7bO1GXik+8BLDd+tZGRsU/Z9YzzACuvDZxWWMKwBHTojOC4xziffh3ZZYLMSIEDv27Vs2L
	IOFCgcXNJUeJJxxYarSjLs0WYi9ctnm5kEcI4PP8d11yHuEJ71yY4LjYnfgIGrv7MBd7Eztg
	X5d1rQVIlLnD0WcNa89AIgY+MtJsm1vgjLXTjWU/OF2cv85ZsLn8Csbm/gigwW4AbGAvzBss
	XpsXJRTQUXYXZf1b4fnBNoT1vwPPvp5AWD8Pdtds8A74c3stxrIvtC1/v840rF9+yGG/ZwHA
	geE5tARsN7wxnOGNeix/CGuvL2IG5zwo4Q+bVnEWg2D7tbBawG0Bfoxam5nKpIjVQoGSyfp/
	3ymqTCNYO4Tg+G7Q+stKqAUgOLAAiKOkF09nWZHzeXJZ9glGo5Jq9BmM1gLEzlWVon7eKSrn
	JSl1UqEoIlwkkUhEEbskQtKHN5tXLecTqTIdk84wakazkYfg7n65yOkTFO29K3HrjKLmSY8p
	WvBVZNhJTz6v48yUcD5bX1pUnEN/UHEj7kh/QWPaxeeKzRFNV967f3Ppi98+hfurZmxD+xIa
	/XwTG4aRu53KbP+3b8fZY7+rloJNWNzx6P7sEBhcXDF95GjXq6WxsN6XJTVtUYk/iBPq8c/D
	bpqbljxikyXnI5pnv/Z8kaQXdU/t7tvjSAp8WumVNFejr86KET3uB73ArgtyVBw+FjPTEV3e
	qxzO+4w7MpN1ANv5+IW4cO6Q9bB1KvlYbOX2P+PHa8wJ9px90s22noPWugubmvgO8zatT9zT
	/AbkIHm67mG0pWK000dcMuY7YErCqi7Zng2THK1CJgxGNVrZf9JDBzmRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnK7ovn8pBi+XW1usP3WM2WL13X42
	i9eHPzFaPDnQzmix991sVoubB3YyWexZNInJYuXqo0wWkw5dY7R4enUWk8XeW9oWC9uWsFjs
	2XuSxeLyrjlsFvOXPWW3WH78H5PFjQlPGS3WvX7PYnHilrTF+b/HWR1EPM7f28jicflsqcem
	VZ1sHpuX1HvsvtnA5rG4bzKrR2/zOzaPj09vsXi833eVzaNvyypGj82nqz0+b5Lz2PTkLVMA
	bxSXTUpqTmZZapG+XQJXRtOlXuaCK+wVPT+esTcwTmLrYuTkkBAwkZj2p4epi5GLQ0hgN6PE
	v5N9TBAJSYllf48wQ9jCEiv/PWeHKHrCKLHr4xKgBAcHi4CqxM/Z5SAmm4C2xOn/HCDlIgJK
	Eh/bD4GVMws8YZGY+/chWLmwgL3E92siICavgK7E8zYxiIkfGSV+d+5gBenlFRCUODnzCQuI
	zSygJXHj30smkHpmAWmJ5f/AxnMKWEts2nEA7HxRAWWJA9uOM01gFJyFpHsWku5ZCN0LGJlX
	MUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx7GW1g7GPas+6B1iZOJgPMQowcGsJMJb
	cuhvihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MudXf
	4ktYwhKj5qterlRYYhkj3PjHIPCe35bvPAaHbr6K+FfIqGbOuCNXuf1nnJdamsLGgzeVTjm7
	qzM2G9pEmIptakhznnjafEE0/+qTfqd6NSqeKLaV/XK8bvvj5pIdO06um6Z8Y8LzoKTAN5a3
	I+Pif5jERwaezDAQ67T1P3RS2qz32eqsd9kv3nCVB25zfyla+uJ92mrPkB3mh6K9lGc1HZDo
	OVWw5LXHi8xz9RVrSu1vdcyMTpNuY5gcXRMRXXyk94Tdz70pQTby0QH7tVgTu6YGv1hy/uyT
	ljNaimdeva+5Zqh7rEN1/pWEy66lXzat/H17nq3e6tpfrTN3XmZamv5O4MwlzQCWyOtKLMUZ
	iYZazEXFiQBBrOgmUgMAAA==
X-CMS-MailID: 20230911071326epcas5p3600b9cef197147920fe1e3b4ab2779eb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daab9_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2
References: <20230906163844.18754-1-nj.shetty@samsung.com>
	<CGME20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2@epcas5p3.samsung.com>
	<20230906163844.18754-10-nj.shetty@samsung.com>
	<cb767dc9-1732-4e31-bcc6-51c187750d66@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_002821_972697_D8D1CBA2 
X-CRM114-Status: GOOD (  19.46  )
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

------EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daab9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Sep 08, 2023 at 08:13:37AM +0200, Hannes Reinecke wrote:
> On 9/6/23 18:38, Nitesh Shetty wrote:
> > Before enabling copy for dm target, check if underlying devices and
> > dm target support copy. Avoid split happening inside dm target.
> > Fail early if the request needs split, currently splitting copy
> > request is not supported.
> > 
> And here is where I would have expected the emulation to take place;
> didn't you have it in one of the earlier iterations?

No, but it was the other way round.
In dm-kcopyd we used device offload, if that was possible, before using default
dm-mapper copy. It was dropped in the current series,
to streamline the patches and make the series easier to review.

> After all, device-mapper already has the infrastructure for copying
> data between devices, so adding a copy-offload emulation for device-mapper
> should be trivial.
I did not understand this, can you please elaborate ?

Thank you,
Nitesh Shetty

------EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daab9_
Content-Type: text/plain; charset="utf-8"


------EkYAGCX2vluH006HpQv8E927.wBqYttzOq6t00vxo_cq_k4p=_daab9_--

