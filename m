Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEC0C7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 04:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zcU6IjB4u/22TyyisQQULD/h8tBU/XrCaBjr/0ylBas=; b=g/7uQ9u42A1fW+NuVm+LVx8vhA
	kxpU73SmOqy2h7qNMsUhnQDTFRWM8Er6f0M8Im5wkygAios80FJSr4NfZQYm0sV45l0Y0d2Gefdl9
	uy3JJ/DHLr552+yj8WJ38bXXlI1NIsPUBQM8jafj9IFvESvB/zByxZL2HFnMq0Rv9ZWebKf6itazk
	gSaDpuBuU3YD2RMyNLABToWU6YZYT0zqI24+DLs/E3tr2ggxPI3o9ki67461wWdVH//DJYGki6VB+
	O6DGRb/KDXqYfm9Wkt+5SQoWdv0yQKRWZw43OpkrhkQyCtLbBUGJbfHyf6bYUHW9ClznjJm6hejyM
	rC+t+wqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkHDb-006J59-21;
	Thu, 06 Apr 2023 04:27:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkHDX-006J3k-37
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 04:27:25 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230406042716epoutp019981b64ebc49079ec4f3c76c0cb5b252~TPfucuFi42779127791epoutp010
	for <linux-nvme@lists.infradead.org>; Thu,  6 Apr 2023 04:27:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230406042716epoutp019981b64ebc49079ec4f3c76c0cb5b252~TPfucuFi42779127791epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680755236;
	bh=zcU6IjB4u/22TyyisQQULD/h8tBU/XrCaBjr/0ylBas=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=M6YjglXt0H2VjbVqCgQpO+98KMyVPjGwmokOU+jpxN97jZReCKutXPwOs7Wxk6Y+B
	 1vHQxGAlrjoCHTUICn+bc611avbAbodyFNWh2oZnEmPAZmxz9DX3n/SkoY0THMmwNO
	 ZmcNwnvJle9bLn1xeE+viTirtiOT0kW9M1r832YE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20230406042716epcas2p2a0118b5f7be1e6cc347a9c38b8ba4251~TPfuPTjdG2151821518epcas2p2-;
	Thu,  6 Apr 2023 04:27:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4PsT440Yqqz4x9Q9; Thu,  6 Apr
	2023 04:27:16 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-5d-642e4a23ef79
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.CC.08750.32A4E246; Thu,  6 Apr 2023 13:27:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [RFC v3 1/1] nvme: add passthrough error logging opt-in
From: Minwoo Im <minwoo.im@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "alan.adamson@oracle.com"
	<alan.adamson@oracle.com>, Pankaj Raghav Partha Sarathy
	<p.raghav@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <e6c70d0d-5363-ea0a-6404-70b923ea082f@nvidia.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230406042715epcms2p54115b0d61dfc8ae89da092022fc45b61@epcms2p5>
Date: Thu, 06 Apr 2023 13:27:15 +0900
X-CMS-MailID: 20230406042715epcms2p54115b0d61dfc8ae89da092022fc45b61
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTTFfZSy/F4NUJfYs9/aeYLN4ffMxq
	sXL1USaLSYeuMVrMX/aU3eLz0hZ2i3Wv37M4sHucv7eRxWPTqk42j81L6j1232xg8+htfsfm
	8fHpLRaPvi2rGAPYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
	XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevl
	pZZYGRoYGJkCFSZkZzQuv8FccEKo4tzqZUwNjDcEuhg5OSQETCQ2N65j72Lk4hAS2MEo8aVj
	MmsXIwcHr4CgxN8dwiA1wgIuEnO/tbCAhIUE5CV+vDKACGtKvNt9hhXEZhNQl2iY+ooFZIyI
	wBxGibPz+5lBEswCWxglFt2ShtjFKzGj/SkLhC0tsX35VkYQm1PATmLV83Z2iLiGxI9lvcwQ
	tqjEzdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouJbF//lwou1qi4fgzJgi7QuLX+wdQ9eYS
	v+/vBjuaV8BX4szbBjYQm0VAVaJ7ym1WiBoXiYtTr7JB3K8tsWzha2aQ35mBHl6/Sx/ElBBQ
	ljhyiwWigk+i4/BfdpgPd8x7ArVVWeLjoUNQWyUlll96zQbR6iGx9iLrBEbFWYhgnoVk1SyE
	VQsYmVcxiqUWFOempxYbFRjDYzY5P3cTIzhharnvYJzx9oPeIUYmDsZDjBIczEoivKpdWilC
	vCmJlVWpRfnxRaU5qcWHGE2BnpzILCWanA9M2Xkl8YYmlgYmZmaG5kamBuZK4rzStieThQTS
	E0tSs1NTC1KLYPqYODilGpiMt29580VL/LTrS3me/Tsm1j04ef28wunnQasOvj6UI8ThUzvF
	uvjCuut5Jx23Fp6UE/eUKNaoD3xme+iZ+1NXkyPmVy64/ta3r+vdV8q7/H/eY67F/3b6KS+Z
	+tE9q7VxsQ5zHNutBdfeRKu7/OO1vqkyK+7xvoOah/4dS/uzQkf62as4J++ilD+2Wsae0ecm
	lD2oC70xYfuOabLH7dfacsfceW1w8S5//XuxyRM+F5w8dHxRw2p7nYMda/Zcz9Ox8nYy2LYx
	oemKzeXdC84vSjZavD1k59T6u7PXp0YIHr31S4p18Xz+w7XP40wX2YSe/e6nKbR80/nIBcbr
	Py/pX1mrY8y4oOearka8/xl7SyWW4oxEQy3mouJEAAHXT5IhBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403083443eucas1p225993f889610c6c070dcb24e232aa526
