Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17122C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rojmnZRnQ7KG02hKmcPTDBLJXraVdf9DieGqnQaktig=; b=LFlqNav7VInWU/DsjAVpWKHnjy
	eAcI7BaZQquU2XdzQVGfYhsPzNILVTy7SAzfW6DQXrjU8cOHYdVmuGfbcLPNDT5B/d0vsWoJSrHVB
	ojcGuO2Ufu8CGMMjxQqFBHppxFUgyddxqkMo7n4z5JAz3+yGABc9lTuo09bd6oJ52WvEkfxeLpDqY
	RGCW3UOqZEAUnJ4B0z4mGbDbrwUxkL/pGIboX0KDAEIbDU1cGKEKCTpVMO1Zsm2kUKmDhp4z3aYAo
	2auF5Qyko5++zgXqRMsMyWDXL1oiG53AY+hfYGRPFgmAxc8v/6CUBOofofX8ZIvC7fMykJZcJmwZ3
	0fZV+dqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPwnC-008FRS-UX; Fri, 04 Mar 2022 01:31:38 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPwn6-008FQl-3P
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 01:31:33 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-_h_WcGdzNK2oICfGaye4nQ-1; Fri, 04 Mar 2022 01:31:28 +0000
X-MC-Unique: _h_WcGdzNK2oICfGaye4nQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 4 Mar 2022 01:31:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 4 Mar 2022 01:31:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Keith Busch' <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, Hannes Reinecke
 <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: RE: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Thread-Topic: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Thread-Index: AQHYLzsopbrJlbfcckWY1hd2yhpRTqyubXZA
Date: Fri, 4 Mar 2022 01:31:26 +0000
Message-ID: <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-4-kbusch@kernel.org>
In-Reply-To: <20220303201312.3255347-4-kbusch@kernel.org>
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
X-CRM114-CacheID: sfid-20220303_173132_457555_3559F249 
X-CRM114-Status: GOOD (  11.90  )
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
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags.

If they are reference tags, are they only interpreted by the
sending system?
In which case they don't need to be big-endian since the
actual value doesn't really matter.

> Provide some helper accessors in preparation for these.
>=20
...
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unalig=
ned.h
> index 1c4242416c9f..8fc637379899 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -126,4 +126,30 @@ static inline void put_unaligned_le24(const u32 val,=
 void *p)
>  =09__put_unaligned_le24(val, p);
>  }
>=20
> +static inline void __put_unaligned_be48(const u64 val, __u8 *p)
> +{
> +=09*p++ =3D val >> 40;
> +=09*p++ =3D val >> 32;
> +=09*p++ =3D val >> 24;
> +=09*p++ =3D val >> 16;
> +=09*p++ =3D val >> 8;
> +=09*p++ =3D val;
> +}

Although that matches __put_unaligned_be24() I think I'd use
array indexing not pointer increments.
The compiler will probably generate the same code anyway.

However it is probably better to do:
=09put_unaligned_be16(val >> 32, p);
=09put_unaligned_be32(val, p + 2);
so you get 2 memory accesses on x86 (etc) instead of 6.

Similarly for __get_unaligned_be48() where it is likely
so make a bigger difference.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


