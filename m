Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0C2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rS7FOcGHzkW+FD0d4tijJY6g6jr/VheAQ/gag2x5rWE=; b=sMWDmZFJFAn19/WQNIt5FyJgkt
	fGsO8343JtPiEL1I9LzEVUKrfz5DhGXyYlYz4o6/BPtBDfsYPqqkosOoDXotIb4ZqtMRKk6l2TAAP
	9N0G5Yc9XI5ca8FL4rZqqvRD0yvlr/D7feFWKiAF2hkH5zgn3IqrZncQPXo5R7Cj8EpSPPDnlzjIG
	VIje2N8X9ybWkKNTZCHQUpAD7qLkOI43xAI9pFzmmFPg7JNzs8ceNqaknKdw4vDJaP9e6dbsgy77w
	/Z0RjYkcuf16eX72pLEaIoybuo2ZRfA5LasLVwqa2pCPeshLm+/Z1X1d0bcqlMCBBppVhBawHgzhV
	KvfPUIag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYrK-00AxHh-Dy; Tue, 22 Feb 2022 17:21:54 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYfg-00AsMf-BN
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 17:09:54 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-210-AoyiLaE1OJah7Pz61gNshw-1; Tue, 22 Feb 2022 17:09:49 +0000
X-MC-Unique: AoyiLaE1OJah7Pz61gNshw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 17:09:47 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 22 Feb 2022 17:09:47 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Joe Perches <joe@perches.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "colyli@suse.de" <colyli@suse.de>, "Bart Van
 Assche" <bvanassche@acm.org>
Subject: RE: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Topic: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Index: AQHYKAxbyZzL6Kc8n0eksk5bzcXivKyfzIzQ
Date: Tue, 22 Feb 2022 17:09:47 +0000
Message-ID: <c5b76c7a0db647bd9850e6165cdb5da0@AcuMS.aculab.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
In-Reply-To: <20220222165045.GA14168@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_090952_712467_0F180DDD 
X-CRM114-Status: GOOD (  15.90  )
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
> Sent: 22 February 2022 16:51
>=20
> On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > Recent data integrity field enhancements allow 48-bit reference tags.
> > > Introduce a helper macro since this will be a repeated operation.
> > []
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > []
> > > @@ -63,6 +63,12 @@
> > >  }=09=09=09=09=09\
> > >  )
> > >
> > > +/**
> > > + * lower_48_bits - return bits 0-47 of a number
> > > + * @n: the number we're accessing
> > > + */
> > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> >
> > why not make this a static inline function?
>=20
> Agreed.
>=20
> > And visually, it's difficult to quickly count a repeated character to 1=
2.
> >
> > Perhaps:
> >
> > static inline u64 lower_48_bits(u64 val)
> > {
> > =09return val & GENMASK_ULL(47, 0);
> > }
>=20
> For anyone who has a minimum knowledge of C and hardware your version
> is an obsfucated clusterfuck, while the version Keith wrote is trivial
> to read.

I'd use the explicit: val & ((1ull << 48) - 1)
I think it is even fewer characters.

=09David.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


