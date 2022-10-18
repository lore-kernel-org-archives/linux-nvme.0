Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E217C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+FRHkAzN0S+TXFauESXYQ/bCnb/kPobD4XYjyWkIqI=; b=OlZv752pNy40OcBdQOFUXnh+KY
	luE43D/WP4fPpURxut0fH07KJ8zsThSBnz3DN63bfI0uXD3dXFzWZsIqc3ezPjrbZ7eFIgmYYyGwA
	KgNce0wxfmmdoGdPx7rjrsnjgpf3TN94ZXuLTJyHEmpSEDBrOpI2JlhhUNHqlotD9E1I6tJLsK/BA
	c53WbF6jX1znHyx4Mi1guqloOf2I1r3FiBqGP/NOmvgL4/KJ80X6+7vv5J91cQlSrROwvzb7hG2Ax
	4TpqtN8mCn+h2rgDIjjFqUE3jtRsLe02uKSDhawn5+1dXP5LnmgzSGYoBnHN7t7VhD9MzfOJbSopS
	hFEDiDlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oksxb-00AKh8-Vu; Tue, 18 Oct 2022 20:13:12 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oksxZ-00AKg9-Ep
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 20:13:10 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 18 Oct 2022 13:12:59 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::213a:a308:b836:4a06%3]) with mapi id 15.01.2375.032; Tue, 18 Oct 2022
 13:12:59 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Keith
 Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
	<sagi@grimberg.me>
Subject: RE: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Thread-Topic: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Thread-Index: AQHY1FTl/5xNbvKKu0OeZNJHTFrqZ64TJB2A//+rNrA=
Date: Tue, 18 Oct 2022 20:12:59 +0000
Message-ID: <96244e61f9b94ed3aff59f3f14ecdca4@kioxia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
 <20220929223955.3275715-2-clay.mayers@kioxia.com>
 <20221017132359.GA23141@lst.de>
In-Reply-To: <20221017132359.GA23141@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_131309_573635_D0DDD7ED 
X-CRM114-Status: GOOD (  19.65  )
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

> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, October 17, 2022 6:24 AM
>=20
> On Thu, Sep 29, 2022 at 03:39:54PM -0700, clay.mayers@kioxia.com wrote:
> > From: Clay Mayers <clay.mayers@kioxia.com>
> >
> > There are AENs from alternate command sets that include
> > extra data in their AEN's CQE.DW1.  For example, the ZNS
> > Zone-Descriptor-Changed AEN uses it to indicate the NSID
> > of the event's log page.
> >
> > NVME_AEN uevent now includes the value of CQE.DW1 as a new
> > property.  It is only included when non-zero to keep previously
> > existing uevents unmodified.
>=20
> I don't think we can actually do this.  If we ever want to handle
> Zone Excursions or any other event where the device can chane the
> Zone Descriptor we need to handle this AEN in the kernel and thus
> control the clearing of the even by reading the associated log page,
> so we can't just send it on to userspace.  This is a bit of a sad
> state of affairs but unavoidable due to the NVMe AEN design.

What happens today is a warning is logged and the log page is left
unread.  The patch closes that gap allowing ZDC AENs to be enable
and handled in user space for things like RocksDB's ZenFS.  Kernel
clients will also need a way to handle them, but can't that be a
different patch series?

The limitation is, the ZDC AEN is enabled/disabled at the controller
level but it's essentially a namespace level event.  Once on for one
namespace, zone descriptor changes have to be handled as an AEN
for all namespaces.


