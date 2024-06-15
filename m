Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671B0C27C4F
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Jun 2024 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmJN1lve7JcoiGFq1UrMKhgHoWc3m9quj0gzt2Le7jk=; b=WM1XBTf5jNQPrBcAfTyV6vjRo0
	3Eyw4XWECboTLO4+nSgrVfb5cb/7wyqV7Q1PM0hE6Rc2fQs7Q868uqMA++KG8DL30/NSXjd3604jp
	oikIUOfzgX+YXAl88SCf1wwaT174i8jfiqrSKLnNosQDcAuXtkBf28z7fMNaMajigKruyAb+n3Ozv
	Az5LX5RDPdUGFQs0/3Zvt3xo7XKy9Ypx4nNSHZG/WWcq1jLviSoqv8jO7jTWZXXQEjIbdau3AzLs2
	gCU6Nx1ab4QLZ1aRQkBWbZbBEozUWdUJWl21rVXygtXf+skJl8E+EStTrAyB3IOAkFAqF0CiRcnv5
	7/zNucFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIb3o-000000069E0-0bi7;
	Sat, 15 Jun 2024 21:35:44 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIb3g-000000069D9-3jUt
	for linux-nvme@lists.infradead.org;
	Sat, 15 Jun 2024 21:35:39 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-WcpmdJxuOlyzpwH8SkS-PQ-1; Sat, 15 Jun 2024 22:35:28 +0100
X-MC-Unique: WcpmdJxuOlyzpwH8SkS-PQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 15 Jun
 2024 22:34:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 15 Jun 2024 22:34:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Index: AQHau8pbCx3DyDdCX0iDpwrmm4Yu8LHJXahA
Date: Sat, 15 Jun 2024 21:34:52 +0000
Message-ID: <df4db10f6f3946e29e7e7340cfa82c33@AcuMS.aculab.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
 <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
 <20240610122939.GA21899@lst.de>
 <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
 <20240611064132.GA6727@lst.de>
In-Reply-To: <20240611064132.GA6727@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240615_143537_224268_AFBF00AD 
X-CRM114-Status: GOOD (  19.68  )
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

From: Christoph Hellwig
> Sent: 11 June 2024 07:42
>=20
> On Mon, Jun 10, 2024 at 05:30:34PM +0300, Sagi Grimberg wrote:
> >> efficient header splitting in the NIC, either hard coded or even
> >> better downloadable using something like eBPF.
> >
> > From what I understand, this is what this offload is trying to do. It u=
ses
> > the nvme command_id similar to how the read_stag is used in iwarp,
> > it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
> > the command_id to an internal MR for dma purposes.
> >
> > What I think you don't like about this is the interface that the offloa=
d
> > exposes
> > to the TCP ulp driver (nvme-tcp in our case)?
>=20
> I don't see why a memory registration is needed at all.
>=20
> The by far biggest painpoint when doing storage protocols (including
> file systems) over IP based storage is the data copy on the receive
> path because the payload is not aligned to a page boundary.

How much does the copy cost anyway?
If the hardware has merged the segments then it should be a single copy.
On x86 (does anyone care about anything else :-) 'rep mosvb' with a
cache-line aligned destination runs at 64 bytes/clock.
(The source alignment doesn't matter at all.)
I guess it loads the source data into the D-cache, the target is probably
required anyway - or you wouldn't be doing a read.

=09David

>=20
> So we need to figure out a way that is as stateless as possible that
> allows aligning the actual data payload on a page boundary in an
> otherwise normal IP receive path.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