References: <e6c70d0d-5363-ea0a-6404-70b923ea082f@nvidia.com>
	<3c11b233-82cc-0ab3-c099-1d6f43e4e1d5@oracle.com>
	<20230331221823.2806192-1-alan.adamson@oracle.com>
	<20230331221823.2806192-2-alan.adamson@oracle.com>
	<20230403082613.owr5wshccoy2uw4z@blixen>
	<20230406041310epcms2p1a4eb5e5201450bcf092cc1a38ae81a8b@epcms2p1>
	<CGME20230403083443eucas1p225993f889610c6c070dcb24e232aa526@epcms2p5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_212724_349776_92D07F23 
X-CRM114-Status: GOOD (  24.01  )
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
Reply-To: minwoo.im@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Chaitanya Kulkarni <chaitanyak=40nvidia.com>
> Sent: Thursday, April 6, 2023 1:24 PM
> To: minwoo.im=40samsung.com; alan.adamson=40oracle.com; Pankaj Raghav Par=
tha
> Sarathy <p.raghav=40samsung.com>
> Cc: linux-nvme=40lists.infradead.org; kbusch=40kernel.org; hch=40lst.de;
> sagi=40grimberg.me
> Subject: Re: =5BRFC v3 1/1=5D nvme: add passthrough error logging opt-in
>
>
> >>> passthrough_logging is a bit misleading as it doesn't indicate it isa
> >>> going to log only passthrough errors. =60passthrough_error_logging=60=
 is a bit
> >>> verbose but it is more apt for what this sysfs entry is doing. Maybe
> >>> an abbreviation for passthrough_error_logging?
> >> Since we are looking at only opting in to passthrough admin commands,
> >> how about we call it:
> >>
> >> /sys/class/nvme/nvme0/pt_admin_error_logging
> > I would make =60passthrough=60 short to =60passthu=60 as it looks like =
we don't use
> > =60pt=60 as a short for passthrough in drivers/nvme/=5Bhost=7Ctarget=5D=
.
> >
>
> right it's =22passthru=22 not =22passthu=22, see :-

Yes, indeed.  I missed out 'r' ;)  Thanks for fixing this=21

> /sys/kernel/config/nvmet/subsystems/tests
> =E2=94=9C=E2=94=80=E2=94=80=20allowed_hosts=0D=0A>=20=E2=94=9C=E2=94=80=
=E2=94=80=20attr_allow_any_host=0D=0A>=20=E2=94=9C=E2=94=80=E2=94=80=20attr=
_cntlid_max=0D=0A>=20=E2=94=9C=E2=94=80=E2=94=80=20attr_cntlid_min=0D=0A>=
=20=E2=94=9C=E2=94=80=E2=94=80=20attr_firmware=0D=0A>=20=E2=94=9C=E2=94=80=
=E2=94=80=20attr_ieee_oui=0D=0A>=20=E2=94=9C=E2=94=80=E2=94=80=20attr_model=
=0D=0A>=20=E2=94=9C=E2=94=80=E2=94=80=20attr_pi_enable=0D=0A>=20=E2=94=9C=
=E2=94=80=E2=94=80=20attr_qid_max=0D=0A>=20=E2=94=9C=E2=94=80=E2=94=80=20at=
tr_serial=0D=0A>=20=E2=94=9C=E2=94=80=E2=94=80=20attr_version=0D=0A>=20=E2=
=94=9C=E2=94=80=E2=94=80=20namespaces=0D=0A>=20=E2=94=94=E2=94=80=E2=94=80=
=20passthru=0D=0A>=20=20=20=20=20=20=E2=94=9C=E2=94=80=E2=94=80=20admin_tim=
eout=0D=0A>=20=20=20=20=20=20=E2=94=9C=E2=94=80=E2=94=80=20clear_ids=0D=0A>=
=20=20=20=20=20=20=E2=94=9C=E2=94=80=E2=94=80=20device_path=0D=0A>=20=20=20=
=20=20=20=E2=94=9C=E2=94=80=E2=94=80=20enable=0D=0A>=20=20=20=20=20=20=E2=
=94=94=E2=94=80=E2=94=80=20io_timeout=0D=0A>=0D=0A>=0D=0A>=20passthru_admin=
_err_logging=20should=20to=20the=20trick=20...=0D=0A>=20-ck=0D=0A

