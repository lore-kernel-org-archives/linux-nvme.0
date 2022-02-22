Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33967C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N19YGgct0dbdLUPguy2pjhYRe+SLA3uLHj9ZRksbGHE=; b=Q4vA9g1YcIZHkWDKmbsqTdZ25u
	R367qpgv0MDTfZtY0shOl1ZK1rlQm/WgILr9cl4yJbuHBr7OaTnOIn5VmY0QgvD/lRaC0DluXxk8N
	py6NaHdMaduVMyKy4e4QYdSe3coKFlIxV5+ynZA90foZez4MGXSmM730xWRxZDfqPVLRFlFZQoyes
	qYCJjeeYVdKW2vx5WLqNIdx+ZNoxnVYY0UJ8zIcU3+C3H+25/quLSa+bJSaKGPYnm+0snAdnXRgNy
	jukIik5PFT/7oNA2vivyIaxvDaxM7dUIIkaur3v9oc+G+EMa+A4D3h++VEJ9n6RMqzrafybPcTyBr
	u6x8lbDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMbTW-00BTfz-QW; Tue, 22 Feb 2022 20:09:30 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbTT-00BTda-Mb
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 20:09:29 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-273-wA-OKjcrNlClFgeO-K9vQw-1; Tue, 22 Feb 2022 20:09:23 +0000
X-MC-Unique: wA-OKjcrNlClFgeO-K9vQw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 20:09:22 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 22 Feb 2022 20:09:21 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joe Perches' <joe@perches.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "colyli@suse.de"
 <colyli@suse.de>, Bart Van Assche <bvanassche@acm.org>
Subject: RE: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Topic: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Index: AQHYKBwQyZzL6Kc8n0eksk5bzcXivKyf/Gmg
Date: Tue, 22 Feb 2022 20:09:21 +0000
Message-ID: <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
 <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
 <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
In-Reply-To: <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
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
X-CRM114-CacheID: sfid-20220222_120928_049656_E0C8C5F4 
X-CRM114-Status: GOOD (  22.39  )
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

From: Joe Perches
> Sent: 22 February 2022 18:43
>=20
> On Tue, 2022-02-22 at 08:56 -0800, Keith Busch wrote:
> > On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> > > On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > > > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > > > +/ *
> > > > > + * lower_48_bits - return bits 0-47 of a number
> > > > > + * @n: the number we're accessing
> > > > > + */
> > > > > +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))
> > > >
> > > > why not make this a static inline function?
> > >
> > > Agreed.
> >
> > Sure, that sounds good to me. I only did it this way to match the
> > existing local convention, but I personally prefer the inline function
> > too.
>=20
> The existing convention is used there to allow the compiler to
> avoid warnings and unnecessary conversions of a u32 to a u64 when
> shifting by 32 or more bits.
>=20
> If it's possible to be used with an architecture dependent typedef
> like dma_addr_t, then perhaps it's reasonable to do something like:
>=20
> #define lower_48_bits(val)=09=09=09=09=09\
> ({=09=09=09=09=09=09=09=09\
> =09typeof(val) high =3D lower_16_bits(upper_32_bits(val));=09\
> =09typeof(val) low =3D lower_32_bits(val);=09=09=09\
> =09=09=09=09=09=09=09=09\
> =09(high << 16 << 16) | low;=09=09=09=09\
> })
>=20
> and have the compiler have the return value be an appropriate type.

The compiler could make a real pigs breakfast of that.

For lower_46_bits() an integer promotion to u64 does no harm.
But for some other cases you get in a right mess when values
that should be unsigned get sign extended.

Although I think:
=09(val) & (((typeof(val))1 << 48) - 1)
avoids any promotion if anyone tries lower_48_bits(int_var).
(It is even likely to be a compile error.)

Oh, did you look for GENMASK([^,]*,[ 0]*) ?
I'd only use something GENMASK() for bit ranges.
Even then it is often easier to just write the value in hex.

I think the only time I've written anything like that recently
(last 30 years) was for some hardware registers when the documentation
user 'bit 1' for the most significant bit.

It's rather like I just know that (x & (x - 1)) checks for 1 bit being set.
I have to lookup is_power_of_2() to see what it does.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


