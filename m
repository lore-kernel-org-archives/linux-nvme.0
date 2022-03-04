Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C26C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fgi9VGCyuCGHuvtzqHswhzO/NiosivG4T4eHllRpiis=; b=vQCyMHDpePaCyiaKUxFRBrFurs
	C5BCq4BI01YWCTEzDNKBuM0j8vsBXp5S/WvizMhgvQ3rLWpGGb3kWw25HCooGaUbx8y2gzSd7aEuL
	cO3t6LK0LqYkyGVOo1SdCq93jW9SGvKERIIwB0N/6PJ3RDajYjYqmoDt6qvQ4+wNhdtK1Vbp8EXxB
	uqvK2NWIW/Zomu4RUDBKScMd2/03yuRAChtBJmkfqLRowO0lxlWx5C8c0N6xtLOcSt5SeOeSalW7N
	IBEVPaaCR/bR56aorzMgNPoe+2mbX/E0a36CugTwlN/5oEwWu8TuUjNugotApI0JgAXcAWW0eRasC
	4vf8beJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQ2lA-008rXs-E1; Fri, 04 Mar 2022 07:53:56 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQ2l7-008rVj-My
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 07:53:55 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-FYvCFpCMOBqyNx07Jia5EQ-1; Fri, 04 Mar 2022 07:53:46 +0000
X-MC-Unique: FYvCFpCMOBqyNx07Jia5EQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 4 Mar 2022 07:53:44 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 4 Mar 2022 07:53:44 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Keith Busch' <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, Hannes Reinecke
 <hare@suse.de>
Subject: RE: [PATCHv4 5/8] lib: add rocksoft model crc64
Thread-Topic: [PATCHv4 5/8] lib: add rocksoft model crc64
Thread-Index: AQHYLzsrMRdzY3NFeE6gsrcF0wQhN6yu0OzA
Date: Fri, 4 Mar 2022 07:53:44 +0000
Message-ID: <30e059eca211460780442e2ded092722@AcuMS.aculab.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-6-kbusch@kernel.org>
In-Reply-To: <20220303201312.3255347-6-kbusch@kernel.org>
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
X-CRM114-CacheID: sfid-20220303_235354_053236_9DC0D098 
X-CRM114-Status: GOOD (  15.81  )
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

From: Keith Busch
> Sent: 03 March 2022 20:13
>=20
> The NVM Express specification extended data integrity fields to 64 bits
> using the Rocksoft parameters. Add the poly to the crc64 table
> generation, and provide a generic library routine implementing the
> algorithm.
>=20
> The Rocksoft 64-bit CRC model parameters are as follows:
>     Poly: 0xAD93D23594C93659
>     Initial value: 0xFFFFFFFFFFFFFFFF
>     Reflected Input: True
>     Reflected Output: True
>     Xor Final: 0xFFFFFFFFFFFFFFFF
>=20
> Since this model used reflected bits, the implementation generates the
> reflected table so the result is ordered consistently.

Since the data is processed least significant bit first the
table must be setup slightly differently.

...
> + * crc64rocksoft[256] table is from the Rocksoft specification polynomia=
l
> + * defined as,
> + *
> + * x^64 + x^63 + x^61 + x^59 + x^58 + x^56 + x^55 + x^52 + x^49 + x^48 +=
 x^47 +
> + * x^46 + x^44 + x^41 + x^37 + x^36 + x^34 + x^32 + x^31 + x^28 + x^26 +=
 x^23 +
> + * x^22 + x^19 + x^16 + x^13 + x^12 + x^10 + x^9 + x^6 + x^4 + x^3 + 1

Which matches the Poly: 0xAD93D23594C93659 above.

...
> +#define CRC64_ROCKSOFT_POLY 0x9A6C9329AC4BC9B5ULL

But that value is clearly different.

You really ought to add a comment that each byte of the constant
has to be bit reversed from the polynomial coefficients.

> -static void generate_crc64_table(void)
> +static void generate_reflected_crc64_table(uint64_t table[256], uint64_t=
 poly)
> +{
> +=09uint64_t i, j, c, crc;
> +
> +=09for (i =3D 0; i < 256; i++) {
> +=09=09crc =3D 0ULL;
> +=09=09c =3D i;
> +
> +=09=09for (j =3D 0; j < 8; j++) {
> +=09=09=09if ((crc ^ (c >> j)) & 1)
> +=09=09=09=09crc =3D (crc >> 1) ^ poly;
> +=09=09=09else
> +=09=09=09=09crc >>=3D 1;
> +=09=09}
> +=09=09table[i] =3D crc;
> +=09}
> +}

That can be speeded up by using the identity:
=09table[x ^ y] =3D=3D table[x] ^ table[y]

something like:
=09crc =3D poly;  /* actually crc(1) */
=09table[0] =3D 0;
=09table[1] =3D crc;
=09for (i =3D 2; i < 8; i++) [
=09=09crc =3D crc & 1 ? (crc >> 1) ^ poly : crc >> 1;
=09=09for (j =3D 0; j < 1u << i; j++)
=09=09=09table[j + (1i << i)] =3D table[j] ^ crc;
=09}

I think the same code can be used for a normal MSB first crc
provided both the polynomial and crc(1) are passed in.

OTOH initialisation speed may not matter.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


