Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B61C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+s7xWazCsiSQTevuQChhBWMZvqG2bPqG0Dby++5yyts=; b=aFMWsc4wSC2jom7Tpc3/Bkb2CQ
	1svtNZIXjLfgOXN2D+KD4GWdF5zvLY80tZJbNNhQkKvzK0j0x/yZx+VCQ8SC0C5lRW1JOcWTCmmFY
	SgrHb6e9naeZZscy6yn1cFnXUMzgLdt1GPqmre9WUuzJJKcFZjC6vONFF1WCkKpHLoK5Rk+et7Dwp
	4EpeuA8HJc+gYGIjKB8qcS7CJGlgW9nWDjy8hvFnMIHbKSe6PxKlyKXE30Nha0aeMbJJqItqe0Aam
	AElv/MfFOuVOGiwqJ2TMTOfZvOlHblltqcqZLegISus69yUUcGKm64RSzqEMjZvb/X+w+kw3em8w+
	VOcke4Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTgq9-004lh2-9v; Mon, 14 Mar 2022 09:18:09 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTgq4-004lgP-NL
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 09:18:06 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220314091800epoutp02913b097421df272d6f5a2d7731f12495~cNKzPpQK82441124411epoutp02V
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 09:18:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220314091800epoutp02913b097421df272d6f5a2d7731f12495~cNKzPpQK82441124411epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647249480;
 bh=+s7xWazCsiSQTevuQChhBWMZvqG2bPqG0Dby++5yyts=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=RVh4/1bcfD288yD2rsk7hcvRjpsxVm14PVa8Hxy9mVOLr7e+dSck5a6q2GggCCAid
 MJYXzAIZYT9HrcsRspqDxLG3S5pXTa92hQ906wR3WJdeHcD85h2wInGiT4I1jUEIUG
 Iq1BCaM+vmZrOUdxPyAZCCbp4nQYlUSiCQWE1hM4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20220314091759epcas2p4ce1c4bdba1e3d986043157de768e8ccc~cNKyMzBRa2477824778epcas2p4f;
 Mon, 14 Mar 2022 09:17:59 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KH9tX3zWZz4x9Q2; Mon, 14 Mar
 2022 09:17:56 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-65-622f08441045
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.94.25540.4480F226; Mon, 14 Mar 2022 18:17:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] driver/nvme/host: Support duplicated nsid for the
 private
From: Sungup Moon <sungup.moon@samsung.com>
To: "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220314070808.GB3806@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220314091755epcms2p1c638716a47c2eae1a6069e2b73e5dc5d@epcms2p1>
Date: Mon, 14 Mar 2022 18:17:55 +0900
X-CMS-MailID: 20220314091755epcms2p1c638716a47c2eae1a6069e2b73e5dc5d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTTNeFQz/JYNIqNov/e46xWaxcfZTJ
 YtKha4wWl3fNYbOYv+wpu8W61+9ZHNg8Jja/Y/c4f28ji8emVZ1sHpuX1HvsvtnA5vF5k1wA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7IwTCz+yFrQIV0zaktXAeJG/i5GTQ0LAROL2zm0sXYxcHEICOxglHhy/xtbFyMHBKyAo8XeH
 MEiNsECwRN/U0ywgtpCAosTfZ32MEHFdiTX/pzCD2GwC2hL3zrxlAmkVEZCVuLKiHmQks8BP
 RonXLa/ZIHbxSsxof8oCYUtLbF++FWwOJ1Dv3/V/WSHiGhI/lvUyQ9iiEjdXv2WHsd8fm88I
 YYtItN47C1UjKPHg526ouKTErqfXoeL5Em2/F7GBHCEh0MEocf7hESaIhLnEn5fXwYbyCvhK
 tLacBzuIRUBV4vDVb1CHukhsuz8T7CBmoOOWLXzNDPIYs4CmxPpd+iCmhICyxJFbLBAVfBId
 h/+yw7y4Y94TqE2qEhcn9LDBvLtyXgPUmR4SpycuZp3AqDgLEdCzkOyahbBrASPzKkax1ILi
 3PTUYqMCY3jUJufnbmIEJ0ct9x2MM95+0DvEyMTBeIhRgoNZSYTXaqlekhBvSmJlVWpRfnxR
 aU5q8SFGU6AvJzJLiSbnA9NzXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKY
 PiYOTqkGpu0TOJL2mqTx1GVciL17OtWgamGY7sdF+1Uazs1fsU/2ivf02RLtt7OnO/dO3biK
 /2Hpi9tPUjNSGxheXjy9bZdWTteDW492r+R4fGtS9O7Vcy39uBZNcb60/fNJ9cWrZVpTn8aX
 2RiuSHVJFmDf5N1z5G9MQLx/xZ4c99l/pn9uvtfXt2bmpPBXgeKXVjPvCa1+dnHCocXrF83Z
 z/b1nXuL+IcMqdSjznk68+bVlwSs6uqan1Qd7RwRUfepvLyoWP+arcT6P8z86st2/tmX4jy1
 6MNd6yh5+Zomjui4leU7pQ5nXL2z/URMfjrj9cTHM/jF/911m3JR9dzlo0/bd0kFpu0L5PfJ
 mWTXt1H12DslluKMREMt5qLiRADrkTzyFwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928
