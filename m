Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D65C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQzVTM0oe4DUkKcNPvBargLTvKm0raLgPd0P1t1Qt24=; b=oKYMWlkajA11sZ1oJCd1mWaeKm
	gia2cnYFQwDrJIQYl1G/womUdxHttYTMjfUCNP+HQjC3ULyAQ55KAkFNMB9ycvNtDv/eRgC2+tVUE
	+M2rS3cWPhEAMb6XPJ1/kyN9fuhrrScXFnFnSzIbC9rCuSR7WBobHLZ6AsfMDfTbvqx3uz/JZz6OP
	itZ+4aCjMIfP1X/K0I+PJ9yfO9j6qEGmikNeZbvYsFOnLDHsIwom6m8TUUI0KtS0RWpus1PtyaAPL
	1bOrtJR8QgVksKAx2sTcWEd31v503wYPuWPzphBAHKSfuGTZ+k2Hci0lVWsU7la/ipyLrz9XSEllB
	zrhYJvPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYmb-00AvFZ-2Z; Tue, 22 Feb 2022 17:17:01 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYYW-00Apjs-UI
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 17:02:31 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-164-i5Yi4IRPO7OQJB0p3ITDCA-1; Tue, 22 Feb 2022 17:02:18 +0000
X-MC-Unique: i5Yi4IRPO7OQJB0p3ITDCA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 17:02:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 22 Feb 2022 17:02:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Keith Busch' <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "colyli@suse.de"
 <colyli@suse.de>
Subject: RE: [PATCHv3 10/10] x86/crypto: add pclmul acceleration for crc64
Thread-Topic: [PATCHv3 10/10] x86/crypto: add pclmul acceleration for crc64
Thread-Index: AQHYKAoDxC35E9Q8uUaW/UAMQuY/zKyfybxw
Date: Tue, 22 Feb 2022 17:02:16 +0000
Message-ID: <a7e806ed3c074534a24b74f827bcc914@AcuMS.aculab.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-11-kbusch@kernel.org>
In-Reply-To: <20220222163144.1782447-11-kbusch@kernel.org>
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
X-CRM114-CacheID: sfid-20220222_090229_391233_C073BE0A 
X-CRM114-Status: GOOD (  13.13  )
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
> Sent: 22 February 2022 16:32
>=20
> The crc64 table lookup method is inefficient, using a significant number
> of CPU cycles in the block stack per IO. If available on x86, use a
> PCLMULQDQ implementation to accelerate the calculation.
>=20
> The assembly from this patch was mostly generated by gcc from a C
> program using library functions provided by x86 intrinsics, and measures
> ~20x faster than the table lookup.

I think I'd like to see the C code and compiler options used to
generate the assembler as comments in the committed source file.
Either that or reasonable comments in the assembler.

It is also quite a lot of code.
What is the break-even length for 'cold cache' including the FPU saves.

...
> +.section=09.rodata
> +.align 32
> +.type=09shuffleMasks, @object
> +.size=09shuffleMasks, 32
> +shuffleMasks:
> +=09.string=09""
> +=09.ascii=09"\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017\217\216\=
215"
> +=09.ascii=09"\214\213\212\211\210\207\206\205\204\203\202\201\200"

That has to be the worst way to define 32 bytes.

> +.section=09.rodata.cst16,"aM",@progbits,16
> +.align 16
> +.LC0:
> +=09.quad=09-1523270018343381984
> +=09.quad=092443614144669557164
> +=09.align 16
> +.LC1:
> +=09.quad=092876949357237608311
> +=09.quad=093808117099328934763

Not sure what those are, but I bet there are better ways to
define/describe them.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


