Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F9FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 05:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYObgb/EpZq1ejnJFsVcP1JqCuEaRAq3H4pxQ/7My0E=; b=yr5KlaEyaDXXMAD5T6QsmQZau0
	zBKt+yWQQFhBVV4EfnsEvmoddoP9neUBkSGu3QFcDbVmpzR9VuyO/NEu8DDrMg7ybZsPM3NsS3P9L
	e8vcyuMYU4NRlQ5SnI00WMYNPGLjEv+t9bxVR84xwUtCM6Pu9Jl/JfImhUfzqJdqpib/vCistSJN+
	ENR0/e8S4n4OCIK3eK7NcOkCYUFerauJ2HqiZBrW3bOZivh/MWEI9cFubrg2Wbn1MvJ7ZS+QQaaGR
	k5F3adnFSZvMCGMAtfF5296iPv9CVb2piVctU4oIuNHFhNz90iS/Z3uPf4er8YE815tSvmLN6qlnq
	k09Qy4zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIK2S-00000004iUt-0BRh;
	Thu, 30 Apr 2026 05:34:16 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIK2N-00000004iU8-0XBF
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 05:34:14 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260430053402epoutp0182abf2672d95dc2d124b9fef5556c2f6~rC5wRkVWT0691806918epoutp01B
	for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 05:34:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260430053402epoutp0182abf2672d95dc2d124b9fef5556c2f6~rC5wRkVWT0691806918epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777527242;
	bh=OYObgb/EpZq1ejnJFsVcP1JqCuEaRAq3H4pxQ/7My0E=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=VK3dS5h/leMT3KR/mTkbsmDKivHYHdrODFIq6nvh/vEW7XLGYm7yvOSUq4QssvlqL
	 vbc5ir8WGZajBDjuxr2o/XWI+ZpVGqmwIsfvu6c0a82GlEHJJ19cpVY4mRYQQedZEV
	 uy/T0Ef9BnooA8IbznqLZnc/VIg263rZrZUL1TTY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20260430053402epcas2p2b82019892e27cf2758a26bb998a8d8a4~rC5v1qd3v2354223542epcas2p25;
	Thu, 30 Apr 2026 05:34:02 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.204]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4g5jXB1G3sz6B9mB; Thu, 30 Apr
	2026 05:34:02 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v6] nvme: Skip trace complete_rq on host path error
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: kernel test robot <lkp@intel.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>, =?UTF-8?B?7Lm47LCs?=
	<joshi.k@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <202604300750.YpUGtmek-lkp@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260430053401epcms2p88c3cac0c3b817015d718cc0f4914532b@epcms2p8>
Date: Thu, 30 Apr 2026 14:34:01 +0900
X-CMS-MailID: 20260430053401epcms2p88c3cac0c3b817015d718cc0f4914532b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260430051839epcas2p20fce5951dc4a04138033e5943f1acdbf
References: <202604300750.YpUGtmek-lkp@intel.com>
	<20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
	<CGME20260430051839epcas2p20fce5951dc4a04138033e5943f1acdbf@epcms2p8>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_223412_463019_F79D13C3 
X-CRM114-Status: GOOD (  13.06  )
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
Reply-To: hmi.jeon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 17, 2026 at 01:00 UTC, =EC=A0=84=EB=AF=BC=EC=8B=9D=20wrote:=0D=
=0A>=20On=20Thu,=20Apr=2016,=202026=20at=2022:00=20UTC,=20Keith=20Busch=20w=
rote:=0D=0A>=20>=20You're=20missing=20the=20=22static=22=20declaration,=20w=
hich=20was=20present=20in=20the=0D=0A>=20>=20original=20suggestion:=0D=0A>=
=20>=0D=0A>=20>=20https://lore.kernel.org/linux-nvme/acVCnozG1WKPkq1L=40kbu=
sch-mbp/=0D=0A>=20>=0D=0A>=20>=20Should=20I=20just=20apply=20my=20local=20c=
opy?=20I=20think=20it's=20an=20original=20patch=20from=0D=0A>=20>=20me=20at=
=20this=20point.=0D=0A>=0D=0A>=20Please=20go=20ahead=20and=20apply=20your=
=20local=20copy.=0D=0A>=20I=20appreciate=20your=20help=20in=20finalizing=20=
the=20patch.=0D=0A=0D=0AHi=20Keith,=0D=0A=0D=0AAre=20you=20planning=20to=20=
apply=20your=20local=20fix=20directly?=0D=0A=0D=0AThanks,=0D=0AMinsik=20Jeon