References: <20220314070808.GB3806@lst.de>
 <20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
 <CGME20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_021805_214746_B4826FE8 
X-CRM114-Status: GOOD (  27.87  )
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
Reply-To: sungup.moon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your reply,

> =20
> On Mon, Mar 14, 2022 at 04:05:05PM +0900, Sungup Moon wrote:
> > When the multi-controller, managed by a special admin command, has priv=
ate
> > namespace with same nsid, current linux driver raise =22Duplicate unsha=
red
> > namespace=22 error. But, NVMe Specification defines the NSID usage like=
 this:
> >=20
> > If Namespace Management, ANA Reporting, or NVM Sets are supported, the
> > NSIDs shall be unique within the NVM subsystem. If the Namespace
> > Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
> > a) for shared namespace shall be unique; and
> > b) for private namespace are not required to be unique.
> > (reference: 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec)
> >=20
> > So, if a multi-controller, which is not managed by Namespace Management
> > function, creates some private namespaces without ANA and NVM Sets, the
> > duplicated NSID should be allowed because that is not a NVMe specificat=
ion
> > violation.
> >=20
> > But, current nvme driver checks only namespace is shared or not, so I
> > propose following patch:
> > 1. nvme_ctrl has unique_nsid field to identify that controller should
> >    assign unique nsid.
> > 2. nvme_init_ns_head function creates new nvme_ns_head instance not onl=
y
> >    head is null but controller's unique_nsid is false (no flagged
> >    attribute) and namespace is not shared.
> > 3. for creating bdev device file, nvme_mpath_set_disk_name will return
> >    false when unique_nsid is false and namespace is not shared.
> > 4. also, nvme_mpath_alloc_disk alto return 0 with same manner.
> =20
> From a very quick glance this looks good.  But please make sure you don't
> spill over 80 charactes per line.

I checked changes using =22scripts/checkpatch.pl --terse --file =7Bchanged =
file=7D=22,
but there is no warning on my changes. However I will recheck the spill-ove=
r
lines over 80 characters.

> Also I think instead of adding the
> unique_nsid field a little helper that checks the relevant flags might
> be a l=D1=96ttle=20nicer.=20=20It=20is=20not=20checked=20in=20a=20fast=20=
path=20anywere=20and=20the=0D=0A>=20checks=20are=20pretty=20trivial.=0D=0A>=
=20=0D=0A=0D=0AThank=20you=20for=20your=20advise=21=20I=20will=20remove=20f=
lag=20and=20add=20checking=20function=20for=0D=0Aunique=20nsid.=0D=0A=0D=0A=
Thank=20you,=0D=0ASungup=20Moon

